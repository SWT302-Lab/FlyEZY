<%-- 
    Document   : flightdetailQuanHT
    Created on : Sep 29, 2024, 10:06:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="dal.PlaneCategoryDAO" %>
<%@page import="dal.StatusDAO"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.Status"%>
<%@page import="model.Airport"%>
<%@page import="model.Flights"%>
<%@page import="model.Location"%>
<%@page import="model.Country"%>
<%@page import="model.Airline"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
        <script src="js/toastrNotification.js"></script>
        <style>
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
                width: 45%;
            }
            .details p {
                font-size: 16px;
            }
            .details span {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <%
            String flight_id = (String) request.getAttribute("fid");
            int fid = Integer.parseInt(flight_id);
            String airlineId = (String)request.getAttribute("aid");
                int aid = Integer.parseInt(airlineId);
        %>
        <div id="back" style="margin-left: 18%;margin-top: 110px;margin-bottom: -130px  " > 
            <a href="flightManagement" class="btn btn-warning" >Back</a>
        </div>

        <%
             Flights list = (Flights) request.getAttribute("listFlight");
             Airport listAirportDep = (Airport) request.getAttribute("listAirportDep");
              Location listLocationDep = (Location) request.getAttribute("listLocationDep");
            Country listCountryDep = (Country) request.getAttribute("listCountryDep");
            AirlineManageDAO airline = new AirlineManageDAO();
              Airport listAirportDes = (Airport) request.getAttribute("listAirportDes");
              Location listLocationDes = (Location) request.getAttribute("listLocationDes");
            Country listCountryDes = (Country) request.getAttribute("listCountryDes");
          
        %>
        <div style="margin-left: 18%;margin-top: 9%; color:#3C6E57 "><h2>FLIGHT DETAIL MANAGEMENT</h2></div>
        <div class="main-container" style="margin-left: 18%;width: 74%;">

            <div class="details">
                <p>Departure: <span> <%= listAirportDep.getName() %> (<%= listLocationDep.getName() %>)</span></p>
                <p>From:<span> <%= listCountryDep.getName() %>  </span></p>
                <p>Airline: <span><%= airline.getAirportNamedById(list.getAirlineId()) %></span></p>
            </div>


            <div class="details">
                <p>Destination: <span> <%= listAirportDes.getName() %> (<%= listLocationDes.getName() %>)</span></p>
                <p>To: <span><%= listCountryDes.getName() %></span></p>
                <p>Time: <span><%= list.getMinutes() %> minutes</span></p>
            </div>
        </div>

        <div style="display: flex; margin-left: 315px;margin-top: 22px">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#add-<%=fid%>">Add New Flight Detail</button>
        </div>
        <form action="flightDetailManagement" method="GET" style="display: flex; align-items: center; margin-left: 210px; margin-top: 20px; position: relative; left: 104px; top: -7px;"" oninput="toggleSearchButton()">
            <div style="margin-right: 10px;">
                <label for="Status">Status:</label>
                <select id="status-search" name="statusSearch" class="form-control">
                    <option value="">---Select---</option>
                    <%
                        StatusDAO sd = new StatusDAO();
                        List<Status> statuses = (List<Status>) sd.getStatusOfFlightDetaisl();
                        if (statuses != null) {
                            for (Status status : statuses) {
                    %>
                    <option value="<%= status.getId() %>"><%= status.getName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div style="margin-right: 10px;">
                <label for="Date">Date:</label>
                <input type="date" id="Date" name="dateSearch" step="1" class="form-control">
            </div>
            <div style="margin-right: 10px;">
                <label for="time-from">Time From:</label>
                <input type="time" id="Time-from" name="fromSearch" step="1" class="form-control">
            </div>
            <div style="margin-right: 10px;">
                <label for="time-to">Time To:</label>
                <input type="time" id="Time-to" name="toSearch" step="1" class="form-control">
            </div>
            <div>
                <button style="margin-top: 45px; position: relative; left: 4px; top: -10px;" type="submit" class="btn btn-primary" name="action" value="search" id="search-button" disabled>Search</button>
                <button style="margin-top: 45px; position: relative; left: 4px; top: -10px;" type="submit" class="btn btn-danger" name="action" value="cancel" id="cancel-button">Cancel</button>
            </div>
            <div>
                <input type="hidden" name="flightId" value="<%= fid %>" >
                <input type="hidden" name="airlineId" value="<%= aid %>" >
            </div>
        </form>
        <table class="entity" style="margin-left: 210px; position: relative; left: 104px; top: -2px; transition: none;" >
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Price</th>
                    <th>Plane Category</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
               
                PlaneCategoryDAO planeCategoryDAO =  new PlaneCategoryDAO();
                List<PlaneCategory> categories = (List<PlaneCategory>) planeCategoryDAO.getAllPlaneCategoryByAirlineId(aid);
                %>
                <%
                    List<FlightDetails> listFlightDetails = (List<FlightDetails>) request.getAttribute("listFlightDetails");
                     listFlightDetails.sort((fd1, fd2) -> fd2.getDate().compareTo(fd1.getDate()));
                    if (listFlightDetails != null) {
                        for (FlightDetails fd : listFlightDetails) {
                                String planeCategoryName = planeCategoryDAO.getNameById(fd.getPlaneCategoryId());
                %>
                <tr>

                    <td><%= fd.getDate() %></td>
                    <td><%= fd.getTime() %></td>
                    <td><%= fd.getPrice() %></td>
                    <td>
                        <%= planeCategoryName %>
                    </td>
                    <td>
                        <select name="status" onchange="submitForm(<%= fd.getId() %>, this.value)">
                            <%
                            for (Status status : statuses) {
                            %>
                            <option value="<%= status.getId() %>" <%= fd.getStatusId() == status.getId() ? "selected" : "" %>><%= status.getName() %></option>

                            <%
                                    }
                            %>
                        </select>
                    </td>
                    <td>
                        <%
                        // Kiểm tra xem status ID có phải là 2 không
                        boolean isStatusTwo = (fd.getStatusId() == 2);
                        %>
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#update-<%=fd.getId()%>"  <%= isStatusTwo ? "disabled" : "" %>>
                            Update
                        </button>
                        <a style="margin-right: 5px;text-decoration: none;<%= isStatusTwo ? "pointer-events: none;opacity: 0.5" : "" %>" class="btn btn-warning"  href="TicketController?flightDetailID=<%= fd.getId() %>">
                            Ticket Detail
                            <span style="margin-left: 8px" class="glyphicon glyphicon-menu-right"></span>
                        </a>

                    </td>
                </tr>

                <!--confirm modal btn3-->
            <div class="modal" id="confirmModal-<%= fd.getId() %>">
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
                            <button type="button" class="btn btn-primary confirmChange" data-modal-id="<%= fd.getId() %>">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal update flight details -->
            <div class="modal fade" id="update-<%=fd.getId()%>" tabindex="-1" aria-labelledby="updateFlightModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateFlightModalLabel">Update Flight Detail</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateFlightForm" method="post" action="flightDetailManagement?action=update">
                                <input type="hidden" id="uid" name="id" value="<%=fd.getId()%>">
                                <input type="hidden" name="flightId" value="<%=fid%>">
                                <input type="hidden" name="airlineId" value="<%=aid%>">
                                <div class="mb-3">
                                    <label for="flightDate" class="form-label">Date: </label>
                                    <input type="date" class="form-control" id="uflightDate-<%=fd.getId()%>" name="date"  oninput="validateForm(<%=fd.getId()%>, 'or')" value=<%= fd.getDate()%> required>
                                    <span id="dateError-<%=fd.getId()%>" style="color:red; display:none;">Date cannot be in the past</span>
                                </div>
                                <div class="mb-3">
                                    <label for="flightTime" class="form-label">Time: </label>
                                    <input id="utime" type="time" name="time" value="<%= fd.getTime() %>" step="1" required>
                                </div>
                                <div class="mb-3">
                                    <label for="flightPrice" class="form-label">Price: </label>
                                    <input type="number" min="100000" class="form-control" id="uflightPrice-<%=fd.getId()%>"  oninput="validateForm(<%=fd.getId()%>, 'or')" name="price" value="<%= fd.getPrice() %>" required>
                                    <span id="priceError-<%=fd.getId()%>" style="color:red; display:none;">Price must be less than 100,000,000 VND</span>
                                </div>
                                <div class="mb-3">
                                    <input type="hidden" class="form-control" id="uFlightId" name="flightId" value="<%= fd.getFlightId() %>" required="">
                                </div>
                                <div class="mb-3">
                                    <label for="planeCategoryId" class="form-label">Plane Category: </label>
                                    <select name="planeCategoryId">
                                        <%
                                            for (PlaneCategory category : categories) {
                                                if(category.getStatusId()==1){
                                        %>
                                        <option value="<%=category.getId()%>"  <%=(category.getName().equals(planeCategoryName) ? "selected" : "")%>><%=category.getName()%></option>
                                        <%
                                            }
                                        }
                                        %>
                                    </select>
                                </div>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button id="submitbtn-<%=fd.getId()%>" type="submit" class="btn btn-primary">Update Flight</button>
                        </div>
                        </form>
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
<!-- Modal to Add Flight Detail -->
<div class="modal fade" id="add-<%=fid%>" tabindex="-1" role="dialog" aria-labelledby="addFlightDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addFlightDetailModalLabel">Add New Flight Detail</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="flightDetailManagement" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="date">Date:</label>
                        <input type="date" class="form-control" id="aflightDate-<%=fid%>"   oninput="validateFormAdd(<%=fid%>, 'or')" name="date" required>
                        <div id="adateError-<%=fid%>" style="display:none; color:red;">Date must be today or later.</div>
                    </div>
                    <div class="form-group">
                        <label for="time">Time:</label>
                        <input id="time-<%=fid%>" type="time" name="time" step="1" oninput="validateTimeAdd(<%=fid%>)" required>
                        <div id="timeError-<%=fid%>" style="color: red; display: none;">Time must be greater than or equal to the current time.</div>
                    </div>
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="number" min="100000" class="form-control" id="aflightPrice-<%=fid%>"  oninput="validateFormAdd(<%=fid%>, 'or')" name="price" required>
                        <div id="apriceError-<%=fid%>" style="display:none; color:red;">Price must be less than 100,000,000.</div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="flightId" name="flightId" value="<%=fid%>">
                    </div>
                    <div class="form-group">
                        <label for="planeCategoryId" class="form-label">Plane Category: </label>
                        <select name="planeCategoryId">
                            <%
                            for (PlaneCategory category : categories) {
                                if(category.getStatusId()==1){
                            %>
                            <option value="<%=category.getId()%>"><%=category.getName()%></option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="flightId" value="<%=fid%>">
                        <input type="hidden" name="airlineId" value="<%=aid%>">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" id="asubmitbtn-<%=fid%>" name="action" value="add" class="btn btn-primary">Add Flight Detail</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function validateTimeAdd(id) {

    }
</script>
<script>
    function validateForm(id, mode) {
        var priceInput = document.getElementById("uflightPrice-" + id).value;
        var dateInput = document.getElementById("uflightDate-" + id).value;

        var priceError = document.getElementById("priceError-" + id);
        var dateError = document.getElementById("dateError-" + id);
        var btnsubmit = document.getElementById("submitbtn-" + id);

        var maxPrice = 100000000;
        var currentDate = new Date();
        var inputDate = new Date(dateInput);

        // Đặt giờ của currentDate về 00:00:00 để so sánh ngày
        currentDate.setHours(0, 0, 0, 0);

        // Ẩn các thông báo lỗi
        priceError.style.display = "none";
        dateError.style.display = "none";

        var isPriceValid = priceInput > 0 && priceInput <= maxPrice;
        var isDateValid = inputDate >= currentDate;

        // Hiển thị thông báo lỗi khi cần
        if (!isPriceValid) {
            priceError.style.display = "inline";
        }
        if (!isDateValid) {
            dateError.style.display = "inline";
        }

        // Xử lý logic theo mode
        if (mode === "or") {
            // "Hoặc": btnsubmit bị disabled nếu một trong hai điều kiện không hợp lệ
            btnsubmit.disabled = !isPriceValid || !isDateValid;
        } else if (mode === "and") {
            // "Và": btnsubmit bị disabled nếu cả hai điều kiện không hợp lệ
            btnsubmit.disabled = !isPriceValid && !isDateValid;
        }
    }
</script>
<script>
    function validateFormAdd(id, mode) {
        var priceInput = document.getElementById("aflightPrice-" + id).value;
        var dateInput = document.getElementById("aflightDate-" + id).value;

        var priceError = document.getElementById("apriceError-" + id);
        var dateError = document.getElementById("adateError-" + id);
        var btnsubmit = document.getElementById("asubmitbtn-" + id);

        var maxPrice = 100000000;
        var currentDate = new Date();
        var inputDate = new Date(dateInput);

        // Đặt giờ của currentDate về 00:00:00 để so sánh ngày
        currentDate.setHours(0, 0, 0, 0);

        // Ẩn các thông báo lỗi
        priceError.style.display = "none";
        dateError.style.display = "none";

        var isPriceValid = priceInput > 0 && priceInput <= maxPrice;
        var isDateValid = inputDate >= currentDate;


        // Hiển thị thông báo lỗi khi cần
        if (!isPriceValid) {
            priceError.style.display = "inline";
        }
        if (!isDateValid) {
            dateError.style.display = "inline";
        }

        // Xử lý logic theo mode
        if (mode === "or") {
            btnsubmit.disabled = !isPriceValid || !isDateValid;
        } else if (mode === "and") {
            btnsubmit.disabled = !isPriceValid && !isDateValid;
        }
    }
</script>
<script>
    let currentId = null;
    let currentStatus = null;
    function submitForm(id, status) {
        currentId = id;
        currentStatus = status;
        $('#confirmModal-' + currentId).modal('show');
    }


    document.addEventListener('click', function (event) {
        // Check if the clicked element is the confirm button
        if (event.target && event.target.classList.contains('confirmChange')) {
            // Get the current modal ID from the button
            var modalId = event.target.getAttribute('data-modal-id');
            // Create the form dynamically
            const form = document.createElement("form");
            form.method = "post";
            form.action = "flightDetailManagement?action=updstatus&flightId=<%=fid %>&airlineId=<%=aid %>";
            const idInput = document.createElement("input");
            idInput.type = "hidden";
            idInput.name = "id";
            idInput.value = currentId;
            const statusInput = document.createElement("input");
            statusInput.type = "hidden";
            statusInput.name = "status";
            statusInput.value = currentStatus;
            form.appendChild(idInput);
            form.appendChild(statusInput);
            document.body.appendChild(form);
            form.submit();
            $('#confirmModal-' + modalId).modal('hide');
        }
        // Xử lý khi nhấn nút Cancel
        if (event.target && event.target.classList.contains('btn-secondary')) {
            const modalId = event.target.closest('.modal').getAttribute('id').split('-')[1];
            $('#confirmModal-' + modalId).modal('hide');
            location.reload();
        }
    });
</script>

<script>
    function toggleSearchButton() {
        // Lấy tất cả các trường cần kiểm tra
        const status = document.getElementById('status-search').value;
        const date = document.getElementById('Date').value;
        const fromTime = document.getElementById('Time-from').value;
        const toTime = document.getElementById('Time-to').value;
        // Kiểm tra xem tất cả các trường đều rỗng
        const isAnyFieldFilled = status !== "" || date !== "" || fromTime !== "" || toTime !== "";
        // Bật hoặc tắt nút tìm kiếm dựa trên trạng thái của các trường
        document.getElementById('search-button').disabled = !isAnyFieldFilled;
    }
</script>
</body>
</html>
