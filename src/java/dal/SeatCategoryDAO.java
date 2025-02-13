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
import model.SeatCategory;

/**
 *
 * @author Admin
 */
public class SeatCategoryDAO extends DBConnect {

    public List<SeatCategory> getAllSeatCategoryByPlaneCategoryId(int id) {
        List<SeatCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Seat_Category WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SeatCategory sc = new SeatCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("numberOfSeat"),
                        rs.getString("image"),
                        rs.getString("info"),
                        rs.getInt("seatEachRow"),
                        rs.getFloat("surcharge"),
                        rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id")
                );
                ls.add(sc);
            }
            return ls;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<SeatCategory> getAllSeatCategoryByFlightDetailId(int id) {
        List<SeatCategory> ls = new ArrayList<>();
        String sql = "select sc.* from flyezy.Seat_Category sc\n"
                + "left join flyezy.Plane_Category pc on pc.id = sc.Plane_Categoryid\n"
                + "left join flyezy.Flight_Detail fd on fd.Plane_Categoryid = pc.id\n"
                + "where fd.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SeatCategory sc = new SeatCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("numberOfSeat"),
                        rs.getString("image"),
                        rs.getString("info"),
                        rs.getInt("seatEachRow"),
                        rs.getFloat("surcharge"),
                        rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id")
                );
                ls.add(sc);
            }
            return ls;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public SeatCategory getSeatCategoryById(int id) {
        String sql = "SELECT * FROM Seat_Category WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new SeatCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("numberOfSeat"),
                        rs.getString("image"),
                        rs.getString("info"),
                        rs.getInt("seatEachRow"),
                        rs.getFloat("surcharge"),
                        rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public SeatCategory getNameBySeatCategoryId(int id) {
        String sql = "SELECT name FROM Seat_Category WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSeatCategory(SeatCategory sc) {
        String sql = "INSERT INTO Seat_Category (name, numberOfSeat, image, info, seatEachRow, surcharge, Plane_Categoryid, Status_id) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setInt(5, sc.getSeatEachRow());
            ps.setFloat(6, sc.getSurcharge());
            ps.setInt(7, sc.getPlane_Categoryid());
            ps.setInt(8, sc.getStatusId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSeatCategory(SeatCategory sc) {
        String sql = "UPDATE Seat_Category SET name = ?, numberOfSeat = ?, image = ?, info = ?, seatEachRow = ?, surcharge = ?, Plane_Categoryid = ?, Status_id = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setInt(5, sc.getSeatEachRow());
            ps.setFloat(6, sc.getSurcharge());
            ps.setInt(7, sc.getPlane_Categoryid());
            ps.setInt(8, sc.getStatusId());
            ps.setInt(9, sc.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateSeatCategoryById(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 1 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deactivateSeatCategoryById(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 2 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateAllSeatCategoryByPlaneCategoryId(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 1 WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void activateAllSeatCategoryByAirline(int airlineId) {
        String sql = "UPDATE Seat_Category sc "
                + "SET sc.Status_id = ? "
                + "WHERE sc.Plane_Categoryid IN ( "
                + "   SELECT pc.id FROM Plane_Category pc "
                + "   WHERE pc.airlineId = ? "
                + ")";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deactivateAllSeatCategoryByPlaneCategoryId(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 2 WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deactivateAllSeatCategoryByAirline(int airlineId) {
        String sql = "UPDATE Seat_Category sc "
                + "SET sc.Status_id = ? "
                + "WHERE sc.Plane_Categoryid IN ( "
                + "   SELECT pc.id FROM Plane_Category pc "
                + "   WHERE pc.airlineId = ? "
                + ")";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getSeatCategoryNameById(int id) {
        String sql = "SELECT name FROM Seat_Category WHERE id = ?";
        String name = null;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);  // Đặt giá trị id vào câu lệnh SQL
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString("name");  // Lấy tên từ kết quả truy vấn
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return name;  // Trả về tên, nếu không có giá trị sẽ trả về null
    }

    public List<SeatCategory> getNameAndNumberOfSeat(int flightDetailId) {
        String sql = "SELECT DISTINCT s.name, s.numberOfSeat, s.numberOfSeat-COUNT(t.Seat_Categoryid) AS countSeat\n"
                + " FROM Seat_Category s\n"
                + " JOIN Ticket t ON s.id = t.Seat_Categoryid\n"
                + " WHERE t.Flight_Detail_id = ? "
                + " And t.code IS NOT NULL and (t.Statusid=12 or t.Statusid=10)\n"
                + " GROUP BY s.name, s.numberOfSeat";
        List<SeatCategory> ls = new ArrayList<>();
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, flightDetailId);  // Đặt giá trị id vào câu lệnh SQL
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                int numberOfSeat = resultSet.getInt("numberOfSeat");
                int countSeat = resultSet.getInt("countSeat");
                ls.add(new SeatCategory(name, numberOfSeat, countSeat));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return ls;
    }

    public int getNumberOfEmptySeat(int flightDetailId, int seatCategoryId) {
        String sql = "SELECT (s.numberOfSeat - COUNT(t.id)) AS ticketCount \n"
                + "FROM Seat_Category s\n"
                + "LEFT JOIN Ticket t ON s.id = t.Seat_Categoryid\n"
                + "  AND t.Flight_Detail_id = ?\n"
                + "  AND t.code IS NOT NULL\n"
                + "  AND (t.Statusid = 12 OR t.Statusid = 10)\n"
                + "WHERE s.id = ?;";
        int ticketCount = 0;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, flightDetailId);
            prepare.setInt(2, seatCategoryId);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                ticketCount = resultSet.getInt("ticketCount");
                return ticketCount;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return ticketCount;
    }

    public boolean isDuplicateSeatCategoryName(String name, int planeCategoryId) {
        String sql = "SELECT * FROM Seat_Category WHERE name = ? AND Plane_Categoryid = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, planeCategoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        SeatCategoryDAO scd = new SeatCategoryDAO();
//        SeatCategory sc = new SeatCategory();
//        sc.setId(20); 
//        sc.setName("New Seat Category Name");
//        sc.setNumberOfSeat(100);
//        sc.setImage("image.jpg");
//        sc.setInfo("Some info about the seat category");
//        sc.setSeatEachRow(10);
//        sc.setSurcharge(20.5f);
//        sc.setPlane_Categoryid(2);
//        sc.setStatusId(1);
//        scd.updateSeatCategory(sc);
        System.out.println(scd.getNumberOfEmptySeat(4, 2));
    }
}
