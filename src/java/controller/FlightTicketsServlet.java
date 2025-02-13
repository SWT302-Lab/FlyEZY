package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dal.AccountsDAO;
import dal.FlightDetailDAO;
import dal.FlightManageDAO;
import dal.FlightTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;
import java.util.Calendar;
import model.Accounts;
import model.FlightDetails;
import model.Flights;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FlightTicketsServlet", urlPatterns = {"/flightTickets"})
public class FlightTicketsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FlightTicketsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightTicketsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountsDAO ad = new AccountsDAO();
        FlightDetailDAO fdd = new FlightDetailDAO();
        FlightManageDAO fd = new FlightManageDAO();
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);
        try {
            int adultTickets = Integer.parseInt(request.getParameter("adult"));
            int childTickets = Integer.parseInt(request.getParameter("child"));
            int infantTickets = Integer.parseInt(request.getParameter("infant"));
            request.setAttribute("totalPassengers", (adultTickets + childTickets + infantTickets));
        } catch (Exception e) {
            System.out.println(e);
        }
        String depAStr = request.getParameter("departure");
        String desAStr = request.getParameter("destination");
        String depDateStr = request.getParameter("departureDate");

        String flightDetailIdStr = request.getParameter("flightDetailId");

        if (flightDetailIdStr == null) {
            try {
                int depA = Integer.parseInt(depAStr);
                int desA = Integer.parseInt(desAStr);
                Date depDate = Date.valueOf(depDateStr);

                request.setAttribute("flightTickets", fdd.getFlightDetailsByAirportAndDDate(depA, desA, depDate));
            } catch (Exception e) {
            }
        } else {
            int flightDetailId = Integer.parseInt(flightDetailIdStr);
            int depAirlineId = fdd.getAirlineIdByFlightDetailId(flightDetailId);
            FlightDetails depFlightDetail = fdd.getFlightDetailById(flightDetailId);
            Flights depFlight = fd.getFlightById(depFlightDetail.getFlightId());

            Date depDate = depFlightDetail.getDate();// ngày xuất phát
            Time depTime = depFlightDetail.getTime();// thòi gian xuất phát
            int flightMinutes = depFlight.getMinutes();// thời gian bay

            //tính thời gian hạ cánh
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(depDate); // Set the date
            calendar.set(Calendar.HOUR_OF_DAY, depTime.toLocalTime().getHour());
            calendar.set(Calendar.MINUTE, depTime.toLocalTime().getMinute());
            calendar.set(Calendar.SECOND, depTime.toLocalTime().getSecond());
            calendar.set(Calendar.MILLISECOND, 0);

            Timestamp departureTimestamp = new Timestamp(calendar.getTimeInMillis());
            calendar.add(Calendar.MINUTE, flightMinutes);
            Timestamp landing = new Timestamp(calendar.getTimeInMillis());
            Date landingDate = new Date(landing.getTime());
            Time landingTime = Time.valueOf(landing.toLocalDateTime().toLocalTime());
            System.out.println(landingDate + "" + landingTime);

            String reDateStr = request.getParameter("returnDate");
            request.setAttribute("reDate", reDateStr);
            try {
                int depA = Integer.parseInt(depAStr);
                int desA = Integer.parseInt(desAStr);
                Date reDate = Date.valueOf(reDateStr);

                request.setAttribute("flightTickets", fdd.getReturnFlightDetailsByAirportAndDDate(desA, depA, reDate, depAirlineId, landingDate, landingTime));
            } catch (Exception e) {
            }
        }

        request.getRequestDispatcher("view/flightTickets.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
