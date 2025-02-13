/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import controller.EncodeController;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import model.Accounts;
import java.sql.ResultSet;

/**
 *
 * @author PMQUANG
 */
public class DBConnect extends EncodeController {

    public Connection conn = null;

    public DBConnect(String url, String username, String pass) {
        try {
            //Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            //connection

            conn = DriverManager.getConnection(url, username, pass);
            System.out.println("connected");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public DBConnect() {
        this("jdbc:mysql://localhost:3306/flyezy", "root", "root");
    }

    public ResultSet getData(String sql) {
        Statement state;
        ResultSet rs = null;
        try {
            state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    public static void main(String[] args) {
        AccountsDAO db = new AccountsDAO();
        for (Accounts a : db.getAllAccounts()) {
            System.out.println(a.getName());
        }
    }
}
