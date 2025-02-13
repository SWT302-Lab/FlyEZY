/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import dal.RegisterDAO;
import java.sql.Timestamp;
import model.UserGoogleDto;
import org.apache.http.protocol.HTTP;

/**
 *
 * @author Admin
 */
public class LoginGoogleHandlerServlet extends HttpServlet {

    AccountsDAO ad = new AccountsDAO();
    LoginDAO ld = new LoginDAO();
    RegisterDAO dao = new RegisterDAO();

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
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accesstoken = gg.getToken(code);
        UserGoogleDto data = gg.getUserInfo(accesstoken);
        UserGoogleDto acc = new UserGoogleDto(data.getName(), data.getEmail(), "KIymfC4XfLDNFnygtZuXNQ==", "0000000000", "img/jack.png", 3, 1, new Timestamp(System.currentTimeMillis()), 1);

        if (!dao.checkEmailExisted(data.getEmail())) {
            dao.addNewGoogleAccount(acc);
        } else if (ld.checkStatus(data.getEmail())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
        int id = ad.getIdByEmailOrPhoneNumber(acc.getEmail());
        session.setAttribute("id", id);
        response.sendRedirect("home");

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
        processRequest(request, response);
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
