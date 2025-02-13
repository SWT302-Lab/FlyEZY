<%-- 
    Document   : Header
    Created on : Sep 14, 2024, 10:09:21 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>JSP Page</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Reddit+Sans:ital,wght@0,200..900;1,200..900&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styleHeader.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <style>
        .transparent-header {
            background-color: transparent !important;
            box-shadow: none;
            transition: background-color 0.3s ease;
        }
    </style>
    <body>
        <div id="header" style="transition: background-color 0.3s ease;">
            <div id="header-logo">
                <a href="home">
                    <img src="img/flyezy-logo5.png" alt=""/>
                </a>
            </div>
            <ul id="header-nav1" style="font-weight: 520">
                <li "><a href="home" >HOME</a></li>
                    <c:if test="${requestScope.account == null || requestScope.account.getRoleId()==3}">
                    <li>
                        <a href="${requestScope.account == null ? 'findOrder' : 'buyingHistory'}">TICKETS</a>
                    </li>
                </c:if>
                <c:if test="${requestScope.account.getRoleId()==1}">
                    <li><a href="accountController">MANAGE</a></li>
                    </c:if>

                <c:if test="${requestScope.account.getRoleId()==2}">
                    <li><a href="airlineController">MANAGE</a></li>
                    </c:if>

                <c:if test="${requestScope.account.getRoleId()==4}">
                    <li><a href="discountManagement">MANAGE</a></li>
                    </c:if>
                <li "><a href="News">NEWS</a></li>
                <li "><a href="#footer" >CONTACT</a></li>
            </ul>

            <c:if test="${requestScope.account==null}">
                <div id="header-nav2">
                    <a href="login"><button id="login-button">Login</button></a>
                    <a href="register"><button id="register-button">Register</button></a>
                </div>
            </c:if>

            <c:if test="${requestScope.account!=null}">
                <div id="header-account">
                    <div id="header-avatar" class="">
                        <img class="" src="${requestScope.account.image}" alt="">
                    </div>
                    <ul id="header-subnav" style="display: none;">
                        <li><a href="info">Account Information</a></li>
                            <c:if test="${requestScope.account.getRoleId()==1}">
                            <li><a href="accountController">Manage</a></li>
                            </c:if>

                        <c:if test="${requestScope.account.getRoleId()==2}">
                            <li><a href="airlineController">Manage</a></li>
                            </c:if>

                        <c:if test="${requestScope.account.getRoleId()==4}">
                            <li><a href="discountManagement">Manage</a></li>
                            </c:if>
                            <c:if test="${requestScope.account.getRoleId()==3}">
                            <li><a href="buyingHistory">Ticket Buying History</a></li>
                            </c:if>
                        <li><a href="changePassword">Change Password</a></li>
                        <li><a style="color: red;" href="logout">Log out</a></li>
                    </ul>
                </div>
            </c:if>
        </div>

        <script>
            window.onload = function () {
                checkScroll();
            };

            function checkScroll() {
                if (window.location.pathname.endsWith("/home") || window.location.pathname.endsWith("/")) {
                    if (window.scrollY === 0) {
                        document.getElementById("header").classList.add("transparent-header");
                    } else {
                        document.getElementById("header").classList.remove("transparent-header");
                    }
                }
            }

            window.onscroll = function () {
                checkScroll();
            };
            var subNav = document.getElementById('header-subnav');
            var avatar = document.getElementById('header-avatar');

            avatar.addEventListener('click', function () {
                if (subNav.style.display === "none" || subNav.style.display === "") {
                    subNav.style.display = "block";
                } else {
                    subNav.style.display = "none";
                }
            });
        </script>
    </body>
</html>
