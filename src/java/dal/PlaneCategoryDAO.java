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
import model.PlaneCategory;

/**
 *
 * @author Admin
 */
public class PlaneCategoryDAO extends DBConnect {

    // DuongNT: to get all of plane categories of corresponding airline - OK
    public List<PlaneCategory> getAllPlaneCategoryByAirlineId(int id) {
        List<PlaneCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Plane_Category WHERE Airlineid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getString("info"), id, rs.getInt("Status_id"));
                ls.add(pc);
            }
            return ls;
        } catch (Exception e) {
        }
        return null;
    }

    // DuongNT: to get a plane categories of corresponding airline with its id- OK
    public PlaneCategory getPlaneCategoryById(int planeCategoryId) {
        String sql = "SELECT * FROM Plane_Category WHERE id =?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, planeCategoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"), rs.getString("image"),
                        rs.getString("info"), rs.getInt("Airlineid"), rs.getInt("Status_id"));
                return pc;
            }
        } catch (Exception e) {
        }
        return null;
    }

    // DuongNT: add a plane category for an airline - OK
    public boolean addPlaneCategory(PlaneCategory pc) {
        String sql = "INSERT INTO Plane_Category (name, image, info, Airlineid, Status_id) VALUES (?, ?, ?, ?, 1)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, pc.getName());
            ps.setString(2, pc.getImage());
            ps.setString(3, pc.getInfo());
            ps.setInt(4, pc.getAirlineid());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activatePlaneCategoryById(int id) {
        String sql = "UPDATE Plane_Category SET Status_id = 1 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void activatePlaneCategoryByAirline(int airlineId) {
        String sql = "UPDATE Plane_Category SET Status_id = ? WHERE airlineId = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deactivatePlaneCategoryById(int id) {
        String sql = "UPDATE Plane_Category SET Status_id = 2 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deactivatePlaneCategoryByAirline(int airlineId) {
        String sql = "UPDATE Plane_Category SET Status_id = ? WHERE airlineId = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAllPlaneCategoryByAirline(int airlineId) {
        String sql = "DELETE FROM Plane_Category WHERE airlineid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, airlineId);  // Thay thế ? bằng airlineId
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DuongNT: update a plane category by id - OK
    public boolean updatePlaneCategoryById(PlaneCategory pc) {
        String sql = "UPDATE Plane_Category SET name = ?, image = ?, info = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, pc.getName());
            ps.setString(2, pc.getImage());
            ps.setString(3, pc.getInfo());
            ps.setInt(4, pc.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // DuongNT: search plane category by name
    public List<PlaneCategory> searchPlaneCategory(String name, int statusId, int airlineId) {
        List<PlaneCategory> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Plane_Category WHERE Airlineid = ?");
        if (statusId != -1) {
            sql.append(" AND Status_id = ?");
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            ps.setInt(1, airlineId);
            int i = 2;
            if (statusId != -1) {
                ps.setInt(i++, statusId);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(i++, "%" + name + "%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"),
                        rs.getString("image"), rs.getString("info"),
                        rs.getInt("Airlineid"), rs.getInt("Status_id"));
                ls.add(pc);
            }
            return ls;
        } catch (Exception e) {
        }
        return null;
    }

    //QuanHT:
    public String getNameById(int planeCategoryId) {
        String categoryName = null;
        String query = "SELECT name FROM Plane_Category WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, planeCategoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                categoryName = rs.getString("name");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoryName;
    }

    //QuanHT: get all categories
    public List<PlaneCategory> getAllCategories() {
        List<PlaneCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM Plane_Category";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PlaneCategory pc = new PlaneCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("info"),
                        rs.getInt("Airlineid"),
                        rs.getInt("Status_id")
                );
                categories.add(pc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
    public boolean isDuplicateCategoryName(String name, int airlineId) {
    String sql = "SELECT * FROM Plane_Category WHERE name = ? AND Airlineid = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ps.setInt(2, airlineId);
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
        PlaneCategoryDAO pd = new PlaneCategoryDAO();
        for (PlaneCategory ls : pd.getAllCategories()) {
            System.out.println("cc");
        }

    }

}
