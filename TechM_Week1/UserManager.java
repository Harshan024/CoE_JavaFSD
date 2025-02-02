package Week_1;
 
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class User implements Serializable {
    String name;
    String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    @Override
    public String toString() {
        return "Name: " + name + ", Email: " + email;
    }
}

class UserManager {
    private List<User> users;

    public UserManager() {
        users = new ArrayList<>();
    }

    public void addUser(String name, String email) {
        users.add(new User(name, email));
    }

    public void saveUsersToFile(String filename) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename))) {
            oos.writeObject(users);
            System.out.println("Users saved to " + filename);
        } catch (IOException e) {
            System.err.println("Error saving users to file: " + e.getMessage());
        }
    }

    public void loadUsersFromFile(String filename) {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
            users = (List<User>) ois.readObject();
            System.out.println("Users loaded from " + filename);
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
            users = new ArrayList<>();
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error loading users from file: " + e.getMessage());
            users = new ArrayList<>();
        }
    }

    public void displayUsers() {
        if (users.isEmpty()) {
            System.out.println("No users in the system.");
        } else {
            System.out.println("Current Users:");
            for (User user : users) {
                System.out.println(user);
            }
        }
    }


    public static void main(String[] args) {
        UserManager userManager = new UserManager();
        String filename = "users.ser"; 
        Scanner sc = new Scanner(System.in);

        userManager.loadUsersFromFile(filename);

        int choice;
        do {
            System.out.println("\nUser Management Menu:");
            System.out.println("1. Add User");
            System.out.println("2. Save Users to File");
            System.out.println("3. Load Users from File");
            System.out.println("4. Display Users");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            choice = sc.nextInt();
            sc.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter name: ");
                    String name = sc.nextLine();
                    System.out.print("Enter email: ");
                    String email = sc.nextLine();
                    userManager.addUser(name, email);
                    break;
                case 2:
                    userManager.saveUsersToFile(filename);
                    break;
                case 3:
                    userManager.loadUsersFromFile(filename);
                    break;
                case 4:
                    userManager.displayUsers();
                    break;
                case 5:
                    System.out.println("Exiting program");
                    break;
                default:
                    System.out.println("Invalid choice...Please try again!");
            }
        } while (choice != 5);

        sc.close();
    }
}
