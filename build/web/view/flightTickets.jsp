<%-- 
    Document   : flightTickets
    Created on : Oct 2, 2024, 7:51:39 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Calendar" %>
<%@page import="model.FlightDetails" %>
<%@page import="model.Flights" %>
<%@page import="model.Airport" %>
<%@page import="model.Airline" %>
<%@page import="model.Location" %>
<%@page import="model.Country" %>
<%@page import="model.PlaneCategory" %>
<%@page import="model.SeatCategory" %>
<%@page import="java.util.List" %>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="dal.FlightDetailDAO" %>
<%@page import="dal.PlaneCategoryDAO" %>
<%@page import="dal.SeatCategoryDAO" %>
<%@page import="dal.AirportDAO" %>
<%@page import="dal.LocationDAO" %>
<%@page import="dal.CountryDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <style>
        .flight-detail {
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            padding: 0 20px;
        }

        .flight-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
        }
        .flight-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            text-align: center;
        }
        .airport-info {
            flex: 1;
        }
        .flight-icon {
            font-size: 30px;
            color: #3C6E57;
            margin-bottom: 10px;
        }
        .airport-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .location {
            color: #666;
            font-size: 14px;
        }
        .flight-details {
            flex: 1;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            padding: 0 20px;
        }
        .flight-type {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .flight-time {
            font-size: 14px;
            color: #666;
        }
        .airline-logo-container {
            width: 12%;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 2px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
        }

        .airline-logo-container img {
            width: 100%;
            height: auto;
            border-radius: 5px;
            transition: transform 0.3s;
        }

        .airline-logo-container img:hover {
            transform: scale(1.05);
        }

        .time {
            font-size: 25px;
            font-weight: 600;
            text-align: center;
            margin: 0;
        }

        .location {
            text-align: center;
            color: #A9A9A9;
        }

        .price {
            font-size: 20px;
            color: #D32F2F;
            font-weight: bold;
            text-align: right;
        }

        .old-price {
            font-size: 14px;
            color: #A9A9A9;
            text-decoration: line-through;
            margin-right: 5px;
            display: block;
        }

        .ticket-category-head{
            color: white;
            font-size: 15px;
            font-weight: 600;
            text-align: center;
            padding:10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px
        }

        .ticket-category-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border: 2px solid;
            padding: 10px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            min-height: 300px;
        }

        .ticket-category-info {
            flex-grow: 1;
            margin-bottom: 20px;
            padding: 0 18px
        }
        .ticket-category-list{
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 25px 90px;
        }

        .ticket-category-form {
            display: flex;
            justify-content: center;
        }

        .ticket-category-form button {
            color: white;
            font-size: 15px;
            width: 50%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .ticket-category-form button:hover {
            opacity: 85%
        }

        .arrow:hover{
            opacity: 60%
        }

        .modal-body {
            border-radius: 5px;
        }
        .modal-body p{
            margin: 0 0 5px;
        }

        .modal-body span {
            color: #3C6E57;
        }

        .modal-body .departure-time,
        .modal-body .destination-time {
            font-size: 16px;
            font-weight: bold;
        }

        .modal-body .location{
            font-style: italic;
        }
        .modal-body .airport {
            color: #aaa;
        }

        .modal-body .total-time {
            font-size: 14px;
            font-weight: normal;
            color: #3C6E57;
        }

        .sorting-options {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: white;
        }

        .sorting-options h5 {
            margin:0;
            color: #333;
            font-weight: bold;
            font-size: 16px;
        }

        .sorting-options label {
            margin:0;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .sorting-options label img {
            width: 35px;
            height: 35px;
            border-radius: 20px
        }

        .sorting-options div {
            margin: 10px 0;
            display: flex;
            align-items: center;
        }

        .sorting-options input[type="radio"] {
            margin-right: 5px;
            cursor: pointer;
            width: 17px;
            height: 17px;
            margin: 0;
            margin-right: 5px
        }

        .sorting-options input[type="radio"]:checked {
            accent-color:#3C6E57;
        }
    </style>

    <body>
        <%
            String[] colors = {"#487F3D","#004472","#D5A00C","red"};
            SimpleDateFormat timeFmt = new SimpleDateFormat("HH:mm");
            SimpleDateFormat dateFmt = new SimpleDateFormat("dd/MM/yyyy");
            AirlineManageDAO amd = new AirlineManageDAO();
            FlightDetailDAO fdd = new FlightDetailDAO();
            PlaneCategoryDAO pcd = new PlaneCategoryDAO();
            SeatCategoryDAO scd = new SeatCategoryDAO();
            AirportDAO ad = new AirportDAO();
            LocationDAO ld = new LocationDAO();
            CountryDAO cd = new CountryDAO();
        %>
        <%@include file="header.jsp" %>
        <div style="margin: 100px 0" class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div class="flight-detail" style="display: block">
                    <%
                    Airport depAirport = (Airport) ad.getAirportById(Integer.parseInt(request.getParameter("departure")));
                    Location depLocation = (Location) ld.getLocationById(depAirport.getLocationId());
                    Country depCountry = (Country) cd.getCountryById(depLocation.getCountryId());

                    Airport desAirport = (Airport) ad.getAirportById(Integer.parseInt(request.getParameter("destination")));
                    Location desLocation = (Location) ld.getLocationById(desAirport.getLocationId());
                    Country desCountry = (Country) cd.getCountryById(desLocation.getCountryId());

                    int adultNumber = Integer.parseInt(request.getParameter("adult"));
                    int childNumber = Integer.parseInt(request.getParameter("child"));
                    int infantNumber = Integer.parseInt(request.getParameter("infant"));
                    int totalPassengers = adultNumber+ childNumber+infantNumber;
                    
                    if(request.getParameter("flightDetailId")==null){
                    %>
                    <div style="width: 100%; color:#3C6E57; text-align: center; "><h3>SELECT OUTBOUND FLIGHT</h3></div>
                    <%} else {
                    Airport tmpA = depAirport; depAirport = desAirport; desAirport = tmpA;
                    Location tmpL = depLocation; depLocation = desLocation; desLocation = tmpL;
                    Country tmpC = depCountry; depCountry = desCountry; desCountry = tmpC;
                    %>
                    <div style="width: 100%; color:#3C6E57; text-align: center "><h3>SELECT REBOUND FLIGHT</h3></div>
                    <% }%>
                    <div class="flight-info" style="width: 100%">
                        <div class="airport-info">
                            <div class="flight-icon">✈️</div>
                            <div class="airport-name"><%=depAirport.getName()%></div>
                            <div class="location"><%=depLocation.getName()%>, <%=depCountry.getName()%></div>
                        </div>
                        <div class="flight-details">
                            <div class="flight-icon">🛫</div>
                            <div class="flight-type">Passenger</div>
                            <div class="flight-time">
                                <%= adultNumber %> Adult<% if (adultNumber > 1) { %>s<% } %>
                                <% if (childNumber > 0) { %>, <%= childNumber %> Child<% } %>
                                <% if (infantNumber > 0) { %>, <%= infantNumber %> Infant<% } %>
                            </div>
                        </div>
                        <div class="airport-info">
                            <div class="flight-icon">🛬</div>
                            <div class="airport-name"><%=desAirport.getName()%></div>
                            <div class="location"><%=desLocation.getName()%>, <%=desCountry.getName()%></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="flight-detail" style="display: block; height: fit-content; background-color: #f9f9f9">
                            <div class="sorting-options">
                                <h5>Sort by:</h5>
                                <div>
                                    <input type="radio" id="sortTimeAsc" name="sortFlights" value="timeAsc" onchange="sortFlights(this.value)" checked>
                                    <label for="sortTimeAsc">Earliest First</label>
                                </div>
                                <div>
                                    <input type="radio" id="sortTimeDesc" name="sortFlights" value="timeDesc" onchange="sortFlights(this.value)">
                                    <label for="sortTimeDesc">Latest First</label>
                                </div>
                                <div>
                                    <input type="radio" id="sortPriceAsc" name="sortFlights" value="priceAsc" onchange="sortFlights(this.value)">
                                    <label for="sortPriceAsc">Price: Low to High</label>
                                </div>
                                <div>
                                    <input type="radio" id="sortPriceDesc" name="sortFlights" value="priceDesc" onchange="sortFlights(this.value)">
                                    <label for="sortPriceDesc">Price: High to Low</label>
                                </div>

                            </div>


                            <%if(request.getParameter("flightDetailId")==null){
                            %>
                            <div class="sorting-options">
                                <h5>Airline:</h5>
                                <div>
                                    <input type="radio" id="sortDefaultAirline" name="sortAirlines" value="default" onchange="sortAirlines(this.value)" checked>
                                    <label for="sortDefaultAirline" >All</label>
                                </div>
                                <%for(Airline a : (List<Airline>)amd.getAllAirline()){
                                    if(a.getName().equals("FLYEZY")) continue;
                                %>
                                <div>
                                    <input type="radio" id="<%=a.getName()%>" name="sortAirlines" value="<%=a.getName()%>" onchange="sortAirlines(this.value)">
                                    <label for="<%=a.getName()%>"><img src="<%=a.getImage()%>" alt="alt"/> <%=a.getName()%></label>
                                </div>
                                <%}%>
                            </div>
                            <%
                        }%>

                        </div>
                    </div>
                    <div class="col-md-9 flights-container">
                        <%
                        List<FlightDetails> flightTickets = (List<FlightDetails>) request.getAttribute("flightTickets");
                
                        for (FlightDetails fd : flightTickets) {
                            if(fd.getStatusId()==1){
                                int airlineId = fdd.getAirlineIdByFlightDetailId(fd.getId());
                                String airlineImage = amd.getImageById(airlineId);
                                String airlineName = amd.getNameById(airlineId);
                                PlaneCategory planeCategory = fdd.getPlaneCategoryByFlightDetailId(fd.getId());
                                List<SeatCategory> ticketCatList = scd.getAllSeatCategoryByPlaneCategoryId(planeCategory.getId());
                                Flights flight = fdd.getFlightByFlightDetailId(fd.getId());                
                        %>
                        <div class="flight-detail" style="display: block">
                            <div class="flight-info" style="display: flex">
                                <div class="airline-logo-container">
                                    <img src="<%= amd.getImageById(airlineId) %>" alt="<%= amd.getNameById(airlineId) %> Logo">
                                </div>

                                <div style="width: 88%; display: flex; align-items: center; padding: 30px 15px">
                                    <div style="width: 20%; text-align: left">
                                        <p class="airline-name"><%= amd.getNameById(airlineId) %></p>
                                        <p class="aircraft"><%= planeCategory.getName()%></p>
                                        <a style="cursor: pointer" onclick="openModal(<%=fd.getId()%>)">Detail Information</a>
                                    </div>

                                    <div style="display: flex; width: 42%; padding-top: 1%">
                                        <div>
                                            <p class="time depTime"><%= timeFmt.format(fd.getTime()) %></p>
                                            <p class="location"><%=depLocation.getName()%></p>
                                        </div>
                                        <svg width="150" height="30" xmlns="http://www.w3.org/2000/svg">
                                        <line x1="12" y1="15" x2="65" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5" />
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" x="70" y="5" viewBox="0 0 576 512">
                                        <path fill="#B1B9CB" d="M482.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64l-116.6 0L265.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6L112 320 68.8 377.6c-3 4-7.8 6.4-12.8 6.4l-42 0c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L32 256 .5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-7.8 6.3-14 14-14l42 0c5 0 9.8 2.4 12.8 6.4L112 192l102.9 0-49-171.6C162.9 10.2 170.6 0 181.2 0l56.2 0c11.5 0 22.1 6.2 27.8 16.1L365.7 192l116.6 0z"/>
                                        </svg>
                                        <line x1="90" y1="15" x2="150" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5" />
                                        </svg>

                                        <%
                                            Calendar cal = Calendar.getInstance();
                                            cal.setTime(fd.getTime()); 
                                            cal.add(Calendar.MINUTE, flight.getMinutes());
                                        %>
                                        <div>
                                            <p class="time"><%= timeFmt.format(cal.getTime()) %></p>
                                            <p class="location"><%=desLocation.getName()%></p>
                                        </div>
                                    </div>
                                    <div style="display: flex; align-items: center; width: 38%; justify-content: end">
                                        <div class="price">
                                            <span class="old-price"><%= NumberFormat.getInstance().format(fd.getPrice()) %> ₫</span>
                                            <span><span style="font-size: 17px">only from</span> <%= NumberFormat.getInstance().format(fd.getPrice())%> ₫</span>
                                        </div>
                                        <div style="display: flex; margin-left: 20px" onclick="showTicketCategory(<%=fd.getId()%>)">
                                            <svg class="arrow" id="arrow<%=fd.getId()%>" xmlns="http://www.w3.org/2000/svg" height="25" width="25" viewBox="0 0 512 512" style="transition: transform 0.3s ease;">
                                            <path d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"/>
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="ticket-category-container<%=fd.getId()%>" style="max-height: 0px; overflow: hidden; transition: max-height 0.5s ease, opacity 0.5s ease; opacity: 0;">
                                <div style="text-align: center; font-size: 20px">Select Ticket Class</div>
                                <div class="ticket-category-list" style="display: flex; flex-wrap: wrap;">
                                    <% 
                                        int activated = 0;
                                        for(int i = 0; i<ticketCatList.size(); i++){
                                            if(ticketCatList.get(i).getStatusId()==1){
                                                activated+=1;
                                            }
                                        }       
                                        for(int i = 0; i<ticketCatList.size(); i++){
                                            if(ticketCatList.get(i).getStatusId()==1){
                                    %>
                                    <div class="ticket-category-box" style="width:<%=90.0/activated%>%;">
                                        <div class="ticket-category-head" style="background-color: <%= colors[i] %>;">
                                            <%=ticketCatList.get(i).getName()%>
                                            <div style="font-size: 25px"><%= NumberFormat.getInstance().format(fd.getPrice()*(1+ticketCatList.get(i).getSurcharge()))%> ₫</div>
                                        </div>
                                        <div class="ticket-category-body" style="border: 2px solid <%= colors[i] %>; padding: 12px 12px;; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;min-height: 85%">
                                            <div>
                                                <img style="width: 100%; display: block; border-radius: 10px; transition: transform 0.3s ease; " 
                                                     src="<%=ticketCatList.get(i).getImage()%>" alt="alt"
                                                     onmouseover="this.style.transform = 'scale(1.05)'" 
                                                     onmouseout="this.style.transform = 'scale(1)'"/>
                                            </div>
                                            <div class="ticket-category-info" style="font-size: 13px; margin-top: 12px">
                                                <%=ticketCatList.get(i).getInfo()%>
                                            </div>
                                            <% if ("oneWay".equals(request.getParameter("flightType"))) { %>
                                            <form class="ticket-category-form" action="bookingFlightTickets" style="display: flex; justify-content: center; ">
                                                <input type="hidden" name="seatCategory" value="<%=ticketCatList.get(i).getId()%>"/>
                                                <input type="hidden" name="flightDetailId" value="<%=fd.getId()%>"/>
                                                <input type="hidden" name="adult" value="${param.adult}"/>
                                                <input type="hidden" name="child" value="${param.child}"/>
                                                <input type="hidden" name="infant" value="${param.infant}"/>
                                                <%    
                                                if(totalPassengers<= scd.getNumberOfEmptySeat(fd.getId(),ticketCatList.get(i).getId())){
                                                %>
                                                <button style="background-color: <%= colors[i] %>;" type="submit">Buy Ticket</button>
                                                <%
                                                    } else {
                                                %>
                                                <button style="background-color: #aaa" disabled >SOLD OUT</button>
                                                <%
                                                }
                                                %>

                                            </form>
                                            <% } else if("roundTrip".equals(request.getParameter("flightType")) && request.getParameter("flightDetailId")==null){
                                            %>
                                            <form class="ticket-category-form" action="flightTickets" style="display: flex; justify-content: center; ">
                                                <input type="hidden" name="flightType" value="${param.flightType}"/>
                                                <input type="hidden" name="seatCategory" value="<%=ticketCatList.get(i).getId()%>"/>
                                                <input type="hidden" name="flightDetailId" value="<%=fd.getId()%>"/>
                                                <input type="hidden" name="departure" value="${param.departure}"/>
                                                <input type="hidden" name="destination" value="${param.destination}"/>
                                                <input type="hidden" name="returnDate" value="${param.returnDate}"/>
                                                <input type="hidden" name="adult" value="${param.adult}"/>
                                                <input type="hidden" name="child" value="${param.child}"/>
                                                <input type="hidden" name="infant" value="${param.infant}"/>
                                                <%    
                                                if(totalPassengers<= scd.getNumberOfEmptySeat(fd.getId(),ticketCatList.get(i).getId())){
                                                %>
                                                <button style="background-color: <%= colors[i] %>;" type="submit">Select Departure Ticket</button>
                                                <%
                                                    } else {
                                                %>
                                                <button style="background-color: #aaa" disabled >SOLD OUT</button>
                                                <%
                                                }
                                                %>

                                            </form>
                                            <% } else if("roundTrip".equals(request.getParameter("flightType")) && request.getParameter("flightDetailId")!=null){ %>
                                            <form class="ticket-category-form" action="bookingFlightTickets" style="display: flex; justify-content: center; ">
                                                <input type="hidden" name="seatCategory" value="${param.seatCategory}"/>
                                                <input type="hidden" name="flightDetailId" value="${param.flightDetailId}"/>
                                                <input type="hidden" name="seatCategory2" value="<%=ticketCatList.get(i).getId()%>"/>
                                                <input type="hidden" name="flightDetailId2" value="<%=fd.getId()%>"/>
                                                <input type="hidden" name="adult" value="${param.adult}"/>
                                                <input type="hidden" name="child" value="${param.child}"/>
                                                <input type="hidden" name="infant" value="${param.infant}"/>
                                                <%    
                                                if(totalPassengers<= scd.getNumberOfEmptySeat(fd.getId(),ticketCatList.get(i).getId())){
                                                %>
                                                <button style="background-color: <%= colors[i] %>;" type="submit">Select Return Ticket</button>                                        
                                                <%
                                                } else {
                                                %>
                                                <button style="background-color: #aaa" disabled >SOLD OUT</button>
                                                <%
                                                }
                                                %>
                                            </form>
                                            <%}%>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    } 
                                    %>
                                </div>
                            </div>
                            <div class="container">
                                <!-- Modal Detail Information -->
                                <div class="modal fade" id="detail<%=fd.getId()%>" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header" style="padding:5px 5px;">
                                                <button type="button" class="close" style="font-size: 30px; margin-right: 8px;
                                                        margin-top: 2px;" data-dismiss="modal">&times;</button>
                                                <h3 style="margin-left: 12px; font-weight: 700; color: #3C6E57">
                                                    <%=depLocation.getName()%> - <%=desLocation.getName()%>
                                                </h3>
                                            </div>
                                            <div class="modal-body row" style="padding:18px 50px;">
                                                <div class="col-md-4">
                                                    <p>Departs: <span class="departure-time"><%=dateFmt.format(fd.getDate()) %></span></p>
                                                    <p>Total time: <span class="total-time"><%= flight.getMinutes() %> minutes</span></p>
                                                    <div>
                                                        <div class="airline-logo-container" style="width: 65%; margin: 15px 0">
                                                            <img src="<%= amd.getImageById(airlineId) %>" alt="<%= amd.getNameById(airlineId) %> Logo">
                                                        </div>
                                                        <p class="airline-name"><strong>Airline: </strong><%= amd.getNameById(airlineId) %></p>
                                                        <p class="aircraft"><strong>Plane: </strong><%= planeCategory.getName()%></p>
                                                    </div>
                                                </div>
                                                <div class="col-md-1"></div>
                                                <div class="col-md-7" style="display: flex">
                                                    <div>
                                                        <svg height="200" width="10" xmlns="http://www.w3.org/2000/svg">
                                                        <line x1="0" y1="0" x2="0" y2="200" style="stroke:black;stroke-width:5px; stroke-dasharray:10,5" />
                                                        Sorry, your browser does not support inline SVG.
                                                        </svg>
                                                    </div>
                                                    <div style="position: relative; width: 100%">
                                                        <div>
                                                            <p>
                                                                <span class="departure-time"><%= timeFmt.format(fd.getTime()) %> - 
                                                                    <span class="location"><%= depLocation.getName() %>, <%=depCountry.getName()%></span>
                                                                </span>
                                                            </p>
                                                            <p><span class="airport"><%= depAirport.getName() %></span></p>
                                                        </div>
                                                        <p style="position: absolute; top: 41%; color: #aaa"><%=flight.getMinutes()%> minutes</p>

                                                        <div style="position: absolute; bottom: 0">
                                                            <p>
                                                                <span class="destination-time"><%= timeFmt.format(cal.getTime()) %> - 
                                                                    <span class="location"><%= desLocation.getName() %>, <%=desCountry.getName()%></span>
                                                                </span>
                                                            </p>
                                                            <p><span class="airport"><%= desAirport.getName() %></span></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            </div>

                                        </div>
                                    </div>
                                </div> 
                            </div>
                        </div>
                        <%
                            }
                        }
                        %>

                    </div>
                </div>
            </div>
            <div class="col-md-1"></div>

        </div>
    </body>
    <script>
        function openModal(id) {
            $("#detail" + id).modal('show');
        }

        function showTicketCategory(id) {
            var container = document.getElementById("ticket-category-container" + id);
            var arrow = document.getElementById("arrow" + id);

            if (container.style.maxHeight === "0px" || container.style.maxHeight === "") {
                container.style.maxHeight = "800px";
                container.style.opacity = "1";
                arrow.style.transform = "rotate(180deg)";
            } else {
                container.style.maxHeight = "0px";
                container.style.opacity = "0";
                arrow.style.transform = "rotate(0deg)";
            }
        }

        function sortFlights(sortBy) {
            const flightsContainer = document.querySelector('.flights-container');
            let flights = Array.from(flightsContainer.children);

            flights.sort((a, b) => {
                const priceA = parseInt(a.querySelector('.price span:last-child').innerText.replace(/[^0-9]/g, ''));
                const priceB = parseInt(b.querySelector('.price span:last-child').innerText.replace(/[^0-9]/g, ''));
                const timeA = parseTime(a.querySelector('.depTime').innerText);
                const timeB = parseTime(b.querySelector('.depTime').innerText);

                switch (sortBy) {
                    case 'priceAsc':
                        return priceA - priceB;
                    case 'priceDesc':
                        return priceB - priceA;
                    case 'timeAsc':
                        return timeA - timeB;
                    case 'timeDesc':
                        return timeB - timeA;
                    default:
                        return 0;
                }
            });
            flightsContainer.innerHTML = '';
            flights.forEach(flight => flightsContainer.appendChild(flight));
        }

        function parseTime(timeString) {
            const [h, m] = timeString.split(':').map(Number);
            return new Date(2004, 16, 11, h, m);
        }

        function sortAirlines(selectedAirline) {
            const flightsContainer = document.querySelector('.flights-container');
            let flights = Array.from(flightsContainer.children);

            flights.forEach(flight => {
                const airlineName = flight.querySelector('.airline-name').innerText;

                if (selectedAirline === 'default' || airlineName === selectedAirline) {
                    flight.style.display = 'block';
                } else {
                    flight.style.display = 'none';
                }
            });
        }

    </script>
</html>
