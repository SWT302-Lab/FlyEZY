/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.EncodeController.SECRET_KEY;
import dal.AccountsDAO;
import dal.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
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
        EncodeController ec = new EncodeController();
        try {
            String u = request.getParameter("user").trim();
            String p = request.getParameter("pass");
            String r = request.getParameter("rem");
            //quanHT: encode password before checkpass
            String encode = ec.encryptAES(p, SECRET_KEY);

            LoginDAO ld = new LoginDAO();
            AccountsDAO ad = new AccountsDAO();
            HttpSession session = request.getSession();
            if (!ld.checkUsername(u)) {
                request.setAttribute("error", "Your account does not exist!");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            } else if (!ld.checkPassword(u, encode)) {
                request.setAttribute("error", "Your password is incorrect!");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            } else if (ld.checkStatus(u)) {
                request.setAttribute("error", "Your account has been deactivated!");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            } else {
                Cookie cu = new Cookie("cuser", u);
                Cookie cp = new Cookie("cpass", p);
                Cookie cr = new Cookie("crem", r);
                if (r != null) {
                    cu.setMaxAge(60 * 60 * 24 * 7);//7 days
                    cp.setMaxAge(60 * 60 * 24 * 7);
                    cr.setMaxAge(60 * 60 * 24 * 7);
                } else {
                    cu.setMaxAge(0);
                    cp.setMaxAge(0);
                    cr.setMaxAge(0);
                }
                //save to browser
                response.addCookie(cu);
                response.addCookie(cp);
                response.addCookie(cr);
                int id = ad.getIdByEmailOrPhoneNumber(u);
                session.setAttribute("id", id);
                response.sendRedirect("home");
            }
        } catch (Exception ex) {
        }

    }

//------------------------------------------------------------------------------------------------------------------
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
