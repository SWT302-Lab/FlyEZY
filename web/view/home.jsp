<%-- 
    Document   : Home
    Created on : Sep 14, 2024, 10:08:31 PM
    Author     : Admin
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="model.Location"%>
<%@page import="model.Accounts"%>
<%@page import="model.Airport"%>
<%@page import="dal.LocationDAO"%>
<%@page import="dal.AirportDAO"%>
<%@page import="model.News" %>
<%@page import="dal.NewsDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />

        <!-- Chọn một phiên bản duy nhất của Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

        <!-- CSS project-->
        <link rel="stylesheet" href="../flyezy/css/styleHome.css"/>
        <link rel="stylesheet" href="css/styleNews.css"/>

        <title>FLYEZY</title>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Bootstrap Datepicker CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <!-- Bootstrap Datepicker JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <style>
            .flight-form {
                position: relative;
                z-index: 10;
            }

            .banner {
                position: relative;
                overflow: hidden;
                color: white;
                width: 100%;
                height: 100vh;
            }

            .banner video {
                position: absolute;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                object-fit: cover;
                z-index: 1;
            }

            #input-form {
                position: relative;
                z-index: 10;
                top: 45%
            }


            .form-container {
                border: 2px solid #ccc;
                padding: 2%;
                background-color: #f9f9f9;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                height: 240px;
                width: 70%;
                border-radius: 6px
            }

            .location-list {
                display: none;
                position: absolute;
                background-color: white;
                border: 1px solid #ccc;
                z-index: 1000;
                width: 250px;
                height: 153px;
                overflow-y: auto;
                top: 80px;
                left: 14px;
                border-radius: 8px;
            }

            .location-item {
                cursor: pointer;
                padding: 10px 15px;
                transition: background-color 0.3s ease;
            }

            .location-item:hover {
                background-color: #f0f0f0;
            }

            .location-item span {
                transition: color 0.3s ease, filter 0.3s ease;
            }

            .passenger-label {
                color: #3C6E57;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            .passenger-selector {
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                justify-content: space-between;
                width: 100%;
                max-width: 600px;
            }
            .passenger-type {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 33%;
            }
            .passenger-input {
                color: activecaption;
                height: 50%;
                width: 40%;
                font-size: 18px;
            }
            .passenger-controls{
                display: flex;
            }
            .options-container {
                margin-top: 30px;
                width: 400px;
                height: auto;
                border-radius: 5px;
            }
            .passenger-count {
                color: #3C6E57;
                font-size: 20px;
                font-weight: bold;
                width: 55px;
                border: 2px solid;
                border-radius: 5px;
                text-align: center;
                margin: 0 10px;
            }

            .search-button {
                height: 100%;
                margin-top: 18px;
                width: 165px;
                font-size: 18px;
                color: #3C6E57;
                background-color: white;
                border: 2px solid #3C6E57;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .search-button:hover {
                color: white;
                background-color: #3C6E57;
            }

            .age-range{
                margin-top: 8px;
                color: #3C6E57;
                font-size: 12px;
                font-weight: 600;
            }



        </style>
    </head>
    <body>
        <%
            LocationDAO locationDao = new LocationDAO();
            AirportDAO airportDao = new AirportDAO();
        %>
        <%@include file="header.jsp" %> 
        <section>
            <div class="flight-form">
                <div class="banner" id="banner">
                    <video src="vid/bg-vid.mp4" muted loop autoplay></video>

                    <form id="input-form" action="flightTickets" method="GET" class="row g-1" onsubmit="return validateLocations(event)">
                        <div class="form-container" style="margin: 0 auto">
                            <div class="row form-input">
                                <div style="display: flex;">
                                    <div style="display: flex; align-items: center; font-size: 16px; margin-right: 20px">
                                        <input type="radio" id="oneWay" name="flightType" value="oneWay" style="transform: scale(1.5);" checked onclick="toggleReturnDate()">
                                        <label for="oneWay" style="color: black;margin: 0; margin-left: 10px">One-way</label>
                                    </div>
                                    <div style="display: flex; align-items: center; font-size: 16px">
                                        <input type="radio" id="roundTrip" name="flightType" value="roundTrip" style="transform: scale(1.5);" onclick="toggleReturnDate()">
                                        <label for="roundTrip" style="color: black;margin: 0; margin-left: 10px">Round-trip</label>
                                    </div>
                                </div>
                                <p id="errorMessage" style="font-size: 16px; color: red;"></p> 
                                <%if(request.getAttribute("account") != null && ((Accounts)request.getAttribute("account")).getRoleId() != 3){
                                %>
                                <p style="font-size: 16px;color: red;">Please use customer account to use the service.</p> 
                                <%
                                    }
                                %>

                                <div class="row" style="height: 55px; margin-top: 20px">
                                    <!-- From Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">FROM</p>
                                        <input type="text" value="Hà Nội" readonly style="height: 100%;font-size: 18px" class="form-control" id="fromDisplay" onclick="showLocationList('from')" oninput="filterLocations('from')" placeholder="FROM" required>
                                        <input type="hidden" value="1" id="from" name="departure">
                                        <div id="from-locations" class="location-list">
                                            <%                
                                                for(Location l : locationDao.getAllLocation()) {
                                                    for(Airport a : airportDao.getAllAirport()){
                                                        if(a.getLocationId() == l.getId()){
                                            %>
                                            <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %>', 'from')">
                                                <span style="font-weight: bold; font-size: 16px; color: black;">
                                                    <%= l.getName() %>
                                                </span></br>
                                                <span style="font-size: 14px; color: grey; filter: blur(1%);">
                                                    <%= a.getName() %>
                                                </span>
                                            </div>
                                            <% } } } %>
                                        </div>
                                    </div>

                                    <!-- To Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">TO</p>
                                        <input type="text" value="TP. Hồ Chí Minh" readonly style="height: 100%;font-size: 18px" class="form-control" id="toDisplay" onclick="showLocationList('to')" oninput="filterLocations('to')" placeholder="TO" required>
                                        <input type="hidden" value="2" id="to" name="destination">
                                        <div id="to-locations" class="location-list">
                                            <%                
                                                for(Location l : locationDao.getAllLocation()) {
                                                    for(Airport a : airportDao.getAllAirport()){
                                                        if(a.getLocationId() == l.getId()){
                                            %>
                                            <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %>', 'to')">
                                                <span style="font-weight: bold; font-size: 16px; color: black;">
                                                    <%= l.getName() %>
                                                </span></br>
                                                <span style="font-size: 14px; color: grey; filter: blur(1%);">
                                                    <%= a.getName() %>
                                                </span>
                                            </div>
                                            <% } } } %>
                                        </div>
                                    </div>

                                    <!-- Departure Date Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">DEPART</p>
                                        <input type="text" class="form-control" id="departureDate" name="departureDate" style="height: 100%;font-size: 18px;" placeholder="yyyy-mm-dd" onkeydown="return false;" required >
                                    </div>
                                    <div class="col-md-2" id="returnDateField" style="display:none;padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">RETURN</p>
                                        <input type="text" id="returnDate" class="form-control" name="returnDate" style="height: 100%;font-size: 18px;" placeholder="yyyy-mm-dd" onkeydown="return false;">
                                    </div>

                                    <!-- Passengers Field -->
                                    <div class="col-md-4" id="passengerField" style="position: relative; padding-right: 0;">
                                        <p style="color: black; margin: 0; font-size: 12px">PASSENGER</p>
                                        <input type="number" class="form-control" id="passengers" value="1" min="1" max="10" required readonly 
                                               onclick="togglePassengerOptions()"
                                               style="height: 100%; width: 100%; font-size: 18px;">

                                        <div id="passenger-options" class="passenger-options" 
                                             style="display: none; position: absolute; top: 50px; left: 15px; z-index: 1000;">
                                            <div class="options-container" style="border: 2px solid #ccc">
                                                <div class="passenger-selector">
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Adult</div>
                                                        <div class="passenger-controls">
                                                            <input type="number" id="adult-count" class="passenger-count" name="adult" value="1" min="1" max="10" class="passenger-input">
                                                        </div>
                                                    </div>
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Children</div>
                                                        <div class="passenger-controls">
                                                            <input type="number"id="child-count" class="passenger-count" name="child" value="0" min="0" max="9" class="passenger-input">
                                                        </div>
                                                        <div class="age-range">2-11 Year Olds</div>
                                                    </div>
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Infant</div>
                                                        <div class="passenger-controls">
                                                            <input type="number" id="infant-count" class="passenger-count" name="infant" value="0" min="0" max="5" class="passenger-input">
                                                        </div>
                                                        <div class="age-range">0-2 Year Olds</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="col-md-2">
                                        <button type="submit" class="search-button" onclick="validateDates()" 
                                                <%= (request.getAttribute("account") == null || ((Accounts)request.getAttribute("account")).getRoleId() == 3) ? "" : "disabled" %>>
                                            Search Flights
                                        </button> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <%-- quanHT --%>
        <div class="main-container">
            <div id="introduction">
                <h1 style="font-size: 30px">Welcome to FLYEZY!</h1>
                <p style="font-size: 16px">New space, new feeling - Book your ticket now to start your journey.</p>
            </div>

            <div id="promotion">
                <div class="promotion-item row">
                    <div class="col-md-6">
                        <img src="img/home1.jpg" alt="">
                    </div>
                    <div class="col-md-6">
                        <h3>Attractive offers</h3>
                        <p>
                            FLYEZY is committed to providing reasonable fares, many transportation options and attractive promotions. The 24/7 customer care team is always ready to support to bring the best experience to you.
                        </p>
                    </div>
                </div>
                <div class="promotion-item row">
                    <div class="col-md-6">
                        <img src="img/home2.jpg" alt="">
                    </div>
                    <div class="col-md-6">
                        <h3>Peaceful discovery</h3>
                        <p>
                            FLYEZY is committed to ensuring absolute safety for customers. The team of drivers are professionally trained, vehicles are always periodically maintained and equipped with standard safety equipment, so that each of your trips goes smoothly and safely.
                        </p>
                    </div>
                </div>

            </div>
            <div style=" background-image: linear-gradient(white,rgb(60, 110, 87));
                 height: 150px">
            </div>
        </div>
        <div class="main-container" >
            <div id="statistics">
                <p class="statistics-heading" style="font-size: 30px">About Us</p>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <h3>100,000+</h3>
                    <p>Người dùng</p>
                    <div class="icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><path fill="#ffffff" d="M144 0a80 80 0 1 1 0 160A80 80 0 1 1 144 0zM512 0a80 80 0 1 1 0 160A80 80 0 1 1 512 0zM0 298.7C0 239.8 47.8 192 106.7 192h42.7c15.9 0 31 3.5 44.6 9.7c-1.3 7.2-1.9 14.7-1.9 22.3c0 38.2 16.8 72.5 43.3 96c-.2 0-.4 0-.7 0H21.3C9.6 320 0 310.4 0 298.7zM405.3 320c-.2 0-.4 0-.7 0c26.6-23.5 43.3-57.8 43.3-96c0-7.6-.7-15-1.9-22.3c13.6-6.3 28.7-9.7 44.6-9.7h42.7C592.2 192 640 239.8 640 298.7c0 11.8-9.6 21.3-21.3 21.3H405.3zM224 224a96 96 0 1 1 192 0 96 96 0 1 1 -192 0zM128 485.3C128 411.7 187.7 352 261.3 352H378.7C452.3 352 512 411.7 512 485.3c0 14.7-11.9 26.7-26.7 26.7H154.7c-14.7 0-26.7-11.9-26.7-26.7z"/></svg>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-route"></i></div>
                    <h3>5,000K+</h3>
                    <p>FLIGHT</p>
                    <div class="icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#ffffff" d="M512 96c0 50.2-59.1 125.1-84.6 155c-3.8 4.4-9.4 6.1-14.5 5H320c-17.7 0-32 14.3-32 32s14.3 32 32 32h96c53 0 96 43 96 96s-43 96-96 96H139.6c8.7-9.9 19.3-22.6 30-36.8c6.3-8.4 12.8-17.6 19-27.2H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320c-53 0-96-43-96-96s43-96 96-96h39.8c-21-31.5-39.8-67.7-39.8-96c0-53 43-96 96-96s96 43 96 96zM117.1 489.1c-3.8 4.3-7.2 8.1-10.1 11.3l-1.8 2-.2-.2c-6 4.6-14.6 4-20-1.8C59.8 473 0 402.5 0 352c0-53 43-96 96-96s96 43 96 96c0 30-21.1 67-43.5 97.9c-10.7 14.7-21.7 28-30.8 38.5l-.6 .7zM128 352a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zM416 128a32 32 0 1 0 0-64 32 32 0 1 0 0 64z"/></svg>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-bus-alt"></i></div>
                    <h3>3000+</h3>
                    <p>Phương tiện</p>
                    <div class="icon">  
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M381 114.9L186.1 41.8c-16.7-6.2-35.2-5.3-51.1 2.7L89.1 67.4C78 73 77.2 88.5 87.6 95.2l146.9 94.5L136 240 77.8 214.1c-8.7-3.9-18.8-3.7-27.3 .6L18.3 230.8c-9.3 4.7-11.8 16.8-5 24.7l73.1 85.3c6.1 7.1 15 11.2 24.3 11.2l137.7 0c5 0 9.9-1.2 14.3-3.4L535.6 212.2c46.5-23.3 82.5-63.3 100.8-112C645.9 75 627.2 48 600.2 48l-57.4 0c-20.2 0-40.2 4.8-58.2 14L381 114.9zM0 480c0 17.7 14.3 32 32 32l576 0c17.7 0 32-14.3 32-32s-14.3-32-32-32L32 448c-17.7 0-32 14.3-32 32z"/></svg>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-headset"></i></div>
                    <h3>24/7</h3>
                    <p>Customer Support</p>
                    <div class="icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#ffffff" d="M256 48C141.1 48 48 141.1 48 256v40c0 13.3-10.7 24-24 24s-24-10.7-24-24V256C0 114.6 114.6 0 256 0S512 114.6 512 256V400.1c0 48.6-39.4 88-88.1 88L313.6 488c-8.3 14.3-23.8 24-41.6 24H240c-26.5 0-48-21.5-48-48s21.5-48 48-48h32c17.8 0 33.3 9.7 41.6 24l110.4 .1c22.1 0 40-17.9 40-40V256c0-114.9-93.1-208-208-208zM144 208h16c17.7 0 32 14.3 32 32V352c0 17.7-14.3 32-32 32H144c-35.3 0-64-28.7-64-64V272c0-35.3 28.7-64 64-64zm224 0c35.3 0 64 28.7 64 64v48c0 35.3-28.7 64-64 64H352c-17.7 0-32-14.3-32-32V240c0-17.7 14.3-32 32-32h16z"/></svg>
                    </div>
                </div>
            </div>

        </div>


        <div class="main-container" id="body-2">

            <div style="display: ${empty param.id ? '' : 'none'};margin: 60px 0">
                <h1 style="margin-bottom: 30px; text-align: center; font-size: 30px">NEWS</h1>
                <div class="news-container">
                    <% 
                        AirlineManageDAO amd = new AirlineManageDAO();
                        List<News> listNew = (List<News>) request.getAttribute("listNew");
                        if (listNew != null) {
                            for (int i = listNew.size() - 1; i >= listNew.size()-4; i--) {
                                News n = listNew.get(i);
                    %>
                    <div class="news-item" onclick="viewNews('<%= n.getId() %>');">
                        <img src="<%= n.getImage() %>" alt="<%= n.getTitle() %>" >

                        <h2 style="height: 25%;"><%= n.getTitle() %></h2>
                        <div class="news-content" style="display: none;">
                            <p><%= n.getContent() %></p>
                        </div>

                        <div   style="margin-top: 7%;margin-left: 3%;">
                            <img src="<%=amd.getImageById(n.getAirline_id())%>" style="width: 12%; height: 100%;">
                            <p style="margin-top: -8%;
                               margin-left: 14%;
                               font-size: 16px;"><%= amd.getNameById(n.getAirline_id()) %></p>
                        </div>

                    </div>
                    <% 
                           }
                       }
                    %>
                </div>
                <div style="width: 100%; text-align: center; margin-top: 20px; ">
                    <a href="News" style="font-size: 20px; color: #3C6E57">More >></a>
                </div>
            </div>


        </div>
    </div>

    <%@include file="footer.jsp" %> 

    <script>
        function viewNews(newsId) {
            window.location.href = 'News?id=' + newsId;
        }

        const passengersInput = document.getElementById('passengers');
        const adultCountInput = document.getElementById('adult-count');
        const childCountInput = document.getElementById('child-count');
        const infantCountInput = document.getElementById('infant-count');
        const passengerOptionsDiv = document.getElementById('passenger-options');

        // Function to update total passengers
        function updateTotalPassengers() {
            const adults = parseInt(adultCountInput.value) || 0;
            const children = parseInt(childCountInput.value) || 0;
            const infants = parseInt(infantCountInput.value) || 0;
            const totalPassengers = adults + children + infants;
            passengersInput.value = totalPassengers;
            // Validation checks
            if (infants > adults) {
                alert("The number of infants cannot exceed the number of adults.");
                infantCountInput.value = adults; // Adjust infants to equal adults
                passengersInput.value -= 1;
                return;
            }

            if (totalPassengers > 10) {
                alert("Total passengers cannot exceed 10.");
                passengersInput.value = 10; // Set to max allowed
                return; // Stop further processing
            }

            // If the total reaches 10, lock the ability to add more passengers
            if (totalPassengers === 10) {
                const remainingSpots = 10 - (adults + children + infants);
                adultCountInput.max = adults; // Prevent increasing adults
                childCountInput.max = children; // Prevent increasing children
                infantCountInput.max = infants; // Prevent increasing infants
            } else {
                // Allow to increase if total passengers < 10
                adultCountInput.max = Math.min(10 - (children + infants), 10);
                childCountInput.max = Math.min(10 - (adults + infants), 9); // Assume max 9 children
                infantCountInput.max = Math.min(10 - (adults + children), 5); // Assume max 5 infants
            }

        }

        adultCountInput.addEventListener('input', updateTotalPassengers);
        childCountInput.addEventListener('input', updateTotalPassengers);
        infantCountInput.addEventListener('input', updateTotalPassengers);

        // Show passenger options when the main input is focused
        passengersInput.addEventListener('focus', () => {
            passengerOptionsDiv.style.display = 'block';
        });


        // Show options when focusing on the main input
        passengersInput.addEventListener('focus', () => {
            passengerOptionsDiv.style.display = "block";
        });

        // Hide options when clicking outside the input and options
        document.addEventListener('click', (event) => {
            const isClickInsideOptions = passengerOptionsDiv.contains(event.target);
            const isClickOnInput = event.target === passengersInput;

            if (!isClickInsideOptions && !isClickOnInput) {
                passengerOptionsDiv.style.display = "none"; // Hide if click is outside
            }
        });

        function showLocationList(inputId) {
            // Hide all location lists first
            hideAllLocationLists();

            // Display the current location list for the clicked input
            document.getElementById(inputId + '-locations').style.display = 'block';
        }

        function hideAllLocationLists() {
            // Get all location lists and hide them
            const locationLists = document.querySelectorAll('.location-list');
            locationLists.forEach(list => {
                list.style.display = 'none';
            });
        }

        function selectLocation(locationId, displayText, inputId) {
            // Set the visible input value to the selected location - airport text
            document.getElementById(inputId + 'Display').value = displayText;

            // Set the hidden input value to the selected locationId
            document.getElementById(inputId).value = locationId;

            // Hide the location list after selection
            document.getElementById(inputId + '-locations').style.display = 'none';
        }

        // Filter locations based on input value
        function filterLocations(type) {
            const input = document.getElementById(type + 'Display');
            const filter = input.value.toLowerCase();
            const locationList = document.getElementById(type + '-locations');
            const items = locationList.getElementsByClassName('location-item');

            // Loop through all items and hide those that don't match the input
            for (let i = 0; i < items.length; i++) {
                const txtValue = items[i].textContent || items[i].innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    items[i].style.display = "";
                } else {
                    items[i].style.display = "none";
                }
            }

            // Show the location list only if there are items visible
            if (filter.length > 0) {
                locationList.style.display = 'block';
            } else {
                locationList.style.display = 'none';
            }
        }


        // Hide the list if the user clicks outside of the input or list
        document.addEventListener('click', function (event) {
            // If the clicked element is not an from or to or part of the location list, hide all lists
            if (!event.target.closest('.location-list') && !event.target.closest('#fromDisplay') && !event.target.closest('#toDisplay')) {
                document.querySelectorAll('.location-list').forEach(list => {
                    list.style.display = 'none';
                });
            }
        });
        function validateLocations(event) {
            const departure = document.getElementById('fromDisplay').value;
            const destination = document.getElementById('toDisplay').value;
            const errorMessageElement = document.getElementById('errorMessage');

            // Check if departure and destination are the same
            if (departure === destination) {
                event.preventDefault(); // Prevent form submission

                // Display error message
                errorMessageElement.textContent = "Duplicate departure and destination";
                errorMessageElement.style.color = "red";

                return false; // Prevent the form from submitting
            }

            // Clear the error message if validation passes
            errorMessageElement.textContent = "";
            return true; // Allow form submission if locations are different
        }
        function toggleReturnDate() {
            const returnDateField = document.getElementById("returnDateField");
            const returnDateInput = document.getElementById("returnDate");
            const flightType = document.querySelector('input[name="flightType"]:checked').value; // Get the value of the selected trip type
            const passengerField = document.getElementById("passengerField");

            // If "Khứ hồi" is selected, display the "Ngày về" field
            if (flightType === "roundTrip") {
                returnDateField.style.display = "block";
                passengerField.className = "col-md-2"; // Set passengers field to col-md-2
                returnDateInput.setAttribute("required", "required");
            } else if (flightType === "oneWay") {
                returnDateField.style.display = "none";
                passengerField.className = "col-md-4"; // Set passengers field to col-md-4
                returnDateInput.removeAttribute("required");
            }
        }
        $(document).ready(function () {
            // Get today's date
            var today = new Date();
            var formattedToday = today.getFullYear() + '-' +
                    ('0' + (today.getMonth() + 1)).slice(-2) + '-' +
                    ('0' + today.getDate()).slice(-2);

            // Initialize datepicker for departureDate
            $('#departureDate').datepicker({
                format: 'yyyy-mm-dd', // Custom date format
                autoclose: true, // Automatically close the calendar after picking a date
                todayHighlight: true, // Highlight today's date
                orientation: 'bottom auto', // Ensure the calendar pops up below the input
                startDate: formattedToday // Minimum date is 01/10/2024
            }).on('changeDate', function (selected) {
                // Get the selected departure date
                var minReturnDate = new Date(selected.date.valueOf());
                minReturnDate.setDate(minReturnDate.getDate()); // Set the return date to be at least one day after the departure

                // Set the minimum date for returnDate
                $('#returnDate').datepicker('setStartDate', minReturnDate);
                // If return date is before the new minimum, clear it
                if ($('#returnDate').datepicker('getDate') && $('#returnDate').datepicker('getDate') < minReturnDate) {
                    $('#returnDate').datepicker('clearDates');
                }
            });

            // Initialize datepicker for returnDate
            $('#returnDate').datepicker({
                format: 'yyyy-mm-dd', // Custom date format
                autoclose: true, // Automatically close the calendar after picking a date
                todayHighlight: true, // Highlight today's date
                orientation: 'bottom auto', // Ensure the calendar pops up below the input
                startDate: formattedToday // Default minimum date for return (will change based on departure)
            });
        });

        // Call toggleReturnDate on page load to handle default states
        document.addEventListener('DOMContentLoaded', toggleReturnDate);

        // Ensure to bind the toggleReturnDate to the radio buttons' change event
        document.getElementById("oneWay").addEventListener('change', toggleReturnDate);
        document.getElementById("roundTrip").addEventListener('change', toggleReturnDate);
        function validateDates() {
            const departureDate = document.getElementById('departureDate').value;
            const returnDate = document.getElementById('returnDate').value;

            // Proceed only if both dates are provided
            if (departureDate && returnDate) {
                const depDate = new Date(departureDate);
                const retDate = new Date(returnDate);

                // Check if the departure date is after the return date
                if (depDate > retDate) {
                    event.preventDefault();
                    alert("Ngày đi phải trước ngày về.");
                    return false; // Prevent form submission
                }
            }

            // Allow form submission if validation passes
            return true;
        }

        // Optional: Toggle the return date field based on departure date selection
        document.getElementById('departureDate').addEventListener('change', function () {
            const returnDateField = document.getElementById('returnDateField');
            returnDateField.style.display = this.value ? 'block' : 'none';
        });


    </script>

</body>
</html>




