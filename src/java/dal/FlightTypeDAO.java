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
import model.Country;
import model.FlightType;

/**
 *
 * @author user
 */
public class FlightTypeDAO extends DBConnect {

    public List<FlightType> getAllFlightType() {
        List<FlightType> list = new ArrayList<>();
        String sql = "select * from Flight_Type";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new FlightType(id, name));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public String getNameType(int id) {
        String sql = "Select name from Flight_Type where id= " + id;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                return name;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        FlightTypeDAO dao = new FlightTypeDAO();
        for (FlightType type : dao.getAllFlightType()) {
            System.out.println(type);
        }
    }
}
