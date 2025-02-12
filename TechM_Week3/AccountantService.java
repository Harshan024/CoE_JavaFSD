package Week_3;

import java.util.List;

public class AccountantService {
    private AccountantDAO accountantDAO;

    public AccountantService() {
        this.accountantDAO = new AccountantDAO();
    }

    public boolean authenticateAccountant(String email, String password) {
        return accountantDAO.login(email, password);
    }

    public void addStudent(Student student) {
        accountantDAO.addStudent(student);
    }

    public List<Student> getAllStudents() {
        return accountantDAO.viewStudents();
    }

    public void editStudent(Student student) {
        accountantDAO.editStudent(student);
    }

    public void deleteStudent(int id) {
        accountantDAO.deleteStudent(id);
    }

    public List<Student> getDueFees() {
        return accountantDAO.viewDueFees();
    }
}
