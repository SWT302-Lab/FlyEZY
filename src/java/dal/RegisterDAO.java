/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import controller.GoogleLogin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Accounts;
import model.UserGoogleDto;

/**
 *
 * @author Admin
 */
public class RegisterDAO extends DBConnect {

    public boolean checkPhoneNumberExisted(String phoneNumber) {
        String sql = "select * from Accounts where phoneNumber=?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, phoneNumber);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean checkEmailExisted(String email) {
        String sql = "select * from Accounts where email=?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    //QuanHT
    public void addNewAccount(Accounts a) {
        String sql = """
                 INSERT INTO Accounts 
                     (name, email, password, phoneNumber, Rolesid, Airlineid, created_at, Status_id) 
                 VALUES 
                 (?,?,?,?,?,?,?,?)""";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, a.getName());
            st.setString(2, a.getEmail());
            String encode = encryptAES(a.getPassword(), SECRET_KEY);
            st.setString(3, encode);
            st.setString(4, a.getPhoneNumber());
            st.setInt(5, a.getRoleId());
            st.setInt(6, a.getAirlineId());
            st.setTimestamp(7, a.getCreated_at());
            st.setInt(8, a.getStatus_id());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void addNewGoogleAccount(UserGoogleDto a) {
        String sql = """
                 INSERT INTO Accounts 
                     (name, email, password, phoneNumber, Rolesid, Airlineid, created_at, Status_id) 
                 VALUES 
                 (?,?,?,?,?,?,?,?)""";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, a.getName());
            st.setString(2, a.getEmail());
            st.setString(3, a.getPassword());
            st.setString(4, a.getPhoneNumber());
            st.setInt(5, a.getRoleId());
            st.setInt(6, a.getAirlineId());
            st.setTimestamp(7, a.getCreated_at());
            st.setInt(8, a.getStatus_id());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        RegisterDAO rd = new RegisterDAO();
    }
}
