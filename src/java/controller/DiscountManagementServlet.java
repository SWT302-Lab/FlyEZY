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
import model.Discount;
import dal.DiscountDAO;
import dal.AccountsDAO;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.sql.Date;
import java.util.Random;
import model.Accounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DiscountManagementServlet", urlPatterns = {"/discountManagement"})
public class DiscountManagementServlet extends HttpServlet {

    DiscountDAO dd = new DiscountDAO();
    AccountsDAO ad = new AccountsDAO();

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
            out.println("<title>Servlet DiscountManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DiscountManagementServlet at " + request.getContextPath() + "</h1>");
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
        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            if (id != null) {
                int sid = Integer.parseInt(id);
                if ("Activate".equalsIgnoreCase(action)) {
                    dd.updateStatus(sid, 1);
                } else if ("Deactivate".equalsIgnoreCase(action)) {
                    dd.updateStatus(sid, 2);
                }
            }
            if (acc.getRoleId() == 2) {
                List<Discount> ls = dd.getDiscountByAirlineId(acc.getAirlineId());
                for (Discount d : ls) {
                    request.setAttribute("did", d.getId());
                }
                request.setAttribute("discountlist", ls);
                request.setAttribute("airlineid", acc.getAirlineId());
            } else if (acc.getRoleId() == 4) {
                List<Discount> ls = dd.getDiscountByAirlineId(acc.getAirlineId());
                request.setAttribute("discountlist", ls);
                request.setAttribute("airlineid", acc.getAirlineId());
            }
        }
        request.getRequestDispatcher("view/discountManagement.jsp").forward(request, response);
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
        String code = generatePromoCode();
        String uid = request.getParameter("uid");
        String ucode = request.getParameter("ucode");
        String percentages = request.getParameter("percentages");
        String min_order = request.getParameter("min_order");
        String date_created = request.getParameter("date_created");
        String valid_until = request.getParameter("valid_until");
        String airline_id = request.getParameter("airline_id");
        String action = request.getParameter("action");
        if (action.equals("add")) {
            double per = Double.parseDouble(percentages);
            int min = Integer.parseInt(min_order);
            Date dcreated = Date.valueOf(date_created);
            Date valid = Date.valueOf(valid_until);
            int aid = Integer.parseInt(airline_id);
            dd.addNew(new Discount(code, per, min, dcreated, valid, aid, 1));
        } else if (action.equals("update")) {
            int id = Integer.parseInt(uid);
            double per = Double.parseDouble(percentages);
            int min = Integer.parseInt(min_order);
            Date dcreated = Date.valueOf(date_created);
            Date valid = Date.valueOf(valid_until);
            int aid = Integer.parseInt(airline_id);

            boolean isDuplicate = false;
            for (Discount d : dd.getAll()) {
                if (ucode.equals(d.getCode()) && d.getId() != id) {
                    isDuplicate = true;
                    break;
                }
            }
            if (isDuplicate) {
                session.setAttribute("duplicateError", "Update failed, this code is existed");
            } else {
                dd.updateDiscount(new Discount(ucode, per, min, dcreated, valid, aid), id);
            }
        }
        response.sendRedirect("discountManagement");
    }

    public static String generatePromoCode() {
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder promoCode = new StringBuilder(10);

        for (int i = 0; i < 10; i++) {
            int index = random.nextInt(CHARACTERS.length()); 
            promoCode.append(CHARACTERS.charAt(index)); 
        }

        return promoCode.toString(); 
    }

    public static void main(String[] args) {
        System.out.println(generatePromoCode());
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
