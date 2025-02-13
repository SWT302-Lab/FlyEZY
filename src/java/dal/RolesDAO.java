/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Roles;
/**
 *
 * @author Admin
 */
public class RolesDAO extends DBConnect {
    public List<Roles> getAllRoles(){
        List<Roles> ls = new ArrayList<>();
        String sql = "SELECT * FROM Roles";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Roles r = new Roles(rs.getInt("id"), rs.getString("name"));
                ls.add(r);
            }
            return ls;
        } catch (SQLException e) {
        }
        return null;
    }
    
    public String getNameById(int id){
        String sql = "SELECT * FROM Roles WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
    public static void main(String[] args) {
        RolesDAO rd = new RolesDAO();
        System.out.println(rd.getNameById(1));
    }
}
