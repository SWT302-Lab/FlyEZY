/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.AccountsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import dal.Config;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import dal.OrderDAO;
import dal.TicketDAO;
import model.Order;
import model.Ticket;
/**
 *
 * @author Fantasy
 */
@WebServlet(name = "VnpayServletController2", urlPatterns = {"/VnpayController2"})
public class VnpayServletController2 extends HttpServlet {

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
        String code = request.getParameter("vnp_TransactionStatus");
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        OrderDAO od = new OrderDAO();
        AccountsDAO ad = new AccountsDAO();
        EmailServlet email = new EmailServlet();
        if (idd == null) {
        } else {
            int i = (idd != null) ? idd : -1;
            Accounts acc = ad.getAccountsById(i);
            request.setAttribute("account", acc);
        }
        
        if (code.equals("00")) {
            int orderID1 = (int) session.getAttribute("orderID");
            od.successfullPayment(orderID1,2);
            Order or = od.getOrderByOrderId(orderID1);
            email.sendPaymentSuccessfulbyEmail(or.getContactEmail(), or);
            request.getRequestDispatcher("view/successfullPayment.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("view/failedPayment.jsp").forward(request, response);
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
