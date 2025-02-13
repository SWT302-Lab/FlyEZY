/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import dal.TicketDAO;
import dal.FlightTypeDAO;
import dal.PassengerTypeDAO;
import dal.StatusDAO;
import dal.AirportDAO;
import dal.FlightDetailDAO;
import dal.FlightManageDAO;
import dal.PlaneCategoryDAO;
import dal.LocationDAO;
import dal.CountryDAO;
import dal.SeatCategoryDAO;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Ticket;
import model.FlightType;
import model.PlaneCategory;
import model.FlightDetails;
import model.Flights;
import model.PassengerType;
import model.Status;
import model.Airport;
import model.Location;
import model.Country;
import model.SeatCategory;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "TicketManagementServlet", urlPatterns = {"/TicketController"})
public class TicketManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet TicketManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TicketManagementServlet at " + request.getContextPath() + "</h1>");
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
        TicketDAO td = new TicketDAO();
        AccountsDAO ad = new AccountsDAO();
        FlightTypeDAO ftd = new FlightTypeDAO();
        PassengerTypeDAO ptd = new PassengerTypeDAO();
        FlightDetailDAO fdd = new FlightDetailDAO();
        FlightManageDAO fmd = new FlightManageDAO();
        AirportDAO aid = new AirportDAO();
        LocationDAO ld = new LocationDAO();
        StatusDAO sd = new StatusDAO();
        CountryDAO cd = new CountryDAO();
        SeatCategoryDAO scd = new SeatCategoryDAO();
        PlaneCategoryDAO pcd = new PlaneCategoryDAO();
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            int i = (idd != null) ? idd : -1;
            Accounts acc = ad.getAccountsById(i);
            request.setAttribute("account", acc);
        }

        String action = request.getParameter("action");
        String flightDetailIdStr = request.getParameter("flightDetailID");
        String orderIdStr = request.getParameter("orderId");
        int flightDetailID = -1;
        int orderId = -1;

        if (flightDetailIdStr != null) {
            flightDetailID = Integer.parseInt(flightDetailIdStr);
            request.setAttribute("flightDetailID", flightDetailID);
        }
        if (orderIdStr != null) {
            orderId = Integer.parseInt(orderIdStr);
            request.setAttribute("orderId", orderId);
        }
        List<Ticket> ticketList;
        if (orderId != -1) {
            ticketList = td.getAllTicketsByOrderId(orderId);
        } else {
            int numberOfItem = td.getNumberOfTicket(flightDetailID);
            int numOfPage = (int) Math.ceil((double) numberOfItem / 5);
            String idx = request.getParameter("index");
            int index = 1;
            if (idx != null) {
                index = Integer.parseInt(idx);
            }
            request.setAttribute("index", index);
            request.setAttribute("numOfPage", numOfPage);
            ticketList = td.getAllTicketsByIdWithPaging(flightDetailID, index);
        }
        request.setAttribute("ticketList", ticketList);

        if (flightDetailID != -1) {
            Flights flight = fdd.getFlightByFlightDetailId(flightDetailID);
            request.setAttribute("flight", flight);

            int airlineId = fdd.getAirlineIdByFlightDetailId(flightDetailID);
            request.setAttribute("airlineId", airlineId);

            Airport airportDep = aid.getAirportById(flight.getDepartureAirportId());
            request.setAttribute("airportDep", airportDep);
            Location locationDep = ld.getLocationById(airportDep.getId());
            request.setAttribute("locationDep", locationDep);
            Country countryDep = cd.getCountryById(locationDep.getCountryId());
            request.setAttribute("countryDep", countryDep);

            Airport airportDes = aid.getAirportById(flight.getDestinationAirportId());
            request.setAttribute("airportDes", airportDes);
            Location locationDes = ld.getLocationById(airportDes.getId());
            request.setAttribute("locationDes", locationDes);
            Country countryDes = cd.getCountryById(locationDes.getCountryId());
            request.setAttribute("countryDes", countryDes);

            FlightDetails flightDetail = fdd.getFlightDetailsByID(flightDetailID);
            request.setAttribute("flightDetail", flightDetail);
            PlaneCategory planeCatrgory = pcd.getPlaneCategoryById(flightDetail.getPlaneCategoryId());
            request.setAttribute("planeCatrgory", planeCatrgory);
        }

        List<FlightType> flightTypeList = ftd.getAllFlightType();
        request.setAttribute("flightTypeList", flightTypeList);

        List<PassengerType> passengerTypeList = ptd.getAllPassengerType();
        request.setAttribute("passengerTypeList", passengerTypeList);

        List<Status> statusTicketList = sd.getStatusOfTicket();
        request.setAttribute("statusTicketList", statusTicketList);

        List<SeatCategory> seatList = scd.getNameAndNumberOfSeat(flightDetailID);
        request.setAttribute("seatList", seatList);

        List<SeatCategory> seatCategoryList = scd.getAllSeatCategoryByFlightDetailId(flightDetailID);
        request.setAttribute("seatCategoryList", seatCategoryList);

        if (action == null) {
            request.getRequestDispatcher("view/ticketManagement.jsp").forward(request, response);
        } else if (action.equals("search")) {

            String flightType = request.getParameter("flightType");
            String passengerType = request.getParameter("passengerType");
            String statusTicket = request.getParameter("statusTicket");
            String fName = request.getParameter("fName").trim();
            String fPhoneNumber = request.getParameter("fPhoneNumber").trim();
            String orderCode = request.getParameter("orderCode").trim();
            request.setAttribute("orderCode", orderCode);
            List<Ticket> ticketSearchList;
            ticketSearchList = td.searchTickets2(passengerType, statusTicket, fName, fPhoneNumber, flightDetailID, flightType, orderCode);
            request.setAttribute("ticketList", ticketSearchList);
            request.getRequestDispatcher("view/ticketManagement.jsp").forward(request, response);
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
        TicketDAO td = new TicketDAO();
        AccountsDAO ad = new AccountsDAO();
        FlightTypeDAO ftd = new FlightTypeDAO();
        PassengerTypeDAO ptd = new PassengerTypeDAO();
        FlightDetailDAO fdd = new FlightDetailDAO();
        FlightManageDAO fmd = new FlightManageDAO();
        AirportDAO aid = new AirportDAO();
        LocationDAO ld = new LocationDAO();
        StatusDAO sd = new StatusDAO();
        CountryDAO cd = new CountryDAO();
        PlaneCategoryDAO pcd = new PlaneCategoryDAO();
        SeatCategoryDAO scd = new SeatCategoryDAO();
        HttpSession session = request.getSession();
        int flightDetailID = Integer.parseInt(request.getParameter("flightDetailID"));

        Flights flight = fdd.getFlightByFlightDetailId(flightDetailID);
        request.setAttribute("flight", flight);
        Airport airportDep = aid.getAirportById(flight.getDepartureAirportId());
        request.setAttribute("airportDep", airportDep);
        Location locationDep = ld.getLocationById(airportDep.getId());
        request.setAttribute("locationDep", locationDep);
        Country countryDep = cd.getCountryById(locationDep.getCountryId());
        request.setAttribute("countryDep", countryDep);

        Airport airportDes = aid.getAirportById(flight.getDestinationAirportId());
        request.setAttribute("airportDes", airportDes);
        Location locationDes = ld.getLocationById(airportDes.getId());
        request.setAttribute("locationDes", locationDes);
        Country countryDes = cd.getCountryById(locationDes.getCountryId());
        request.setAttribute("countryDes", countryDes);

        FlightDetails flightDetail = fdd.getFlightDetailsByID(flightDetailID);
        request.setAttribute("flightDetail", flightDetail);
        PlaneCategory planeCatrgory = pcd.getPlaneCategoryById(flightDetail.getPlaneCategoryId());
        request.setAttribute("planeCatrgory", planeCatrgory);

        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        List<Ticket> ticketList = td.getAllTicketsById(flightDetailID);
        request.setAttribute("ticketList", ticketList);

        List<Ticket> allTicketList = td.getAllTickets();
        request.setAttribute("ticketList", ticketList);

        List<FlightType> flightTypeList = ftd.getAllFlightType();
        request.setAttribute("flightTypeList", flightTypeList);

        List<PassengerType> passengerTypeList = ptd.getAllPassengerType();
        request.setAttribute("passengerTypeList", passengerTypeList);

        List<Status> statusTicketList = sd.getStatusOfTicket();
        request.setAttribute("statusTicketList", statusTicketList);

        List<SeatCategory> seatList = scd.getNameAndNumberOfSeat(flightDetailID);
        request.setAttribute("seatList", seatList);

        List<SeatCategory> seatCategoryList = scd.getAllSeatCategoryByFlightDetailId(flightDetailID);
        request.setAttribute("seatCategoryList", seatCategoryList);

        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("view/ticketManagement.jsp").forward(request, response);
        } else if (action.equals("changeStatus")) {
            int status = Integer.parseInt(request.getParameter("statusID"));
            int id = Integer.parseInt(request.getParameter("id"));
            sd.changeStatusTicket(id, status);
            response.sendRedirect("TicketController?flightDetailID=" + flightDetailID);
        } else if (action.equals("create")) {
            try {
                String code = request.getParameter("code");
                int seatCategoryId = Integer.parseInt(request.getParameter("seatCategory"));
                List<String> existingCodes = td.getAllTicketCodesAndSeatByFlightDetail(flightDetailID, seatCategoryId);
                request.setAttribute("existingCodes", existingCodes);
                if (existingCodes.contains(code)) {
                    request.getSession().setAttribute("errorMessage", "This seat code already exists.");
                    response.sendRedirect("TicketController?flightDetailID=" + flightDetailID);
                } else {
                    td.createMaintenanceSeat(code, flightDetailID, seatCategoryId);
                    response.sendRedirect("TicketController?flightDetailID=" + flightDetailID);
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
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
