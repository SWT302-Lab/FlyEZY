<%-- 
    Document   : findOrder
    Created on : Oct 30, 2024, 8:20:07 AM
    Author     : phung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.TicketDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.PassengerTypeDAO"%>
<%@page import="dal.PlaneCategoryDAO"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.BaggageManageDAO"%>
<%@page import="dal.FeedbackDao"%>
<%@page import="java.util.List"%>
<%@page import="model.Status"%>
<%@page import="model.Order"%>
<%@page import="model.Flights"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.FlightType"%>
<%@page import="model.PassengerType"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="model.Baggages"%>
<%@page import="model.Feedbacks"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- for vnpay -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>

        <title>Ticket Buying History</title>
        <style>
            .buying-history {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .order-card {
                border: 1px solid #ddd;
                padding: 15px;
                border-radius: 8px;
                background-color: #f9f9f9;
                margin-bottom: 25px;
            }

            .order-header {
                display: flex;
                justify-content: space-between;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
                margin-bottom: 10px;
            }

            .ticket-details {
                display: flex;
                align-items: center;
                padding: 15px 20px;
                border-bottom: 1px solid #ddd;
                background-color: white;
                margin-bottom: 10px;
                border-radius: 10px;
            }
            .list-price{
                border-bottom: 1px solid #ddd;
            }

            .airline-image {
                width: 100px;
                margin-right: 15px;
            }

            .flight-info {
                flex-grow: 1;
            }

            .ticket-actions {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: flex-end;
                gap: 5px;
                height: 230px;
                padding: 10px 0;
            }
            .order-total{
                text-align: right;
            }
            .ticket-details i {
                color: #666;
                margin-right: 5px;
                font-size: 0.9em;
                vertical-align: middle;
            }

            .flight-info div {
                line-height: 1.5;
                color: #333;
            }

            .status-label {
                padding: 5px 10px;
                font-size: 15px;
                color: white;
                font-weight: bold;
                display: inline-block;
                text-align: center;
                white-space: nowrap;
                color: white;
                border-radius: 12px;
                text-align: center;
                width: 165px;
            }

            .status-label.completed {
                background-color: black;
            }

            .status-label.pending {
                background-color: #ffc107;
            }

            .status-label.successful {
                background-color: #28a745;
            }
            .status-label.request {
                background-color: #ffc107;
            }

            .status-label.processing {
                background-color: orange;
            }

            .status-label.cancelled {
                background-color: #dc3545;
            }
            .status-label.refund {
                background-color: #28a745;
            }
            .status-label.rejection {
                background-color: #dc3545;
            }
            .status-label.rejected {
                background-color: #dc3545;
            }
            .status-label.request {
                background-color: #ffc107;
            }
            .status-label.canceled {
                background-color: #28a745;
            }
            .status-label.refund {
                background-color: #28a745;
            }
            .status-label.rejection {
                background-color: #dc3545;
            }
            #payment_methods {
                margin-top: 10px;
                border-radius: 3px;
                background-color: #f9f9f9;
            }

            #payment_methods h2 {
                font-size: 25px;
                margin-bottom: 50px;
                text-align: center;
            }
            .imgPayment{
                width: 70px;
                height: 70px;
            }
            .payment-options {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .payment-option {
                display: flex;
                flex-direction: row;
                align-items: center;
                padding: 8px;
                flex: 1;
                margin-right: 10px;
            }

            .payment-option:last-child {
                margin-right: 0; /* Remove right margin for the last item */
            }

            .payment-option input[type="radio"] {
                margin-right: 10px;
            }

            .payment-option label {
                display: flex;
                align-items: center;
                cursor: pointer;
            }

            .name-pay {
                padding: 5px 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 100%;
                font-family: Arial, sans-serif;
                text-align: left;
                font-size: 15px;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm dd-MM-yyyy");
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            StatusDAO sd = new StatusDAO();
            List<Status> listStatusOrder = sd.getStatusOfOrder();
            AirlineManageDAO ad = new AirlineManageDAO();
            OrderDAO od = new OrderDAO();
            FlightDetailDAO fdd = new FlightDetailDAO();
            FlightManageDAO fd = new FlightManageDAO();
            TicketDAO td = new TicketDAO();
            FlightTypeDAO ftd = new FlightTypeDAO();
            PassengerTypeDAO ptd = new PassengerTypeDAO();
            PlaneCategoryDAO pcd = new PlaneCategoryDAO();
            SeatCategoryDAO scd = new SeatCategoryDAO();
            BaggageManageDAO bmd = new BaggageManageDAO();
            
            Order o = (Order)request.getAttribute("order");
            List<FlightDetails> listFlightDetails = (List<FlightDetails>)request.getAttribute("listFlightDetails");
        %>

        <!-- Container for the order details -->

        <div class="container mt-5 order-container" style="transform: translateY(45px)">
            <!-- Search Bar Section -->
            <div class="row mt-3 mb-3">
                <div class="col-md-12">
                    <form action="findOrder" method="get" class="form-inline justify-content-center" onsubmit="return validateCodeInput()">
                        <input type="text" value="${param.code}" class="form-control" name="code" id="codeInput" placeholder="Enter code here to search ..." aria-label="Search" style="width: 30%; font-size: 1.2em">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fa fa-search"></i> 
                            </button>
                        </div>
                    </form>
                    <div style="
                         text-align: center;
                         color: seagreen;
                         ">
                        <h3><%=request.getAttribute("notice")!=null ? request.getAttribute("notice") : ""%></h3>
                    </div>
                    <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Buying History Section -->
            <div class="buying-history">
                <%int id = 0;%>
                <% if(o!=null){             
                    List<Ticket> listTicketInOrder = td.getAllTicketsByOrderId(o.getId());
                    if (!listTicketInOrder.isEmpty()) { %>

                <% Boolean isVerified = (Boolean) request.getAttribute("isVerified"); %>
                <% String errorContact = (String) request.getAttribute("errorContact"); %>
                <% if (isVerified != null && isVerified) { %>
                <div class="order-card">
                    <div class="order-header">

                        <div class="order-id" >
                            <strong style="font-size: 28px;"><%=o.getCode()%></strong>
                            <span style="margin-left: 4px; font-size: 12px; color: #aaa;"><%=sdf.format(o.getCreated_at())%></span><br>
                            <div class="contact-info" style="color: #9a9999;
                                 margin-top: 5px;">
                                Contact: <i class="fas fa-user"></i> <%= o.getContactName() %> | 
                                <i class="fas fa-phone"></i> <%= o.getContactPhone() %> | 
                                <i class="fas fa-envelope"></i> <%= o.getContactEmail() %>
                            </div>

                        </div>


                        <div class="order-details">
                            <span class="status-label <%= sd.getStatusNameById(o.getStatus_id()).toLowerCase() %>">
                                <%= sd.getStatusNameById(o.getStatus_id()) %>
                            </span>
                        </div>
                    </div>

                    <% int ticketOfBaggage = 0; int count = 1; int total = 0;%>
                    <% for(Ticket t : listTicketInOrder) { %>
                    <% ticketOfBaggage = bmd.getPriceBaggagesById(t.getId()); %>
                    <% id = t.getId(); %>
                    <div class="ticket-details">
                        <div class="flight-info" style="display: flex; flex-direction: column; gap: 5px;">
                            <div style="display: flex; align-items: center; gap: 10px;margin-bottom: 20px">
                                <div class="airline-image">
                                    <img src="<%=ad.getImageById(td.getAirlineByTicket(t.getId()))%>" alt="Airline Logo" class="img-fluid">
                                </div>
                                <div>
                                    <div>Ticket <%= count %></div>
                                    <div><%= t.getpSex() == 1 ? "Mr." : "Mrs." %> <%= t.getpName() %></div>
                                    <div><%= scd.getSeatCategoryById(t.getSeat_Categoryid()).getName() %> - <%= t.getCode() %></div>
                                </div>
                            </div>
                            <% for(FlightDetails detail : fdd.getAll()) {
                if(detail.getId() == t.getFlightDetailId()) { %>

                            <!-- Flight route icon -->
                            <div><i class="fas fa-plane"></i> <%= fd.getDepartureByFlight(od.getFlightIdByOrder(o.getId())) %> to <%= fd.getDestinationByFlight(od.getFlightIdByOrder(o.getId())) %></div>

                            <!-- Date and Time with icons -->
                            <div>
                                <i class="far fa-calendar-alt"></i>
                                <%= detail.getDate() %>
                                <span class="time-separator" style="margin-left: 10px;">
                                    <i class="far fa-clock"></i>
                                    <%= detail.getTime()%> - <%=fd.getFlightById(detail.getFlightId()).getMinutes() %> minutes
                                </span>
                            </div>


                            <!-- Plane category and flight duration with icons -->
                            <div><i class="fas fa-plane-departure"></i> <%= pcd.getPlaneCategoryById(detail.getPlaneCategoryId()).getName() %> </div>

                            <% }} %>

                            <!-- Extra baggage with icon -->
                            <% for(Baggages b : bmd.getAllBaggages()) {
                if(b.getId() == t.getBaggagesid()) { %>
                            <div><i class="fas fa-suitcase"></i> Extra baggage: <%= b.getWeight() %>kg</div>
                            <% } } %>
                        </div>

                        <div class="ticket-actions">

                            <div class="status-label <%= sd.getStatusNameById(t.getStatusid()).toLowerCase() %>">
                                <%= sd.getStatusNameById(t.getStatusid()) %>
                            </div>
                            <div><strong style="font-size: 16px"><%= currencyFormatter.format(t.getTotalPrice()) %></strong></div>
                                <% if(t.getStatusid() == 10 || t.getStatusid() == 12) { %>
                            <a class="btn btn-danger" style="text-decoration: none; margin-top: 5px;" onclick="openModalTicket(<%= t.getId() %>,<%= o.getId() %>)">Cancel ticket</a>

                            <% }
                            if ((o.getStatus_id() == 10 || o.getStatus_id() == 7) && t.getStatusid() == 7 && o.getPaymentTime() != null && t.getCancelled_at() != null 
                                && o.getPaymentTime().compareTo(t.getCancelled_at()) < 0) { // vé bị huỷ trước lúc thanh toán sẽ không cho phép refund
                            %>
                            <a class="btn btn-warning" style="text-decoration: none; margin-top: 5px;" onclick="openModalRequestRefund(<%= t.getId() %>,<%= o.getId() %>)">Request refund</a>
                            <%
                            }
                            %>
                        </div>
                    </div>
                    <% count++; %>
                    <% } %>




                    <div class="list-price" style="text-align: right; padding: 15px 0 "> 
                        <div>Order Tickets: <%=currencyFormatter.format(od.getTotalPriceAllTickets(o.getId())) %></div>
                        <div>Cancel Tickets: <%=currencyFormatter.format(od.getTotalPriceCancelledTicket(o.getId())) %></div>
                        <div>Is Paid <%=currencyFormatter.format((o.getPaymentTime()!=null)?o.getTotalPrice():0) %></div>
                        <div class="order-discount">Discount: 0%</div>
                        <div class="order-total"><strong style="font-size: 1.2em;">Total: <%=currencyFormatter.format(od.getTotalPriceAllTickets(o.getId())-od.getTotalPriceCancelledTicket(o.getId())) %></strong></div>
                    </div>


                    <div class="order-total-section" style="font-size: 1.2em;">
                        <div class="order-actions" style="margin-top: 10px;text-align: right">
                            <% if (td.countNumberTicketNotCancel(o.getId()) == 0) { %>
                            <a class="btn btn-danger" style="text-decoration: none; display: none;" onclick="openModalOrder(<%= o.getId() %>)">Cancel Order</a>
                            <% } else { %>
                            <a class="btn btn-danger" style="text-decoration: none;" onclick="openModalOrder(<%= o.getId() %>)">Cancel Order</a>
                            <% } %>

                            <%if(o.getStatus_id()==12){%>
                            <button type="submit" class="btn btn-success" id="togglePaymentBtn">PAY NOW</button>
                            <%}%>
                        </div>
                    </div>

                </div>
            </div>
            <div id="payment_methods" style="display: none;">
                <h2>Payments Method</h2>
                <div class="payment-options">
                    <div class="payment-option">
                        <form action="VnpayServlet" id="frmCreateOrder"  method="post"> 
                            <input type="hidden" name="orderID" value="<%=o.getId()%>"/>
                            <input type="hidden" name="bankCode" value="">
                            <input type="hidden" class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="1000000000" min="1" name="amount" type="number" value="<%=o.getTotalPrice()%>" />
                            <input type="hidden" name="language" checked value="vn">
                            <button type="submit" class="btn btn-default">
                                <label for="payment_gateway" id="submitLabel"> 
                                    <img class="imgPayment" src="<c:url value='/img/VnPay.jpg'/>"> &nbsp;
                                    <div class="name-pay">
                                        VNPAY<br>
                                        VNPAY payment gateway
                                    </div>
                                </label>
                            </button>
                        </form>
                    </div>
                    <div class="payment-option">
                        <form action="QRCodeController" method="post"> 
                            <input type="hidden" name="orderID" value="<%=o.getId()%>"/>
                            <button type="submit" class="btn btn-default" href>
                                <label for="payment_ORcode">
                                    <img class="imgPayment" src="<c:url value='/img/qr_code.jpg'/>" alt="QR Code"> &nbsp;
                                    <div class="name-pay">
                                        QR Code<br>
                                        Pay by QR Code transfer
                                    </div>
                                </label>
                            </button>
                        </form>
                    </div>

                </div>
            </div>
            <% }else{ %>
            <div class="contact-verification mt-3">
                <form action="findOrder" method="get" onsubmit="return validateNameInput()">
                    <input type="hidden" name="code" value="<%= o.getCode() %>">
                    <label for="contactInfo">Please verify your contact information:</label>
                    <input type="text" id="contactInfo" name="contactInfo" class="form-control" placeholder="Enter your contact mail/phone">
                    <% if (errorContact != null && !errorContact.isEmpty()) { %>
                    <div class="alert alert-danger mt-2">
                        <%= errorContact %>
                    </div>
                    <% } %>
                    <button type="submit" class="btn btn-primary mt-2">Verify</button>
                </form>
            </div>
            <%}%>

            <%}%>
            <%}%>

        </div>
        <!--        Cancel ticket modal-->
        <div id="cancelTicketModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
            <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
                <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888;">
                    <form action="cancelTicket" method="post">
                        <input type="hidden" id="modalTicketId" name="ticketId" value="">
                        <input type="hidden" id="modalOrderId" name="orderId" value="">
                        <h2>Cancel Ticket</h2>
                        <p>Are you sure you want to cancel this ticket?</p>
                        <!-- Container for buttons with flex display -->
                        <div style="display: flex; justify-content: space-between;">
                            <button type="submit" id="confirmCancel" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                            <button type="button" id="closeModal" class="btn btn-secondary" style="flex: 1;" onclick="closeModal()">No</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="cancelOrderModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
            <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
                <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888;">
                    <form action="cancelOrder" method="post">
                        <input type="hidden" id="modalOrderId1" name="orderId" value="">
                        <h2>Cancel Order</h2>
                        <p>Are you sure you want to cancel this order?</p>
                        <!-- Container for buttons with flex display -->
                        <div style="display: flex; justify-content: space-between;">
                            <button type="submit" id="confirmCancelOrder" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                            <button type="button" id="closeOrderModal" class="btn btn-secondary" style="flex: 1;" onclick="closeOrderModal()">No</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="requestRefundModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
            <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
                <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888;">
                    <form action="requestRefund" method="post" onsubmit="return validateBankAccount()">
                        <input type="hidden" id="modalTicketId2" name="ticketId" value="">
                        <input type="hidden" id="modalOrderId2" name="orderId" value="">
                        <h2 id="requestRefundLabel">Request Refund</h2>
                        <p id="requestRefundDescription">Please provide your bank details to request a refund.</p>
                        <div class="form-group">
                            <label for="bank">Bank Name</label>
                            <select id="bank" name="bank" required class="form-control">
                                <option value="">Select a bank</option>
                                <option value="BIDV">BIDV</option>
                                <option value="TP Bank">TP Bank</option>
                                <option value="MB Bank">MB Bank</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="bankAccount">Bank Account</label>
                            <input type="text" id="bankAccount" name="bankAccount" required class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="confirmBankAccount">Confirm Bank Account</label>
                            <input type="text" id="confirmBankAccount" name="confirmBankAccount" required class="form-control">
                        </div>
                        <!-- Container for buttons with flex display -->
                        <div style="display: flex; justify-content: space-between;">
                            <button type="submit" id="confirmRequestRefund" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                            <button type="button" id="closeRequestRefundModal" class="btn btn-secondary" style="flex: 1;" onclick="closeOrderModal()">No</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script>
                                $("#frmCreateOrder").submit(function () {
                                    var postData = $("#frmCreateOrder").serialize();
                                    var submitUrl = $("#frmCreateOrder").attr("action");
                                    $.ajax({
                                        type: "POST",
                                        url: submitUrl,
                                        data: postData,
                                        dataType: 'JSON',
                                        success: function (x) {
                                            if (x.code === '00') {
                                                if (window.vnpay) {
                                                    vnpay.open({width: 768, height: 600, url: x.data});
                                                } else {
                                                    location.href = x.data;
                                                }
                                                return false;
                                            } else {
                                                alert(x.Message);
                                            }
                                        }
                                    });
                                    return false;
                                });

                                document.getElementById('togglePaymentBtn').addEventListener('click', function () {
                                    var paymentMethods = document.getElementById('payment_methods');
                                    if (paymentMethods.style.display === 'none' || paymentMethods.style.display === '') {
                                        paymentMethods.style.display = 'block';
                                    } else {
                                        paymentMethods.style.display = 'none';
                                    }
                                });
        </script>
        <script>
            function openModalRequestRefund(ticketId, orderId) {
                document.getElementById("modalTicketId2").value = ticketId;
                document.getElementById("modalOrderId2").value = orderId;
                document.getElementById("requestRefundModal").style.display = "block";
            }

            function closeModalRequestRefund() {
                document.getElementById("requestRefundModal").style.display = "none";
            }

            document.getElementById("closeRequestRefundModal").onclick = closeModalRequestRefund;

            function openModalTicket(ticketId, orderId) {
                document.getElementById("modalTicketId").value = ticketId;
                document.getElementById("modalOrderId").value = orderId;
                document.getElementById("cancelTicketModal").style.display = "block";
            }

            function closeModalTicket() {
                document.getElementById("cancelTicketModal").style.display = "none";
            }

            document.getElementById("closeModal").onclick = closeModalTicket;

            function openModalOrder(orderId) {
                document.getElementById('modalOrderId1').value = orderId;
                document.getElementById('cancelOrderModal').style.display = 'block';
            }

            function closeOrderModal() {
                document.getElementById('cancelOrderModal').style.display = 'none';
            }

            document.getElementById("closeOrderModal").onclick = closeOrderModal;

            // Consolidated click outside handler
            window.onclick = function (event) {
                const modals = [
                    document.getElementById("requestRefundModal"),
                    document.getElementById("cancelTicketModal"),
                    document.getElementById("cancelOrderModal")
                ];

                modals.forEach(function (modal) {
                    if (event.target === modal) {
                        modal.style.display = "none";
                    }
                });
            };
            function validateNameInput() {
                const nameInput = document.getElementById("contactInfo").value.trim();
                if (nameInput === "") {
                    alert("Please enter valid contact. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
            function validateCodeInput() {
                const codeInput = document.getElementById("codeInput").value.trim();
                if (codeInput === "") {
                    alert("Please enter valid code. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
