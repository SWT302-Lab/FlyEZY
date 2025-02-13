<%-- 
    Document   : seatCategoryController
    Created on : Oct 16, 2024, 10:13:39 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.PlaneCategoryDAO"%>
<%@page import="dal.StatusDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <%
            PlaneCategoryDAO pcd = new PlaneCategoryDAO();
            Integer planeCategoryId = null;
            String planeCategoryIdParam = request.getParameter("planeCategoryId");
            if (planeCategoryIdParam != null) {
                planeCategoryId = Integer.parseInt(planeCategoryIdParam);
            } else {
                Object planeCategoryIdAttr = request.getAttribute("planeCategoryId");
                if (planeCategoryIdAttr != null) {
                    planeCategoryId = Integer.parseInt(planeCategoryIdAttr.toString());
                }
            }
        PlaneCategory pc = pcd.getPlaneCategoryById(planeCategoryId);   
        %>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="main-content">
            <div id="back" > 
                <a href="planeCategoryController" class="btn btn-warning" >Back</a>
            </div>
            <div style="margin-bottom: 30px; color:#3C6E57 "><h2>SEAT CATEGORY MANAGEMENT: ${requestScope.planeCatName}</h2></div>
            <div>
                <a class="btn btn-success" style="text-decoration: none; margin-bottom: 20px" onclick="openModalInsertSeatCategory(<%= pc.getId() %>)">Add new seat category</a>
            </div>
            <!-- Modal for inserting seat category -->
            <div class="modal fade" id="myModalInsertSeatCategory<%= pc.getId() %>" role="dialog">
                <div class="modal-dialog" >
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header" style="padding:5px 5px;">
                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                            <h4 style="float:left;margin-left: 12px">Add New Seat Category</h4>
                        </div>
                        <div class="modal-body" style="padding:40px 50px;">
                            <form role="form" action="seatCategoryController" method="post" onsubmit="return validateNameAndInfoInput(0)">
                                <div class="row">
                                    <input type="hidden" value="<%= pc.getId() %>" name="planeCategoryId"/>
                                    <input type="hidden" value="1" name="status"/>
                                    <div class="form-group col-md-2">
                                        <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                        <input type="text" class="form-control" name="id" readonly>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                        <input type="file" class="form-control" name="image" onchange="displayImage1(this)">
                                    </div>
                                    <div class="col-md-6">
                                        <img id="previewImage1" src="#" alt="Preview" style="width: 100%">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                    <input pattern="^[\p{L}\d\s]+$" id="name0" type="text" class="form-control" name="name" required/>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                    <input type="number" class="form-control" name="numberOfSeat" min="0" max="300" required>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-picture"></span>Seat each row:</label>
                                    <input type="number" class="form-control" name="seatEachRow" min="1" max="9" required>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-picture"></span>Surcharge:</label>
                                    <input step="0.01" type="number" class="form-control" name="surcharge" required min="0" max="1">
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
            <!-- DuongNT: Seat category dashboard -->
            <div>
                <table class="entity">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Number Of Seat</th>
                            <th>Seat Each Row</th>
                            <th>Surcharge</th>
                            <th>Info</th>
                            <th>Status</th>
                            <th style="padding: 0 55px; min-width: 156px">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        SeatCategoryDAO scd = new SeatCategoryDAO();
                        StatusDAO sdao = new StatusDAO();
                        List<SeatCategory> seatCategoryList = scd.getAllSeatCategoryByPlaneCategoryId(pc.getId());
                        for (SeatCategory sc : seatCategoryList) {
                        %>
                        <tr>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getName() %></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><img src="<%= sc.getImage() %>" alt="<%= sc.getName() %>"></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getNumberOfSeat() %></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getSeatEachRow() %></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getSurcharge() %></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><div style="max-height:  100px; text-align: left; overflow-y: scroll; padding-left: 20px;"><%= sc.getInfo() %></div></td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>">
                                <a class="btn <%=(sc.getStatusId() == 1) ? "btn-success" : "btn-danger"%>" 
                                   style="text-decoration: none; width: 100px; margin: 0" 
                                   <% if (pc.getStatusId() == 1) { %> 
                                   onclick="changeSeatCategoryStatus('<%= sc.getId() %>', '<%= sc.getName() %>', '<%= sc.getStatusId() %>')" 
                                   <% } %>
                                   >
                                    <%= (sc.getStatusId() == 1) ? "Activated" : "Deactivated" %>
                                </a>
                            </td>
                            <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>">
                                <a class="btn btn-info" style="text-decoration: none" onclick="openModalSeatCategory('<%= sc.getId() %>')">Update</a>
                            </td>
                        </tr>
                        <!-- Modal for updating seat category -->
                    <div class="modal fade" id="myModalSeatCategory<%= sc.getId() %>" role="dialog">
                        <div class="modal-dialog" >
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header" style="padding:5px 5px;">
                                    <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                    <h4 style="margin-left: 12px">Update</h4>
                                </div>
                                <div class="modal-body" style="padding:40px 50px;">
                                    <form role="form" action="seatCategoryController" method="post" onsubmit="return validateNameAndInfoInput(<%= sc.getId() %>)">
                                        <div class="row">
                                            <input type="hidden" value="<%= sc.getPlane_Categoryid() %>" name="planeCategoryId"/>
                                            <input type="hidden" value="<%= sc.getStatusId() %>" name="status"/>

                                            <div class="form-group col-md-2">
                                                <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                <input type="text" class="form-control" name="id" value="<%= sc.getId() %>" readonly>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                <input type="file" class="form-control" name="image" onchange="displayImage3(this,<%= sc.getId() %>)">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <img id="hideImage1<%= sc.getId() %>" src="<%= sc.getImage() %>" alt="Image" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                <img id="preImage3<%= sc.getId() %>" src="#" alt="Preview" style="display: none; width: 100px; height: 100px; float: right;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                            <input pattern="^[\p{L}\d\s]+$" id="name<%= sc.getId() %>" type="text" class="form-control" name="name" value="<%= sc.getName() %>" required/>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                            <input type="number" class="form-control" name="numberOfSeat" value="<%= sc.getNumberOfSeat() %>" min="0" max="300" required/>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-picture"></span>Seat each row:</label>
                                            <input type="number" class="form-control" name="seatEachRow" value="<%= sc.getSeatEachRow() %>" min="1" max="9" required>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-picture"></span>Surcharge:</label>
                                            <input type="number" step="0.01" class="form-control" name="surcharge" value="<%= sc.getSurcharge() %>" required  min="0" max="1"/>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                            <div class="editor-container">
                                                <textarea pattern="^[\p{L}\d\s]+$" id="info<%= sc.getId() %>" type="text" class="editor" name="info" ><%= sc.getInfo() %></textarea>
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
                    <!-- Modal change status seat category -->
                    <div class="modal fade" id="changeSeatCategoryStatusModal<%= sc.getId() %>" tabindex="-1" aria-labelledby="deleteSeatCategoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteSeatCategoryModalLabel">Confirm <span id="status3<%= sc.getId() %>"></span> seat category</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="seatCategoryController" method="post">
                                    <input type="hidden" name="action" value="changeStatus"/>
                                    <input type="hidden" value="<%= sc.getPlane_Categoryid() %>" name="planeCategoryId"/>
                                    <input type="hidden" name="seatCategoryid" value="<%= sc.getId() %>"/>
                                    <div class="modal-body">
                                        Do you want to <span style="font-weight: bold" id="status4<%= sc.getId() %>"></span><span id="seatCategoryName<%= sc.getId() %>"></span>?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-danger" id="confirmChangeSeatCategoryStatus">Confirm</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%
                    }
                    %>
                    </tbody>
                </table>

            </div>
        </div>
    </body>
    <script>
        function openModalSeatCategory(id) {
            $("#myModalSeatCategory" + id).modal('show');
        }
        ;
        function validateNameAndInfoInput(i) {
                const name = document.getElementById("name" + i).value.trim();
                const info = document.getElementById("info" + i).value.trim();

                if (name === "" || info === "") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }

        // func change seat category status
        let changeSeatCategoryStatusUrl = "";
        function changeSeatCategoryStatus(id, name, status) {
            document.getElementById('seatCategoryName' + id).textContent = name;
            let statusText = (status === "1") ? "deactivate" : "activate";
            console.log(statusText);
            document.getElementById('status3' + id).textContent = statusText;
            document.getElementById('status4' + id).textContent = statusText;

            $('#changeSeatCategoryStatusModal' + id).modal('show');
        }


        function openModalInsertSeatCategory(id) {
            $("#myModalInsertSeatCategory" + id).modal('show');
        }

        function displayImage1(input) {
            var previewImage = document.getElementById("previewImage1");
            var file = input.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                previewImage.src = e.target.result;
                previewImage.style.display = "block";
            };

            reader.readAsDataURL(file);
        }
        function displayImage3(input, id) {
            var i = id;
            var hideImage = document.getElementById(`hideImage1` + i);
            var previewImage2 = document.getElementById(`preImage3` + i);
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
</html>
