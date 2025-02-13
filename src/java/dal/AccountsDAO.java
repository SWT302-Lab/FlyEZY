/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import model.Accounts;

/**
 *
 * @author Admin
 */
public class AccountsDAO extends DBConnect {

    private final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    public List<Accounts> getAllAccountsWithPaging(int index) {
        List<Accounts> ls = new ArrayList<>();
        String sql = "SELECT * FROM Accounts\n"
                + "ORDER BY id\n"
                + "LIMIT 5 OFFSET ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));
                ls.add(a);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Accounts> getAllAccounts() {
        List<Accounts> ls = new ArrayList<>();
        String sql = "Select * from Accounts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));
                ls.add(a);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public int getNumberOfAccounts() {
        String sql = "Select Count(*) from Accounts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
        }
        return 0;
    }

    public int getIdByEmailOrPhoneNumber(String emailOrPhoneNumber) {
        String sql = "SELECT id FROM Accounts WHERE email = ? OR phoneNumber = ?";
        int userId = -1;

        try (PreparedStatement st = conn.prepareStatement(sql)) {

            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }

    public Accounts getAccountsById(int id) {
        String sql = "SELECT * FROM Accounts WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public String getAccountNameById(int id) {
        String sql = "SELECT * FROM Accounts WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));
                return a.getName();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public String getAccountEmailById(int id) {
        String sql = "SELECT * FROM Accounts WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));
                return a.getEmail();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateAccount(Accounts account) {
        String sql = "UPDATE Accounts\n"
                + "   SET name = ?\n"
                + "      ,email = ?\n"
                + "      ,password = ?\n"
                + "      ,phoneNumber = ?\n"
                + "      ,address = ?\n"
                + "      ,Rolesid = ?\n"
                + "      ,Airlineid = ?\n"
                + "      ,image = ?\n"
                + "      ,dob = ?\n"
                + "      ,updated_at = ?\n"
                + " WHERE id=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, account.getName());
            pre.setString(2, account.getEmail());
            String encode = encryptAES(account.getPassword(), SECRET_KEY);
            pre.setString(3, encode);
            pre.setString(4, account.getPhoneNumber());
            pre.setString(5, account.getAddress());
            pre.setInt(6, account.getRoleId());
            pre.setInt(7, account.getAirlineId());
            pre.setString(8, account.getImage());
            pre.setDate(9, account.getDob());
            pre.setTimestamp(10, account.getUpdated_at());
            pre.setInt(11, account.getId());

            pre.executeUpdate();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void changeStatusAccount(int id, int status) {
        String sql = "UPDATE Accounts\n"
                + "   SET Status_id=?"
                + " WHERE id=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);

            pre.executeUpdate();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void removeAccount(int id) {
        String sql = "delete from Accounts where id = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Accounts> searchAccounts(String role, String name, String phoneNumber) {
        List<Accounts> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Accounts WHERE 1=1");

        if (role != null && !role.isEmpty()) {
            sql.append(" AND Rolesid = ?");
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            sql.append(" AND phoneNumber LIKE ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (role != null && !role.isEmpty()) {
                ps.setString(i++, role);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(i++, "%" + name + "%");
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                String vp = phoneNumber;
                if (vp.startsWith("0")) {
                    vp = vp.substring(1);
                }
                ps.setString(i++, "%" + vp + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"),
                        rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"), rs.getInt("Status_id"));

                ls.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public boolean checkAccount(Accounts accounts) {
        String emailQuery = "SELECT * FROM Accounts WHERE email = ?";
        String phoneQuery = "SELECT * FROM Accounts WHERE phoneNumber = ?";

        try {
            // Kiểm tra email
            PreparedStatement emailStatement = conn.prepareStatement(emailQuery);
            emailStatement.setString(1, accounts.getEmail());  // Thay thế dấu ? bằng giá trị email
            ResultSet emailResultSet = emailStatement.executeQuery();
            if (emailResultSet.next()) {
                return false;  // Email đã tồn tại
            }

            // Kiểm tra số điện thoại
            PreparedStatement phoneStatement = conn.prepareStatement(phoneQuery);
            phoneStatement.setString(1, accounts.getPhoneNumber());  // Thay thế dấu ? bằng giá trị phoneNumber
            ResultSet phoneResultSet = phoneStatement.executeQuery();
            if (phoneResultSet.next()) {
                return false;  // Số điện thoại đã tồn tại
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Có thể thay bằng logging để ghi log lỗi
        }

        return true;  // Email và số điện thoại đều chưa tồn tại
    }

    public int createAccount(Accounts accounts) {
        int n = 0;
        String sql = """
                 INSERT INTO Accounts 
                     (name, email, password, phoneNumber, address, image, dob, Rolesid,created_at,Airlineid,Status_id) 
                 VALUES 
                 (?,?,?,?,?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set các giá trị vào PreparedStatement
            ps.setString(1, accounts.getName());
            ps.setString(2, accounts.getEmail());

            String encode = encryptAES(accounts.getPassword(), SECRET_KEY);
            ps.setString(3, encode);

            ps.setString(4, accounts.getPhoneNumber());
            ps.setString(5, accounts.getAddress());
            ps.setString(6, accounts.getImage());
            ps.setDate(7, accounts.getDob());
            ps.setInt(8, accounts.getRoleId());
            ps.setTimestamp(9, accounts.getCreated_at());
            ps.setInt(10, accounts.getAirlineId());
            ps.setInt(11, accounts.getStatus_id());
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public void changePassword(String idAccount, String newPassword) {
        String sqlupdate = "UPDATE `flyezy`.`Accounts`\n"
                + "SET\n"
                + "`password` = ?\n"
                + "WHERE `id` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlupdate);
            String encode = encryptAES(newPassword, SECRET_KEY);
            pre.setString(1, encode);
            pre.setString(2, idAccount);

            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void infoUpdate(Accounts account) {
        String sqlUpdate = "UPDATE `flyezy`.`Accounts`\n"
                + "SET\n"
                + "`name` = ?,\n"
                + "`dob` = ?,\n"
                + "`email` = ?,\n"
                + "`phoneNumber` = ?,\n"
                + "`address` = ?,\n"
                + "`image` = ?\n"
                + "WHERE `id` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlUpdate);
            pre.setString(1, account.getName());
            pre.setDate(2, account.getDob());
            pre.setString(3, account.getEmail());
            pre.setString(4, account.getPhoneNumber());
            pre.setString(5, account.getAddress());
            pre.setString(6, account.getImage());
            pre.setInt(7, account.getId());
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteAllAccountByAirline(int airlineId) {
        String sql = "DELETE FROM `flyezy`.`Accounts` WHERE airlineid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, airlineId);  // Thay thế ? bằng airlineId
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int findIdByEmail(String email) {
        String sql = "select id from Accounts where email = ?";
        int userId = -1;
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return userId;
    }

    public boolean checkEmailExist(String email) {
        String sql = "select * from Accounts where email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public String generateRandomString() {
        StringBuilder sb = new StringBuilder(8);
        Random r = new Random();
        for (int i = 0; i < 8; i++) {
            int index = r.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }

    public void deactivateAllAccountByAirline(int airlineId) {
        String sql = "UPDATE Accounts SET Status_id = ? WHERE Airlineid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void activateAllAccountByAirline(int airlineId) {
        String sql = "UPDATE Accounts SET Status_id = ? WHERE Airlineid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        AccountsDAO dao = new AccountsDAO();
        System.out.println(dao.getNumberOfAccounts());
    }
}
