<%-- 
    Document   : Login
    Created on : Sep 14, 2024, 8:37:16 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <title>Login</title>

    </head>
    <body>
        <div class="container">
            <div style="display: flex">
                <h1 style="margin-bottom: 30px">
                    Login                  
                </h1>

                <div>
                    <a href="home" style="    transform: translate(0px, 1px);
                       position: relative;
                       left: 188px;
                       top: 1px;">
                        <i style="font-size: 25px;color: #3c6e57;" class="bi bi-house"></i>
                    </a>
                </div>

            </div>
            <c:if test="${not empty requestScope.notice}">
                <h4 style="color: #3c6e57;margin-bottom: 20px;">${requestScope.notice}</h4>
            </c:if>
            <c:set var="cookie" value="${pageContext.request.cookies}" />
            <form action="login" method="post">     

                <div class="form-group">
                    <input
                        type="text"
                        name="user"
                        value="${cookie.cuser.value}"
                        required
                        />
                    <label for="">Email or Phone Number</label>
                </div>
                <div class="form-group">
                    <input
                        type="password"
                        id="password"
                        name="pass"
                        value="${cookie.cpass.value}"
                        required
                        />
                    <label for="">Password</label>
                    <svg id="eye"
                         style="position: absolute;
                         z-index: 9999;
                         right: 10px;
                         top: 15px;
                         width: 25px;
                         cursor: pointer" 
                         onclick="togglePasswordVisibility()" 
                         xmlns="http://www.w3.org/2000/svg" 
                         viewBox="0 0 576 512">
                    <path id="eye-path" d="M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z"
                          fill="rgb(60, 110, 87)"/>
                    </svg>
                </div>
                <p id="wrongAccount" style="color: red">${requestScope.error}</p>
                <p id="capslock-warning" style="display: none; margin-bottom: 25px">
                    ⚠️ Caps Lock is on
                </p>
                <input type="checkbox" ${cookie.crem != null ? 'checked' : ''}
                       name="rem" value="ON"/> Remember me
                <a id="forgetPassword" href="forgetPassword">Forget Password</a
                ><br /><br />
                <div class="button" style="height: 60px">
                    <input type="submit" value="Login" /><br /><br />
                </div>
                <div style="display: flex; justify-content: center;">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/flyezy/loginGoogleHandler&response_type=code&client_id=567083027781-r2dqc8ursvogag062snkt50uhbtnh90r.apps.googleusercontent.com&approval_prompt=force" 
                       style="display: inline-flex;
                       align-items: center;
                       justify-content: center;
                       width: 100%;
                       background-color: white;
                       color: #4285F4;
                       padding: 10px 20px;
                       border: 2px solid;
                       border-radius: 4px;
                       text-decoration: none;
                       font-family: Arial, sans-serif;
                       font-size: 15px;
                       font-weight: 550;
                       transition: background-color 0.3s, color 0.3s;
                       margin-bottom: 10px;"
                       onmouseover="this.style.backgroundColor = '#f1f1f1'; this.style.color = '#0d47a1';"
                       onmouseout="this.style.backgroundColor = 'white'; this.style.color = '#4285F4';">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="24px" height="24px" style="margin-right: 10px;">
                        <path fill="#FFC107" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"/>
                        <path fill="#FF3D00" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"/>
                        <path fill="#4CAF50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"/>
                        <path fill="#1976D2" d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"/>
                        </svg>
                        Login with Google
                    </a>
                </div>

                Don't have an account?
                <a class="letDoIt" href="register">Register Now</a>
            </form>
        </div>
        <script>
            var input = document.getElementById("password");
            var text = document.getElementById("capslock-warning");
            input.addEventListener("keyup", function (event) {
                if (event.getModifierState("CapsLock")) {
                    text.style.display = "block";
                } else {
                    text.style.display = "none";
                }
            });

            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("password");
                var eyePath = document.getElementById("eye-path");
                var eye = document.getElementById("eye");

                var openEyeViewBox = "0 0 576 512";
                var closedEyeViewBox = "0 0 640 512";

                var openEyePath = "M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z";
                var closedEyePath = "M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zm151 118.3C226 97.7 269.5 80 320 80c65.2 0 118.8 29.6 159.9 67.7C518.4 183.5 545 226 558.6 256c-12.6 28-36.6 66.8-70.9 100.9l-53.8-42.2c9.1-17.6 14.2-37.5 14.2-58.7c0-70.7-57.3-128-128-128c-32.2 0-61.7 11.9-84.2 31.5l-46.1-36.1zM394.9 284.2l-81.5-63.9c4.2-8.5 6.6-18.2 6.6-28.3c0-5.5-.7-10.9-2-16c.7 0 1.3 0 2 0c44.2 0 80 35.8 80 80c0 9.9-1.8 19.4-5.1 28.2zm51.3 163.3l-41.9-33C378.8 425.4 350.7 432 320 432c-65.2 0-118.8-29.6-159.9-67.7C121.6 328.5 95 286 81.4 256c8.3-18.4 21.5-41.5 39.4-64.8L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5zm-88-69.3L302 334c-23.5-5.4-43.1-21.2-53.7-42.3l-56.1-44.2c-.2 2.8-.3 5.6-.3 8.5c0 70.7 57.3 128 128 128c13.3 0 26.1-2 38.2-5.8z";

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    eyePath.setAttribute("d", closedEyePath);
                    eye.setAttribute("viewBox", closedEyeViewBox);
                } else {
                    passwordInput.type = "password";
                    eyePath.setAttribute("d", openEyePath);
                    eye.setAttribute("viewBox", openEyeViewBox);
                }
            }

        </script>
    </body>
</html>
