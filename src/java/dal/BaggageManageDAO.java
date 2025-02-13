/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class BaggageManageDAO extends DBConnect {

    public List<Baggages> getAllBaggages() {
        List<Baggages> list = new ArrayList<>();
        String sql = "select * from Baggages";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                int airlineId = resultSet.getInt("airlineId");
                int statusId = resultSet.getInt("Status_id");
                list.add(new Baggages(id, weight, price, airlineId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int getPriceBaggagesById(int id) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select price from Baggages \n"
                + "where id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int price = resultSet.getInt("price");
                return price;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }

    public List<Baggages> getAllBaggagesByAirline(int airlineId) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select * from Baggages\n"
                + "where Airlineid= ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, airlineId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                int airlineIdFound = resultSet.getInt("Airlineid");
                int statusId = resultSet.getInt("Status_id");
                list.add(new Baggages(id, weight, price, airlineIdFound, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int createBaggages(Baggages baggage) {
        String sql = "INSERT INTO `flyezy`.`Baggages` (`weight`, `price`, `Airlineid`,`Status_id`)\n"
                + "VALUES (?, ?, ?,1)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pre.setFloat(1, baggage.getWeight());  // airline name
            pre.setInt(2, baggage.getPrice());  // airline image
            pre.setInt(3, baggage.getAirlineId());
            pre.executeUpdate();

            // Lấy baggageId vừa được tạo
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating airline failed, no ID obtained.");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return generatedId;  // Trả về ID hoặc giá trị mặc định -1 nếu có lỗi
    }

    public void deleteBaggage(int id) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE id = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteAllBaggageByAirline(int airlineId) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE airlineid = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, airlineId);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateBaggage(Baggages baggage) {
        String sql = "UPDATE `flyezy`.`Baggages`\n"
                + "SET\n"
                + "`weight` =?,\n"
                + "`price` = ?\n"
                + "WHERE `id` = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setFloat(1, baggage.getWeight());  // airline name
            pre.setInt(2, baggage.getPrice());  // airline image
            pre.setInt(3, baggage.getId());  // airline image
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void changeStatus(int id, int statusId) {
        // Kiểm tra nếu statusId chỉ là 1 hoặc 2
        if (statusId == 1 || statusId == 2) {
            String updateSql = "UPDATE `flyezy`.`Baggages`\n"
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

    public void DeactiveAllByAirline(int airlineId) {
        // Kiểm tra nếu statusId chỉ là 1 hoặc 2

        String updateSql = "UPDATE `flyezy`.`Baggages`\n"
                + "SET\n"
                + "`Status_id` = ?\n"
                + "WHERE `airlineId` = ?";
        try (PreparedStatement pre = conn.prepareStatement(updateSql)) {
            pre.setInt(1, 2);
            pre.setInt(2, airlineId);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void ReactiveAllByAirline(int airlineId) {
        // Kiểm tra nếu statusId chỉ là 1 hoặc 2

        String updateSql = "UPDATE `flyezy`.`Baggages`\n"
                + "SET\n"
                + "`Status_id` = ?\n"
                + "WHERE `airlineId` = ?";
        try (PreparedStatement pre = conn.prepareStatement(updateSql)) {
            pre.setInt(1, 1);
            pre.setInt(2, airlineId);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public float getWeight(int id) {
        String sql = "select weight from Baggages where id= " + id;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                float weight = resultSet.getFloat("weight");
                return weight;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }

    public int getPriceById(int id) {
        String sql = "SELECT price FROM Baggages WHERE id = ?";
        int price = 0;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                price = resultSet.getInt("price");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return price;
    }

    public boolean checkWeightExists(float weight, int airlineId) {
        String sql = "SELECT * FROM Baggages WHERE weight = ? and Airlineid = ?";
        try (PreparedStatement prepare = conn.prepareStatement(sql)) {
            prepare.setFloat(1, weight);
            prepare.setInt(2, airlineId);
            ResultSet resultSet = prepare.executeQuery();
            return resultSet.next();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        BaggageManageDAO dao = new BaggageManageDAO();

        System.out.println(dao.checkWeightExists(80,4));

    }
}
