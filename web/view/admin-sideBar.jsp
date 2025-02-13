<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Accounts"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Admin Sidebar</title>
        <link rel="stylesheet" href="css/styleAdminSideBar.css" />
    </head>
    <body>
        <%
            String currentPage = request.getRequestURI();
            Accounts acc = (Accounts)request.getAttribute("account");
            int roleId = acc.getRoleId();
        %>
        <div id="sidebar">
            <ul>
                <% if (roleId == 1) { %>
                <li>
                    <a href="accountController" class="<%= currentPage.equals("/flyezy/view/accountController.jsp") ? "current-page" : "" %>">
                        Account Management
                    </a>
                </li>
                <% } %>

                <% if (roleId ==1 || roleId ==2) { %>
                <li>
                    <a href="airlineController" class="<%= currentPage.equals("/flyezy/view/airlineManagement.jsp") ? "current-page" : "" %>">
                        Airline Management
                    </a>
                </li>
                <% } %>

                <% if (roleId == 2) { %>
                <li>
                    <a href="planeCategoryController" class="<%= currentPage.equals("/flyezy/view/planeCategoryController.jsp") ? "current-page" : "" %>">
                        Plane Category Management
                    </a>
                </li>
                <li>
                    <a href="flightManagement" class="<%= currentPage.equals("/flyezy/view/flightManagement.jsp") ? "current-page" : "" %>">
                        Flight Management
                    </a>
                </li>
                <li>
                    <a href="OrderController" class="<%= currentPage.equals("/flyezy/view/orderManagement.jsp") ? "current-page" : "" %>">
                        Order Management
                    </a>
                </li>
                <li>
                    <a href="feedbackController" class="<%= currentPage.equals("/flyezy/view/Feedback.jsp") ? "current-page" : "" %>">
                        Feedback Management
                    </a>
                </li>
                <li>
                    <a href="RefundController" class="<%= currentPage.equals("/flyezy/view/Refund.jsp") ? "current-page" : "" %>">
                        Refund Management
                    </a>
                </li>

                <% } %>

                <% if (roleId==2 || roleId==4) { %>
                <li>
                    <a href="discountManagement" class="<%= currentPage.equals("/flyezy/view/discountManagement.jsp") ? "current-page" : "" %>">
                        Discount Management
                    </a>
                </li>
                <li>
                    <a href="newsManagement" class="<%= currentPage.equals("/flyezy/view/newsManagement.jsp") ? "current-page" : "" %>">
                        News Management
                    </a>
                </li>

                <% } %>
            </ul>
        </div>
    </body>
</html>
