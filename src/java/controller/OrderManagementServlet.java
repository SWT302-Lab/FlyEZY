/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.AirportDAO;
import dal.CountryDAO;
import dal.FlightDetailDAO;
import dal.LocationDAO;
import dal.OrderDAO;
import dal.PlaneCategoryDAO;
import dal.StatusDAO;
import dal.TicketDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Order;
import model.Status;

/**
 *
 * @author PMQUANG
 */
public class OrderManagementServlet extends HttpServlet {

    FlightDetailDAO fdd = new FlightDetailDAO();
    OrderDAO od = new OrderDAO();
    AccountsDAO ad = new AccountsDAO();
    AirportDAO aid = new AirportDAO();
    LocationDAO ld = new LocationDAO();
    CountryDAO cd = new CountryDAO();
    PlaneCategoryDAO pcd = new PlaneCategoryDAO();
    StatusDAO statusDao = new StatusDAO();
    TicketDAO td = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);

            String flightDetailIdStr = request.getParameter("flightDetailID");

            OrderDAO od = new OrderDAO();

            String idx = request.getParameter("index");
            int index = 1;
            if (idx != null) {
                index = Integer.parseInt(idx);
            }
            request.setAttribute("index", index);
            request.setAttribute("airlineId", acc.getAirlineId());

            List<Order> listOrder;
            String submit = request.getParameter("submit");
            if (submit == null) {
                listOrder = od.getAllOrderByAirlineId(acc.getAirlineId());
            } else {
                // Search for airlines based on keyword and status
                String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : null;
                String code = request.getParameter("code") != null ? request.getParameter("code").trim() : null;
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

                listOrder = od.searchOrder(statusId, code, keyword,acc.getAirlineId());
            }
            List<Status> listStatus = statusDao.getStatusOfOrder();
            request.setAttribute("listOrder", listOrder);
            request.setAttribute("listStatus", listStatus);
            request.getRequestDispatcher("view/orderManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
