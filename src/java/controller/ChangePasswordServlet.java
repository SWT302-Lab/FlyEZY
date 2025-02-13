/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

/**
 *
 * @author user
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {

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

        HttpSession session = request.getSession();
        AccountsDAO ad = new AccountsDAO();

        String errorCurrent = (String) session.getAttribute("errorCurrent");
        String errorNew = (String) session.getAttribute("errorNew");

        if (errorCurrent != null) {
            request.setAttribute("error", errorCurrent);
            session.removeAttribute("errorCurrent");
        }
        if (errorNew != null) {
            request.setAttribute("errorNew", errorNew);
            session.removeAttribute("errorNew");
        }

        int id = (int) session.getAttribute("id");
        Accounts acc = ad.getAccountsById(id);
        request.setAttribute("account", acc);
        request.getRequestDispatcher("view/changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountsDAO ad = new AccountsDAO();
        HttpSession session = request.getSession();

        String newPass = request.getParameter("newPass");
        String idAccount = request.getParameter("idAccount");
        String newPass2 = request.getParameter("newPass2");
        String pass = request.getParameter("pass");
        String currentPass = request.getParameter("currentPassword");

        if (!currentPass.equals(pass)) {
//            request.setAttribute("errorCurrent", "Current password don't duplicated, please enter password again !");
            session.setAttribute("errorCurrent", "Current password incorrect, please enter password again !");
            response.sendRedirect("changePassword");
        } else {
            if (!newPass.equals(newPass2)) {
//                request.setAttribute("errorNew", "New password don't duplicated, please enter new password again !");
                session.setAttribute("errorNew", "Re enter password not matches with new password , please enter new password again !");
                response.sendRedirect("changePassword");
            } else {
                ad.changePassword(idAccount, newPass);
                int id = (int) session.getAttribute("id");
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
                request.getRequestDispatcher("view/successfulChangePassword.jsp").forward(request, response);

            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
