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
import dal.AccountsDAO;
import dal.RefundDAO;
import dal.StatusDAO;
import dal.TicketDAO;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Refund;
import model.Status;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "RefundControllerServlet", urlPatterns = {"/RefundController"})
public class RefundControllerServlet extends HttpServlet {

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
            out.println("<title>Servlet RefundControllerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RefundControllerServlet at " + request.getContextPath() + "</h1>");
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
        AccountsDAO ad = new AccountsDAO();
        RefundDAO rd = new RefundDAO();
        StatusDAO sd = new StatusDAO();
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

            List<Refund> refundList = rd.getAllRefund(acc.getAirlineId());
            request.setAttribute("refundList", refundList);

            List<Status> statusList = sd.getStatusOfRefund();
            request.setAttribute("statusList", statusList);

            String action = request.getParameter("action");
            if (action == null) {
                request.getRequestDispatcher("view/Refund.jsp").forward(request, response);
            } else if (action.equals("search")) {
                String fStaus = request.getParameter("fStaus");
                String fDateFrom = request.getParameter("fDateFrom");
                String fDateTo = request.getParameter("fDateTo");
                String fDateFrom1 = request.getParameter("fDateFrom1");
                String fDateTo1 = request.getParameter("fDateTo1");
                List<Refund> refundListSearch = rd.searchRefund(fStaus, fDateFrom, fDateTo, fDateFrom1, fDateTo1,acc.getAirlineId());
                request.setAttribute("refundList", refundListSearch);
                request.getRequestDispatcher("view/Refund.jsp").forward(request, response);
            }
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
        String action = request.getParameter("action");
        if (action.equals("changeStatus")) {
            StatusDAO sd = new StatusDAO();
            int  price = Integer.parseInt(request.getParameter("price"));
            int statusID = Integer.parseInt(request.getParameter("statusID"));
            int refundID = Integer.parseInt(request.getParameter("refundId"));
            sd.changeStatusRefund(refundID, statusID,price);
            if (statusID == 8) {
                td.completeTicketRefundById(refundID);
            }
            else if(statusID == 14){
                td.rejectTicketRefundById(refundID);
            }
            response.sendRedirect("RefundController");
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
