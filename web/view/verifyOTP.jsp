<%-- 
    Document   : verifyOTP
    Created on : Oct 27, 2024, 12:19:54 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <title>Verify OTP</title>
        <style>
            /* Main container styling */
            .container {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
                background-color: #fffff;
                border-radius: 8px;
                width: 350px;
                height: 400px;
                margin: auto;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                font-family: Arial, sans-serif;
            }
            .icon {
                width: 64px; /* Thay đổi kích thước theo nhu cầu */
                height: 64px;
                margin-bottom: 15px;
            }

            .otp-title {
                font-size: 20px;
                color: #333;
                margin-bottom: 10px;
                text-align: center;
                overflow: hidden;
                white-space: nowrap;
                border-right: 3px solid #4a90e2; /* Cursor effect */
                display: inline-block;
                animation: typing 2s steps(20, end) forwards, wave 2s ease-in-out infinite 3s; /* Starts wave after typing */
            }

            /* Typing animation keyframes */
            @keyframes typing {
                from {
                    width: 0;
                }
                to {
                    width: 85%;
                }
            }

            /* Wave animation keyframes */
            @keyframes wave {
                0%, 100% {
                    transform: translateY(0);
                }
                20% {
                    transform: translateY(-10px);
                }
                40% {
                    transform: translateY(5px);
                }
                60% {
                    transform: translateY(-5px);
                }
                80% {
                    transform: translateY(5px);
                }
            }

            /* can le auto */
            .otp-container {
                display: flex;
                gap: 8px;
                margin-bottom: 20px;
            }

            /* css block input */
            .otp-input {
                width: 40px;
                height: 40px;
                font-size: 24px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                outline: none;
                transition: border-color 0.3s;
                margin-top: 15px;
                margin-bottom: -62px;
            }

            /* css focus button */
            .otp-input:focus {
                border-color: #4a90e2;
            }

            /* Button container */
            .button {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            #submit {
                margin-top: 80px;
                padding: 10px 20px;
                font-size: 16px;
                background-color: #3c6e57;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            #submit:hover {
                background-color: #75a160;
            }

            .error-message {
                color: red;
                margin-top: 10px;
                font-size: 14px;
                text-align: center;
            }
            .footcard{
                margin-top: 40px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <img src="img/verify.gif" alt="Loading Icon" class="icon">
            <h4 class="otp-title">Please enter your OTP</h4>

            <form action="verify" method="POST">
                <div class="otp-container">
                    <input type="text" name="otp1" maxlength="1" class="otp-input" oninput="moveToNext(this, 'otp2'); updateOTP()" required>
                    <input type="text" name="otp2" maxlength="1" class="otp-input" oninput="moveToNext(this, 'otp3'); updateOTP()" required>
                    <input type="text" name="otp3" maxlength="1" class="otp-input" oninput="moveToNext(this, 'otp4'); updateOTP()" required>
                    <input type="text" name="otp4" maxlength="1" class="otp-input" oninput="moveToNext(this, 'otp5'); updateOTP()" required>
                    <input type="text" name="otp5" maxlength="1" class="otp-input" oninput="moveToNext(this, 'otp6'); updateOTP()" required>
                    <input type="text" name="otp6" maxlength="1" class="otp-input" oninput="moveToNext(this, ''); updateOTP()">
                    <input type="hidden" name="otpcode"  class="otpcode" id="otpcode" />
                </div>

                <div class="button">
                    <input id="submit" type="submit" value="Verify">
                    <input type="hidden" name="name" value="<%= request.getAttribute("name") %>">
                    <input type="hidden" name="email" value="<%= request.getAttribute("email") %>">
                    <input type="hidden" name="phoneNumber" value="<%= request.getAttribute("phoneNumber") %>">
                    <input type="hidden" name="pass" value="<%= request.getAttribute("pass") %>">
                    <input type="hidden" name="genotp" value="<%= request.getAttribute("otp") %>">
                </div>
            </form>
            <c:if test="${not empty requestScope.error}">
                <h5 class="error-message">${requestScope.error}</h5>
            </c:if>
            <div class="footcard">

                You want to retry register? <a class="letDoIt" href="register">Register</a>
            </div>

        </div>
        <script>
            function moveToNext(current, nextFieldID) {
                if (current.value.length === 1 && nextFieldID) {
                    document.getElementsByName(nextFieldID)[0].focus();
                }
            }
            function updateOTP() {
                const otp1 = document.querySelector('input[name="otp1"]').value;
                const otp2 = document.querySelector('input[name="otp2"]').value;
                const otp3 = document.querySelector('input[name="otp3"]').value;
                const otp4 = document.querySelector('input[name="otp4"]').value;
                const otp5 = document.querySelector('input[name="otp5"]').value;
                const otp6 = document.querySelector('input[name="otp6"]').value;

                const otpcode = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

                document.getElementById('otpcode').value = otpcode;

            }

        </script>
    </body>
</html>

