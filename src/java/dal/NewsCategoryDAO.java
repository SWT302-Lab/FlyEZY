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
import model.NewCategory;

/**
 *
 * @author user
 */
public class NewsCategoryDAO extends DBConnect {

    public List<NewCategory> getNewCategory() {
        List<NewCategory> list = new ArrayList<NewCategory>();
        String sql = "select * from News_Category";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                NewCategory a = new NewCategory(rs.getInt("id"), rs.getString("name"));
                list.add(a);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String getNameNewsCategoryById(int newCategoryId) {
        String sql = "SELECT * FROM News_Category WHERE id =?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newCategoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NewCategory pc = new NewCategory(rs.getInt("id"), rs.getString("name"));
                return pc.getName();
            }
        } catch (Exception e) {
        }
        return null;
    }

   
    
}
