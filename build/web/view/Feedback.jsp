<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="dal.AccountsDAO"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Accounts"%>
<%@page import="model.Feedbacks"%>
<%@page import="model.Status"%>
<%@page import="model.Order"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.FeedbackDao"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Management</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <script src="js/validation.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="js/toastrNotification.js"></script>

        <style>
            .modal-body{
                text-align: left
            }
            .modal-body span{
                margin-right: 5px
            }
            #myBtn{
                display: flex;
            }
        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="main-content" style="    margin: 6% 2% 0 15%;">
            <div style="margin-bottom: 30px; color:#3C6E57 "><h2>FEEDBACK MANAGEMENT</h2></div>
            <div class="filterController col-md-12" style="width: 100%">
                <form action="feedbackController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="orderId" value="${orderId}">
                    <strong>Rated star :</strong>
                    <input class="filterElm" type="number" name="fStar" value="${param.fStar}">
                    <strong>Account email :</strong>
                    <input class="filterElm" type="text" name="fEmail" value="${param.fEmail}" placeholder="Enter Email">
                    <button class="btn btn-info" type="submit">
                        Search
                    </button>
                    <a class="btn btn-danger" href="feedbackController">Cancel</a>
                </form>


            </div>
            <!-- Create Modal -->   
            <div class="container">
                <!-- Modal -->
                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header" style="padding:5px 5px;">
                                <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                <h4 style="margin-left: 12px">Create new account</h4>
                            </div>
                            <div class="modal-body" style="padding:40px 50px;" id="addAccount">
                                <c:if test="${not empty error}">
                                    <p id="error" class="text-danger"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
                                </c:if>
                                <form role="form" action="accountController" method="Post">
                                    <input type="hidden" name="action" value="create"/>
                                    <div class="row" style="margin-bottom: 20px">

                                        <div class="form-group col-md-6">
                                            <label for="image"><span class="glyphicon glyphicon-picture"></span>Avatar:</label>
                                            <input type="file" class="form-control" name="image" onchange="displayImage(this)">
                                        </div>
                                        <div class="col-md-6">
                                            <img  id="previewImage" src="#" alt="Preview"
                                                  style="display: none; max-width: 130px; float: left">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                            <select name="roleId" value="" style="height:  34px;width: 100%;">
                                            </select>
                                        </div>

                                        <div class="form-group col-md-6">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Airline:</label></div>
                                            <select name="airlineID" value="" style="height:  34px; width: 100%;">
                                            </select>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="name"><span class="glyphicon glyphicon-user"></span>Name:</label>
                                        <input type="text" class="form-control" name="name" pattern="^[\p{L}\s]+$">
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="dob"><span class="glyphicon glyphicon-calendar"></span>Date of birth:</label>
                                            <input type="date" class="form-control" name="dob" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="phoneNumber"><span class="glyphicon glyphicon-earphone"></span>Phone number:</label>
                                            <input type="text" class="form-control" name="phoneNumber" oninput="validatePhone(this)">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="email"><span class="glyphicon glyphicon-envelope"></span>Email:</label>
                                        <input type="email" class="form-control" name="email" value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="password"><span class="glyphicon glyphicon-eye-open"></span>Password:</label>
                                        <input type="password" class="form-control" name="password" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="address"><span class="glyphicon glyphicon-home"></span>Address:</label>
                                        <input type="text" class="form-control" name="address" pattern="^[\p{L}\s]+$">
                                    </div>
                                    <button type="submit" class="btn btn-success btn-block">
                                        Confirm
                                    </button>
                                    <p style="color: red; font-size: 20px">${message}</p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
            <h4 style="color : red">${message}</h4>
            <table class="entity" >
                <thead>
                    <tr>
                        <th>Order</th>

                        <th>Contact Phone</th>
                        <th>Contact Email</th>
                        <th>Rated star</th>
                        <th>Comment</th>
                        <th>Create At</th>
                        <th>Update at</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                      AccountsDAO ad = new AccountsDAO();
                      StatusDAO sd = new StatusDAO();
                      OrderDAO od = new OrderDAO();
                      FeedbackDao fbd = new FeedbackDao();
                      List<Feedbacks> list = (List<Feedbacks>)request.getAttribute("feedbackList");
                      for(Feedbacks f : list){
                    %>
                    <tr>
                        <td><%=((Order)(od.getOrderByOrderId(f.getOrder_id()))).getCode()%></td>
                        <td>
                            <%=fbd.getContactPhone(f.getOrder_id())%>
                        </td>
                        <td><%=ad.getAccountEmailById(f.getAccountsid())%></td>
                        <td><%=f.getRatedStar()%></td>
                        <td><%=f.getComment()%></td>
                        <td><%=f.getCreated_at()%></td>
                        <td><%=f.getUpdated_at()%></td>


                    </tr>
                    <%}%>
                </tbody>
            </table>
            
        </div>

        <!-- change status Modal -->
        <div id="statusModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm account status change account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="confirmChangeStatusBtn">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
            function doActivateDeactivate(id, name, action) {
                document.getElementById('modalMessage').innerHTML = "Are you sure you want to " + action + " the account <strong>" + name + "</strong>?";

                const confirmChangeStatusBtn = document.getElementById('confirmChangeStatusBtn');
                confirmChangeStatusBtn.onclick = function () {
                    window.location = "accountController?action=changeStatus&idAcc=" + id;
                };
                $('#statusModal').modal('show');
            }

            $(document).ready(function () {
                $("#myBtn").click(function () {
                    $("#myModal").modal();
                });
            });
            function displayImage(input) {
                var previewImage = document.getElementById("previewImage");
                var file = input.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                };

                reader.readAsDataURL(file);
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

            $(document).ready(function () {
            <% if (request.getAttribute("result") != null) { %>
                successful("<%= request.getAttribute("result").toString()%>");
            <% } %>

            });
        </script>

    </body>
</html>