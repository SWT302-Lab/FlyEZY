/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import jdk.jfr.Timespan;
import model.Feedbacks;

/**
 *
 * @author Fantasy
 */
public class FeedbackDao extends DBConnect {

    public int createFeedback(Feedbacks feedback) {
        int n = 0;
        String sql = """
                 INSERT INTO Feedbacks 
                     (Accountsid, ratedStar, comment, date, created_at, Statusid, Order_id) 
                 VALUES 
                 (?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set các giá trị vào PreparedStatement
            ps.setInt(1, feedback.getAccountsid());
            ps.setInt(2, feedback.getRatedStar());
            ps.setString(3, feedback.getComment());
            ps.setTimestamp(4, feedback.getDate());
            ps.setTimestamp(5, feedback.getCreated_at());
            ps.setInt(6, feedback.getStatusid());
            ps.setInt(7, feedback.getOrder_id());
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }
    public String getContactPhone(int id) {
        int n = 0;
        String sql = "Select contactPhone \n"
                + "from Feedbacks f Join flyezy.`Order` o On f.Order_id = o.id\n"
                + "Where o.id = ?";
        List<String> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void deleteFeedback(int id, int orderId) {
        String sql = "delete from Feedbacks where Accountsid = ? And Order_id=?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Feedbacks getFeedbakByOrderId(int orderId, int accountId) {
        int n = 0;
        String sql = "Select * from Feedbacks where Order_id =? And Accountsid=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Feedbacks getFeedbakByOrderId1(int orderId) {
        int n = 0;
        String sql = "Select * from Feedbacks where Order_id =?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Feedbacks> getFeedbakByOrderId2(int orderId) {
        int n = 0;
        String sql = "Select * from Feedbacks where Order_id =?";
        List<Feedbacks> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedbacks f = new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
                list.add(f);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Feedbacks> getAllFeedback(int id) {
        int n = 0;
        String sql = "Select Distinct f.id,f.Accountsid,f.ratedStar,f.comment,f.date,f.created_at,f.updated_at,f.Statusid,f.Order_id\n"
                + "From Feedbacks f Join `flyezy`.`Order` o On f.Order_id= o.id\n"
                + "                Join  Ticket t On t.Order_id= o.id\n"
                + "                Join  Flight_Detail f1 on f1.id=t.Flight_Detail_id\n"
                + "                Join Flight f2 on f2.id=f1.Flightid\n"
                + "                Join Airline a on a.id=f2.Airline_id\n"
                + "                Where f2.Airline_id =?";
        List<Feedbacks> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedbacks f = new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
                list.add(f);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void updateFeedback(Feedbacks feedbacks) {
        String sql = "UPDATE Feedbacks\n"
                + "   SET ratedStar = ?\n"
                + "      ,comment = ?\n"
                + "      ,updated_at = ?\n"
                + " WHERE Order_id=? And Accountsid=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, feedbacks.getRatedStar());
            pre.setString(2, feedbacks.getComment());
            pre.setTimestamp(3, feedbacks.getUpdated_at());
            pre.setInt(4, feedbacks.getOrder_id());
            pre.setInt(5, feedbacks.getAccountsid());
            pre.executeUpdate();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public List<Feedbacks> searchFeedback(String Status, String Star, String Email, int orderId) {
        List<Feedbacks> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT f.id,f.Accountsid,f.ratedStar,f.comment,f.date,f.created_at,f.updated_at,f.Statusid,f.Order_id,a.email FROM Feedbacks f\n"
                + "              join Accounts a On f.Accountsid=a.id WHERE Order_id=" + orderId);

        if (Status != null && !Status.isEmpty()) {
            sql.append(" AND Statusid = ?");
        }
        if (Star != null && !Star.isEmpty()) {
            sql.append(" AND ratedStar = ?");
        }
        if (Email != null && !Email.isEmpty()) {
            sql.append(" AND email LIKE ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (Status != null && !Status.isEmpty()) {
                int status = Integer.parseInt(Status);
                ps.setInt(i++, status);
            }
            if (Star != null && !Star.isEmpty()) {
                int star = Integer.parseInt(Star);
                ps.setInt(i++, star);
            }
            if (Email != null && !Email.isEmpty()) {
                ps.setString(i++, "%" + Email + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedbacks f = new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
                ls.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public List<Feedbacks> searchFeedback2(String Status, String Star, String Email, int id) {
        List<Feedbacks> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("Select Distinct f.id,f.Accountsid,f.ratedStar,f.comment,f.date,f.created_at,f.updated_at,f.Statusid,f.Order_id\n"
                + "From Feedbacks f Join `flyezy`.`Order` o On f.Order_id= o.id\n"
                + "                Join  Ticket t On t.Order_id= o.id\n"
                + "                Join  Flight_Detail f1 on f1.id=t.Flight_Detail_id\n"
                + "                Join Flight f2 on f2.id=f1.Flightid\n"
                + "                Join Airline a on a.id=f2.Airline_id\n"
                + "                Join Accounts a1 on a1.id=f.Accountsid\n"
                + "                Where f2.Airline_id = " + id);

        if (Status != null && !Status.isEmpty()) {
            sql.append(" AND f.Statusid = ?");
        }
        if (Star != null && !Star.isEmpty()) {
            sql.append(" AND ratedStar = ?");
        }
        if (Email != null && !Email.isEmpty()) {
            sql.append(" AND a1.email LIKE ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (Status != null && !Status.isEmpty()) {
                int status = Integer.parseInt(Status);
                ps.setInt(i++, status);
            }
            if (Star != null && !Star.isEmpty()) {
                int star = Integer.parseInt(Star);
                ps.setInt(i++, star);
            }
            if (Email != null && !Email.isEmpty()) {
                ps.setString(i++, "%" + Email.trim() + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedbacks f = new Feedbacks(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5), rs.getTimestamp(6), rs.getTimestamp(7), rs.getInt(8), rs.getInt(9));
                ls.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public static void main(String[] args) {
        FeedbackDao fd = new FeedbackDao();
        List<Feedbacks> list = fd.getFeedbakByOrderId2(1);
        for (Feedbacks f : list) {
            System.out.println(f.getCreated_at());
        }
    }
}
