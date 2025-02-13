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
import model.Location;

/**
 *
 * @author user
 */
public class LocationDAO extends DBConnect {

    public List<Location> getAllLocation() {
        List<Location> list = new ArrayList<>();
        String sql = "select * from Location";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int Country_id = rs.getInt("Country_id");
                list.add(new Location(id, name, Country_id));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    public List<Location> searchLocation(String name) {
        List<Location> list = new ArrayList<>();
        String sql = "select * from Location where name like ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setString(1, "%" + name + "%");
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                name = resultSet.getString("name");
                int countryId = resultSet.getInt("Country_id");

                list.add(new Location(id, name, countryId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public Location getLocationById(int id) {
        String sql = "SELECT * FROM Location WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id); 
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int locationId = rs.getInt("id");
                String name = rs.getString("name");
                int countryId = rs.getInt("Country_id");
                Location l = new Location(locationId, name, countryId);
                return l;
            }
        } catch (Exception e) {
        }

        return null; 
    }

    public int getIdByLocationName(String name) {
        String sql = "Select * from Location where name = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setString(1, name);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("id");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public List<Location> getLocationsByCountryId(int cid) {
        List<Location> list = new ArrayList<>();
        String sql = "select * from Location WHERE Country_id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, cid);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int Country_id = resultSet.getInt("Country_id");
                list.add(new Location(id, name, Country_id));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    public static void main(String[] args) {
        LocationDAO dao = new LocationDAO();
        System.out.println(dao.searchLocation("n"));
    }
}
