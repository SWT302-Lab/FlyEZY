<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Country"%>
<%@page import="model.Airport"%>
<%@page import="model.Flights"%>
<%@page import="model.Location"%>
<%@page import="model.Status"%>
<%@page import="model.Airline"%>
<%@page import="dal.AirportDAO"%>
<%@page import="dal.CountryDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.LocationDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="dal.PlaneCategoryDAO" %>
<%@page import="dal.StatusDAO"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.PlaneCategory"%>
<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flight Management</title>
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
            .modal-body{
                text-align: left
            }
            .modal-body span{
                margin-right: 5px
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>

        <!--MODAL: Add new flight-->
        <div class="modal fade" id="addFlight" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="addBookModalLabel">Add Airline</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>
                    <div class="modal-body">
                        <form id="addProductForm" action="flightManagement" method="POST">
                            <input type="hidden" name="action" value="create">     
                            
                            <div class="form-group">
                                <label for="minutesInput"><span class="glyphicon glyphicon-plane"></span> Minutes:</label>
                                <input type="number" min="2" max="980" class="form-control" id="minutesInput" name="minutes" required>
                            </div>
                            <%
                                CountryDAO cd = new CountryDAO();
                                LocationDAO ld = new LocationDAO();
                                AirportDAO aird = new AirportDAO();
                            %>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <div class="flight-form-group">
                                        <strong>DEP Country:</strong>
                                        <select class="flight-select" name="departureCountry" id="departureCountry1" required>
                                            <option value="">Select Country</option>
                                            <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                            <option value="<%= c.getName() %>"><%= c.getName() %></option>
                                            <% } %>
                                        </select>

                                        <strong>DEP Location:</strong>
                                        <select class="flight-select" name="departureLocation" id="departureLocation1" required>
                                            <option value="">Select Location</option>

                                        </select>

                                        <strong>DEP Airport:</strong>
                                        <select class="flight-select" name="departureAirport" id="departureAirport1" required>
                                            <option value="">Select Airport</option>

                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <div class="flight-form-group">
                                        <strong>DES Country:</strong>
                                        <select class="flight-select" name="destinationCountry" id="destinationCountry1" required>
                                            <option value="">Select Country</option>
                                            <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                            <option value="<%= c.getName() %>"><%= c.getName() %></option>
                                            <% } %>
                                        </select>

                                        <strong>DES Location:</strong>
                                        <select class="flight-select" name="destinationLocation" id="destinationLocation1" required>
                                            <option value="">Select Location</option>

                                        </select>


                                        <strong>DES Airport:</strong>
                                        <select class="flight-select" name="destinationAirport" id="destinationAirport1" required>
                                            <option value="">Select Airport</option>

                                        </select>
                                    </div>
                                </div>
                            </div>       
                            <input type="hidden" class="form-control" name="airlineId" value="${requestScope.account.getAirlineId()}" readonly="">


                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary" form="addProductForm">Add</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <div id="main-content">
            <div style="color:#3C6E57 "><h2>FLIGHT MANAGEMENT</h2></div>
            <div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addFlight"  style="margin-top: 20px;flex-shrink: 0;">
                    Add New Flight
                </button>
            </div>

            <div class="row" style="margin: 0">
                <div class="col-md-8" id="left-column" style="padding: 0; margin-top: 20px">
                    <table class="entity">
                        <thead>     
                            <tr>
                                <th>DEP Country</th>
                                <th>DEP Location</th>
                                <th>DEP Airport</th>
                                <th>DES Country</th>
                                <th>DES Location</th>
                                <th>DES Airport</th>      
                                <th>Minutes</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead> 
                        <tbody>
                            <%
                            ResultSet rsFlightManage;
                            if (request.getAttribute("rsFlightManage") != null) {
                                rsFlightManage = (ResultSet) request.getAttribute("rsFlightManage");
                            } else {
                                rsFlightManage = null;
                            }
                            int i = 0;
                            while(rsFlightManage != null && rsFlightManage.next()) {%>
                            <tr>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(5)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(4)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>" ><%=rsFlightManage.getString(3)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(8)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(7)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(6)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getInt(2)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>">
                                    <%if (rsFlightManage.getInt(12) == 1){ %>
                                    <button class="btn btn-success" data-toggle="modal" data-target="#changeActive-airline-<%=rsFlightManage.getInt(1) %>">Activated</button>
                                    <%}%>
                                    <%if (rsFlightManage.getInt(12) == 2){ %>
                                    <button class="btn btn-danger" data-toggle="modal" data-target="#changeActive-airline-<%=rsFlightManage.getInt(1) %>">Deactivated</button>
                                    <%}%>

                                    <!-- MODAL: Change status -->
                                    <div class="modal fade" id="changeActive-airline-<%=rsFlightManage.getInt(1) %>" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="delete-modal-label">Change Status</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <%if (rsFlightManage.getInt(12) == 2){ %>
                                                <div class="modal-body">
                                                    <p>Do you want to reactivate this airline?</p>
                                                </div>
                                                <%}%>
                                                <%if (rsFlightManage.getInt(12) == 1){ %>
                                                <div class="modal-body">
                                                    <p>Do you want to deactivate this airline?</p>
                                                </div>
                                                <%}%>
                                                <div class="modal-footer">
                                                    <form action="flightManagement" method="post">
                                                        <input type="hidden" name="action" value="changeStatus">
                                                        <div class="form-group" style="display: none">
                                                            <input type="text" class="form-control" id="idDeleteInput" name="flightId" value="<%=rsFlightManage.getInt(1) %>">
                                                        </div>
                                                        <div class="form-group" style="display: none">
                                                            <input type="text" class="form-control" id="idDeleteInput" name="flightStatus" value="<%=rsFlightManage.getInt(12) %>">
                                                        </div>

                                                        <%if (rsFlightManage.getInt(12) == 2){ %>
                                                        <button type="submit" class="btn btn-danger">Yes</button>
                                                        <%}%>
                                                        <%if (rsFlightManage.getInt(12) == 1){ %>
                                                        <button type="submit" class="btn btn-success">Yes</button>
                                                        <%}%>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </td>

                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>">  
                                    <button class="btn btn-info" style="width: 80%" data-toggle="modal" data-target="#update-flight-<%=rsFlightManage.getInt(1) %>">Update</button>
                                    <a style="width: 80%; margin: 0; margin-top: 5px; text-decoration: none; text-align: center" href="flightDetailManagement?flightId=<%= rsFlightManage.getInt(1) %>&airlineId=${requestScope.account.getAirlineId()}" class="btn btn-warning">
                                        Flight Detail
                                        <span style="margin-right: 5px" class="glyphicon glyphicon-menu-right"></span>
                                    </a>
                                    <!-- MODAL: Update flight-->
                                    <div class="modal fade" id="update-flight-<%=rsFlightManage.getInt(1) %>" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" style="text-align: left;">Update Airline</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form  action="flightManagement" method="post"> 
                                                        <input type="hidden" name="action" value="update"/>
                                                        <input type="hidden" name="airlineId" value="${requestScope.account.getAirlineId()}" readonly=""/>
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%=rsFlightManage.getInt(1) %>" readonly="">


                                                        <!-- Minutes -->
                                                        <div class="form-group">
                                                            <label for="nameInput" style="text-align: left; display: block;"><span class="glyphicon glyphicon-plane"></span> Minutes:</label>
                                                            <input type="number" min="2" max="980" class="form-control" id="nameInput" name="minutes" value="<%=rsFlightManage.getInt(2)%>" required/>
                                                        </div>

                                                        <div class="row" >
                                                            <div class="flight-form-group col-md-6">
                                                                <strong>DEP Country:</strong>
                                                                <select class="flight-select" name="departureCountry" id="departureCountry2<%=i%>" required>
                                                                    <option value="">Select Country</option>
                                                                    <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                                                    <option value="<%= c.getName() %>" <%= (c.getName().equals(rsFlightManage.getString(5)) ? "selected" : "") %>><%= c.getName() %></option>
                                                                    <% } %>
                                                                </select>

                                                                <strong>DEP Location:</strong>
                                                                <select class="flight-select" name="departureLocation" id="departureLocation2<%=i%>" required>
                                                                    <option value="">Select Location</option>
                                                                    <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(rsFlightManage.getString(5)))) { %>
                                                                    <option value="<%= l.getName() %>" <%= (l.getName().equals(rsFlightManage.getString(4)) ? "selected" : "") %>><%= l.getName() %></option>
                                                                    <% } %>
                                                                </select>

                                                                <strong>DEP Airport:</strong>
                                                                <select class="flight-select" name="departureAirport" id="departureAirport2<%=i%>" required>
                                                                    <option value="">Select Airport</option>
                                                                    <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(rsFlightManage.getString(4)))) { %>
                                                                    <option value="<%= ap.getName() %>" <%= (ap.getName().equals(rsFlightManage.getString(3)) ? "selected" : "") %>><%= ap.getName() %></option>
                                                                    <% } %>
                                                                </select>
                                                            </div>

                                                            <div class="flight-form-group col-md-6">
                                                                <strong>DES Country:</strong>
                                                                <select class="flight-select" name="destinationCountry" id="destinationCountry2<%=i%>" required>
                                                                    <option value="">Select Country</option>
                                                                    <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                                                    <option value="<%= c.getName() %>" <%= (c.getName().equals(rsFlightManage.getString(8)) ? "selected" : "") %>><%= c.getName() %></option>
                                                                    <% } %>
                                                                </select>

                                                                <strong>DES Location:</strong>
                                                                <select class="flight-select" name="destinationLocation" id="destinationLocation2<%=i%>" required>
                                                                    <option >Select Location</option>
                                                                    <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(rsFlightManage.getString(8)))) { %>
                                                                    <option value="<%= l.getName() %>" <%= (l.getName().equals(rsFlightManage.getString(7)) ? "selected" : "") %>><%= l.getName() %></option>
                                                                    <% } %>
                                                                </select>


                                                                <strong>DES Airport:</strong>
                                                                <select class="flight-select" name="destinationAirport" id="destinationAirport2<%=i%>" required>
                                                                    <option>Select Airport</option>
                                                                    <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(rsFlightManage.getString(7)))) { %>
                                                                    <option value="<%= ap.getName() %>" <%= (ap.getName().equals(rsFlightManage.getString(6)) ? "selected" : "") %>><%= ap.getName() %></option>
                                                                    <% } %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="modal-footer" style="text-align: right;">
                                                    <button type="submit" class="btn btn-primary" >Update</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>

                                                </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </td>


                                <%i++;}%>

                        </tbody>
                    </table>
                    <div style="">
                        <nav aria-label="...">
                            <ul class="pagination">
                                <c:if test="${index != 1}">    
                                    <li class="page-item">
                                        <a class="page-link" href="flightManagement?index=${index -1}">Previous</a>
                                    </li>
                                </c:if>    
                                <c:forEach begin="1" end ="${numOfPage}" var="i">
                                    <c:if test="${index == i}">
                                        <li class="page-item active">
                                            <a class="page-link" href="flightManagement?index=${i}">${i}</a>
                                        </li>
                                    </c:if>

                                    <c:if test="${index != i}">
                                        <li class="page-item">
                                            <a class="page-link" href="flightManagement?index=${i}">${i}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${index != numOfPage}">    
                                    <li class="page-item">
                                        <a class="page-link" href="flightManagement?index=${index +1}">Next</a>
                                    </li>
                                </c:if> 
                            </ul>
                        </nav>
                    </div>
                </div>

                <!-- SEARCH FLIGHT FORM -->
                <div class="col-md-4">
                    <form class="flight-form" action="flightManagement" method="GET" style="display: flex; width: 78%; align-items: center;">
                        <input type="hidden" name="action" value="search"/>
                        <input type="hidden" class="form-control" name="airlineId" value="${requestScope.account.getAirlineId()}" >
                        <div class="flight-form-group">
                            <strong>DEP Country:</strong>
                            <select class="flight-select" name="departureCountry" id="departureCountry3">
                                <option value="">Select Country</option>
                                <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                <option value="<%= c.getName() %>" <%= (c.getName().equals(request.getParameter("departureCountry")) ? "selected" : "") %>><%= c.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DEP Location:</strong>
                            <select class="flight-select" name="departureLocation" id="departureLocation3">
                                <option value="">Select Location</option>
                                <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(request.getParameter("departureCountry")))) { %>
                                <option value="<%= l.getName() %>" <%= (l.getName().equals(request.getParameter("departureLocation")) ? "selected" : "") %>><%= l.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DEP Airport:</strong>
                            <select class="flight-select" name="departureAirport" id="departureAirport3">
                                <option value="">Select Airport</option>
                                <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(request.getParameter("departureLocation")))) { %>
                                <option value="<%= ap.getName() %>" <%= (ap.getName().equals(request.getParameter("departureAirport")) ? "selected" : "") %>><%= ap.getName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="flight-form-group">
                            <strong>DES Country:</strong>
                            <select class="flight-select" name="destinationCountry" id="destinationCountry3">
                                <option value="">Select Country</option>
                                <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                <option value="<%= c.getName() %>" <%= (c.getName().equals(request.getParameter("destinationCountry")) ? "selected" : "") %>><%= c.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DES Location:</strong>
                            <select class="flight-select" name="destinationLocation" id="destinationLocation3">
                                <option value="">Select Location</option>
                                <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(request.getParameter("destinationCountry")))) { %>
                                <option value="<%= l.getName() %>" <%= (l.getName().equals(request.getParameter("destinationLocation")) ? "selected" : "") %>><%= l.getName() %></option>
                                <% } %>
                            </select>


                            <strong>DES Airport:</strong>
                            <select class="flight-select" name="destinationAirport" id="destinationAirport3">
                                <option value="">Select Airport</option>
                                <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(request.getParameter("destinationLocation")))) { %>
                                <option value="<%= ap.getName() %>" <%= (ap.getName().equals(request.getParameter("destinationAirport")) ? "selected" : "") %>><%= ap.getName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div>
                            <button class="btn btn-info" type="submit">Search</button>
                            <a class="btn btn-danger" href="flightManagement">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="ck-body-wrapper">
            <div class="ck ck-reset_all ck-body ck-rounded-corners" dir="ltr" role="application">
                <div class="ck ck-clipboard-drop-target-line ck-hidden"></div>
                <div class="ck ck-aria-live-announcer">
                    <div aria-live="polite" aria-relevant="additions">
                        <ul class="ck ck-aria-live-region-list"></ul>
                    </div>
                    <div aria-live="assertive" aria-relevant="additions">
                        <ul class="ck ck-aria-live-region-list"></ul>
                    </div>
                </div>
            </div>
        </div>

        <script type="importmap">
            {
            "imports": {
            "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
            "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
            }
            }
        </script>
        <script>
            //SHOW Flight Detail of each flight
            function toggleFlightDetails(flightid) {
                var detailsRow = document.getElementById('flight-details-' + flightid);
                var arrow = document.getElementById("arrow" + flightid);

                if (detailsRow.style.display === 'table-row') {
                    detailsRow.style.display = 'none';
                    arrow.classList.remove("glyphicon-menu-up");
                    arrow.classList.add("glyphicon-menu-down");
                } else {
                    detailsRow.style.display = 'table-row';
                    arrow.classList.remove("glyphicon-menu-down");
                    arrow.classList.add("glyphicon-menu-up");
                }
            }


            $(document).ready(function () {
                //Toast notification:
            <% if (request.getAttribute("error") != null) { %>
                error("<%= request.getAttribute("error").toString()%>");
            <% }
                if (request.getAttribute("result") != null) { %>
                successful("<%= request.getAttribute("result").toString()%>");
            <% }%>
                // Create an empty countries object
                var countries = {
                    "All": {
                        locations: ["All"],
                        airports: {"All": ["All"]}
                    }
                };

            <%
                LocationDAO ld2 = new LocationDAO();
                AirportDAO aird2 = new AirportDAO();
                List<Country> listCountry = (List<Country>) request.getAttribute("listC");

                for (Country c : listCountry) { 
                    List<Location> listLocation = ld2.getLocationsByCountryId(c.getId());
            %>

                countries["<%= c.getName() %>"] = {
                locations: [
            <% for (Location l : listLocation) { %>
                "<%= l.getName() %>",
            <% } %>
                ],
                        airports: {
            <% for (Location l : listLocation) {
                        List<Airport> listAirport = aird2.getAirportsByLocationId(l.getId());
            %>
                        "<%= l.getName() %>": [
            <% for (int j = 0; j < listAirport.size(); j++) {
                            Airport airport = listAirport.get(j);
                            out.print("\"" + airport.getName() + "\"");
                            if (j < listAirport.size() - 1) {
                                out.print(", ");
                            }
                        } %>
                        ],
            <% } %>
                        }
                };
            <% } %>

                function updateLocationOptions(countrySelector, locationSelector, airportSelector) {
                    $(countrySelector).change(function () {
                        console.log("Selected country: " + $(this).val());
                        var selectedCountry = $(this).val();
                        var locationOptions = "<option value=''>Select Location</option>";

                        if (selectedCountry && countries[selectedCountry]) {
                            var locations = countries[selectedCountry]["locations"];
                            locations.forEach(function (location) {
                                locationOptions += "<option value='" + location + "'>" + location + "</option>";
                            });
                            $(locationSelector).html(locationOptions);
                        } else {
                            $(locationSelector).empty();
                            $(airportSelector).empty();
                        }
                    });

                    $(locationSelector).change(function () {
                        console.log("Selected location: " + $(this).val());
                        var selectedCountry = $(countrySelector).val();
                        var selectedLocation = $(this).val();
                        var airportOptions = "<option value=''>Select Airport</option>";

                        if (selectedLocation && countries[selectedCountry]) {
                            var airports = countries[selectedCountry]["airports"][selectedLocation];
                            airports.forEach(function (airport) {
                                airportOptions += "<option value='" + airport + "'>" + airport + "</option>";
                            });
                            $(airportSelector).html(airportOptions);
                        } else {
                            $(airportSelector).empty();
                        }
                    });
                }


                updateLocationOptions("#departureCountry1", "#departureLocation1", "#departureAirport1");
                updateLocationOptions("#destinationCountry1", "#destinationLocation1", "#destinationAirport1");
            <% for(int k = 0; k<i;k++){%>
                updateLocationOptions("#departureCountry2<%=k%>", "#departureLocation2<%=k%>", "#departureAirport2<%=k%>");
                updateLocationOptions("#destinationCountry2<%=k%>", "#destinationLocation2<%=k%>", "#destinationAirport2<%=k%>");
            <%}%>
                updateLocationOptions("#departureCountry3", "#departureLocation3", "#departureAirport3");
                updateLocationOptions("#destinationCountry3", "#destinationLocation3", "#destinationAirport3");
            });
        </script>
    </body>
</html>