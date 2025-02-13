<%-- 
    Document   : Register
    Created on : Sep 14, 2024, 8:43:02 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="icon/themify-icons/themify-icons.css" />
        <script src="js/validation.js"></script>
    </head>
    <body>
        <div class="container">
            <div style="display: flex">
                <h1 style="margin-bottom: 30px">
                    Register
                </h1>
                <a href="home" style="    position: relative;
                   left: 150px;
                   top: 6px;
                   transition: none;
                   cursor: move;">
                    <i style="font-size: 25px;color: #3c6e57;" class="bi bi-house"></i>
                </a>
            </div>
            <h3 style="color: red">${requestScope.error}</h3>
            <c:set var="cookie" value="${pageContext.request.cookies}" />
            <form action="register" method="post" onsubmit="validateNameInput()">
                <div class="form-group">
                    <input type="text" pattern="^[\p{L}\s]+$" name="name" id="name" required />
                    <label for="">Your Name</label>
                </div>
                <div class="form-group">
                    <input type="email" name="email" id="email" oninput="validateEmail()" required />
                    <label for="">Email</label>
                </div>
                <div class="form-group">
                    <input type="number" name="phoneNumber" id="phoneNumber" oninput="validatePhone(this)" required />
                    <label for="">Phone Number</label>
                </div>
                <div class="form-group">
                    <input type="password" name="pass" id="password" required oninput="validatepassword()" />
                    <label for="">Password</label>
                    <svg id="eye-password" onclick="togglePasswordVisibility()"  style="position: absolute; z-index: 9999; right: 10px; top: 15px; width: 25px; cursor: pointer" onclick="togglePasswordVisibility('password', 'eye-password')" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path id="eye-path-password" d="M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z" fill="rgb(60, 110, 87)"/>
                    </svg>
                </div>
                <div id="errorPass" style="color: red; display: none;">Password must more than 6 characters</div>
                <div class="form-group">
                    <input
                        type="password"
                        id="confirmPassword"
                        required
                        onkeyup="checkPass()"
                        required
                        />
                    <label for="">Re-enter Password</label>
                    <svg id="eye-confirm" onclick="toggleConfirmPasswordVisibility()"  style="position: absolute; z-index: 9999; right: 10px; top: 15px; width: 25px; cursor: pointer" onclick="togglePasswordVisibility('confirmPassword', 'eye-confirm')" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path id="eye-path-confirm" d="M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z" fill="rgb(60, 110, 87)"/>
                    </svg>
                </div>
                <div><p id="wrongPass" style="display: none; color: red">
                        Passwords do not match
                    </p></div>

                <br />
                <span id="phoneError" style="color:red; display:none;">Phone Number is invalid!</span>
                <span id="emailError" style="color: red; display: none;">Email is must be valid!</span>
                <p id="capslock-warning" style="display: none; margin-bottom: 20px">⚠️ Caps Lock is on</p>
                <p style="color: red">${requestScope.existedUsername}</p>
                <div class="button">
                    <input id="submit" type="submit" value="Register" /><br /><br />
                </div>
                You have account? <a class="letDoIt" href="login">Login</a>
            </form>
        </div>

        <script>
            var p = document.getElementById("password");
            var cp = document.getElementById("confirmPassword");
            var submit = document.getElementById("submit");
            var wrongPass = document.getElementById("wrongPass");
            var text = document.getElementById("capslock-warning");
            function validatepassword() {
                var pass = document.getElementById("password").value;
                var errorPass = document.getElementById("errorPass");
                if (pass.length < 6) {
                    errorPass.style.display = "inline";
                } else {
                    errorPass.style.display = "none";
                }
            }
            function validateNameInput() {
                const nameInput = document.getElementById("name").value.trim();

                if (nameInput === "") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
            function validateEmail() {
                var email = document.getElementById("email").value;
                var emailError = document.getElementById("emailError");

                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$/;
                var fptemailRegex = /^[a-zA-Z0-9._%+-]+@fpt\.edu\.vn$/;
                if (email === "") {
                    emailError.style.display = "none";
                } else if (!email.match(emailRegex) && !email.match(fptemailRegex)) {
                    emailError.style.display = "inline";
                } else {
                    emailError.style.display = "none";
                }
            }
           
            function CapsCheck(event) {
                if (event.getModifierState("CapsLock")) {
                    text.style.display = "block";
                } else {
                    text.style.display = "none";
                }
            }

            p.addEventListener("keyup", CapsCheck);
            cp.addEventListener("keyup", CapsCheck);

            function checkPass() {
                if (p.value !== cp.value) {
                    submit.disabled = true;
                    cp.style.border = "2px solid red";
                    wrongPass.style.display = "inline";
                } else {
                    submit.disabled = false;
                    cp.style.border = "2px solid green";
                    wrongPass.style.display = "none";
                }
            }

            var openEyeViewBox = "0 0 576 512";
            var closedEyeViewBox = "0 0 640 512";

            var openEyePath = "M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z";
            var closedEyePath = "M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zm151 118.3C226 97.7 269.5 80 320 80c65.2 0 118.8 29.6 159.9 67.7C518.4 183.5 545 226 558.6 256c-12.6 28-36.6 66.8-70.9 100.9l-53.8-42.2c9.1-17.6 14.2-37.5 14.2-58.7c0-70.7-57.3-128-128-128c-32.2 0-61.7 11.9-84.2 31.5l-46.1-36.1zM394.9 284.2l-81.5-63.9c4.2-8.5 6.6-18.2 6.6-28.3c0-5.5-.7-10.9-2-16c.7 0 1.3 0 2 0c44.2 0 80 35.8 80 80c0 9.9-1.8 19.4-5.1 28.2zm51.3 163.3l-41.9-33C378.8 425.4 350.7 432 320 432c-65.2 0-118.8-29.6-159.9-67.7C121.6 328.5 95 286 81.4 256c8.3-18.4 21.5-41.5 39.4-64.8L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5zm-88-69.3L302 334c-23.5-5.4-43.1-21.2-53.7-42.3l-56.1-44.2c-.2 2.8-.3 5.6-.3 8.5c0 70.7 57.3 128 128 128c13.3 0 26.1-2 38.2-5.8z";


            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("password");
                var eyePathPass = document.getElementById("eye-path-password");
                var eyePass = document.getElementById("eye-password");

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    eyePathPass.setAttribute("d", closedEyePath);
                    eyePass.setAttribute("viewBox", closedEyeViewBox);
                } else {
                    passwordInput.type = "password";
                    eyePathPass.setAttribute("d", openEyePath);
                    eyePass.setAttribute("viewBox", openEyeViewBox);
                }
            }

            function toggleConfirmPasswordVisibility() {
                var confirmPasswordInput = document.getElementById("confirmPassword");
                var eyePathCf = document.getElementById("eye-path-confirm");
                var eyeCf = document.getElementById("eye-confirm");

                if (confirmPasswordInput.type === "password") {
                    confirmPasswordInput.type = "text";
                    eyePathCf.setAttribute("d", closedEyePath);
                    eyeCf.setAttribute("viewBox", closedEyeViewBox);
                } else {
                    confirmPasswordInput.type = "password";
                    eyePathCf.setAttribute("d", openEyePath);
                    eyeCf.setAttribute("viewBox", openEyeViewBox);
                }
            }



        </script>
    </body>
</html>
