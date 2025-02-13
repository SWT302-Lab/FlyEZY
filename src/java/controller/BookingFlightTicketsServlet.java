/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.BaggageManageDAO;
import dal.OrderDAO;
import dal.PassengerTypeDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Accounts;
import model.Order;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingFlightTicketsServlet", urlPatterns = {"/bookingFlightTickets"})
public class BookingFlightTicketsServlet extends HttpServlet {

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
            out.println("<title>Servlet BookingFlightTicketsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingFlightTicketsServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
        }
        request.getRequestDispatcher("view/bookingFlightTickets.jsp").forward(request, response);

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
        OrderDAO od = new OrderDAO();
        TicketDAO td = new TicketDAO();
        PassengerTypeDAO ptd = new PassengerTypeDAO();
        BaggageManageDAO bmd = new BaggageManageDAO();
        AccountsDAO ad = new AccountsDAO();
        EmailServlet email = new EmailServlet();
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        int totalPrice = 0;
        try {
            String pContactName = request.getParameter("pContactName").trim();
            String pContactPhoneNumber = request.getParameter("pContactPhoneNumber").trim();
            String pContactEmail = request.getParameter("pContactEmail").trim();

            int adultTicket = Integer.parseInt(request.getParameter("adultTicket"));
            int childTicket = Integer.parseInt(request.getParameter("childTicket"));
            int infantTicket = Integer.parseInt(request.getParameter("infantTicket"));
            int totalPassengers = adultTicket + childTicket + infantTicket;

            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            int seatCategoryId = Integer.parseInt(request.getParameter("seatCategoryId"));
            float commonPriceFloat = Float.parseFloat(request.getParameter("commonPrice"));
            int commonPrice = (int) Math.round(commonPriceFloat);
            totalPrice += commonPrice * (ptd.getPassengerTypePriceById(1) * adultTicket + ptd.getPassengerTypePriceById(2) * childTicket + ptd.getPassengerTypePriceById(3) * infantTicket);

            String flightDetailId2Str = request.getParameter("flightDetailId2");
            int flightDetailId2 = 0;
            int seatCategoryId2 = 0;
            int commonPrice2 = 0;
            if (flightDetailId2Str != null) {
                flightDetailId2 = Integer.parseInt(flightDetailId2Str);
                seatCategoryId2 = Integer.parseInt(request.getParameter("seatCategoryId2"));
                float commonPriceFloat2 = Float.parseFloat(request.getParameter("commonPrice2"));
                commonPrice2 = (int) Math.round(commonPriceFloat2);
                totalPrice += commonPrice2 * (ptd.getPassengerTypePriceById(1) * adultTicket + ptd.getPassengerTypePriceById(2) * childTicket + ptd.getPassengerTypePriceById(3) * infantTicket);
            }

            String orderCode = od.createOrder(pContactName, pContactPhoneNumber, pContactEmail, totalPrice, id);
            Order o = od.getOrderByCode(orderCode);

            for (int i = 1; i <= totalPassengers; i++) {
                int pSex = Integer.parseInt(request.getParameter("pSex" + i));
                String pName = request.getParameter("pName" + i).trim();
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));

                String code = request.getParameter("code" + i);
                if (code != null) {
                    if (td.getTicketByCode(code, flightDetailId, seatCategoryId) != null) {
                        od.deleteOrderByCode(o.getCode());
                        request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                        return;
                    }
                }

                if (flightDetailId2Str != null) {
                    String code2 = request.getParameter("code" + (totalPassengers + i));
                    if (code2 != null) {
                        if (td.getTicketByCode(code2, flightDetailId2, seatCategoryId2) != null) {
                            od.deleteOrderByCode(o.getCode());
                            request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                            return;
                        }
                    }
                    if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {
                        td.createTicket(code, flightDetailId, seatCategoryId, 2, pName, pSex, null, pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceById(2)), o.getId(), 2);
                        td.createTicket(code2, flightDetailId2, seatCategoryId2, 2, pName, pSex, null, pDob, null, (int) (commonPrice2 * ptd.getPassengerTypePriceById(2)), o.getId(), 3);
                    } else if (i >= adultTicket + childTicket + 1) {
                        td.createTicket(code, flightDetailId, seatCategoryId, 3, pName, pSex, null, pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceById(3)), o.getId(), 2);
                        td.createTicket(null, flightDetailId2, seatCategoryId2, 3, pName, pSex, null, pDob, null, (int) (commonPrice2 * ptd.getPassengerTypePriceById(3)), o.getId(), 3);
                    } else {
                        String pPhoneNumber = request.getParameter("pPhoneNumber" + i).trim();
                        Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                        Integer pBaggages2 = request.getParameter("pBaggages" + (totalPassengers + i)).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + (totalPassengers + i)));
                        int pBPrice = ((pBaggages != null) ? bmd.getPriceBaggagesById(pBaggages) : 0);
                        int pBPrice2 = ((pBaggages2 != null) ? bmd.getPriceBaggagesById(pBaggages2) : 0);
                        totalPrice += pBPrice + pBPrice2;
                        td.createTicket(code, flightDetailId, seatCategoryId, 1, pName, pSex, pPhoneNumber, pDob, pBaggages, (int) (commonPrice * ptd.getPassengerTypePriceById(1) + pBPrice), o.getId(), 2);
                        td.createTicket(code2, flightDetailId2, seatCategoryId2, 1, pName, pSex, pPhoneNumber, pDob, pBaggages2, (int) (commonPrice2 * ptd.getPassengerTypePriceById(1) + pBPrice2), o.getId(), 3);
                    }
                } else {
                    if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {
                        td.createTicket(code, flightDetailId, seatCategoryId, 2, pName, pSex, null, pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceById(2)), o.getId(), 1);
                    } else if (i >= adultTicket + childTicket + 1) {
                        td.createTicket(code, flightDetailId, seatCategoryId, 3, pName, pSex, null, pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceById(3)), o.getId(), 1);
                    } else {
                        String pPhoneNumber = request.getParameter("pPhoneNumber" + i).trim();
                        Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                        int pBPrice = ((pBaggages != null) ? bmd.getPriceBaggagesById(pBaggages) : 0);
                        totalPrice += pBPrice;
                        td.createTicket(code, flightDetailId, seatCategoryId, 1, pName, pSex, pPhoneNumber, pDob, pBaggages, (int) (commonPrice * ptd.getPassengerTypePriceById(1) + pBPrice), o.getId(), 1);
                    }
                }
                od.updateTotalPrice(o.getId(), totalPrice);
            }

            if (id != null) {
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
            }
            o = od.getOrderByCode(orderCode);
            email.sendOrderEmail(o.getContactEmail(), o);
            request.setAttribute("ORDERID", o.getId());
            request.setAttribute("price", o.getTotalPrice());
            request.getRequestDispatcher("view/successfulBooking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
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
