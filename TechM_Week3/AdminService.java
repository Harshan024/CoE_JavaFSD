package Week_3;

public class AdminService {
    private AdminDAO adminDAO;

    public AdminService() {
        this.adminDAO = new AdminDAO();
    }

    public boolean authenticateAdmin(String username, String password) {
        return adminDAO.login(username, password);
    }

    public void addAccountant(String name, String email, String phone, String password) {
        adminDAO.addAccountant(name, email, phone, password);
    }

    public void viewAccountants() {
        adminDAO.viewAccountants().forEach(System.out::println);
    }

    public void editAccountant(int id, String name, String email, String phone, String password) {
        adminDAO.editAccountant(id, name, email, phone, password);
    }

    public void deleteAccountant(int id) {
        adminDAO.deleteAccountant(id);
    }
}
