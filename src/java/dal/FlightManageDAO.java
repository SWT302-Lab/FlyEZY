/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Flights;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author user
 */
public class FlightManageDAO extends DBConnect {

    public List<Flights> getAllFlights() {
        List<Flights> list = new ArrayList<>();
        String sql = "select * from Flight";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                int departureAirportId = resultSet.getInt("departureAirportId");
                int destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");

                list.add(new Flights(id, minutes, departureAirportId, destinationAirportId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int getNumberOfFlights(int idd) {
        List<Flights> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    Count(*)\n"
                + "FROM flyezy.Flight AS f\n"
                + "INNER JOIN flyezy.Airport AS a1 ON a1.id = f.departureAirportid\n"
                + "INNER JOIN flyezy.Airport AS a2 ON a2.id = f.destinationAirportid\n"
                + "INNER JOIN Location AS l1 ON l1.id = a1.locationid\n"
                + "INNER JOIN Country AS c1 ON c1.id = l1.country_id\n"
                + "INNER JOIN Location AS l2 ON l2.id = a2.locationid\n"
                + "INNER JOIN Country AS c2 ON c2.id = l2.country_id\n"
                + "INNER JOIN Status AS s ON s.id = f.Status_id\n"
                + "INNER JOIN Accounts AS acc ON acc.Airlineid = f.Airline_id\n"
                + "WHERE acc.id = " + idd;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }

    public List<Flights> getAllFlightsWithPaging(int index) {
        List<Flights> list = new ArrayList<>();
        String sql = "select * from Flight"
                + "ORDER BY id\n"
                + "LIMIT 5 OFFSET ?;";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, (index - 1) * 5);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                int departureAirportId = resultSet.getInt("departureAirportId");
                int destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");

                list.add(new Flights(id, minutes, departureAirportId, destinationAirportId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public List<Flights> getAllFlightsByDepartAndDes(int departureAirportId, int destinationAirportId) {
        List<Flights> list = new ArrayList<>();
        String sql = "select * from flyezy.Flight where Flight.departureAirportid = ? and Flight.destinationAirportid = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, departureAirportId);
            prepare.setInt(2, destinationAirportId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                departureAirportId = resultSet.getInt("departureAirportId");
                destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");

                list.add(new Flights(id, minutes, departureAirportId, destinationAirportId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }

    public Flights getFlightById(int id) {
        String sql = "SELECT * FROM Flight WHERE id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();

            if (resultSet.next()) {
                int flightId = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                int departureAirportId = resultSet.getInt("departureAirportId");
                int destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");
                int airlineId = resultSet.getInt("Airline_id");
                return new Flights(flightId, minutes, departureAirportId, destinationAirportId, statusId, airlineId);
            }
        } catch (Exception e) {
        }

        return null;
    }

    public String getDepartureByFlight(int id) {
        String sql = "select l.name from flyezy.Flight f \n"
                + "join flyezy.Airport a on a.id = f.departureAirportid\n"
                + "join flyezy.Location l on l.id = a.locationId\n"
                + "where f.id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();

            if (resultSet.next()) {
                return resultSet.getString("name");
            }
        } catch (Exception e) {
        }

        return null;
    }

    public String getDestinationByFlight(int id) {
        String sql = "select l.name from flyezy.Flight f \n"
                + "join flyezy.Airport a on a.id = f.destinationAirportid\n"
                + "join flyezy.Location l on l.id = a.locationId\n"
                + "where f.id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();

            if (resultSet.next()) {
                return resultSet.getString("name");
            }
        } catch (Exception e) {
        }

        return null;
    }

    public boolean checkDuplicated(Flights flight, int airlineId) {
        String sql = "SELECT * FROM Flight WHERE Airline_id = ? AND departureAirportid = ? AND destinationAirportid = ? AND id != ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, airlineId);
            ps.setInt(2, flight.getDepartureAirportId());
            ps.setInt(3, flight.getDestinationAirportId());
            ps.setInt(4, flight.getId()); // không check chuyến bay hiện tại, th mà kh update des và dep sẽ kh bị lỗi
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public Flights getAllFlight() {
        String sql = "select * from Flight";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                int departureAirportId = resultSet.getInt("departureAirportId");
                int destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");
                Flights f = new Flights(id, minutes, departureAirportId, destinationAirportId, statusId, statusId);
                return f;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public int createFlight(Flights flight) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Flight`\n"
                + "(\n"
                + "`minutes`,\n"
                + "`departureAirportid`,\n"
                + "`destinationAirportid`,\n"
                + "`Status_id`,\n"
                + "`Airline_id`)\n"
                + "VALUES\n"
                + "(?,?,?,1,?);";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set các giá trị vào PreparedStatement
//            ps.setInt(1, flight.getId());
            ps.setInt(1, flight.getMinutes());
            ps.setInt(2, flight.getDepartureAirportId());
            ps.setInt(3, flight.getDestinationAirportId());
            ps.setInt(4, flight.getAirlineId());
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public void updateFlight(Flights flight) {
        String sql = "UPDATE `flyezy`.`Flight`\n"
                + "SET\n"
                + "`minutes` = ?,\n"
                + "`departureAirportid` = ?,\n"
                + "`destinationAirportid` = ?\n"
                + "WHERE `id` = ?;";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, flight.getMinutes());
            pre.setInt(2, flight.getDepartureAirportId());
            pre.setInt(3, flight.getDestinationAirportId());
            pre.setInt(4, flight.getId());

            pre.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void changeStatus(int id, int newStatus) {
        String sqlupdate = "UPDATE Flight\n"
                + "                SET\n"
                + "                Status_id = ?\n"
                + "                WHERE id =?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlupdate);
            pre.setInt(2, id);
            pre.setInt(1, newStatus);
            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void changestatusFlightDetaol(int Fid, int newStatus) {
        String sqlupdate = "UPDATE `flyezy`.`flight_detail`\n"
                + "SET\n"
                + "`Status_id` = ? \n"
                + "WHERE Flightid = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlupdate);
            pre.setInt(2, Fid);
            pre.setInt(1, newStatus);
            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void deactivateAllFlightByAirline(int airlineId) {
        String sql = "UPDATE Flight SET Status_id = ? WHERE Airline_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void activateAllFlightByAirline(int airlineId) {
        String sql = "UPDATE Flight SET Status_id = ? WHERE Airline_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        FlightManageDAO dao = new FlightManageDAO();
        System.out.println(dao.getDepartureByFlight(2));

    }

}
