/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import dal.OrderDAO;
import dal.AccountsDAO;
import dal.TicketDAO;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Order;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "QRCodeServletController", urlPatterns = {"/QRCodeController"})
public class QRCodeServletController extends HttpServlet {

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
            out.println("<title>Servlet QRCodeServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QRCodeServletController at " + request.getContextPath() + "</h1>");
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
        OrderDAO od = new OrderDAO();
        TicketDAO td = new TicketDAO();
        AccountsDAO ad = new AccountsDAO();
        EmailServlet email = new EmailServlet();
        Integer idd = (Integer) session.getAttribute("id");

        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        int orderID = (int) session.getAttribute("orderID");
        String discountIdStr = request.getParameter("discountId");
        String lastPriceStr = request.getParameter("totalCost");
        try {
            if (discountIdStr != null && !discountIdStr.isEmpty()) {
                int discountId = Integer.parseInt(discountIdStr);
                od.updateDiscountOrder(discountId, orderID);
                double lastPriceDouble = Double.parseDouble(lastPriceStr);
                int lastPrice = (int) Math.round(lastPriceDouble);
                od.updatetotalPriceOfOrder(orderID, lastPrice);
            }
            od.successfullPayment(orderID, 1);
            td.confirmSuccessAllTicketsByOrderId(orderID);
            Order or = od.getOrderByOrderId(orderID);
            email.sendPaymentSuccessfulbyEmail(or.getContactEmail(), or);
            request.getRequestDispatcher("view/successfullPayment.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();  // Prints detailed stack trace to the console
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
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        AccountsDAO ad = new AccountsDAO();
        OrderDAO od = new OrderDAO();

        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        String orderID = request.getParameter("orderID");
        if (orderID != null) {
            int orderId = Integer.parseInt(orderID);
            Order o = od.getOrderById(orderId);
            session.setAttribute("orderID", orderId);
            request.setAttribute("email", o.getContactEmail());
            request.setAttribute("phone", o.getContactPhone());
            request.setAttribute("totalCost", o.getTotalPrice());
            request.getRequestDispatcher("view/paymen-QRCode.jsp").forward(request, response);
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
