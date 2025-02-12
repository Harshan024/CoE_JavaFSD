package Week_3;

import java.util.Scanner;

public class AdminUI {
    private static AdminService adminService = new AdminService();

    public static void adminMenu() {
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n------- Admin Dashboard -------");
            System.out.println("1. Add Accountant");
            System.out.println("2. View Accountants");
            System.out.println("3. Edit Accountant");
            System.out.println("4. Delete Accountant");
            System.out.println("5. Logout");
            System.out.print("Enter your choice: ");
            int choice = sc.nextInt();
            sc.nextLine(); 

            switch (choice) {
                case 1:
                    System.out.println("\n------- Add Accountant ---------");
                    System.out.print("Name: ");
                    String name = sc.nextLine();
                    System.out.print("Email: ");
                    String email = sc.nextLine();
                    System.out.print("Phone: ");
                    String phone = sc.nextLine();
                    System.out.print("Password: ");
                    String accPassword = sc.nextLine();
                    adminService.addAccountant(name, email, phone, accPassword);
                    break;

                case 2:
                    System.out.println("\n-------- List of Accountants -----------");
                    adminService.viewAccountants();
                    break;

                case 3:
                    System.out.println("\n--------- Edit Accountant ---------");
                    System.out.print("Enter Accountant ID: ");
                    int editId = sc.nextInt();
                    sc.nextLine();
                    System.out.print("New Name: ");
                    String newName = sc.nextLine();
                    System.out.print("New Email: ");
                    String newEmail = sc.nextLine();
                    System.out.print("New Phone: ");
                    String newPhone = sc.nextLine();
                    System.out.print("New Password: ");
                    String newPassword = sc.nextLine();
                    adminService.editAccountant(editId, newName, newEmail, newPhone, newPassword);
                    break;

                case 4:
                    System.out.println("\n--------- Delete Accountant --------");
                    System.out.print("Enter Accountant ID: ");
                    int deleteId = sc.nextInt();
                    sc.nextLine();
                    adminService.deleteAccountant(deleteId);
                    break;

                case 5:
                    System.out.println("Logging out...");
                    return;

                default:
                    System.out.println("Invalid choice!... Try again");
            }
        }
    }
}
