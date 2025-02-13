<%-- 
    Document   : orderManagement
    Created on : Oct 12, 2024, 11:08:48 AM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="model.FlightDetails"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="dal.PaymentTypeDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.DiscountDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Flights"%>
<%@page import="model.Order"%>
<%@page import="model.Accounts"%>
<%@page import="model.PaymentType"%>
<%@page import="model.FlightType"%>
<%@page import="model.Status"%>
<%@page import="model.Airport"%>
<%@page import="model.Country"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.Location"%>
<%@page import="model.SeatCategory"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleFlightManagement.css">
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .flight-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                width: 90%;
                margin: 25px auto;
            }

            .flight-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .flight-section {
                flex: 1;
                text-align: center;
                padding: 20px;
            }

            .flight-section.middle {
                border-left: 1px solid #e0e0e0;
                border-right: 1px solid #e0e0e0;
            }

            .flight-section i {
                font-size: 24px;
                color: #3C6E57;
                margin-bottom: 10px;
            }

            .details p {
                margin: 5px 0;
                font-size: 14px;
            }

            .details p strong {
                font-size: 16px;
            }

            @media (max-width: 768px) {
                .flight-info {
                    flex-direction: column;
                }

                .flight-section {
                    padding: 10px 0;
                }

                .flight-section.middle {
                    border-left: none;
                    border-right: none;
                    border-top: 1px solid #e0e0e0;
                    border-bottom: 1px solid #e0e0e0;
                    margin: 10px 0;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div style="margin-left: 210px;margin-top: 7%;margin-bottom: -100px " /> 
        <div style="margin-bottom: 25px; color:#3C6E57; margin-left: 61px "><h2>ORDERS MANAGEMENT</h2></div>

        <input type="hidden" name="flightDetailID">
        <div class="filterController col-md-12" style="width: 100%; margin-left: 5%">
            <form action="OrderController" method="get" style="margin-bottom: 20px;">

                <input type="hidden" name="action" value="search">
                <%int airlineId = (int)request.getAttribute("airlineId");%>
                <input type="hidden" name="airlineId" value="<%=airlineId%>">


                <strong class="filterElm">Status:</strong>
                <select class="filterElm" name="status">
                    <option value="" ${param.status == null ? 'selected' : ''}>All</option>
                    <c:set var="counter" value="0" />
                    <c:forEach items="${requestScope.listStatus}" var="status">
                        <c:if test="${counter < 3}">
                            <option value="${status.id}" ${param.status != null && (param.status == status.id) ? 'selected' : ''}>${status.name}</option>
                            <c:set var="counter" value="${counter + 1}" />
                        </c:if>
                    </c:forEach>
                </select>
                <strong>Code: </strong>
                <input class="filterElm" value="${param.code}" type="text" placeholder="Enter code here..." name="code" style="margin-left:5px"/>
                <strong>Contact: </strong>
                <input class="filterElm" value="${param.keyword}" type="text" placeholder="Enter contact name or phone or mail here..." name="keyword" style="margin-left:5px;width: 23%"/>
                <input type="submit" class="btn btn-info" name="submit" value="Search" style="margin-right: 5px">

                <a class="btn btn-danger" href="OrderController">Cancel</a>
            </form>


        </div>
        <table class="entity" style="margin:0 auto; width: 90%" >
            <thead>
                <tr>
                    <th>Order Code</th>
                    <th>Contact Name</th>
                    <th>Contact Phone</th>
                    <th>Contact Mail</th>
                    <th>Total Price</th>
                    <th>Account</th>
                    <th>Created_at</th>
                    <th>Payment Type</th>
                    <th>Payment Time</th>
                    <th>Discount</th>
                    <th>Status</th>
                    <th style="width: 25%">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                        
                    OrderDAO od = new OrderDAO();
                    AccountsDAO ad = new AccountsDAO();
                    PaymentTypeDAO ptd = new PaymentTypeDAO();
                    FlightTypeDAO ftd = new FlightTypeDAO();
                    StatusDAO sd = new StatusDAO();
                    List<Order> listOrder = (List<Order>)request.getAttribute("listOrder");
                    List<Accounts> listAcc = ad.getAllAccounts();
                    DiscountDAO dd = new DiscountDAO();    
                    if(listOrder != null){
                        for(Order o : listOrder){
                            
                        
                %>
                <tr>
                    <td><%=o.getCode()%></td>
                    <td><%=o.getContactName()%></td>
                    <td><%=o.getContactPhone()%></td>
                    <td><%=o.getContactEmail()%></td>
                    <td><%=NumberFormat.getInstance().format(o.getTotalPrice())%></td>
                    <td><%=ad.getAccountNameById(o.getAccountsId())%></td>
                    <%String paymentName = ptd.getPaymentTypeNameById(o.getPaymentTypesId());%>
                    <td><%=o.getCreated_at()%></td>
                    <td><%=paymentName%></td>
                    <td><%=o.getPaymentTime()%></td>     
                    <td> <%= dd.getPercentageById(o.getDiscountId())%>%</td>
                    <td style="font-weight: bold; <%= (o.getStatus_id() == 12) ? "color: #FFA500;" : (o.getStatus_id() == 10) ? "color: #228B22;" : "" %>">
                        <%= sd.getStatusNameById(o.getStatus_id()) %>
                    </td>
                    <td> 
                        <a href="TicketController?orderId=<%=o.getId()%>" class="btn btn-primary" style="margin-left: 10px;">
                            View Order Tickets >>
                        </a>
                    </td>
                </tr>
                <!--confirm modal btn3-->
            <div class="modal" id="confirmModal-<%= o.getId() %>">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Confirm Change</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to change the flight status?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary confirmChange" data-modal-id="<%= o.getId() %>">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            }
            %>
        </tbody>
    </table>
    <div style="display: flex; justify-content: center">
        <nav aria-label="...">
            <ul class="pagination">
                <c:if test="${index != 1}">    
                    <li class="page-item">
                        <a class="page-link" href="OrderController?flightDetailID=${flightDetailId}&&index=${index -1}">Previous</a>
                    </li>
                </c:if>    
                <c:forEach begin="1" end ="${numOfPage}" var="i">
                    <c:if test="${index == i}">
                        <li class="page-item active">
                            <a class="page-link" href="OrderController?flightDetailID=${flightDetailId}&&index=${i}">${i}</a>
                        </li>
                    </c:if>

                    <c:if test="${index != i}">
                        <li class="page-item">
                            <a class="page-link" href="OrderController?flightDetailID=${flightDetailId}&&index=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${index != numOfPage}">    
                    <li class="page-item">
                        <a class="page-link" href="OrderController?flightDetailID=${flightDetailId}&&index=${index +1}">Next</a>
                    </li>
                </c:if> 
            </ul>
        </nav>
    </div>
    <script>
        function openModal(id) {
            $("#myModal" + id).modal('show');
        }
        document.addEventListener('DOMContentLoaded', function () {
            const sections = document.querySelectorAll('.flight-section');

            sections.forEach(section => {
                section.addEventListener('mouseenter', function () {
                    this.style.backgroundColor = '#f8f9fa';
                });

                section.addEventListener('mouseleave', function () {
                    this.style.backgroundColor = 'transparent';
                });
            });
        });
    </script>
</body>
</html>
