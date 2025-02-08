package MidWeek_1;

import java.util.*;
import java.util.concurrent.*;
import java.io.*;

class OutOfStockException extends Exception {
    public OutOfStockException(String message) {
        super(message);
    }
}

class InvalidLocationException extends Exception {
    public InvalidLocationException(String message) {
        super(message);
    }
}

class Product {
    private String productID;
    private String name;
    private int quantity;
    private Location location;

    public Product(String productID, String name, int quantity, Location location) {
        this.productID = productID;
        this.name = name;
        this.quantity = quantity;
        this.location = location;
    }

    public String getProductID() {
        return productID;
    }

    public String getName() {
        return name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    @Override
    public String toString() {
        return "Product [ID: " + productID + ", Name: " + name + ", Quantity: " + quantity + ", Location: " + location + "]";
    }
}

// Location Class
class Location {
    private int aisle;
    private int shelf;
    private int bin;

    public Location(int aisle, int shelf, int bin) {
        this.aisle = aisle;
        this.shelf = shelf;
        this.bin = bin;
    }

    public int getAisle() {
        return aisle;
    }

    public int getShelf() {
        return shelf;
    }

    public int getBin() {
        return bin;
    }

    @Override
    public String toString() {
        return "Aisle: " + aisle + ", Shelf: " + shelf + ", Bin: " + bin;
    }
}

// Order Class
class Order {
    private String orderID;
    private List<String> productIDs;
    private Priority priority;

    public Order(String orderID, List<String> productIDs, Priority priority) {
        this.orderID = orderID;
        this.productIDs = productIDs;
        this.priority = priority;
    }

    public enum Priority {
        STANDARD, EXPEDITED
    }

    public String getOrderID() {
        return orderID;
    }

    public List<String> getProductIDs() {
        return productIDs;
    }

    public Priority getPriority() {
        return priority;
    }

    @Override
    public String toString() {
        return "Order [ID: " + orderID + ", Products: " + productIDs + ", Priority: " + priority + "]";
    }
}

class OrderComparator implements Comparator<Order> {
    @Override
    public int compare(Order o1, Order o2) {
        return o1.getPriority().compareTo(o2.getPriority());
    }
}

class InventoryManager {
    private Map<String, Product> products;
    private PriorityQueue<Order> orderQueue;

    public InventoryManager() {
        products = new ConcurrentHashMap<>();
        orderQueue = new PriorityQueue<>(new OrderComparator());
    }

    public synchronized void addProduct(Product product) {
        products.put(product.getProductID(), product);
        System.out.println("Product added: " + product);
    }

    public void processOrders() {
        while (!orderQueue.isEmpty()) {
            Order order = orderQueue.poll();
            new Thread(() -> {
                try {
                    fulfillOrder(order);
                } catch (OutOfStockException | InvalidLocationException e) {
                    System.out.println("Order " + order.getOrderID() + " failed: " + e.getMessage());
                }
            }).start();
        }
    }

    private void fulfillOrder(Order order) throws OutOfStockException, InvalidLocationException {
        for (String productID : order.getProductIDs()) {
            Product product = products.get(productID);
            if (product == null) {
                throw new InvalidLocationException("Product not found: " + productID);
            }
            if (product.getQuantity() <= 0) {
                throw new OutOfStockException("Product out of stock: " + productID);
            }
            product.setQuantity(product.getQuantity() - 1);
            System.out.println("Order " + order.getOrderID() + " processed for product: " + productID);
        }
    }

    public void addOrder(Order order) {
        orderQueue.add(order);
        System.out.println("Order added: " + order);
    }

    public void saveInventoryToFile(String filename) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename))) {
            oos.writeObject(products);
            System.out.println("Inventory saved to file: " + filename);
        } catch (IOException e) {
            System.out.println("Failed to save inventory: " + e.getMessage());
        }
    }

    @SuppressWarnings("unchecked")
    public void loadInventoryFromFile(String filename) {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
            products = (ConcurrentHashMap<String, Product>) ois.readObject();
            System.out.println("Inventory loaded from file: " + filename);
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("Failed to load inventory: " + e.getMessage());
        }
    }

    public Map<String, Product> getProducts() {
        return products;
    }
}

public class WarehouseInventoryManagementSystem  {
    public static void main(String[] args) {
        InventoryManager inventoryManager = new InventoryManager();

        try {
            inventoryManager.loadInventoryFromFile("inventory.dat");
        } catch (Exception e) {
            System.out.println("Failed to load inventory: " + e.getMessage());
        }

        Product product1 = new Product("P001", "Laptop", 10, new Location(1, 2, 3));
        Product product2 = new Product("P002", "Smartphone", 20, new Location(2, 3, 4));
        Product product3 = new Product("P003", "Tablet", 5, new Location(3, 4, 5));
        inventoryManager.addProduct(product1);
        inventoryManager.addProduct(product2);
        inventoryManager.addProduct(product3);

        List<String> order1Products = Arrays.asList("P001", "P002");
        Order order1 = new Order("O001", order1Products, Order.Priority.EXPEDITED);

        List<String> order2Products = Arrays.asList("P002", "P003");
        Order order2 = new Order("O002", order2Products, Order.Priority.STANDARD);

        List<String> order3Products = Arrays.asList("P001", "P003");
        Order order3 = new Order("O003", order3Products, Order.Priority.EXPEDITED);

        inventoryManager.addOrder(order1);
        inventoryManager.addOrder(order2);
        inventoryManager.addOrder(order3);

        ExecutorService executor = Executors.newFixedThreadPool(3);
        executor.submit(() -> {
            try {
                inventoryManager.processOrders();
            } catch (Exception e) {
                System.out.println("Error processing orders: " + e.getMessage());
            }
        });

        executor.shutdown();
        try {
            if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
        }

        try {
            inventoryManager.saveInventoryToFile("inventory.dat");
        } catch (Exception e) {
            System.out.println("Failed to save inventory: " + e.getMessage());
        }

        System.out.println("Final inventory state:");
        for (Product product : inventoryManager.getProducts().values()) {
            System.out.println(product);
        }
    }
}