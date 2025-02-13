/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.RefundDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import model.Accounts;
import model.Refund;

/**
 *
 * @author phung
 */
@WebServlet(name = "RequestRefundServlet", urlPatterns = {"/requestRefund"})
public class RequestRefundServlet extends HttpServlet {

    AccountsDAO ad = new AccountsDAO();
    RefundDAO rd = new RefundDAO();
    TicketDAO td = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
            response.sendRedirect("buyingHistory");
        } else {
            response.sendRedirect("findOrder");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bank = request.getParameter("bank");
        String bankAccount = request.getParameter("confirmBankAccount");
        String ticketIdStr = request.getParameter("ticketId");
        Timestamp requestDate = new Timestamp(System.currentTimeMillis());
        Timestamp refundDate = null;
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            int statusId = 3;
            int refundId = rd.createRefund(new Refund(bank, bankAccount, requestDate, refundDate, td.getPriceById(ticketId), ticketId, statusId));
            td.refundWaitingTicketById(ticketId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect("requestRefund");
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
