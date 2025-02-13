/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BaggageManageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class BaggageManagementServlet extends HttpServlet {

    BaggageManageDAO baggageManageDao = new BaggageManageDAO();

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
        //action
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addBaggage(request);
                break;
            case "changeStatus":
                changeStatusBaggage(request);
                break;
            case "update":
                updateBaggage(request);
                break;
            default:

        }
        response.sendRedirect("airlineController");
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

    private void addBaggage(HttpServletRequest request) {
        try {
            float baggageWeight = Float.parseFloat(request.getParameter("baggageWeight"));
            int baggagePrice = Integer.parseInt(request.getParameter("baggagePrice").trim());
            int airlineId = Integer.parseInt(request.getParameter("airlineIdBaggage"));
            if (!baggageManageDao.checkWeightExists(baggageWeight, airlineId)) {
                baggageManageDao.createBaggages(new Baggages(baggageWeight, baggagePrice, airlineId));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void changeStatusBaggage(HttpServletRequest request) {
        try {

            int baggageId = Integer.parseInt(request.getParameter("baggageId"));
            int baggageStatus = Integer.parseInt(request.getParameter("baggageStatus"));
            int newStatus = 1;
            if (baggageStatus == 1) {
                newStatus = 2;
            } else if (baggageStatus == 2) {
                newStatus = 1;
            }
            baggageManageDao.changeStatus(baggageId, newStatus);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateBaggage(HttpServletRequest request) {
        try {
            float baggageWeight = Float.parseFloat(request.getParameter("baggageWeight"));
            int baggagePrice = Integer.parseInt(request.getParameter("baggagePrice"));
            int baggageId = Integer.parseInt(request.getParameter("baggageId"));
            int airlineId = Integer.parseInt(request.getParameter("airlineIdBaggage"));
            if (baggageManageDao.getWeight(baggageId) == baggageWeight || !baggageManageDao.checkWeightExists(baggageWeight, airlineId)) {
                baggageManageDao.updateBaggage(new Baggages(baggageId, baggageWeight, baggagePrice));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
