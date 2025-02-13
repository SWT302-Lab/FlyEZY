<%-- Document : infor Created on : May 12, 2024, 9:59:46 PM Author : Admin --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%@page import="model.Roles" %>
<%@page import="model.Accounts" %>
<%@page import="dal.RolesDAO" %>
<%
    RolesDAO rd = new RolesDAO();
    Accounts a = (Accounts)request.getAttribute("account");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Account Information</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleInfo.css" />
        <script src="js/validation.js"></script>
        <link rel="stylesheet" href="icon/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="row" id="info" style="margin: 0; margin-top: 100px; margin-bottom: 100px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div id="info-banner">
                    <div id="info-avatar" style="display: flex; position: relative;">
                        <img id="info-avatar-pic" style="height: 220px; width: 216px;" src="${requestScope.account.image}" />
                        <p>${requestScope.account.name}
                        <p style="font-size: 20px; opacity: 0.6; margin-top: 165px;">#<%=rd.getNameById(a.getRoleId())%></p>
                        </p>
                    </div>
                </div>

                <div id="info-in4" class="row">
                    <div class="info-in4-1 col-md-4">
                        Khách hàng thân thiết
                        <strong></strong>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="info-in4-1 col-md-7">

                        <strong>Full Name:</strong>
                        <p>${requestScope.account.name}</p>
                        <strong>Day of birth:</strong>
                        <p>${requestScope.account.dob}</p>
                        <strong>Email:</strong>
                        <p>${requestScope.account.email}</p>
                        <strong>Phone Number:</strong>
                        <p>${requestScope.account.phoneNumber}</p>
                        <strong>Address:</strong>
                        <p>${requestScope.account.address}</p>

                        <div style="width: 100%;
                             display: flex;
                             justify-content: space-around; ">
                            <button style="width: 40%;height: 45px" class="btn btn-success" data-toggle="modal" data-target="#myModal-${requestScope.account.getId()}" >Update profile</button>
                            <button style="width: 40%" class="btn btn-danger" onclick="window.location.href = 'home'">Home</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <!-- Modal -->
        <div id="myModal-${requestScope.account.getId()}" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="font-weight:bold;">Update profile</h4>
                    </div>
                    <div class="modal-body">
                        <form action="infoUpdateServlet" method="post" onsubmit="return validateNameInput()" >
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="image" class="control-label">Avatar</label>
                                    <input type="file" name="image" onchange="validateImageInput(this,${requestScope.account.id})" value="${requestScope.account.image}" class="form-control"
                                           style="padding:5px;" >
                                </div>
                                <div class="form-group col-md-6" >
                                    <img id="hideImage${requestScope.account.id}" src="${requestScope.account.image}" style="float: right" width="50%" height="50%"/>
                                    <img id="preImage2${requestScope.account.id}" style="display: none;float: right" src="#"  width="50%" height="50%">
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${requestScope.account.id}"/>
                            <!-- Full Name -->
                            <div class="form-group">
                                <label for="name" class="control-label">Full name:</label>
                                <% 
                                    java.util.Calendar calendar = java.util.Calendar.getInstance();
                                    calendar.add(java.util.Calendar.YEAR, 0);
                                    String maxDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
                                %>
                                <input type="text" name="name" value="${requestScope.account.name}" class="form-control" 
                                       pattern="^[\p{L}\s]+$" id="nameInput" required />
                            </div>
                            <div class="form-group">
                                <label for="birth" class="control-label">Date of birth:</label>
                                <input type="date" name="birth" value="${requestScope.account.dob}" class="form-control" required max="<%=maxDate%>" onkeydown="return false;"/>
                            </div>
                            <div class="form-group">
                                <label for="email" class="control-label">Email:</label>
                                <input type="email" name="email" value="${requestScope.account.email}" class="form-control" readonly=""/>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="control-label">Phone number:</label>
                                <input type="text" name="phone" value="${requestScope.account.phoneNumber}" class="form-control" 
                                       pattern="^\d{10}$" required oninput="validatePhone(this)" />
                            </div>
                            <div class="form-group">
                                <label for="address" class="control-label">Address:</label>
                                <textarea name="address" class="form-control" pattern="/^[\p{L}\s]+$" rows="3">${requestScope.account.address}</textarea>
                            </div>
                            <div class="form-group text-right">
                                <button type="submit" class="btn btn-success">Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>


            </div>
        </div>
        <script>
            function validateNameInput() {
                const nameInput = document.getElementById("nameInput").value.trim();

                if (nameInput === "") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
            function validateImageInput(input, id) {
                const filePath = input.value;
                const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;

                if (!allowedExtensions.exec(filePath)) {
                    alert('Please select a file in .jpg or .png format.');
                    input.value = '';
                    return false;
                } else {
                    displayImage2(input, id);
                }
            }

            function displayImage2(input, id) {
                var i = id;
                var hideImage = document.getElementById(`hideImage` + i);
                var previewImage2 = document.getElementById(`preImage2` + i);
                var file = input.files[0];
                var reader = new FileReader();

                console.log(hideImage, previewImage2);

                reader.onload = function (e) {
                    hideImage.style.display = "none";
                    previewImage2.src = e.target.result;
                    previewImage2.style.display = "block";
                };

                reader.readAsDataURL(file);
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
