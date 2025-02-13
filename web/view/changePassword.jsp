<%-- 
    Document   : changePassword
    Created on : Jun 9, 2024, 2:10:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controller.EncodeController"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="model.Accounts"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <style>
            body{
                background-image: none !important;
            }

            label {
                font-weight: 500 !important
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <%
           EncodeController ec = new EncodeController();
        %>



        <div style="margin: 107px 0;margin-left: 41%;">

            <form action="changePassword" method="post" style="margin: 100px 0;" >
                <%String currentP = ((Accounts)request.getAttribute("account")).getPassword();%>
                <input type="hidden" name="currentPassword" id="currentPassword" value="<%=ec.decryptAES(currentP,SECRET_KEY)%>"/>
                <input type="hidden" name="idAccount" value="${requestScope.account.getId()}"/>             

                <p style="color: red; margin-left: -6%;">${error}</p>
                <p  style="color: red; margin-left: -6%;">${errorNew}</p>

                <div class="form-group">  
                    <input type="password" name="pass" id="password" required />
                    <label for="">Current password</label>
                </div>

                <div class="form-group">
                    <input type="password" name="newPass" id="newPass" oninput="checkLengthNewPass()" required />
                    <label for="">New password</label>
                </div>

                <div class="form-group">
                    <input type="password" name="newPass2" required />
                    <label for="">New password again</label>
                </div>
                <div id="errorPass" style="color: red; display: none;">Password must more than 6 characters</div>
                <div class="button">
                    <input id="submit" type="submit" value="Đổi mật khẩu" style="width: 26.9%;"/><br /><br />
                </div>
            </form>
        </div>
        <script>
               function checkLengthNewPass() {
                var newPass = document.getElementById("newPass").value;
                var errorPass = document.getElementById("errorPass");
                if (newPass.length < 6) {
                    errorPass.style.display = "inline";
                    submit.disabled = true;
                } else {
                    errorPass.style.display = "none";
                    submit.disabled = false;
                }
            }
        </script>
    </body>
</html> 