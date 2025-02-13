/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.AirlineManageDAO;
import dal.BaggageManageDAO;
import dal.FlightDetailDAO;
import dal.FlightManageDAO;
import dal.PlaneCategoryDAO;
import dal.SeatCategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Airline;

/**
 *
 * @author PMQUANG
 */
public class AirlineManagementServlet extends HttpServlet {

    private AirlineManageDAO airlineManageDao = new AirlineManageDAO();
    private BaggageManageDAO baggageManageDao = new BaggageManageDAO();
    private PlaneCategoryDAO planeCategoryDao = new PlaneCategoryDAO();
    private SeatCategoryDAO seatCategoryDao = new SeatCategoryDAO();
    private FlightManageDAO flightManageDao = new FlightManageDAO();
    private FlightDetailDAO flightDetailDao = new FlightDetailDAO();
    private AccountsDAO accountDao = new AccountsDAO();

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
        HttpSession session = request.getSession();
        //action
        String action = request.getParameter("action") == null
                ? action = "" : request.getParameter("action");
        switch (action) {
            case "add":
                addAirline(request);
                session.setAttribute("result", "Add airline successfully!");
                break;
            case "changeStatus":
                ChangeStatusAirline(request);
                session.setAttribute("result", "Change airline status successfully!");
                break;
            case "update":
                updateAirline(request);
                session.setAttribute("result", "Update airline successfully!");
                break;
            default:

        }
        response.sendRedirect("airlineController");
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

    private void addAirline(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            // Lấy thông tin từ request
            String airlineName = request.getParameter("airlineName").trim();
            //get image path
            String airlineImage = "img/" + request.getParameter("airlineImage");
            //get info
            String airlineInfo = request.getParameter("airlineInfo").trim();

            if (airlineManageDao.checkAirlineDuplicated(airlineName)) {
                session.setAttribute("error", "Airline name already exists. Please choose a different name.");
                return;
            }
            Airline airline = new Airline(airlineName, airlineImage, airlineInfo);

            // Thêm airline vào cơ sở dữ liệu
            // Lấy airlineId
            int airlineId = airlineManageDao.createAirline(airline);
            session.setAttribute("success", "Airline created successfully!");
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void ChangeStatusAirline(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            int airlineId = Integer.parseInt(request.getParameter("airlineId"));
            int statusId = Integer.parseInt(request.getParameter("airlineStatus"));
            int newStatusId = 1;
            if (statusId == 1) {
                baggageManageDao.DeactiveAllByAirline(airlineId);
                planeCategoryDao.deactivatePlaneCategoryByAirline(airlineId);
                seatCategoryDao.deactivateAllSeatCategoryByAirline(airlineId);
                flightManageDao.deactivateAllFlightByAirline(airlineId);
                flightDetailDao.deactivateAllFlightDetailByAirline(airlineId);
                accountDao.deactivateAllAccountByAirline(airlineId);
                newStatusId = 2;
            } else if (statusId == 2) {
                baggageManageDao.ReactiveAllByAirline(airlineId);
                planeCategoryDao.activatePlaneCategoryByAirline(airlineId);
                seatCategoryDao.activateAllSeatCategoryByAirline(airlineId);
                flightManageDao.activateAllFlightByAirline(airlineId);
                flightDetailDao.activateAllFlightDetailByAirline(airlineId);
                accountDao.activateAllAccountByAirline(airlineId);
                newStatusId = 1;
            }
            airlineManageDao.changeStatus(airlineId, newStatusId);
            session.setAttribute("success", "Change airline status successfully!");
        } catch (Exception e) {
            // Xử lý lỗi khác
            e.printStackTrace();
        }
    }

    private void updateAirline(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            int airlineId = Integer.parseInt(request.getParameter("airlineId"));
            String airlineName = request.getParameter("airlineName").trim();
            String airlineImage = "img/" + request.getParameter("airlineImage").trim();
            String airlineInfo = request.getParameter("airlineInfo").trim();
            if (airlineImage.equals("img/")) {
                airlineImage = airlineManageDao.getAirlineById(airlineId).getImage();
            }
            Airline a = airlineManageDao.getAirlineById(airlineId);
            if (!airlineName.equals(a.getName()) && airlineManageDao.checkAirlineDuplicated(airlineName)) {
                session.setAttribute("error", "Airline name already exists. Please choose a different name.");
                return;
            }

            Airline airline = new Airline(airlineId, airlineName, airlineImage, airlineInfo);
            airlineManageDao.updateAirline(airline);
            session.setAttribute("success", "Update airline successful!");
        } catch (Exception e) {
            // Xử lý lỗi khác
            e.printStackTrace();
        }
    }
}
