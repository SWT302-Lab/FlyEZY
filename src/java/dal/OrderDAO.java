/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Order;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;

/**
 *
 * @author PMQUANG
 */
public class OrderDAO extends DBConnect {

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> getAllOrdersByAccountId(int accountId,int index) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where Accounts_id=? order by id desc"
                + " LIMIT 2 OFFSET ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setInt(2, (index-1)*2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }
    public int getNumberAllOrdersByAccountId(int accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where Accounts_id=? order by id desc";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list.size();
        } catch (Exception e) {
        }
        return 0;
    }
    public void updatetotalPriceOfOrder(int orderId, double totalPrice) {
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE flyezy.Order SET totalPrice = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);

            // Thiết lập giá trị cho các tham số
            ps.setDouble(1, totalPrice);
            ps.setInt(2, orderId);

            // Thực hiện cập nhật
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } 
    }
    public int getAirlineIdByOrder(int id) {
        String sql = "select o.id,f.Airline_id from flyezy.Order o\n"
                + "join Ticket t on t.Order_id = o.id\n"
                + "join Flight_Detail fd on t.Flight_Detail_id = fd.id\n"
                + "join Flight f on f.id = fd.Flightid\n"
                + "where o.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Airline_id");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }

    public List<Order> getAllOrderByAirlineId(int airlineId) {
        List<Order> list = new ArrayList<>();
        String sql = "select distinct o.* from flyezy.Order o\n"
                + "join Ticket t on t.Order_id = o.id\n"
                + "join Flight_Detail fd on fd.id = t.Flight_Detail_id\n"
                + "join Flight f on f.id = fd.Flightid\n"
                + "where f.Airline_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, airlineId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public int getFlightIdByOrder(int id) {
        String sql = "select o.id,fd.Flightid from flyezy.Order o\n"
                + "join Ticket t on t.Order_id = o.id\n"
                + "join Flight_Detail fd on t.Flight_Detail_id = fd.id\n"
                + "where o.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Flightid");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }

    public List<Order> searchOrder(int statusId, String code, String keyword, int airlineId) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT distinct o.* FROM flyezy.Order o "
                + "JOIN Ticket t ON t.Order_id = o.id "
                + "JOIN Flight_Detail fd ON fd.id = t.Flight_Detail_id "
                + "JOIN Flight f ON f.id = fd.Flightid "
                + "WHERE f.Airline_id = ? "
        );

        // Use a list to hold parameter values
        List<Object> parameters = new ArrayList<>();
        parameters.add(airlineId); // airlineId is mandatory

        // Append condition for code if provided
        if (code != null && !code.trim().isEmpty()) {
            sql.append("AND o.code LIKE ? ");
            parameters.add("%" + code + "%");
        }

        // Append condition for statusId if provided
        if (statusId != -1) { // Assuming -1 means "no filter"
            sql.append("AND o.Status_id = ? ");
            parameters.add(statusId);
        }

        // Append condition for keyword if provided
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (o.contactName LIKE ? OR o.contactPhone LIKE ? OR o.contactEmail LIKE ?) ");
            String keywordPattern = "%" + keyword + "%";
            parameters.add(keywordPattern);
            parameters.add(keywordPattern);
            parameters.add(keywordPattern);
        }

        try {
            // Prepare the SQL statement
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            // Set the parameters in the prepared statement
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i)); // Use setObject for dynamic types
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return !list.isEmpty() ? list : null;
    }

    public List<Order> getAllOrdersByFlightDetail(int flightDetailId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where flyezy.Order.Flight_Detail_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> getAllOrdersByFlightDetailWithPaging(int flightDetailId, int index) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where flyezy.Order.Flight_Detail_id = ? LIMIT 5 OFFSET ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ps.setInt(2, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public int getNumberOfOrdersByFlightDetail(int flightDetailId) {
        String sql = "select Count(*) from flyezy.Order where flyezy.Order.Flight_Detail_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateDiscountOrder(int did, int oid) {
        // Câu lệnh SQL để cập nhật Discount_id trong bảng Order
        String sql = "UPDATE flyezy.Order SET Discount_id = ? WHERE id = ?";

        // Kết nối với cơ sở dữ liệu và thực hiện cập nhật
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, did);
            ps.setInt(2, oid);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Discount updated successfully.");
            } else {
                System.out.println("No rows updated, maybe the order ID doesn't exist.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateOrderStatus(int orderId, int newStatusId) {
        String sql = "UPDATE flyezy.Order SET Status_id = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newStatusId);
            ps.setInt(2, orderId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Order getOrderByOrderId(int id) {
        String sql = "select * from flyezy.Order where id= ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order a = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                return a;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean successfullPayment(int orderId, int paymentType) {
        String sql = "UPDATE flyezy.Order SET Payment_Types_id = ?, paymentTime = ?,  Status_id = 10 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, paymentType);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, orderId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String createOrder(String contactName, String contactPhone, String contactEmail, int totalPrice, Integer accountId) {
        String sql = "INSERT INTO `Order` (code, contactName, contactPhone, contactEmail, totalPrice, Accounts_id,Status_id, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        String code = generateUniqueCode();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ps.setString(2, contactName);
            ps.setString(3, contactPhone);
            ps.setString(4, contactEmail);
            ps.setInt(5, totalPrice);
            if (accountId != null) {
                ps.setInt(6, accountId);
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
            ps.setInt(7, 12); //is pending
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
            return code;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public String generateUniqueCode() {
        String code;
        List<String> existingCodes = getAllOrderCodes();
        Random random = new Random();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        do {
            StringBuilder sb = new StringBuilder(9);
            for (int i = 0; i < 9; i++) {
                sb.append(characters.charAt(random.nextInt(characters.length())));
            }
            code = sb.toString();
        } while (existingCodes.contains(code));

        return code;
    }

    public List<String> getAllOrderCodes() {
        List<String> codes = new ArrayList<>();
        String sql = "SELECT code FROM flyezy.Order";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                codes.add(rs.getString("code"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return codes;
    }

    public String getCodeByOrderId(Integer id) {
        // Kiểm tra xem id có null không, nếu có thì trả về null hoặc chuỗi trống
        if (id == null) {
            return null;
        }

        String sql = "SELECT code FROM flyezy.Order WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("code");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Order getOrderInfoByTicket(int ticketId) {

        String sql = "select o.code,o.contactName,o.contactPhone,o.contactEmail,o.Accounts_id,o.Payment_Types_id,o.paymentTime,o.Status_id from flyezy.Order o\n"
                + "join Ticket t on t.Order_id = o.id\n"
                + "where t.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Order(rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getInt("Status_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Order getOrderById(int id) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Order WHERE id= ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no order is found
    }

    public Order getOrderByCode(String code) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Order WHERE code= ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no order is found
    }

    public void deleteOrderByCode(String code) {
        String sql = "DELETE FROM flyezy.Order WHERE code = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getListOrderByCodeAndAccountId(String code, int accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Order WHERE code= ? and Accounts_id = ? order by id desc";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(order);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no order is found
    }

    public List<Order> getOrdersAccountId(int accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order\n"
                + "where Accounts_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> getOrdersByStatusAndAccountId(int statusId, int accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order\n"
                + "where flyezy.Order.Status_id=? and Accounts_id = ? order by id desc";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, statusId);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public void updateTotalPrice(int orderId, int newTotalPrice) {
        String sql = "UPDATE flyezy.Order SET totalPrice = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newTotalPrice);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalPriceAllTickets(int orderId) {
        String sql = "SELECT SUM(totalPrice) as total FROM flyezy.Ticket WHERE Order_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalPriceByOrderId(int orderId) {
        String sql = "SELECT totalPrice FROM flyezy.Order WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalPrice");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalPriceCancelledTicket(int orderId) {
        String sql = "SELECT SUM(totalPrice) as total FROM flyezy.Ticket WHERE Order_id = ? and (Statusid = 7 or Statusid = 8 or Statusid=13 or Statusid=14)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void cancelOrderById(int id) {
        String sql = "UPDATE flyezy.Order SET Status_id = 7 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
    }

}
