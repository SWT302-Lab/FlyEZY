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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
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
            .payment-options {
                display: flex;
                flex-direction: row;
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
            .imgPayment{
                width: 100px;
            }
            h2{
                text-align: center;
            }
            
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="box">
            <div>
                <svg id="check-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#32b877" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>
            </div>
            <h3>Order Booking Successful</h3>
            <p>Order approved, please pay at least 10 days before flight time</p>
            <button type="submit" class="btn btn-success" id="togglePaymentBtn${ORDERID}" onclick="paymentMedthodDisplay(${ORDERID})">Pay Now</button>
            <button type="submit" class="btn btn-danger" onclick="goHome()">Pay Later</button>
        </div>
        <div id="payment_methods${ORDERID}" style="display: none;">
            <h2>Payments Method</h2>
            <div class="payment-options">
                <div class="payment-option">
                    <form action="VnpayServlet" id="frmCreateOrder"  method="post"> 
                        <input type="hidden" name="orderID" value="${ORDERID}"/>
                        <input type="hidden" name="bankCode" value="">
                        <input type="hidden" class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="1000000000" min="1" name="amount" type="number" value="${price}" />
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
                        <input type="hidden" name="orderID" value="${ORDERID}"/>
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
        <%@include file="footer.jsp" %>
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script>
                function goHome() {
                    window.location.href = 'home';
                }
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
                function paymentMedthodDisplay(id) {
                    var paymentMethods = document.getElementById("payment_methods" + id);
                    if (paymentMethods.style.display === 'none' || paymentMethods.style.display === '') {
                        paymentMethods.style.display = 'block';
                    } else {
                        paymentMethods.style.display = 'none';
                    }
                }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
