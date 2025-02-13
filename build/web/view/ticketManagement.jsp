<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="dal.RolesDAO"%>
<%@page import="model.Roles"%>
<%@page import="model.Status"%>
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.Status"%>
<%@page import="model.Airport"%>
<%@page import="model.Country"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Accounts"%>
<%@page import="model.Status"%>
<%@page import="model.Flights"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Location"%>
<%@page import="model.Order"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.TicketDAO"%>
<%@page import="dal.AirportDAO"%>
<%@page import="dal.BaggageManageDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="dal.PassengerTypeDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.PaymentTypeDAO"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.OrderDAO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticket Management</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


        <style>
            .modal-body{
                text-align: left
            }
            .modal-body span{
                margin-right: 5px
            }
            #myBtn{
                display: flex;
                flex:left
            }
            #main-content{

            }
            body {
                background-color: #f7f7f7;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .main-container {
                border: 1px solid #ddd;
                margin-bottom: 20px;
                margin-top: 20px;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: flex-start;
            }
            .details {
                width: 50%;
                margin: 0 0 0 26%;
            }
            .details p {
                font-size: 16px;
            }
            .details span {
                font-weight: bold;
            }
            .order-details {
                font-family: Arial, sans-serif;
                max-width: 500px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            .order-details p {
                display: flex;
                align-items: center;
                margin: 8px 0;
                color: #333;
                font-size: 14px;
            }

            .order-details i {
                margin-right: 8px;
                color: #555;
            }

            .order-details strong {
                margin-left: 5px;
                color: #555;
            }

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
            .seat-category-list {
                display: flex;
                flex-wrap: wrap;
                gap: 1.5rem;
                width: fit-content;
                padding: 2rem;
                background-color: #f8f9fa;
                border-radius: 1.25rem;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
            }

            .seat-category-item {
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                border-radius: 1rem;
                padding: 1.5rem;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                min-width: 240px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border: 1px solid rgba(0, 0, 0, 0.05);
                position: relative;
                overflow: hidden;
            }

            .seat-category-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #BADF6C, #3C6E57);
                transition: height 0.3s ease;
            }

            .seat-category-item:hover {
                transform: translateY(-6px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            }

            .seat-category-item:hover::before {
                height: 6px;
            }

            .seat-category-name {
                font-size: 1.7rem;
                font-weight: 700;
                color: #3C6E57;
                margin-bottom: 0.75rem;
                transition: color 0.3s ease;
            }

            .seat-category-item:hover .seat-category-name {
                color: #BADF6C;
            }

            .seat-category-count {
                display: flex;
                align-items: center;
                font-size: 1.7rem;
                font-weight: 500;
                color: #34495e;
                background-color: rgba(186, 223, 108, 0.2);
                border-radius: 2rem;
                padding: 0.5rem 1rem;
                transition: background-color 0.3s ease;
            }

            .seat-category-item:hover .seat-category-count {
                background-color: rgba(60, 110, 87, 0.2);
            }

            .seat-category-count span {
                font-size: 1.8rem;
                font-weight: 700;
            }

            .seat-category-count span:first-child {
                color: #3C6E57;
                margin-right: 0.25rem;
            }

            .seat-category-count span:nth-child(2) {
                color: #7f8c8d;
                margin: 0 0.25rem;
            }

            .seat-category-count span:last-child {
                color: #34495e;
                margin-left: 0.25rem;
            }

        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <%
        Flights flight = (Flights)request.getAttribute("flight");
        Airport airportDep =(Airport)request.getAttribute("airportDep");
        Airport airportDes =(Airport)request.getAttribute("airportDes");
        FlightDetails flightDetail = (FlightDetails)request.getAttribute("flightDetail");
        Location locationDep = (Location)request.getAttribute("locationDep");
        Location locationDes = (Location)request.getAttribute("locationDes");
        Country countryDep = (Country)request.getAttribute("countryDep");
        Country countryDes = (Country)request.getAttribute("countryDes");
        PlaneCategory planeCatrgory = (PlaneCategory)request.getAttribute("planeCatrgory");
        List<SeatCategory> seatList =(List<SeatCategory>)request.getAttribute("seatList");
        %>
        <div id="main-content" style="padding:15vh 0vw 15vh 17vw; margin: 0">

            <div class="filterController col-md-12" style="width: 100%;padding: 0">
                <c:choose>
                    <c:when test="${not empty requestScope.orderId}">
                        <!-- Back button for orderID -->
                        <a href="OrderController" class="btn btn-warning"><< Back to Orders Management</a>
                    </c:when>
                    <c:otherwise>
                        <!-- Back button for flightDetailID -->
                        <a href="flightDetailManagement?flightId=${requestScope.flight.getId()}&airlineId=${requestScope.airlineId}" class="btn btn-warning"> << Back</a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div style="margin: 45px 0 18px 0; color:#3C6E57; "><h2>TICKETS MANAGEMENT</h2></div>

            <%if(airportDep != null && locationDep != null && countryDep != null && airportDes != null && locationDes != null && countryDes != null){%>
            <div class="flight-card">
                <div class="flight-info">
                    <div class="flight-section">
                        <i class="fas fa-plane-departure"></i>
                        <div class="details">
                            <p><strong><%=airportDep.getName()%></strong> </p>
                            <p>(<%=locationDep.getName()%>, <%=countryDep.getName()%>)</p>
                        </div>
                    </div>
                    <div class="flight-section middle">
                        <i class="fas fa-plane"></i>
                        <p><%=planeCatrgory.getName()%></p>
                        <p>
                            <i class="fas fa-calendar-alt"></i> <%=flightDetail.getDate()%> <%=flightDetail.getTime()%>
                            <i class="fas fa-clock" style="margin-left: 20px"></i> <%=flight.getMinutes()%> min
                        </p>
                    </div>
                    <div class="flight-section">
                        <i class="fas fa-plane-arrival"></i>
                        <div class="details">
                            <p><strong><%=airportDes.getName()%></strong></p>
                            <p>(<%=locationDes.getName()%>, <%=countryDes.getName()%>)</p>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
            <c:if test="${requestScope.flightDetailID != null}">
                <form action="TicketController" method="get"">
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="flightDetailID" value="${flightDetailID}">
                    <strong class="filterElm">Flight Type</strong>
                    <select class="filterElm" name="flightType">
                        <option value="" ${param.flightType == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${flightTypeList}" var="type">
                            <option value="${type.id}" ${param.flightType != null && (param.flightType==type.id) ? 'selected' : ''}>${type.name}</option>
                        </c:forEach>
                    </select>
                    <strong class="filterElm">Passenger Type</strong>
                    <select class="filterElm" name="passengerType">
                        <option value="" ${param.passengerType == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${passengerTypeList}" var="type">
                            <option value="${type.id}" ${param.passengerType != null && (param.passengerType==type.id) ? 'selected' : ''}>${type.name}</option>
                        </c:forEach>
                    </select>

                    <strong class="filterElm">Status</strong>
                    <select class="filterElm" name="statusTicket">
                        <option value="" ${param.statusTicket == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${statusTicketList}" var="status">
                            <option value="${status.id}" ${param.statusTicket != null && (param.statusTicket==status.id) ? 'selected' : ''}>${status.name}</option>
                        </c:forEach>
                    </select>
                    <strong>Passenger Name: </strong>
                    <input class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <br><br>
                    <strong>Phone number: </strong>
                    <input class="filterElm" type="number" name="fPhoneNumber" value="${param.fPhoneNumber}" placeholder="Enter phone number">
                    <strong>Order code: </strong>

                    <input class="filterElm" type="text" name="orderCode" value="${param.orderCode}" placeholder="Enter order code">
                    <button class="btn btn-info" type="submit">
                        Search
                    </button>
                    <a class="btn btn-danger" href="TicketController?flightDetailID=${flightDetailID}">Cancel</a>

                </form>
                <div class="seat-category-list" style="display: flex; align-items:  center">
                    <% for(SeatCategory s : seatList) { %>
                    <div class="seat-category-item" style="display: flex">
                        <span class="seat-category-name"><%= s.getName() %></span>
                        <span class="seat-category-count">
                            <span><%= s.getCountSeat() %></span>/<span><%= s.getNumberOfSeat() %></span>
                        </span>
                    </div>
                    <% } %>
                    <button type="button" class="btn btn-success" id="myBtn" style="height: fit-content" onclick="myModal3()">Add New Maintenance Seat</button>
                </div>
                <div class="modal fade" id="myModal3" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header" style="padding:5px 5px;">
                                <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                <h4 style="margin-left: 12px">Create maintainence seat</h4>
                            </div>
                            <div class="modal-body" style="padding:40px 50px;">


                                <form role="form" action="TicketController" method="post">
                                    <input type="hidden" name="action" value="create"/>
                                    <input type="hidden" name="flightDetailID" value="${flightDetailID}">
                                    <input type="hidden" name="createdAt" value=""/>
                                    <div class="row">
                                        <div class="form-group col-md-8">
                                            <label for="name"><span class="glyphicon glyphicon-user"></span>Code</label>
                                            <input type="text" class="form-control" name="code" value="" pattern="^[A-I][1-9]{1,2}$">
                                        </div>
                                        <div class="form-group col-md-8">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Seat Category:</label></div>
                                            <select name="seatCategory" value="" style="height:  34px">
                                                <%List<SeatCategory> seatCategoryList = (List<SeatCategory>)request.getAttribute("seatCategoryList");
                                                            for(SeatCategory seat : seatCategoryList){%>
                                                <option value="<%=seat.getId()%>"><%=seat.getName()%></option>
                                                <%}%>
                                            </select>
                                        </div> 
                                    </div>
                                    <button type="submit" class="btn btn-success btn-block">
                                        Confirm
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <% 
                    String errorMessage = (String) session.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        session.removeAttribute("errorMessage");  // Clear the error message after displaying it
                %>
                <div class="alert alert-danger" id="errorMessage"><%= errorMessage %></div>
                <% } %>

            </c:if>



            <!-- Update Modal -->   

            <table class="entity" >
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Seat Category</th>
                        <th>Passenger type </th>
                        <th>Passenger Name</th>
                        <th>Passenger Sex</th>
                        <th>Phone number</th>
                        <th>Date of birth</th>
                        <th>Baggage weight</th>
                        <th>Order Code</th>
                        <th>Flight Type</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th style="padding: 0 20px; width: 18%">Actions</th>
                    </tr>
                </thead>
                <tbody>

                    <%
                    List<Ticket> ticketList = (List<Ticket>) request.getAttribute("ticketList");
                    AirportDAO ad = new AirportDAO();
                    BaggageManageDAO bmd = new BaggageManageDAO();
                    AccountsDAO acd = new AccountsDAO();
                    FlightTypeDAO ftd = new FlightTypeDAO();
                    PassengerTypeDAO ptd = new PassengerTypeDAO();
                    PaymentTypeDAO PTD = new PaymentTypeDAO();
                    SeatCategoryDAO scd = new SeatCategoryDAO();
                    StatusDAO sd = new StatusDAO();
                    OrderDAO od = new OrderDAO();
                    
                    for (Ticket list : ticketList   ) {
                    %>
                    <tr>
                        <td><%= list.getCode() %></td>
                        <td><%= scd.getSeatCategoryNameById(list.getSeat_Categoryid()) %></td>
                        <td><%= ptd.getPassengerTypeNameById(list.getPassenger_Typesid()) %></td>
                        <td><%= list.getpName() %></td>
                        <td><%= list.getpSex()==1?"Male":"Female" %></td>
                        <td><%= list.getpPhoneNumber() %></td>
                        <td><%= list.getpDob() %></td>
                        <td><%= bmd.getWeight(list.getBaggagesid()) %></td>
                        <td><%= od.getCodeByOrderId(list.getOrder_id()) == null ? "" : od.getCodeByOrderId(list.getOrder_id())%></td>
                        <td><%= ftd.getNameType(list.getFlight_Type_id()) %></td>
                        <td><%= list.getTotalPrice() %></td>
                        <td style="font-weight: bold; <%= (list.getStatusid() == 12) ? "color: #FFA500;" : (list.getStatusid() == 10) ? "color: #228B22;" : "" %>">
                            <%= sd.getStatusNameById(list.getStatusid()) %>
                        </td>
                        <td>
                            <c:if test="${requestScope.flightDetailID != null}">
                                <!--change status modal-->
                                <a class="btn btn-info" style="text-decoration: none;width: 65%;margin-bottom: 4%;border-radius: 4px;" id="myBtn<%= list.getId() %>" onclick="openModal(<%= list.getId() %>)">Change status</a>
                                <div class="modal fade" id="myModal<%= list.getId() %>" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header" style="padding:5px 5px;">
                                                <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                                <h4 style="margin-left: 12px">Change status</h4>
                                            </div>
                                            <div class="modal-body" style="padding:40px 50px;">
                                                <form role="form" action="TicketController" method="post">
                                                    <input type="hidden" name="action" value="changeStatus"/>
                                                    <input type="hidden" name="flightDetailID" value="${flightDetailID}">
                                                    <input type="hidden" name="createdAt" value=""/>
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                            <input type="text" class="form-control" id="usrname" name="id" value="<%= list.getId() %>" readonly="">
                                                        </div>
                                                        <div class="form-group col-md-8">
                                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Status:</label></div>
                                                            <select name="statusID" value="" style="height:  34px">
                                                                <%List<Status> statusList = (List<Status>)request.getAttribute("statusTicketList");
                                                            for(Status status : statusList){%>
                                                                <option value="<%=status.getId()%>" <%=(list.getStatusid() == status.getId())?"selected":""%>><%=status.getName()%></option>"
                                                                <%}%>
                                                            </select>
                                                        </div>                    

                                                    </div>
                                                    <button type="submit" class="btn btn-success btn-block">
                                                        Confirm
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <!--order in4 modal-->
                            <a class="btn btn-warning" style="text-decoration: none;width: 65%;" id="myBtn2<%= list.getId() %>" onclick="openModal2(<%= list.getId() %>)">Order Information</a>
                            <div class="modal fade" id="myModal2<%= list.getId() %>" role="dialog">
                                <div class="modal-dialog modal-lg">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header" style="padding:5px 5px;">
                                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                            <h4 style="margin-left: 12px">Order Information</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <input type="hidden" name="ticketId" value="<%= list.getId() %>">


                                            <p><i class="fas fa-receipt"></i> <strong>Order Code:</strong> <%= od.getOrderInfoByTicket(list.getId()).getCode() %></p>
                                            <p><i class="fas fa-user"></i> <strong>Contact Name:</strong> <%= od.getOrderInfoByTicket(list.getId()).getContactName() %></p>
                                            <p><i class="fas fa-phone"></i> <strong>Contact Phone:</strong> <%= od.getOrderInfoByTicket(list.getId()).getContactPhone() %></p>
                                            <p><i class="fas fa-envelope"></i> <strong>Contact Mail:</strong> <%= od.getOrderInfoByTicket(list.getId()).getContactEmail() %></p>
                                            <p><i class="fas fa-user-circle"></i> <strong>Account:</strong> <%= acd.getAccountNameById(od.getOrderInfoByTicket(list.getId()).getAccountsId()) %></p>
                                            <p><i class="fas fa-credit-card"></i> <strong>Payment Type:</strong> <%= PTD.getPaymentTypeNameById(od.getOrderInfoByTicket(list.getId()).getPaymentTypesId()) %></p>
                                            <p><i class="fas fa-clock"></i> <strong>Payment Time:</strong> <%= od.getOrderInfoByTicket(list.getId()).getPaymentTime() %></p>
                                            <p><i class="fas fa-info-circle"></i> <strong>Status:</strong> <%= sd.getStatusNameById(od.getOrderInfoByTicket(list.getId()).getStatus_id()) %></p>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            <%String flightDetailID = request.getParameter("flightDetailID");
               String action = request.getParameter("action");
               if(action==null &&flightDetailID!=null){
               int FDetailID= Integer.parseInt(flightDetailID);%>
            <div style="">
                <nav aria-label="...">
                    <ul class="pagination">
                        <c:if test="${index != 1}">    
                            <li class="page-item">
                                <a class="page-link" href="TicketController?index=${index -1}&flightDetailID=<%=FDetailID%>">Previous</a>
                            </li>
                        </c:if>    
                        <c:forEach begin="1" end ="${numOfPage}" var="i">
                            <c:if test="${index == i}">
                                <li class="page-item active">
                                    <a class="page-link" href="TicketController?index=${i}&flightDetailID=<%=FDetailID%>">${i}</a>
                                </li>
                            </c:if>

                            <c:if test="${index != i}">
                                <li class="page-item">
                                    <a class="page-link" href="TicketController?index=${i}&flightDetailID=<%=FDetailID%>">${i}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${index != numOfPage}">    
                            <li class="page-item">
                                <a class="page-link" href="TicketController?index=${index +1}&flightDetailID=<%=FDetailID%>">Next</a>
                            </li>
                        </c:if> 
                    </ul>
                </nav>
            </div>
            <%}%>
        </div>


        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
            function openModal2(id) {
                $("#myModal2" + id).modal('show');
            }
            function myModal3() {
                $("#myModal3").modal('show');
            }
        </script>


    </body>
</html>