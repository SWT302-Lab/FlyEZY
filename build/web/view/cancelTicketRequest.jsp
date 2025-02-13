<%-- 
    Document   : cancelTicketRequest
    Created on : Oct 23, 2024, 10:30:52 PM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M32 0C14.3 0 0 14.3 0 32S14.3 64 32 64l0 11c0 42.4 16.9 83.1 46.9 113.1L146.7 256 78.9 323.9C48.9 353.9 32 394.6 32 437l0 11c-17.7 0-32 14.3-32 32s14.3 32 32 32l32 0 256 0 32 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l0-11c0-42.4-16.9-83.1-46.9-113.1L237.3 256l67.9-67.9c30-30 46.9-70.7 46.9-113.1l0-11c17.7 0 32-14.3 32-32s-14.3-32-32-32L320 0 64 0 32 0zM288 437l0 11L96 448l0-11c0-25.5 10.1-49.9 28.1-67.9L192 301.3l67.9 67.9c18 18 28.1 42.4 28.1 67.9z"/></svg>
            </div>
            <h3>Ticket cancellation request was send</h3>
            <p>Your ticket cancellation request is pending.</p>
            <a href="home" class="button">Home</a>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
