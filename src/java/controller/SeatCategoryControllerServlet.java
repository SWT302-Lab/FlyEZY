/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.PlaneCategoryDAO;
import dal.SeatCategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.SeatCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SeatCategoryControllerServlet", urlPatterns = {"/seatCategoryController"})
public class SeatCategoryControllerServlet extends HttpServlet {

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
            out.println("<title>Servlet SeatCategoryControllerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SeatCategoryControllerServlet at " + request.getContextPath() + "</h1>");
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
        AccountsDAO ad = new AccountsDAO();
        PlaneCategoryDAO pcd = new PlaneCategoryDAO();
        HttpSession session = request.getSession();

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
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);

            String planeCategoryId = request.getParameter("planeCategoryId");
            request.setAttribute("planeCatName", pcd.getPlaneCategoryById(Integer.parseInt(planeCategoryId)).getName());
            request.setAttribute("planeCategoryId", planeCategoryId);
            request.getRequestDispatcher("view/seatCategoryController.jsp").forward(request, response);
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
        SeatCategoryDAO scd = new SeatCategoryDAO();
        String planeCategoryIdStr = request.getParameter("planeCategoryId");
        String action = request.getParameter("action");
        int planeCategoryId = 0;

        try {
            if (planeCategoryIdStr != null) {
                planeCategoryId = Integer.parseInt(planeCategoryIdStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        if (action != null && action.equals("changeStatus")) {
            try {
                int id = Integer.parseInt(request.getParameter("seatCategoryid"));
                if (scd.getSeatCategoryById(id).getStatusId() == 1) {
                    scd.deactivateSeatCategoryById(id);
                } else {
                    scd.activateSeatCategoryById(id);
                }
                response.sendRedirect("seatCategoryController?planeCategoryId=" + planeCategoryId);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                return;
            }
        }

        // Process adding/updating seat categories
        String idStr = request.getParameter("id");
        String image = "img/" + request.getParameter("image");
        String name = request.getParameter("name").trim();
        String numberOfSeatStr = request.getParameter("numberOfSeat");
        String info = request.getParameter("info");
        String seatEachRowStr = request.getParameter("seatEachRow");
        String surchargeStr = request.getParameter("surcharge");
        String statusIdStr = request.getParameter("status");
        int numberOfSeat = 0;
        int seatEachRow = 0;
        float surcharge = 0;
        int statusId = 0;

        try {
            numberOfSeat = Integer.parseInt(numberOfSeatStr);
            statusId = Integer.parseInt(statusIdStr);
            seatEachRow = Integer.parseInt(seatEachRowStr);
            surcharge = Float.parseFloat(surchargeStr);
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);

                if (image.equals("img/")) {
                    image = scd.getSeatCategoryById(id).getImage();
                }

                if (name.equals(scd.getSeatCategoryById(id).getName()) || !scd.isDuplicateSeatCategoryName(name, planeCategoryId)) {
                    scd.updateSeatCategory(new SeatCategory(id, name, numberOfSeat, image, info, seatEachRow, surcharge, planeCategoryId, statusId));
                }

            } else {
                if (!scd.isDuplicateSeatCategoryName(name, planeCategoryId)) {
                    scd.addSeatCategory(new SeatCategory(name, numberOfSeat, image, info, seatEachRow, surcharge, planeCategoryId, 1));
                }

            }
            response.sendRedirect("seatCategoryController?planeCategoryId=" + planeCategoryId);
        } catch (Exception e) {
            System.out.println(e);
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
