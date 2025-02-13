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
import java.util.List;
import model.Accounts;
import model.Airline;
import model.Status;
import dal.AccountsDAO;
import dal.FeedbackDao;
import dal.StatusDAO;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import model.Feedbacks;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "FeedbackManagementServlet", urlPatterns = {"/feedbackController"})
public class FeedbackManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet evaluteControllerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet evaluteControllerServlet at " + request.getContextPath() + "</h1>");
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
        String statusMessage = (String) session.getAttribute("result");
        AccountsDAO ad = new AccountsDAO();
        FeedbackDao fd = new FeedbackDao();
        StatusDAO sd = new StatusDAO();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("airlineID", acc.getAirlineId());
            request.setAttribute("account", acc);
            String action = request.getParameter("action");
            if (action == null) {
                List<Feedbacks> feedbackList = fd.getAllFeedback(acc.getAirlineId());
                List<Status> statusList = sd.getStatusOfFeedback();
                request.setAttribute("feedbackList", feedbackList);
                request.setAttribute("statusList", statusList);
                request.getRequestDispatcher("view/Feedback.jsp").forward(request, response);
            } else if (action.equals("search")) {
                String fStaus = request.getParameter("fStaus");
                String fStar = request.getParameter("fStar");
                String fEmail = request.getParameter("fEmail");
                List<Feedbacks> feedbackList = fd.searchFeedback2(fStaus, fStar, fEmail, acc.getAirlineId());
                List<Status> statusList = sd.getStatusOfFeedback();
                request.setAttribute("feedbackList", feedbackList);
                request.setAttribute("statusList", statusList);
                request.getRequestDispatcher("view/Feedback.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        if (action.equals("changeStatus")) {
            StatusDAO sd = new StatusDAO();
            int statusID = Integer.parseInt(request.getParameter("statusID"));
            int feedBackId = Integer.parseInt(request.getParameter("feedBackId"));
            sd.changeStatusFeedback(feedBackId, statusID);
            response.sendRedirect("feedbackController");

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
