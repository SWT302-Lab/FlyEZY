<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plan Category Management</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
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

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="main-content">
            <div style="margin-bottom: 30px; color:#3C6E57 "><h2>PLANE CATEGORY MANAGEMENT</h2></div>
            <!-- DuongNT: Filter category of plane -->
            <div class="filterController" style="width: 100%">
                <form action="planeCategoryController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <strong class="filterElm">Status:</strong>
                    <select class="filterElm" name="fStatus">
                        <option value="" ${param.fStatus == null ? 'selected' : ''}>All</option>
                        <option value="1" ${param.fStatus != null && (param.fStatus==1) ? 'selected' : ''}>Activated</option>
                        <option value="2" ${param.fStatus != null && (param.fStatus==2) ? 'selected' : ''}>Deactivated</option>
                    </select>
                    <strong>Name: </strong>
                    <input pattern="^[\p{L}\d\s]+$" class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <button class="btn btn-info" type="submit" >
                        Search
                    </button>
                    <a class="btn btn-danger" href="planeCategoryController">Cancle</a>
                </form>
            </div>

            <div>
                <a class="btn btn-success" style="text-decoration: none; margin-bottom: 20px" onclick="openModal(0)">Add New Plane Category</a>
            </div>
            <!-- Modal for inserting new plane category -->
            <div class="modal fade" id="myModal0" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header" style="padding:5px 5px;">
                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                            <h4 style="margin-left: 12px">Add New Plane Category</h4>
                        </div>
                        <div class="modal-body" style="padding:40px 50px;">
                            <form role="form" action="planeCategoryController" method="post" onsubmit="return validateNameAndInfoInput(0)">
                                <div class="row">
                                    <input type="hidden" value="${account.getAirlineId()}" name="airlineId"/>
                                    <input type="hidden" class="form-control" name="status" value="1"/>
                                    <div class="form-group col-md-6">
                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                        <input type="file" class="form-control" name="image" onchange="displayImage(this)">
                                    </div>
                                    <div class="col-md-6">
                                        <img  id="previewImage" src="#" alt="Preview"
                                              style="display: none;  width: 100%; height: 100%; float: right;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                    <input pattern="^[\p{L}\d\s]+$" id="name0" type="text" class="form-control" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                    <div class="editor-container">
                                        <textarea pattern="^[\p{L}\d\s]+$" id="info0" class="editor" name="info"></textarea>
                                    </div>
                                </div>  
                                <button type="submit" class="btn btn-success btn-block">
                                    Confirm
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- DuongNT: Plane category dashboard -->
            <table class="entity" style="width: 96%">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Information</th>
                        <th>Status</th>
                        <th style="padding: 0 55px; min-width: 380px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    SeatCategoryDAO scd = new SeatCategoryDAO();
                    StatusDAO sd = new StatusDAO();
                    AirlineManageDAO ad = new AirlineManageDAO();
                    List<PlaneCategory> planeCategoryList = (List<PlaneCategory>) request.getAttribute("planeCategoryList");
                    for (PlaneCategory pc : planeCategoryList) {
                    %>
                    <tr>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><%= pc.getName() %></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><img style="width: 100%" src="<%= pc.getImage() %>" alt="<%= pc.getName() %>"></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><div style="max-height:  100px; text-align: left;padding-left: 20px; overflow-y: scroll;"><%= pc.getInfo() %></div></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>">
                            <a class="btn <%= (pc.getStatusId() == 1) ? "btn-success" : "btn-danger" %>" style="text-decoration: none; width: 100px;margin: 0"
                               <% if (ad.getStatusById(pc.getAirlineid()) == 1) { %> 
                               onclick="changePlaneCategoryStatus('<%= pc.getId() %>', '<%= pc.getName() %>', '<%= pc.getStatusId() %>')">
                                <% } %>

                                <%= (pc.getStatusId() == 1) ? "Activated" : "Deactivated" %>
                            </a>
                        </td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>">
                            <a class="btn btn-info" style="text-decoration: none" onclick="openModal(<%= pc.getId() %>)">Update</a>

                            <a class="btn btn-warning" style="text-decoration: none" href="seatCategoryController?planeCategoryId=<%= pc.getId() %>" >Seat Category Setting
                                <span id="arrow<%= pc.getId() %>" style="margin-left: 8px" class="glyphicon glyphicon-menu-right"></span>
                            </a>
                        </td>
                    </tr>

                    <!-- Modal for updating plane category -->
                <div class="modal fade" id="myModal<%= pc.getId() %>" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header" style="padding:5px 5px;">
                                <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                <h4 style="margin-left: 12px">Update</h4>
                            </div>
                            <div class="modal-body" style="padding:40px 50px;">
                                <form role="form" action="planeCategoryController" method="post" onsubmit="return validateNameAndInfoInput(<%= pc.getId() %>)">
                                    <div class="row">
                                        <input type="hidden" value="<%= pc.getAirlineid() %>" name="airlineId"/>
                                        <input type="hidden" class="form-control" name="status" value="<%= pc.getStatusId() %>"/>
                                        <div class="form-group col-md-2">
                                            <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                            <input type="text" class="form-control" name="id" value="<%= pc.getId() %>" readonly>
                                        </div>
                                        <div class="form-group col-md-7">
                                            <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                            <input type="file" class="form-control" name="image" onchange="displayImage2(this,<%= pc.getId() %>)">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <img id="hideImage<%= pc.getId() %>" src="<%= pc.getImage() %>" alt="Avatar" class="img-thumbnail" style="height: 100%; float: right;">
                                        <img id="preImage2<%= pc.getId() %>" src="#" alt="Preview" style="display: none; width: 100%">
                                    </div>
                                    <div class="form-group">
                                        <label><span class="glyphicon glyphicon-picture"></span>Name:</label>
                                        <input pattern="^[\p{L}\d\s]+$" id="name<%= pc.getId() %>" type="text" class="form-control" name="name" value="<%= pc.getName() %>" required/>
                                    </div>
                                    <div class="form-group">
                                        <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                        <div class="editor-container">
                                            <textarea pattern="^[\p{L}\d\s]+$" id="info<%= pc.getId() %>" type="text" class="editor" name="info"><%= pc.getInfo() %></textarea>
                                        </div>

                                    </div>  
                                    <button type="submit" class="btn btn-success btn-block">
                                        Confirm
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
        <!-- Modal change status plane category -->
        <div class="modal fade" id="changePlaneCategoryStatusModal" tabindex="-1" aria-labelledby="changePlaneCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePlaneCategoryModalLabel">Confirm <span id="status1"></span> plane category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Do you want to <span style="font-weight: bold" id="status2"></span><span id="planeCategoryName"></span>?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="confirmChangeStatusPlaneCategory">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }

            $(document).ready(function () {
            <% if (request.getAttribute("result") != null) { %>
                successful("<%= request.getAttribute("result").toString()%>");
            <% } %>

            });

            function validateNameAndInfoInput(i) {
                const name = document.getElementById("name" + i).value.trim();

                if (name === "") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }

            //func change plane category status
            let changePlaneCategoryStatusUrl = "";
            function changePlaneCategoryStatus(id, name, status) {
                // Cập nhật tên loại máy bay trong modal
                document.getElementById('planeCategoryName').textContent = name;
                let statusText = (status === "1") ? "deactivate" : "activate";
                document.getElementById('status1').textContent = statusText;
                document.getElementById('status2').textContent = statusText;

                changePlaneCategoryStatusUrl = "planeCategoryController?action=changeStatus&id=" + id;

                $('#changePlaneCategoryStatusModal').modal('show');
            }
            document.getElementById('confirmChangeStatusPlaneCategory').onclick = function () {
                window.location = changePlaneCategoryStatusUrl;
            };



            window.onload = function () {
                if (window.location.protocol === 'file:') {
                    alert('This sample requires an HTTP server. Please serve this file with a web server.');
                }
            };
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
    </body>
</html>