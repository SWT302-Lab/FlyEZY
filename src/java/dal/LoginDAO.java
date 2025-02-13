/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class LoginDAO extends DBConnect {

    public boolean checkUsername(String emailOrPhoneNumber) {
        String sql = "SELECT * FROM Accounts WHERE email = ? OR phoneNumber = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                if (emailOrPhoneNumber.equals(email) || emailOrPhoneNumber.equals(phoneNumber)) {
                    return true; // Chỉ trả về true nếu khớp chính xác
                }
            }
        } catch (SQLException e) {
        }

        return false;
    }

    public boolean checkPassword(String emailOrPhoneNumber, String password) {
        String sql = "SELECT * FROM Accounts WHERE (email=? OR phoneNumber=?) AND password=?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean checkStatus(String emailOrPhoneNumber) {
        String sql = "SELECT * FROM Accounts WHERE (email=? OR phoneNumber=?) AND Status_id = 2 ";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public static void main(String[] args) {
        LoginDAO a = new LoginDAO();

        System.out.println(a.checkUsername("td2k416@gmail.com"));
    }

}
