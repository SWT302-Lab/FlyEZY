/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.jdbc.PreparedStatementWrapper;
import dal.DBConnect;
import java.sql.Timestamp;
import model.Discount;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.sql.Date;

import model.Airline;

/**
 *
 * @author Admin
 */
public class DiscountDAO extends DBConnect {

    public List<Discount> getAll() {
        List<Discount> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Discount;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String code = rs.getString("code");
                Double percentage = rs.getDouble("percentage");
                int min_order = rs.getInt("minimum_order_value");
                Date date_created = rs.getDate("date_created");
                Date valid_until = rs.getDate("valid_until");
                int Airlineid = rs.getInt("Airline_id");
                int Status_id = rs.getInt("Status_id");

                ls.add(new Discount(id, code, percentage, min_order, date_created, valid_until, Airlineid, Status_id));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return ls;
    }

    public List<Discount> getDiscountByAirlineId(int aid) {
        List<Discount> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Discount WHERE Airline_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, aid); // Đặt tham số cho câu lệnh chuẩn bị
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String code = rs.getString("code");
                Double percentage = rs.getDouble("percentage");
                int min_order = rs.getInt("minimum_order_value");
                Date date_created = rs.getDate("date_created");
                Date valid_until = rs.getDate("valid_until");
                int Airlineid = rs.getInt("Airline_id");
                int Status_id = rs.getInt("Status_id");

                ls.add(new Discount(id, code, percentage, min_order, date_created, valid_until, Airlineid, Status_id));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ls;
    }

    public Discount getDiscountByCode(String dcode, int totalPrice, Timestamp create_at, int airlineId) {
        String sql = "SELECT * FROM Discount d "
                + "WHERE d.code = ? AND ? > d.minimum_order_value AND  d.date_created <= ? AND ? <= d.valid_until AND d.Airline_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dcode);
            ps.setInt(2, totalPrice);
            ps.setTimestamp(3, create_at);
            ps.setTimestamp(4, create_at);
            ps.setInt(5, airlineId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String code = rs.getString("code");
                    Double percentage = rs.getDouble("percentage");
                    int min_order = rs.getInt("minimum_order_value");
                    Date date_created = rs.getDate("date_created");
                    Date valid_until = rs.getDate("valid_until");
                    int Airlineid = rs.getInt("Airline_id");
                    int Status_id = rs.getInt("Status_id");

                    return new Discount(id, code, percentage, min_order, date_created, valid_until, Airlineid, Status_id);

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public double getPercentageById(int id) {
        double percentage = 0.0;
        String sql = "SELECT percentage FROM Discount WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    percentage = rs.getDouble("percentage");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return percentage;
    }

    public double getPercentageByCode(String code) {
        double percentage = 0.0;
        String sql = "SELECT percentage FROM Discount WHERE code = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    percentage = rs.getDouble("percentage");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return percentage;
    }

    public void addNew(Discount discount) {
        String sql = "INSERT INTO Discount (code, percentage, minimum_order_value, date_created, valid_until, Airline_id, Status_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            ps.setString(1, discount.getCode());
            ps.setDouble(2, discount.getPercentage());
            ps.setInt(3, discount.getMin_order());
            ps.setDate(4, new java.sql.Date(discount.getDate_created().getTime()));
            ps.setDate(5, new java.sql.Date(discount.getValid_until().getTime()));
            ps.setInt(6, discount.getAirline_id());
            ps.setInt(7, discount.getStatus_id());

            // Thực hiện thao tác chèn
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Thêm discount thành công.");
            } else {
                System.out.println("Thêm discount thất bại.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDiscount(Discount discount, int id) {
        String sql = "UPDATE Discount SET code = ?, percentage = ?, minimum_order_value = ?, date_created = ?, valid_until = ?, Airline_id = ? WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, discount.getCode()); // Thêm dòng này để cập nhật code
            pstmt.setDouble(2, discount.getPercentage());
            pstmt.setInt(3, discount.getMin_order());
            pstmt.setDate(4, new java.sql.Date(discount.getDate_created().getTime()));
            pstmt.setDate(5, new java.sql.Date(discount.getValid_until().getTime()));
            pstmt.setInt(6, discount.getAirline_id());
            pstmt.setInt(7, id); // ID để xác định bản ghi cần cập nhật

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Discount updated successfully!");
            } else {
                System.out.println("No discount found with the given ID.");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateStatus(int id, int status) {
        String sql = "UPDATE Discount SET Status_id = ? WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, status);
            pstmt.setInt(2, id);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Status updated successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getAirlineNameById(int id) {
        String sql = "SELECT name FROM flyezy.Airline WHERE id = ?";
        String name = null;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString("Name");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return name;
    }

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

    public boolean isUsedDiscount(int accountId, int discountId) {
        String sql = "SELECT * from flyezy.Order o where o.Accounts_id = ? and o.Discount_id = ? and (o.Status_id = 10 or o.Status_id = 12)";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, accountId);
            prepare.setInt(2, discountId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public static void main(String[] args) {

        DiscountDAO dal = new DiscountDAO();
        System.out.println(dal.isUsedDiscount(7, 7));
    }
}
