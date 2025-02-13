<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dal.DiscountDAO" %>
<%@ page import="model.Accounts" %>
<%@ page import="model.Discount" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>QR Code Payment</title>
        <style>
            :root {
                --primary-color: #3c6e57;
                --secondary-color: #28a745;
                --background-color: #f4f4f4;
                --card-background: #ffffff;
                --text-color: #333333;
                --border-radius: 12px;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: var(--background-color);
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                background-color: var(--card-background);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: var(--border-radius);
                padding: 2rem;
                max-width: 800px;
                width: 100%;
            }

            h1 {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .content {
                display: flex;
                flex-wrap: wrap;
                gap: 2rem;
            }

            .qr-code {
                flex: 1;
                min-width: 300px;
            }

            .qr-code img {
                width: 100%;
                max-width: 325px;
                height: auto;
                display: block;
                margin: 0 auto;
            }

            .details {
                flex: 1;
                min-width: 300px;
            }

            .details p {
                margin-bottom: 1rem;
                font-size: 1.1rem;
            }

            .details b {
                color: var(--primary-color);
            }

            .details i {
                color: #666;
                font-size: 0.9rem;
            }

            .submit-btn {
                display: block;
                width: 100%;
                padding: 1rem;
                background-color: var(--secondary-color);
                color: white;
                border: none;
                border-radius: var(--border-radius);
                font-size: 1.2rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-top: 1.5rem;
            }

            .submit-btn:hover {
                background-color: #218838;
            }

            .discount-form {
                margin-top: 2rem;
            }

            .discount-form h4 {
                margin-bottom: 0.5rem;
            }

            .discount-input {
                width: 100%;
                padding: 0.5rem;
                font-size: 1rem;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .apply-btn {
                display: inline-block;
                padding: 0.5rem 1rem;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 1rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-top: 0.5rem;
            }

            .apply-btn:hover {
                background-color: #357ae8;
            }

            .message {
                margin-top: 1rem;
                text-align: center;
                font-weight: bold;
            }

            .success {
                color: var(--secondary-color);
            }

            .error {
                color: #dc3545;
            }

        </style>
    </head>
    <body>
        <%
            DiscountDAO dd = new DiscountDAO();
            Accounts currentAcc = null;
            if(request.getAttribute("account") != null){
                currentAcc = (Accounts) request.getAttribute("account");
            }
            int airlineId = (Integer) request.getAttribute("airlineId");
        %>
        <div class="container">
            <h1>QR Code Payment</h1>
            <div class="content">
                <div class="qr-code">
                    <img src="<c:url value='/img/QRCode.jpg'/>" alt="QR Code"/>
                </div>
                <div class="details">
                    <p>Payment customer information: <b>${phone} ${email}</b></p>
                    <p>Payment amount: <b>${totalCost} VND</b></p>
                    <p><i>Payment time within 24 hours. If after 24 hours you do not receive transfer information, the order will be canceled.</i></p>
                </div>
            </div>
            <form action="QRCodeController" method="get">
                <input type="hidden" value="${discountId}" name="discountId"/>
                <input type="hidden" value="${totalCost}" name="totalCost"/>
                <input type="submit" value="Confirm Payment" class="submit-btn">
            </form>

            <% if(currentAcc != null) { %>
            <div class="discount-form">
                <form action="discountApplyServlet" method="GET">
                    <h4>Enter your giftcode (optional):</h4>
                    <div style="display: flex; justify-content: center">
                        <input class="discount-input" type="text" name="discountcode" pattern="^[A-Z0-9]{10}$" placeholder="Enter 10-character code">
                        <button style="margin:0;margin-left: 20px" class="apply-btn" type="submit">Apply</button>
                    </div>
                    <div class="message">
                        <p class="success">${requestScope.successfulDiscount}</p>
                        <p class="error">${requestScope.failedDiscount}</p>
                    </div>

                </form>
            </div>
            <% } else {
            %>
            <p class="success">Please login to use discount!  <a href="login">Login</a></p>
            <%
            }%>
        </div>
    </body>
</html>