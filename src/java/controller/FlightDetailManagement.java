/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FlightDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.sql.Time;
import model.FlightDetails;
import dal.AccountsDAO;
import dal.AirlineManageDAO;
import dal.AirportDAO;
import dal.CountryDAO;
import dal.FlightManageDAO;
import dal.LocationDAO;
import model.Accounts;
import model.Airline;
import model.Airport;
import model.Country;
import model.Flights;
import model.Location;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FlightDetailManage", urlPatterns = {"/flightDetailManagement"})
public class FlightDetailManagement extends HttpServlet {

    FlightDetailDAO dao = new FlightDetailDAO();
    AccountsDAO ad = new AccountsDAO();
    FlightManageDAO fmd = new FlightManageDAO();
    AirportDAO air = new AirportDAO();
    LocationDAO loc = new LocationDAO();
    CountryDAO cou = new CountryDAO();
    AirlineManageDAO airline = new AirlineManageDAO();

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
            out.println("<title>Servlet FlightDetailManage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightDetailManage at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        try {
            Integer idd = (Integer) session.getAttribute("id");
            FlightDetailDAO fdd = new FlightDetailDAO();
            if (idd == null) {
                response.sendRedirect("login");
                return;
            } else {
                Accounts acc = ad.getAccountsById(idd);
                request.setAttribute("account", acc);
            }

            String airlineId = request.getParameter("airlineId");
            if (airlineId != null) {
                request.setAttribute("aid", airlineId);
            }

            String flightid = request.getParameter("flightId");

            if (flightid != null) {
                int fid = Integer.parseInt(flightid);
                request.setAttribute("fid", flightid);
                request.setAttribute("flightid", fid);
                int numberOfItem = fdd.getNumberOfFlightDetail(fid);
                int numOfPage = (int) Math.ceil((double) numberOfItem / 5);
                String idx = request.getParameter("index");
                int index = 1;
                if (idx != null) {
                    index = Integer.parseInt(idx);
                }
                request.setAttribute("index", index);
                request.setAttribute("numOfPage", numOfPage);
                String action = request.getParameter("action");

                Flights listFlight = fmd.getFlightById(fid);
                request.setAttribute("listFlight", listFlight);

                Airline a = airline.getAirlineById(listFlight.getAirlineId());
                request.setAttribute("a", a);

                Airport listAirportDep = air.getAirportById(listFlight.getDepartureAirportId());
                request.setAttribute("listAirportDep", listAirportDep);

                Location listLocationDep = loc.getLocationById(listAirportDep.getLocationId());
                request.setAttribute("listLocationDep", listLocationDep);

                Country listCountryDep = cou.getCountryById(listLocationDep.getCountryId());
                request.setAttribute("listCountryDep", listCountryDep);

                Airport listAirportDes = air.getAirportById(listFlight.getDestinationAirportId());
                request.setAttribute("listAirportDes", listAirportDes);

                Location listLocationDes = loc.getLocationById(listAirportDes.getLocationId());
                request.setAttribute("listLocationDes", listLocationDes);

                Country listCountryDes = cou.getCountryById(listLocationDes.getCountryId());
                request.setAttribute("listCountryDes", listCountryDes);

            List<FlightDetails> detail_ls = dao.getAllDetailByFlightId(fid);
            List<FlightDetails> searchResults = new ArrayList<>();

            if (action != null && action.equals("cancel")) {
                searchResults = dao.getAllDetailByFlightId(fid);
                request.setAttribute("listFlightDetails", searchResults);
            } else if (action != null && action.equals("search")) {

                String statusSearch = request.getParameter("statusSearch");
                String dateSearch = request.getParameter("dateSearch");
                String fromSearch = request.getParameter("fromSearch");
                String toSearch = request.getParameter("toSearch");
                if (statusSearch != null && !statusSearch.isEmpty()) {
                    int status_search = Integer.parseInt(statusSearch);
                    searchResults = dao.searchByStatus(status_search, fid);
                }

                if (dateSearch != null && !dateSearch.isEmpty()) {
                    Date date = Date.valueOf(dateSearch);
                    searchResults = dao.searchByDate(date, fid);

                }
                if (fromSearch != null && toSearch != null && !fromSearch.isEmpty() && !toSearch.isEmpty()) {
                    Time fromTime = Time.valueOf(fromSearch);
                    Time toTime = Time.valueOf(toSearch);
                    searchResults = dao.searchByTimeRange(fromTime, toTime, fid);
                }
                request.setAttribute("listFlightDetails", searchResults);

                } else {
                    request.setAttribute("listFlightDetails", detail_ls);
                }
            }

            request.getRequestDispatcher("view/flightDetailsManagement.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("home");
        }
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
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddFlightDetail(request, response);
                break;
            case "update":
                handleUpdateFlightDetail(request, response);
                break;
            case "updstatus":
                handleUpdateFlightStatus(request, response);
                break;
            case "changeDetail":
                changeToTicket(request, response);
                break;
        }
    }

    private void changeToTicket(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        int flightDetailID = Integer.parseInt(request.getParameter("flightDetailID"));
        request.setAttribute("flightDetailID", flightDetailID);
        response.sendRedirect("TicketController?flightDetailID=" + flightDetailID);
    }

    private void handleAddFlightDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int flightId = Integer.parseInt((String) request.getParameter("flightId"));
        int airlineId = Integer.parseInt((String) request.getParameter("airlineId"));
        FlightDetails newFlightDetail = createFlightDetailFromRequest(request);
        dao.addnew(newFlightDetail);
        response.sendRedirect("flightDetailManagement?flightId=" + flightId + "&airlineId=" + airlineId);
    }

    private void handleUpdateFlightDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int flightId = Integer.parseInt((String) request.getParameter("flightId"));
        int airlineId = Integer.parseInt((String) request.getParameter("airlineId"));
        int id = Integer.parseInt(request.getParameter("id"));
        FlightDetails updatedFlightDetail = createFlightDetailFromRequest(request);
        dao.updateFlightDetail(updatedFlightDetail, id);
        response.sendRedirect("flightDetailManagement?flightId=" + flightId + "&airlineId=" + airlineId);
    }

    private void handleUpdateFlightStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int flightId = Integer.parseInt((String) request.getParameter("flightId"));
        int airlineId = Integer.parseInt((String) request.getParameter("airlineId"));
        int id = Integer.parseInt(request.getParameter("id"));
        int status_id = Integer.parseInt(request.getParameter("status"));
        dao.updateFlightStatus(id, status_id);
        response.sendRedirect("flightDetailManagement?flightId=" + flightId + "&airlineId=" + airlineId);
    }

    private FlightDetails createFlightDetailFromRequest(HttpServletRequest request) {
        String dateString = request.getParameter("date");
        String timeString = request.getParameter("time");
        String priceString = request.getParameter("price");
        String flightIdString = request.getParameter("flightId");
        String planeCategoryIdString = request.getParameter("planeCategoryId");

        Date date = Date.valueOf(dateString);
        Time time = Time.valueOf(timeString);
        int price = Integer.parseInt(priceString);
        int flightId = Integer.parseInt(flightIdString);
        int planeCategoryId = Integer.parseInt(planeCategoryIdString);

        FlightDetails flightDetail = new FlightDetails();
        flightDetail.setDate(date);
        flightDetail.setTime(time);
        flightDetail.setPrice(price);
        flightDetail.setFlightId(flightId);
        flightDetail.setPlaneCategoryId(planeCategoryId);

        return flightDetail;
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
