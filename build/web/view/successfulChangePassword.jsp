<%-- 
    Document   : successfulBooking
    Created on : Oct 19, 2024, 11:14:07 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Successful Change Password</title>
        <style>
            .box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 80%;
                max-width: 600px;
                margin: 176px auto;
                padding: 30px;
                text-align: center;
            }
            .box svg {
                width: 100px;
                height: 100px;
                fill: #C02E2A;
                margin: 0 auto 20px;
                animation: rotateIcon 0.75s infinite linear;
            }
            @keyframes rotateIcon {
                0% {
                    transform: rotate(0deg);
                }
                50% {
                    transform: rotate(15deg);
                }
                100% {
                    transform: rotate(0deg);
                }
            }
            h3 {
                color: #333;
                font-size: 24px;
                margin-bottom: 10px;
            }
            p {
                color: #666;
                font-size: 16px;
                line-height: 1.6;
            }
            .button {
                display: inline-block;
                color: #3C6E57;
                font-size: 16px;
                padding: 10px 20px;
                text-decoration: none;
                border:2px solid #3C6E57;
                border-radius: 5px;
                margin-top: 20px;
                transition: background-color 0.3s;
            }
            .button:hover {
                color: white;
                text-decoration: none;
                background-color: #3C6E57;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="box">
            <div>
                <svg id="check-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#32b877" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>
            </div>
            <h3>Change Password Successful</h3>
<!--            <p>Order approved, please pay at least 10 days before flight time</p>-->
            <a href="home" class="button">Home</a>
            
        </div>
        <%@include file="footer.jsp" %>
        <script>
            
        </script>
    </body>
</html>
