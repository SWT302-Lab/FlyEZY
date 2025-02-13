<%-- 
    Document   : AirlineManage
    Created on : Sep 15, 2024, 9:45:43 PM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Airline"%>
<%@page import="java.util.*" %>
<%@page import="model.Status"%>
<%@page import="dal.StatusDAO"%>
<!DOCTYPE html>
<html>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Airline Management</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="js/toastrNotification.js"></script>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>


        <!-- Modal add airline -->
        <div class="modal fade" id="addAirline" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addBookModalLabel">Add Airline</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm" action="airlineManagement" method="POST" onsubmit="return validateNameAndInfoInput(0)">
                            <input type="hidden" name="action" value="add">
                            <!-- Name -->
                            <div class="form-group">
                                <label for="nameInput"><span class="glyphicon glyphicon-plane"></span> Airline Name:</label>
                                <input pattern="^[\p{L}\s]+$" type="text" id="name0" class="form-control" id="nameInput" name="airlineName" required>
                                <div id="nameError" class="error"></div>
                            </div>

                            <!-- Image -->
                            <div class="row">
                                <div class="form-group col-md-8">
                                    <label for="imageInput"><span class="glyphicon glyphicon-paperclip"></span> Image URL:</label>
                                    <input type="file" class="form-control-file" id="image" name="airlineImage" onchange="displayImage(this)" required>
                                    <div id="imageError" class="error"></div>
                                </div>
                                <div class="col-md-4">
                                    <img  id="previewImage" src="#" alt="Preview"
                                          style="display: none; max-width: 130px; float: left">
                                </div>
                            </div>

                            <!-- Information -->
                            <div class="form-group">
                                <label><span class="glyphicon glyphicon-info-sign"></span> Information:</label>
                                <div class="editor-container">
                                    <textarea id="info0" pattern="^[\p{L}\s]+$" class="editor" name="airlineInfo"></textarea>
                                </div>
                            </div>  
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" form="addProductForm">Add</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>

                </div>
            </div>
        </div>

        <div id="main-content">
            <div style="margin-bottom: 30px; color:#3C6E57 "><h2>WELCOME, ${requestScope.manager}! </h2></div>
            <c:if test="${requestScope.account.getRoleId() == 1}">
                <div>
                    <!-- Search bar -->
                    <div style="max-width: 60%;">
                        <form action="airlineController" method="GET" style="display: flex; width: 50%; align-items: center;">
                            <input type="hidden" name="search" value="search">
                            <strong class="filterElm">Status:</strong>
                            <select class="filterElm" name="status">
                                <option value="" ${param.status == null ? 'selected' : ''}>All</option>
                                <c:set var="counter" value="0" />
                                <c:forEach items="${requestScope.listStatus}" var="status">
                                    <c:if test="${counter < 2}">
                                        <option value="${status.id}" ${param.status != null && (param.status == status.id) ? 'selected' : ''}>${status.name}</option>
                                        <c:set var="counter" value="${counter + 1}" />
                                    </c:if>
                                </c:forEach>
                            </select>
                            <strong>Name: </strong>
                            <input class="filterElm" value="${param.keyword}" type="text" pattern="^[\p{L}\s]+$" placeholder="Airline Name ..." name="keyword" style="margin-left:5px"/>
                            <input type="submit" class="btn btn-info" name="submit" value="Search" style="margin-right: 5px">
                            <a class="btn btn-danger" href="airlineController">Cancel</a>
                        </form>
                    </div>

                    <!-- Trigger the modal with a button -->
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addAirline" style="margin-top: 20px;flex-shrink: 0;">
                        Add New Airline
                    </button>
                </div>
            </c:if> 
            <% 
                String error = (String) session.getAttribute("error");
                if (error != null) { 
            %>
            <div class="alert alert-danger"><%= error %></div>
            <% session.removeAttribute("error"); %>
            <% } %>
            
            <% 
                String success = (String) session.getAttribute("success");
                if (success != null) { 
            %>
            <div class="alert alert-success"><%= success %></div>
            <% session.removeAttribute("success"); %>
            <% } %>

            <% StatusDAO statusDao = new StatusDAO();
            
            %>
            <div class="row" style="margin: 0">


                <div class="col-md-10" id="left-column" style="padding: 0; margin-top: 10px">
                    <table class="entity">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Information</th>
                                <th>Status</th>
                                    <c:if test="${requestScope.account.getRoleId() == 2}">
                                    <th style="min-width: 156px" >Actions</th>
                                    </c:if>                             
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.listAirline}" var="airline">
                                <tr>
                                    <td name="name">${airline.getName()}</td>
                                    <td name="image">
                                        <img src="${airline.getImage()}" width="100" height="100" alt="airline" class="primary" />                                      
                                    </td>
                                    <td>
                                        <div style="max-height:  100px; text-align: left;padding-left: 20px; overflow-y: scroll;">
                                            ${airline.getInfo()}
                                        </div>
                                    </td>

                                    <td name="status"> 
                                        <c:forEach items="${requestScope.listStatus}" var="status">
                                            <c:if test="${status.getId() == airline.getStatusId()}">
                                                <c:if test="${airline.getStatusId() == 1}">
                                                    <button class="btn btn-success" data-toggle="modal" data-target="#changeActive-airline-${airline.getId()}" ${account.roleId == 2 ? 'disabled' : ''}>Activate</button>
                                                </c:if>
                                                <c:if test="${airline.getStatusId() == 2}">
                                                    <button class="btn btn-danger" data-toggle="modal" data-target="#changeActive-airline-${airline.getId()}" ${account.roleId == 2 ? 'disabled' : ''}>Deactivate</button>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <c:if test="${requestScope.account.getRoleId() == 2}">
                                        <td>
                                            <button class="btn btn-info" data-toggle="modal" data-target="#update-airline-${airline.getId()}">Update</button>
                                            <button class="btn btn-warning" onclick="toggleBaggageDetails(${airline.id})">Baggage Detail
                                                <span id="arrow${airline.id}" style="margin-left: 8px" class="glyphicon glyphicon-menu-down"></span>
                                            </button>
                                        </td>
                                    </c:if> 
                                </tr>
                                <!--change status airline modal-->
                            <div class="modal fade" id="changeActive-airline-${airline.getId()}" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="delete-modal-label">Delete</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <c:if test="${airline.getStatusId() == 1}">
                                            <div class="modal-body">
                                                <p>Do you want to deactivate this airline?</p>
                                            </div>
                                        </c:if>
                                        <c:if test="${airline.getStatusId() == 2}">
                                            <div class="modal-body">
                                                <p>Do you want to reactivate this airline?</p>
                                            </div>
                                        </c:if>
                                        <div class="modal-footer">
                                            <form action="airlineManagement" method="POST">
                                                <input type="hidden" name="action" value="changeStatus">
                                                <div class="form-group" style="display: none">
                                                    <input type="text" class="form-control" id="idDeleteInput" name="airlineId" value="${airline.getId()}">
                                                </div>
                                                <div class="form-group" style="display: none">
                                                    <input type="text" class="form-control" id="idDeleteInput" name="airlineStatus" value="${airline.getStatusId()}">
                                                </div>

                                                <c:if test="${airline.getStatusId() == 1}">
                                                    <button type="submit" class="btn btn-danger">Yes</button>
                                                </c:if>
                                                <c:if test="${airline.getStatusId() == 2}">
                                                    <button type="submit" class="btn btn-success">Yes</button>
                                                </c:if>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--update airline modal-->
                            <div class="modal fade" id="update-airline-${airline.getId()}" tabindex="-1" role="dialog" aria-labelledby="updateAirlineModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" style="text-align: left;">Update Airline</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="airlineManagement" method="POST" onsubmit="return validateNameAndInfoInput(${airline.getId()})">
                                                <input type="hidden" name="action" value="update"/>
                                                <!-- Name -->
                                                <div class="form-group">
                                                    <label for="nameInput" style="text-align: left; display: block;"><span class="glyphicon glyphicon-plane"></span> Airline Name:</label>
                                                    <input pattern="^[\p{L}\s]+$" type="text" id="name${airline.getId()}" class="form-control" id="nameInput" name="airlineName" value="${airline.getName()}" required>
                                                    <div id="nameError" class="error"></div>
                                                </div>

                                                <!-- Image Input -->
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="imageInput"><span class="glyphicon glyphicon-paperclip"></span> Image URL:</label>
                                                        <input type="file" class="form-control-file" id="image" name="airlineImage" value="${airline.getImage()}" onchange="displayImage2(this,${airline.getId()})">
                                                        <div id="imageError" class="error"></div>
                                                    </div>
                                                    <!-- Preview Image -->
                                                    <div class="col-md-6">
                                                        <img id="hideImage${airline.getId()}" src="${airline.getImage()}" alt="Preview" style="display: block; max-width: 130px;"> 
                                                        <img id="preImage2${airline.getId()}" src="#" alt="Preview" style="display: none; max-width: 130px;">
                                                    </div>
                                                </div>
                                                <!-- Information -->
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-info-sign"></span> Information:</label>
                                                    <div class="editor-container">
                                                        <textarea pattern="^[\p{L}\s]+$" id="info${airline.getId()}" class="editor" name="airlineInfo">${airline.getInfo()}</textarea>
                                                    </div>
                                                </div>
                                                <input type="hidden" value="${airline.getId()}" name="airlineId">
                                                </div>
                                                <div class="modal-footer" style="text-align: right;">
                                                    <button type="submit" class="btn btn-primary" >Update</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden row for baggage details -->
                                <tr id="baggage-details-${airline.id}" style="display: none;">

                                    <td colspan="5">
                                        <div id="baggage-content-${airline.id}">
                                            <!-- This is where the baggage details will be loaded -->
                                            <!-- Trigger the modal with a button -->
                                            <div style="display: flex; justify-content: start; margin-bottom: 2%;">
                                                <button type="button" class="btn btn-success" 
                                                        data-toggle="modal" 
                                                        data-target="#addBaggages-${airline.id}">
                                                    Add Another Baggage
                                                </button>

                                            </div>
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>Weight</th>
                                                        <th>Price</th>
                                                        <th>Status</th>
                                                        <th style="min-width: 156px">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="counter" value="0" />
                                                    <c:forEach items="${requestScope.listBaggage}" var="baggage">

                                                        <c:if test="${baggage.airlineId == airline.id}">

                                                            <tr>
                                                                <td><c:set var="counter" value="${counter+1}" />${counter}</td>
                                                                <td>${baggage.getWeight()}</td>
                                                                <td>${baggage.getPrice()}</td>
                                                                <td>
                                                                    <c:forEach items="${requestScope.listStatus}" var="status">
                                                                        <c:if test="${status.getId() == baggage.getStatusId()}">
                                                                            <c:if test="${baggage.getStatusId() == 1}">
                                                                                <button class="btn btn-success" data-toggle="modal" data-target="#changeActive-baggage-${baggage.getId()}">Activate</button>
                                                                            </c:if>
                                                                            <c:if test="${baggage.getStatusId() == 2}">
                                                                                <button class="btn btn-danger" data-toggle="modal" data-target="#changeActive-baggage-${baggage.getId()}">Deactivate</button>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                                <td>
                                                                    <button 
                                                                        class="btn btn-info"
                                                                        data-toggle="modal" data-target="#update-baggage-${baggage.id}">Update</button>
                                                                </td>
                                                            </tr>
                                                            <!--change status baggage modal-->
                                                        <div class="modal fade" id="changeActive-baggage-${baggage.id}" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="delete-modal-label">Change Status</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <c:if test="${baggage.getStatusId() == 1}">
                                                                        <div class="modal-body">
                                                                            <p>Do you want to deactivate this baggage?</p>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${baggage.getStatusId() == 2}">
                                                                        <div class="modal-body">
                                                                            <p>Do you want to reactivate this baggage?</p>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="modal-footer">
                                                                        <form action="baggageManagement" method="POST">
                                                                            <input type="hidden" name="action" value="changeStatus">
                                                                            <div class="form-group" style="display: none">
                                                                                <input type="text" class="form-control" id="idDeleteInput" name="baggageId" value="${baggage.id}">
                                                                            </div>
                                                                            <div class="form-group" style="display: none">
                                                                                <input type="text" class="form-control" id="idDeleteInput" name="baggageStatus" value="${baggage.getStatusId()}">
                                                                            </div>
                                                                            <button type="submit" class="btn btn-danger">Yes</button>
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>

                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!--update baggage modal-->
                                                        <div class="modal fade" id="update-baggage-${baggage.id}" tabindex="-1" role="dialog" aria-labelledby="updateBaggageModal" aria-hidden="true">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" style="text-align: left;">Update Baggage</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="baggageManagement" method="POST">
                                                                            <input type="hidden" name="action" value="update"/>
                                                                            <!-- Weight -->
                                                                            <div class="form-group" style="display: flex">
                                                                                <label style="width: 10%" for="nameInput" style="display: flex; justify-content: start;">Weight:</label>
                                                                                <input readonly pattern="^\d{1,3}(\.\d+)?$" style="width: 40%" type="text" class="form-control" id="nameInput" value="${baggage.weight}" name="baggageWeight" required> 
                                                                                <div style="margin-left: 10px">kg</div>
                                                                                <div id="nameError" class="error"></div>
                                                                            </div>
                                                                            <!-- Price -->
                                                                            <div class="form-group"  style="display: flex">
                                                                                <label style="width: 10%" for="imageInput" style="display: flex; justify-content: start;">Price:</label>
                                                                                <input pattern="\d{1,8}" style="width: 40%" type="text" class="form-control" id="imageInput" value="${baggage.price}" name="baggagePrice" required>
                                                                                <div style="margin-left: 10px">VND</div>
                                                                                <div id="imageError" class="error"></div>
                                                                            </div>
                                                                            <input type="hidden" name="baggageId" value="${baggage.id}">
                                                                            </div>
                                                                            <div class="modal-footer" style="text-align: right;">
                                                                                <button type="submit" class="btn btn-primary" >Update</button>
                                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                                <input type="hidden" name="airlineIdBaggage" value="${airline.id}">
                                                                            </div>
                                                                        </form>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                            </table>
                                        </div>
                                    </td>
                                    <!-- add baggage Modal -->
                                <div class="modal fade" id="addBaggages-${airline.id}" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addBookModalLabel" style="text-align: left;">Add New Baggage</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="addBaggage-${airline.id}" action="baggageManagement" method="POST">
                                                    <input type="hidden" name="action" value="add"/> 
                                                    <!-- Weight -->
                                                    <div class="form-group" style="display: flex">
                                                        <label style="width: 10%" for="nameInput" style="display: flex; justify-content: start;">Weight:</label>
                                                        <input pattern="^\d{1,3}(\.\d+)?$" style="width: 40%" type="text" class="form-control" id="nameInput" name="baggageWeight" required> 
                                                        <div style="margin-left: 10px">kg</div>
                                                        <div id="nameError" class="error"></div>
                                                    </div>
                                                    <!-- Price -->
                                                    <div class="form-group"  style="display: flex">
                                                        <label style="width: 10%" for="imageInput" style="display: flex; justify-content: start;">Price:</label>
                                                        <input pattern="\d{1,8}" style="width: 40%" type="text" class="form-control" id="imageInput" name="baggagePrice" required>
                                                        <div style="margin-left: 10px">VND</div>
                                                        <div id="imageError" class="error"></div>
                                                    </div>
                                                    <input type="hidden" name="airlineIdBaggage" value="${airline.id}">
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" form="addBaggage-${airline.id}">Add</button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                                </tr>
                            </c:forEach>
                            </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function validateNameAndInfoInput(i) {
                const name = document.getElementById("name" + i).value.trim();


                if (name === "") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
            function toggleBaggageDetails(airlineId) {

                var detailsRow = document.getElementById('baggage-details-' + airlineId);
                var arrow = document.getElementById("arrow" + airlineId);

                if (detailsRow.style.display === 'table-row') {
                    detailsRow.style.display = 'none';
                    arrow.classList.remove("glyphicon-menu-up");
                    arrow.classList.add("glyphicon-menu-down");
                } else {
                    detailsRow.style.display = 'table-row';
                    arrow.classList.remove("glyphicon-menu-down");
                    arrow.classList.add("glyphicon-menu-up");


                    fetch('baggageDetails?airlineId=' + airlineId)
                            .then(response => response.json())
                            .then(data => {
                                var baggageContent = document.getElementById('baggage-content-' + airlineId);
                                baggageContent.innerHTML = '';

                                if (data.length > 0) {

                                    var table = '<table class="table table-bordered"><thead><tr><th>Baggage ID</th><th>Weight (kg)</th><th>Price ($)</th></tr></thead><tbody>';
                                    data.forEach(function (baggage) {
                                        table += '<tr><td>' + baggage.baggageId + '</td><td>' + baggage.weight + '</td><td>' + baggage.price + '</td></tr>';
                                    });
                                    table += '</tbody></table>';
                                    baggageContent.innerHTML = table;
                                } else {
                                    baggageContent.innerHTML = '<p>No baggages available for this airline.</p>';
                                }
                            })
                            .catch(error => {
                                console.error('Error fetching baggage details:', error);
                                baggageContent.innerHTML = '<p>Error loading baggages.</p>';
                            });
                }
            }
            function toggleBaggageInputs() {
                var baggageInputs = document.getElementById('baggageInputs');
                baggageInputs.style.display = baggageInputs.style.display === 'none' ? 'block' : 'none';
            }

            function addBaggageInput() {
                var container = document.getElementById("baggageContainer");

                // Tìm số lượng phần tử hiện tại trong container
                var baggageIndex = container.querySelectorAll('.baggage-section').length + 1;



                var baggageHtml =
                        '<div class="baggage-section">' +
                        '<h5>Baggage ' + baggageIndex + '</h5>' + // Hiển thị chỉ số hành lý
                        '<div class="form-group">' +
                        '<label for="weightInput' + baggageIndex + '">Baggage Weight ' + baggageIndex + ':</label>' +
                        '<input type="text" class="form-control" id="weightInput' + baggageIndex + '" name="baggageWeight" step="0.1">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="priceInput' + baggageIndex + '">Baggage Price ' + baggageIndex + ':</label>' +
                        '<input type="text" class="form-control" id="priceInput' + baggageIndex + '" name="baggagePrice" step="0.01">' +
                        '</div>' +
                        '</div>';

                container.insertAdjacentHTML("beforeend", baggageHtml);
            }
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

        </script>
        <script type="importmap">
            {
            "imports": {
            "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
            "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
            }
            }
        </script>
        <script type="module">
            import {
            ClassicEditor,
                    Essentials,
                    Paragraph,
                    Bold,
                    Italic,
                    Font,
                    List
            } from 'ckeditor5';
            document.querySelectorAll('.editor').forEach((editorElement) => {
                ClassicEditor
                        .create(editorElement, {
                            plugins: [Essentials, Paragraph, Bold, Italic, Font, List],
                            toolbar: [
                                'undo', 'redo', '|', 'bold', 'italic', '|',
                                'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor',
                                '|', 'bulletedList', 'numberedList'
                            ]
                        })
                        .then(editor => {
                            console.log('Editor initialized:', editor);
                        })
                        .catch(error => {
                            console.error(error);
                        });
            });
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
            <% if (request.getAttribute("result") != null) { %>
                successful("<%= request.getAttribute("result").toString()%>");
            <% } %>

            });
        </script>

    </body>
</html>

