package Week_3;

import java.util.List;
import java.util.Scanner;

public class AccountantUI {
    private static AccountantService accountantService = new AccountantService();

    public static void accountantMenu() {
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n--------- Accountant Dashboard -----------");
            System.out.println("1. Add Student");
            System.out.println("2. View Students");
            System.out.println("3. Edit Student");
            System.out.println("4. Delete Student");
            System.out.println("5. Check Due Fee");
            System.out.println("6. Logout");
            System.out.print("Enter your choice: ");
            int choice = sc.nextInt();
            sc.nextLine();

            switch (choice) {
                case 1:
                    addStudent(sc);
                    break;
                case 2:
                    viewStudents();
                    break;
                case 3:
                    editStudent(sc);
                    break;
                case 4:
                    deleteStudent(sc);
                    break;
                case 5:
                    checkDueFees();
                    break;
                case 6:
                    System.out.println("Logging out...");
                    return;
                default:
                    System.out.println("Invalid choice! Try again.");
            }
        }
    }

    private static void addStudent(Scanner sc) {
        System.out.println("\n-------- Add Student ---------");
        System.out.print("Name: ");
        String name = sc.nextLine();
        System.out.print("Email: ");
        String email = sc.nextLine();
        System.out.print("Course: ");
        String course = sc.nextLine();
        System.out.print("Total Fee: ");
        double fee = sc.nextDouble();
        System.out.print("Amount Paid: ");
        double paid = sc.nextDouble();
        sc.nextLine();
        double due = fee - paid;
        System.out.print("Address: ");
        String address = sc.nextLine();
        System.out.print("Phone: ");
        String phone = sc.nextLine();

        Student student = new Student(0, name, email, course, fee, paid, due, address, phone);
        accountantService.addStudent(student);
    }

    private static void viewStudents() {
        System.out.println("\n=== List of Students ===");
        List<Student> students = accountantService.getAllStudents();
        if (students.isEmpty()) {
            System.out.println("No students found.");
        } else {
            for (Student student : students) {
                System.out.println(student);
            }
        }
    }

    private static void editStudent(Scanner sc) {
        System.out.println("\n------- Edit Student ---------");
        System.out.print("Enter Student ID: ");
        int id = sc.nextInt();
        sc.nextLine();

        System.out.print("New Name: ");
        String name = sc.nextLine();
        System.out.print("New Email: ");
        String email = sc.nextLine();
        System.out.print("New Course: ");
        String course = sc.nextLine();
        System.out.print("New Total Fee: ");
        double fee = sc.nextDouble();
        System.out.print("New Amount Paid: ");
        double paid = sc.nextDouble();
        sc.nextLine();
        double due = fee - paid;
        System.out.print("New Address: ");
        String address = sc.nextLine();
        System.out.print("New Phone: ");
        String phone = sc.nextLine();

        Student student = new Student(id, name, email, course, fee, paid, due, address, phone);
        accountantService.editStudent(student);
    }

    private static void deleteStudent(Scanner scanner) {
        System.out.println("\n-------- Delete Student ----------");
        System.out.print("Enter Student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        accountantService.deleteStudent(id);
    }

    private static void checkDueFees() {
        System.out.println("\n---------- Students with Pending Fees ----------");
        List<Student> dueStudents = accountantService.getDueFees();
        if (dueStudents.isEmpty()) {
            System.out.println("No pending fees.");
        } else {
            for (Student student : dueStudents) {
                System.out.println(student);
            }
        }
    }
}
