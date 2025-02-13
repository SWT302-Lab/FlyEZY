/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.News;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class NewsDAO extends DBConnect{
     
    
    public News getNewsById(int id) {
        
        String sql = "select * from News where id= ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News a = new News(rs.getInt("id"), rs.getString("title"), rs.getString("image"), rs.getString("content"), rs.getInt("News_Categoryid"), rs.getInt("Accountsid"), rs.getInt("Airline_id"));
               return a;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        NewsDAO nd = new NewsDAO();
        int id = 11;
        System.out.println(nd.getNewsById(id));
    }
}
