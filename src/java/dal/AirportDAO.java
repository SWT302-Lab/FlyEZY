/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Airport;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class AirportDAO extends DBConnect {

    public List<Airport> getAllAirport() {
        List<Airport> list = new ArrayList<>();
        String sql = "select * from Airport";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int locationId = resultSet.getInt("Locationid");

                list.add(new Airport(id, name, locationId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    public List<Airport> searchAirport(String name) {
        List<Airport> list = new ArrayList<>();
        String sql = "select * from Airport where name like ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setString(1, "%" + name + "%");
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                name = resultSet.getString("name");
                int locationId = resultSet.getInt("Locationid");

                list.add(new Airport(id, name, locationId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public Airport getAirportById(int id) {
        String sql = "SELECT * FROM Airport WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int airportId = rs.getInt("id");
                String name = rs.getString("name");
                int locationId = rs.getInt("Locationid");
                Airport a = new Airport(airportId, name, locationId);
                return a;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return null;
    }
    
    public int getAirportIdByName(String name) {
        String sql = "SELECT id FROM Airport WHERE name = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("id");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return -1;
    }


    public List<Airport> getAirportsByLocationId(int lid) {
        List<Airport> list = new ArrayList<>();
        String sql = "select * from Airport WHERE Locationid = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, lid);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int locationId = resultSet.getInt("Locationid");

                list.add(new Airport(id, name, locationId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    
    public static void main(String[] args) {
        AirportDAO ad = new AirportDAO();
        System.out.println(ad.getAirportIdByName("Narita International Airport"));
    }
}
