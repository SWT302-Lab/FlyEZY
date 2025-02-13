/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.DiscountDAO;
import dal.OrderDAO;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Discount;
import model.Order;

/**
 *
 * @author Admin
 */
@WebServlet(name = "discountApplyServlet", urlPatterns = {"/discountApplyServlet"})
public class discountApplyServlet extends HttpServlet {

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
            out.println("<title>Servlet discountApplyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet discountApplyServlet at " + request.getContextPath() + "</h1>");
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
        DiscountDAO dd = new DiscountDAO();
        AccountsDAO ad = new AccountsDAO();
        OrderDAO od = new OrderDAO();
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        int orderID = (int) session.getAttribute("orderID");
        Order o = od.getOrderById(orderID);

        String discountcode = request.getParameter("discountcode").trim();
        double percentages = dd.getPercentageByCode(discountcode);
        Discount discount = dd.getDiscountByCode(discountcode, o.getTotalPrice(), o.getCreated_at(), od.getAirlineIdByOrder(orderID));
        if (discount != null && discount.getStatus_id()==1 && !dd.isUsedDiscount(i, discount.getId())) {
            request.setAttribute("successfulDiscount", "Successful apply " + discount.getCode() + " " + discount.getPercentage()+"%");
            request.setAttribute("discountId", discount.getId());
            double priceAfterDiscount = o.getTotalPrice() - (o.getTotalPrice() * (percentages / 100));

            request.setAttribute("email", o.getContactEmail());
            request.setAttribute("phone", o.getContactPhone());
            request.setAttribute("totalCost", priceAfterDiscount);

            request.getRequestDispatcher("view/paymen-QRCode.jsp").forward(request, response);
        } else {
            request.setAttribute("failedDiscount", "Your discount is not existed or have been used before");
            request.setAttribute("email", o.getContactEmail());
            request.setAttribute("phone", o.getContactPhone());
            request.setAttribute("totalCost", o.getTotalPrice());
            request.getRequestDispatcher("view/paymen-QRCode.jsp").forward(request, response);
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

        response.sendRedirect("discountApplyServlet");
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
