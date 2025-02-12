package Week_3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    public boolean login(String username, String password) {
        String query = "SELECT * FROM admin WHERE(username= ? AND password=?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addAccountant(String name, String email, String phone, String password) {
        String query = "INSERT INTO accountant (name, email, phone, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, password);

            stmt.executeUpdate();
            System.out.println("Accountant added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<String> viewAccountants() {
        String query = "SELECT * FROM accountant";
        List<String> accountants = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                accountants.add(rs.getInt("id") + ". " + rs.getString("name") + " - " + rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountants;
    }

    public void editAccountant(int id, String name, String email, String phone, String password) {
        String query = "UPDATE accountant SET name=?, email=?, phone=?, password=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, password);
            stmt.setInt(5, id);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Accountant updated successfully!");
            } else {
                System.out.println("No accountant found with the given ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAccountant(int id) {
        String query = "DELETE FROM accountant WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Accountant deleted successfully!");
            } else {
                System.out.println("No accountant found with the given ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
