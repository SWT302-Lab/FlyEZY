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
import model.Accounts;
import dal.AccountsDAO;
import dal.FeedbackDao;
import dal.StatusDAO;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import model.Feedbacks;

/**
 *
 * @author Fantasy
 */
@WebServlet(name = "evaluteControllerServlet", urlPatterns = {"/evaluateController"})
public class evaluteControllerServlet extends HttpServlet {

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
            request.setAttribute("account", acc);
        }
        String action = request.getParameter("action");
        String action1 = request.getParameter("action1");
        String orderID = request.getParameter("orderId");
        if (orderID != null) {
            int orderid = Integer.parseInt(orderID);
            session.setAttribute("orderId", orderid);
        }
        int orderId = (int) session.getAttribute("orderId");
        
        if(action1!=null){
            action = "";
        }
        if (action == null) {
            request.setAttribute("ratingValue", 5);
            request.getRequestDispatcher("view/evaluate.jsp").forward(request, response);
        } else {
            
            if (action.equals("evaluate")) {
                String comment = request.getParameter("editor");
                if (comment == "") {
                    comment = " ";
                } else {
                    comment = comment.substring(3, comment.length() - 4);
                }
                int ratedStar = Integer.parseInt(request.getParameter("ratingValue"));

                SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
                String timeStr = dateFormat.format(new Timestamp(System.currentTimeMillis()));
                Feedbacks feedback = new Feedbacks(idd, ratedStar, comment, new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()), 3, orderId);
                int n = fd.createFeedback(feedback);
                request.getRequestDispatcher("view/successfullEvaluate.jsp").forward(request, response);
            } else if (action.equals("viewUpdate")) {
                Feedbacks feedback = fd.getFeedbakByOrderId(orderId, idd);
                int ratingValue = feedback.getRatedStar();
                String comment = feedback.getComment();
                request.setAttribute("ratedStar", ratingValue);
                request.setAttribute("comment", comment);
                request.getRequestDispatcher("view/evaluate.jsp").forward(request, response);
            } else if (action.equals("update")) {
                String comment = request.getParameter("editor").trim();
                if (comment == "") {
                    comment = " ";
                } else {
                    comment = comment.substring(3, comment.length() - 4);
                }
                int ratedStar = Integer.parseInt(request.getParameter("ratingValue"));
                Feedbacks feedback = new Feedbacks(idd, ratedStar, comment, new Timestamp(System.currentTimeMillis()), orderId);
                fd.updateFeedback(feedback);
                request.getRequestDispatcher("view/successfullEvaluate.jsp").forward(request, response);
            }
            if (action1 != null) {
                fd.deleteFeedback(idd, orderId);
                response.sendRedirect("home");
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
         if(action.equals("changeStatus")){
             StatusDAO sd = new StatusDAO();
             int statusID = Integer.parseInt(request.getParameter("statusID"));
             int feedBackId = Integer.parseInt(request.getParameter("feedBackId"));
             int orderId = Integer.parseInt(request.getParameter("orderId"));
             sd.changeStatusFeedback(feedBackId, statusID);
             response.sendRedirect("evaluateController?action=view&orderId="+orderId);
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
