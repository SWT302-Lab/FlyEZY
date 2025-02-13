/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Refund;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.sql.Statement;

/**
 *
 * @author Fantasy
 */
public class RefundDAO extends DBConnect {

    public List<Refund> getAllRefund(int airlineID) {
        List<Refund> ls = new ArrayList<>();
        String sql = "Select r.id,r.bank,r.bankAccount,r.requestDate,r.refundDate,r.refundPrice,r.Ticketid,r.Statusid\n"
                + "From Refund r Join Ticket t On r.Ticketid = t.id\n"
                + "              Join Flight_Detail f on f.id =t.Flight_Detail_id\n"
                + "              Join Flight f1 on f1.id=f.Flightid\n"
                + "              Join Airline a On f1.Airline_id=a.id\n"
                + "              where a.id =?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, airlineID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund(rs.getInt("id"), rs.getString("bank"), rs.getString("bankAccount"),
                        rs.getTimestamp("requestDate"), rs.getTimestamp("refundDate"), rs.getInt("refundPrice"), rs.getInt("Ticketid"),
                        rs.getInt("Statusid"));
                ls.add(refund);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Refund> searchRefund(String Status, String requestDateFrom, String requestDateTo, String refundDateFrom, String refundDateTo,int airlineID) {
        List<Refund> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("Select r.id,r.bank,r.bankAccount,r.requestDate,r.refundDate,r.refundPrice,r.Ticketid,r.Statusid\n"
                + "From Refund r Join Ticket t On r.Ticketid = t.id\n"
                + "              Join Flight_Detail f on f.id =t.Flight_Detail_id\n"
                + "              Join Flight f1 on f1.id=f.Flightid\n"
                + "              Join Airline a On f1.Airline_id=a.id\n"
                + "              where a.id = "+airlineID);

        if (Status != null && !Status.isEmpty()) {
            sql.append(" AND r.Statusid = ?");
        }
        if (requestDateFrom != null && !requestDateFrom.isEmpty()) {
            sql.append(" AND Date(r.requestDate) >= ?");
        }
        if (requestDateTo != null && !requestDateTo.isEmpty()) {
            sql.append(" AND Date(r.requestDate) <= ?");
        }
        if (refundDateFrom != null && !refundDateFrom.isEmpty()) {
            sql.append(" AND Date(r.refundDate) >= ?");
        }
        if (refundDateTo != null && !refundDateTo.isEmpty()) {
            sql.append(" AND Date(r.refundDate) <= ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (Status != null && !Status.isEmpty()) {
                int status = Integer.parseInt(Status);
                ps.setInt(i++, status);
            }
            if (requestDateFrom != null && !requestDateFrom.isEmpty()) {
                ps.setString(i++, requestDateFrom);
            }
            if (requestDateTo != null && !requestDateTo.isEmpty()) {
                ps.setString(i++, requestDateTo);
            }
            if (refundDateFrom != null && !refundDateFrom.isEmpty()) {
                ps.setString(i++, refundDateFrom);
            }
            if (refundDateTo != null && !refundDateTo.isEmpty()) {
                ps.setString(i++, refundDateTo);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund(rs.getInt("id"), rs.getString("bank"), rs.getString("bankAccount"),
                        rs.getTimestamp("requestDate"), rs.getTimestamp("refundDate"), rs.getInt("refundPrice"), rs.getInt("Ticketid"),
                        rs.getInt("Statusid"));
                ls.add(refund);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }
    public int getPriceOfTicket(int id){
         String sql = "Select totalPrice from Ticket t Join Refund r On t.id=r.Ticketid where r.id =?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
        }
        return 0;
    }
    public int createRefund(Refund refund) {
        String sql = "INSERT INTO `flyezy`.`Refund`\n"
                + "(`bank`,`bankAccount`,`requestDate`,`refundDate`,`refundPrice`,`Ticketid`,`Statusid`)\n"
                + "VALUES (?,?,?,?,?,?,13)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, refund.getBank());
            preparedStatement.setString(2, refund.getBankAccount());
            preparedStatement.setTimestamp(3, refund.getRequestDate());
            preparedStatement.setTimestamp(4, refund.getRefundDate());
            preparedStatement.setInt(5, refund.getRefundPrice());
            preparedStatement.setInt(6, refund.getTicketid());
            preparedStatement.executeUpdate();

            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating refund failed, no ID obtained.");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId; 
    }
}
