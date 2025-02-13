/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Airline;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class AirlineManageDAO extends DBConnect {

    public List<Airline> getAllAirline() {
        List<Airline> list = new ArrayList<>();
        String sql = "select * from Airline";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                int statusId = resultSet.getInt("Status_id");
                list.add(new Airline(id, name, image, info, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public String getNameById(int id) {
        String sql = "select name from Airline where id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public String getImageById(int id) {
        String sql = "select image from Airline where id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int getStatusById(int id) {
        String sql = "select * from Airline where id = ?";
        int statusId = -1;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Status_id");
            }
        } catch (Exception e) {
        }
        return statusId;
    }

    public Airline getAirlineById(int id) {
        List<Airline> list = new ArrayList<>();
        String sql = "select * from Airline where id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                int statusId = resultSet.getInt("Status_id");
                list.add(new Airline(id, name, image, info, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list.get(0);
    }

    public String getAirportNamedById(int id) {
        String sql = "SELECT name FROM Airline WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public List<Airline> searchAirline(String name, int statusId) {
        List<Airline> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Airline WHERE 1=1"); // Base query

        // Use a list to hold parameter values
        List<Object> parameters = new ArrayList<>();

        // Check if name is not null or empty
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
            parameters.add("%" + name + "%"); // Add the parameter for name
        }

        // Check if statusId is not null
        if (statusId != -1) {
            sql.append(" AND Status_id = ?");
            parameters.add(statusId); // Add the parameter for statusId
        }

        try {
            PreparedStatement prepare = conn.prepareStatement(sql.toString());

            // Set the parameters in the prepared statement
            for (int i = 0; i < parameters.size(); i++) {
                prepare.setObject(i + 1, parameters.get(i)); // Use setObject for dynamic types
            }

            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String airlineName = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                int status = resultSet.getInt("Status_id"); // Retrieve statusId from the result set
                list.add(new Airline(id, airlineName, image, info, status));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        // Return the list if not empty, otherwise null
        return !list.isEmpty() ? list : null; // Or handle the case as needed
    }

    public List<Airline> getAirlineByStatusId(int statusId) {
        List<Airline> list = new ArrayList<>();
        String sql = "SELECT * FROM Airline WHERE Status_id = ?";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            // Set the statusId parameter in the prepared statement
            prepare.setInt(1, statusId);

            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String airlineName = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                // No need to set statusId again since we're filtering by it
                list.add(new Airline(id, airlineName, image, info, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        // Return the list if not empty, otherwise null
        return !list.isEmpty() ? list : null;
    }

    public List<Baggages> getAirlineBaggages(int airlineId) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select id,weight,price from Baggages\n"
                + "where airlineid = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, airlineId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                list.add(new Baggages(id, weight, price));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int getMaxAirlineId() {

        String sql = "select max(id) as maxId from Airline";
        int id = 0;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                id = resultSet.getInt("maxId");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return id;
    }

    public int createAirline(Airline airline) {
        String sql = "INSERT INTO Airline (name, image,info,Status_id) VALUES (?, ?, ?,1)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, airline.getName());
            preparedStatement.setString(2, airline.getImage());
            preparedStatement.setString(3, airline.getInfo());
            preparedStatement.executeUpdate();

            // Lấy airlineId vừa được tạo
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating airline failed, no ID obtained.");
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQL tại đây
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;  // Trả về ID hoặc giá trị mặc định -1 nếu có lỗi
    }

    public void deleteAirline(int id) {
        String sql = "DELETE FROM `flyezy`.`Airline`\n"
                + "WHERE id = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateAirline(Airline airline) {
        String sql = "UPDATE `flyezy`.`Airline`\n"
                + "SET\n"
                + "`name` =?,\n"
                + "`image` = ?,\n"
                + "`info` = ?\n"
                + "WHERE `id` = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, airline.getName());
            pre.setString(2, airline.getImage());
            pre.setString(3, airline.getInfo());
            pre.setInt(4, airline.getId());
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void changeStatus(int id, int statusId) {
        // Kiểm tra nếu statusId chỉ là 1 hoặc 2
        if (statusId == 1 || statusId == 2) {
            String updateSql = "UPDATE `flyezy`.`Airline`\n"
                    + "SET\n"
                    + "`Status_id` = ?\n"
                    + "WHERE `id` = ?";
            try (PreparedStatement pre = conn.prepareStatement(updateSql)) {
                pre.setInt(1, statusId);
                pre.setInt(2, id);
                pre.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            System.out.println("Invalid status ID. Status ID must be 1 or 2.");
        }
    }

    public boolean checkAirlineDuplicated(String name) {
        String sql = "select * from flyezy.Airline where name = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        AirlineManageDAO dao = new AirlineManageDAO();

////        // Create Airline and Baggage objects
//        Airline airline = new Airline(5, "ab", "ab.jpg", "abc");
//        int n = dao.createAirline(airline);
//        System.out.println("n= " + n);
//        dao.deleteAirline(228);
//        dao.updateAirline(new Airline(9, "abccc", "ab.jpg", "abcccccc", 1));
//        dao.changeStatus(9, 2);
//        for (Airline airline1 : dao.getAllAirline()) {
//            System.out.println(airline1);
//        }
        System.out.println(dao.checkAirlineDuplicated("vietnam airline"));
//        System.out.println(dao.getAirlineById(3));
//        System.out.println(dao.getAirlineBaggages(3));

        //System.out.println(dao.getMaxAirlineId() + 1);
    }
}
