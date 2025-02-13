/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.AirlineManageDAO;
import dal.BaggageManageDAO;
import dal.StatusDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;
import model.Airline;
import model.Baggages;
import model.Status;

/**
 *
 * @author PMQUANG
 */
public class DashboardAirlineServlet extends HttpServlet {

    AirlineManageDAO airlineManageDao = new AirlineManageDAO();
    BaggageManageDAO baggageManageDao = new BaggageManageDAO();
    StatusDAO statusDao = new StatusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountsDAO ad = new AccountsDAO();
        HttpSession session = request.getSession();

        String statusMessage = (String) session.getAttribute("result");
        if (statusMessage != null) {
            request.setAttribute("result", statusMessage);
            session.removeAttribute("result");
        }

        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            int i = (idd != null) ? idd : -1;
            Accounts acc = ad.getAccountsById(i);
            request.setAttribute("account", acc);
            List<Airline> listAirline = new ArrayList<>();
            List<Baggages> listBaggage = baggageManageDao.getAllBaggages();
            String submit = request.getParameter("submit");
            if (acc.getRoleId() == 1) {
                request.setAttribute("manager", "FLYEZY");
                if (submit == null) {
                    listAirline = airlineManageDao.getAllAirline();
                    
                } else {
                    // Search for airlines based on keyword and status
                    String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : null;
                    String statusParam = request.getParameter("status");
                    int statusId = -1;

                    // Ensure status is a valid integer
                    if (statusParam != null && !statusParam.isEmpty()) {
                        try {
                            statusId = Integer.parseInt(statusParam);
                        } catch (NumberFormatException e) {
                            // Log the error and handle it accordingly (e.g., set statusId to null or default)
                            System.out.println("Invalid status ID format: " + e.getMessage());
                        }
                    }

                    // Fetch the airlines based on search criteria
                    listAirline = airlineManageDao.searchAirline(keyword, statusId);
                }
            }else if(acc.getRoleId() == 2){
                listAirline = new ArrayList<>();
                Airline airline = airlineManageDao.getAirlineById(acc.getAirlineId());
                request.setAttribute("manager", airline.getName().toUpperCase());
                if(airline != null){
                    listAirline.add(airline);
                }
            }
            List<Status> listStatus = statusDao.getAllStatus();
            request.setAttribute("listAirline", listAirline);
            request.setAttribute("listBaggage", listBaggage);
            request.setAttribute("listStatus", listStatus);

            request.getRequestDispatcher("view/airlineManagement.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
