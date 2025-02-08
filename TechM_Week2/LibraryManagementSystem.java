package MidWeek_1;

import java.util.*;
import java.io.*;
import java.util.concurrent.*;

class BookNotFoundException extends Exception {
    public BookNotFoundException(String message) {
        super(message);
    }
}

class UserNotFoundException extends Exception {
    public UserNotFoundException(String message) {
        super(message);
    }
}

class MaxBooksAllowedException extends Exception {
    public MaxBooksAllowedException(String message) {
        super(message);
    }
}

class Book {
    private String title;
    private String author;
    private String ISBN;

    public Book(String title, String author, String ISBN) {
        this.title = title;
        this.author = author;
        this.ISBN = ISBN;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getISBN() {
        return ISBN;
    }

    @Override
    public String toString() {
        return "Book [Title: " + title + ", Author: " + author + ", ISBN: " + ISBN + "]";
    }
}

class User {
    private String name;
    private String userID;
    private List<Book> borrowedBooks;

    public User(String name, String userID) {
        this.name = name;
        this.userID = userID;
        this.borrowedBooks = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public String getUserID() {
        return userID;
    }

    public List<Book> getBorrowedBooks() {
        return borrowedBooks;
    }

    public void borrowBook(Book book) {
        borrowedBooks.add(book);
    }

    public void returnBook(Book book) {
        borrowedBooks.remove(book);
    }

    @Override
    public String toString() {
        return "User [Name: " + name + ", UserID: " + userID + ", Borrowed Books: " + borrowedBooks.size() + "]";
    }
}

interface ILibrary {
    void borrowBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException, MaxBooksAllowedException;
    void returnBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException;
    void reserveBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException;
    Book searchBook(String title);
}

abstract class LibrarySystem implements ILibrary {
    protected List<Book> books;
    protected List<User> users;

    public LibrarySystem() {
        books = new ArrayList<>();
        users = new ArrayList<>();
    }

    public abstract void addBook(Book book);
    public abstract void addUser(User user);

    @Override
    public Book searchBook(String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null;
    }
}

class LibraryManager extends LibrarySystem {
    private static final int MAX_BOOKS_ALLOWED = 3;

    @Override
    public void addBook(Book book) {
        books.add(book);
    }

    @Override
    public void addUser(User user) {
        users.add(user);
    }

    @Override
    public synchronized void borrowBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException, MaxBooksAllowedException {
        Book book = findBookByISBN(ISBN);
        User user = findUserByID(userID);

        if (book == null) {
            throw new BookNotFoundException("Book with ISBN " + ISBN + " not found.");
        }

        if (user == null) {
            throw new UserNotFoundException("User with ID " + userID + " not found.");
        }

        if (user.getBorrowedBooks().size() >= MAX_BOOKS_ALLOWED) {
            throw new MaxBooksAllowedException("User " + userID + " has reached the maximum limit of borrowed books.");
        }

        user.borrowBook(book);
        System.out.println("Book " + book.getTitle() + " borrowed by " + user.getName());
    }

    @Override
    public synchronized void returnBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException {
        Book book = findBookByISBN(ISBN);
        User user = findUserByID(userID);

        if (book == null) {
            throw new BookNotFoundException("Book with ISBN " + ISBN + " not found.");
        }

        if (user == null) {
            throw new UserNotFoundException("User with ID " + userID + " not found.");
        }

        user.returnBook(book);
        System.out.println("Book " + book.getTitle() + " returned by " + user.getName());
    }

    @Override
    public void reserveBook(String ISBN, String userID) throws BookNotFoundException, UserNotFoundException {
        System.out.println("Book with ISBN " + ISBN + " reserved by user " + userID);
    }

    private Book findBookByISBN(String ISBN) {
        for (Book book : books) {
            if (book.getISBN().equals(ISBN)) {
                return book;
            }
        }
        return null;
    }

    private User findUserByID(String userID) {
        for (User user : users) {
            if (user.getUserID().equals(userID)) {
                return user;
            }
        }
        return null;
    }

    public void saveData(String bookFilename, String userFilename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(bookFilename))) {
            writer.write("Title,Author,ISBN\n");
            for (Book book : books) {
                writer.write(book.getTitle() + "," + book.getAuthor() + "," + book.getISBN() + "\n");
            }
            System.out.println("Books data saved to " + bookFilename);
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFilename))) {
            writer.write("Name,UserID,BorrowedBooks\n");
            for (User user : users) {
                writer.write(user.getName() + "," + user.getUserID() + "," + user.getBorrowedBooks().size() + "\n");
            }
            System.out.println("Users data saved to " + userFilename);
        }
    }

    public void loadData(String bookFilename, String userFilename) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(bookFilename))) {
            String line;
            reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                books.add(new Book(data[0], data[1], data[2]));
            }
            System.out.println("Books data loaded from " + bookFilename);
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(userFilename))) {
            String line;
            reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                users.add(new User(data[0], data[1]));
            }
            System.out.println("Users data loaded from " + userFilename);
        }
    }
}

public class LibraryManagementSystem {
    public static void main(String[] args) {
        LibraryManager libraryManager = new LibraryManager();

        libraryManager.addBook(new Book("Java Programming", "James Gosling", "1234567890"));
        libraryManager.addBook(new Book("Python for Beginners", "Guido van Rossum", "0987654321"));
        libraryManager.addBook(new Book("C++ Programming", "Bjarne Stroustrup", "1122334455"));
        libraryManager.addBook(new Book("Data Structures", "John Doe", "5566778899"));

        libraryManager.addUser(new User("Damon", "U001"));
        libraryManager.addUser(new User("Stefan", "U002"));
        libraryManager.addUser(new User("Elena", "U003"));
        libraryManager.addUser(new User("Bonnie", "U004"));

        try {
            libraryManager.borrowBook("1234567890", "U001");
            libraryManager.borrowBook("0987654321", "U001");
            libraryManager.borrowBook("1122334455", "U002");
            libraryManager.returnBook("1234567890", "U001");
            libraryManager.borrowBook("5566778899", "U003");
            libraryManager.returnBook("0987654321", "U001");
            libraryManager.borrowBook("1234567890", "U004");
        } catch (BookNotFoundException | UserNotFoundException | MaxBooksAllowedException e) {
            System.out.println(e.getMessage());
        }

        try {
            libraryManager.saveData("books.csv", "users.csv");
        } catch (IOException e) {
            System.out.println("Error saving library data: " + e.getMessage());
        }

        try {
            libraryManager.loadData("books.csv", "users.csv");
        } catch (IOException e) {
            System.out.println("Error loading library data: " + e.getMessage());
        }

        ExecutorService executor = Executors.newFixedThreadPool(2);
        executor.submit(() -> {
            try {
                libraryManager.borrowBook("0987654321", "U002");
            } catch (BookNotFoundException | UserNotFoundException | MaxBooksAllowedException e) {
                System.out.println(e.getMessage());
            }
        });
        executor.submit(() -> {
            try {
                libraryManager.returnBook("0987654321", "U001");
            } catch (BookNotFoundException | UserNotFoundException e) {
                System.out.println(e.getMessage());
            }
        });
        executor.shutdown();
    }
}