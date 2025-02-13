<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.NewsCategoryDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="model.NewCategory"%>
<%@page import="model.News"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png"/>
        <link rel="stylesheet" href="css/styleAdminController.css">
        <script src="js/validation.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
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
            #main-content{
                margin: 2vh 0vw 10vh 11vw!important;
            }
        </style>
    </head>


    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>



        <div id="main-content"  margin: 0">

            <div class="filterController col-md-12" style="margin-left: 45px;margin-top: 4%;"  >
                <div style="margin-bottom: 35px; color:#3C6E57 "><h2>NEWS MANAGEMENT</h2></div>
                <form action="newsManagement" method="get" style="margin-bottom: 20px">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#News" style="flex-shrink: 0; margin-right: 20px">
                        Add News
                    </button>
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="airlineId" value="${requestScope.account.getAirlineId()}">
                    <strong class="filterElm">News Category</strong>
                    <select class="filterElm" name="newsCategory">
                        <option value=""  ${param.newsCategory == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${newC}" var="nc"> 
                            <option value="${nc.getId()}" ${param.newsCategory != null && (param.newsCategory == nc.getId()) ? 'selected' : ''}> ${nc.getName()}</option>"
                        </c:forEach>
                    </select>
                    <strong>Title </strong>
                    <input class="filterElm" type="text" name="title" value="${param.title}" placeholder="Enter title">
                    <button class="btn btn-info" type="submit">
                        Search

                    </button>
                    <a class="btn btn-danger" href="newsManagement">Cancel</a>
                </form>
            </div>




            <!-- modal add new -->
            <div class="modal fade" id="News" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true" >
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBookModalLabel">Add </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addNews" action="newsManagement" method="POST" onsubmit="return validateNameInput()" >
                                <input type="hidden" name="action" value="create">
                                <input type="hidden" name="accountId" value="${requestScope.account.getId()}">
                                <input type="hidden" name="airlineId" value="${requestScope.account.getAirlineId()}">

                                <!--Title -->
                                <div class="form-group">
                                    <label for="nameInput"><span class="glyphicon glyphicon-plane"></span> Title:</label>
                                    <input type="text" class="form-control" id="nameInput" name="Title" required>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="image" class="control-label">Image</label>
                                        <input type="file" name="image" onchange="displayImage(this)"class="form-control" >
                                    </div>
                                    <div class="form-group col-md-6" >
                                        <img  id="previewImage" src="#" alt="Preview"style="display: none; max-width: 130px; float: left; margin-left: 115px;">
                                    </div>          
                                </div>


                                <div class="row">
                                    <!-- News Category -->
                                    <div class="form-group col-md-6">
                                        <label for="category"><span class="glyphicon glyphicon-knight"></span> News Category</label>
                                        <select class="form-control" name="category" id="category">
                                            <c:forEach items="${newC}" var="nc">
                                                <option value="${nc.getId()}">${nc.getName()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Author -->
                                    <div class="form-group col-md-6">
                                        <label for="author"><span class="glyphicon glyphicon-user"></span> Author:</label>
                                        <input type="text" class="form-control" id="author" value="${requestScope.account.getName()}" readonly>
                                    </div>
                                </div>

                                <!-- Content-->
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-info-sign"></span> Content:</label>
                                    <div class="editor-container">
                                        <textarea class="editor" id="news-content" name="Content" ></textarea>
                                    </div>
                                </div>  
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" form="addNews">Add</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>


            <h4 style="color : red"></h4>
            <div class="row" style="margin: 0">

                <div class="col-md-10" id="left-column" style="margin-left: 44px;">
                    <table class="entity">
                        <thead>
                            <tr>
                                <th style="width: 138px;">Title</th>
                                <th style="width: 166px;">Image</th>
                                <th style="width: 457px;">Content</th>
                                <th style="width: 127px;">News Category</th>
                                <th style="width: 131px;">Author</th>
                                <th style="width: 18%">Actions</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                         NewsCategoryDAO nc = new NewsCategoryDAO();
                         AccountsDAO ad = new AccountsDAO();
                         List<News> newList = (List<News>) request.getAttribute("lnew");
                            for (News list : newList) {
                            %>
                            <tr>
                                <td><%= list.getTitle() %></td>
                                <td>
                                    <img src="<%= list.getImage() %>" alt="Image" style="max-width:100px; max-height:100px;">
                                </td>
                                <td>
                                    <div style="max-height: 100px;
                                         text-align: left;
                                         padding-left: 20px;
                                         overflow-y: scroll;">
                                        <%= list.getContent() %>
                                    </div>
                                </td>
                                <td><%= nc.getNameNewsCategoryById(list.getNewCategory()) %></td>
                                <td><%=ad.getAccountNameById(list.getAccountId())%></td>

                                <td>
                                    <!-- delete modal -->
                                    <button class="btn btn-info" data-toggle="modal" data-target="#update-news-<%= list.getId() %>">Update</button>
                                    <input type="hidden" value="<%= list.getId() %>" name="id">
                                    <a class="btn btn-danger" onclick="doDelete('<%= list.getId() %>')">Delete</a>

                                    <!-- update -->
                                    <div class="modal fade" id="update-news-<%= list.getId() %>" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" style="text-align: left;">Update News</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form  action="newsManagement" method="POST" onsubmit="return validateNameInputForUpdate(<%= list.getId() %>)">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="accountId" value="${requestScope.account.getId()}">
                                                        <input type="hidden" name="airlineId" value="${requestScope.account.getAirlineId()}">
                                                        <input type="hidden" name="id" value="<%= list.getId() %>">

                                                        <div class="form-group">
                                                            <label for="nameInput"><span class="glyphicon glyphicon-plane"></span> Title:</label>
                                                            <input type="text" class="form-control" id="nameInput<%= list.getId() %>" name="title"  value="<%= list.getTitle() %>" required>
                                                        </div>

                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <label for="image<%= list.getId() %>" class="control-label">Image</label>
                                                                <input type="file" name="image" onchange="displayImage2(this,<%= list.getId() %>)"  value="<%= list.getImage() %>" class="form-control"
                                                                       style="padding:5px;" >
                                                            </div>
                                                            <div class="form-group col-md-6" >
                                                                <img id="hideImage<%= list.getId() %>" src="<%= list.getImage() %>" style="float: right" width="50%" height="50%"/>
                                                                <img id="preImage2<%= list.getId() %>" style="display: none;float: right" src="#"  width="50%" height="50%">
                                                            </div>      
                                                        </div>

                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>News Category</label></div>
                                                                <select name="category" style="height:  34px;width: 100%;">
                                                                    <%     List<NewCategory> listCategory = (List<NewCategory>)request.getAttribute("newC");
                                                                    for(NewCategory category : listCategory){%>
                                                                    <option value="<%=category.getId()%>" <%= (list.getNewCategory()== category.getId()) ? "selected" : "" %>><%=category.getName()%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Author: </label></div>
                                                                <input type="text" value="${requestScope.account.getName()}" class="form-control"  required="">
                                                            </div>
                                                        </div>


                                                        <div class="form-group">
                                                            <label><span class="glyphicon glyphicon-info-sign"></span> Content:</label>
                                                            <div class="editor-container">
                                                                <textarea class="editor" name="content" id="news-content<%= list.getId() %>"  maxlength="500"><%= list.getContent() %> </textarea>
                                                            </div>
                                                        </div>  

                                                </div>
                                                <div class="modal-footer" >
                                                    <button type="submit" class="btn btn-primary" >Update</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script type="importmap">
            {
            "imports": {
            "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
            "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
            }
            }
        </script>
        <script>
            function doDelete(id) {
                if (confirm("Bạn có muốn xoá bài viết này? ")) {

                    var form = document.createElement("form");
                    form.method = "POST";
                    form.action = "newsManagement";


                    var actionInput = document.createElement("input");
                    actionInput.type = "hidden";
                    actionInput.name = "action";
                    actionInput.value = "delete";
                    form.appendChild(actionInput);


                    var idInput = document.createElement("input");
                    idInput.type = "hidden";
                    idInput.name = "id";
                    idInput.value = id;
                    form.appendChild(idInput);

                    // Append the form to the body and submit
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function validateNameInput() {
                const nameInput = document.getElementById("nameInput").value.trim();
                const newsContent = document.getElementById("news-content").value.trim();

                if (nameInput === "" || newsContent==="") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
            }
            
            function validateNameInputForUpdate(i) {
                const nameInput = document.getElementById("nameInput"+i).value.trim();
                const newsContent = document.getElementById("news-content"+i).value.trim();

                if (nameInput === "" || newsContent==="") {
                    alert("Please enter valid content. Do not enter spaces only.");
                    return false;
                }
                return true;
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
        <script type="module">
            import {
            ClassicEditor,
                    Essentials,
                    Paragraph,
                    Bold,
                    Italic,
                    Font,
                    List,
                    Link,
                    Image,
                    ImageToolbar,
                    ImageCaption,
                    ImageStyle,
                    ImageUpload,
                    BlockQuote,
                    Alignment
            } from 'ckeditor5';

            document.querySelectorAll('.editor').forEach((editorElement) => {
                ClassicEditor
                        .create(editorElement, {
                            plugins: [
                                Essentials,
                                Paragraph,
                                Bold,
                                Italic,
                                Font,
                                List,
                                Link,
                                Image,
                                ImageToolbar,
                                ImageCaption,
                                ImageStyle,
                                ImageUpload,
                                BlockQuote,
                                Alignment
                            ],
                            toolbar: [
                                'undo', 'redo', '|',
                                'bold', 'italic', '|',
                                'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor',
                                '|', 'bulletedList', 'numberedList', '|',
                                'link', 'imageUpload', 'blockQuote', '|',
                                'alignment:left', 'alignment:center', 'alignment:right', 'alignment:justify'
                            ],

                        })
                        .then(editor => {
                        })
                        .catch(error => {
                            console.error('CKEditor initialization error:', error);
                        });
            });
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


    </body>
</html>