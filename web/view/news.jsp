<%-- 
    Document   : news
    Created on : 24 thg 10, 2024, 10:05:02
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.News" %>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="dal.NewsDAO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png"/>
        <link rel="stylesheet" href="css/styleNews.css"/>
        <title>News</title>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <div class="box" >
            <div style="display: ${empty param.id ? '' : 'none'};margin: 130px 0">
                <h1 style="margin-bottom: 20px; text-align: center;">NEWS</h1>
                <div class="news-container">
                    <% 
                        AirlineManageDAO amd = new AirlineManageDAO();
                        List<News> listNew = (List<News>) request.getAttribute("listNew");
                        if (listNew != null) {
                            for (int i = listNew.size() - 1; i >= 0; i--) {
                                News n = listNew.get(i);
                    %>
                    <div class="news-item" onclick="viewNews('<%= n.getId() %>');">
                        <img src="<%= n.getImage() %>" alt="<%= n.getTitle() %>" >

                        <h2 style="height: 25%;"><%= n.getTitle() %></h2>
                        <div class="news-content" style="display: none;">
                            <p><%= n.getContent() %></p>
                        </div>


                        <div   style="margin-top: 9%;margin-left: 3%;">
                            <img src="<%=amd.getImageById(n.getAirline_id())%>" style="width: 12%; height: 100%;">
                            <p style="margin-top: -8%;
                               margin-left: 14%;
                               font-size: 16px;"><%= amd.getNameById(n.getAirline_id()) %></p>
                        </div>

                    </div>
                    <% 
                           }
                       }
                    %>
                </div>
            </div>

            <div id="selected" style="display: ${empty param.id ? 'none' : ''}" class="row">
                <div class="col-md-2"></div>
                <div class="col-md-6" style="margin: 130px 0">
                    <% 
                    NewsDAO nd = new NewsDAO();
                    String newsIdStr = request.getParameter("id");
                    if (newsIdStr != null) {
                        try {
                            int newsId = Integer.parseInt(newsIdStr);
                            News selectedNews = nd.getNewsById(newsId); 
                            if (selectedNews != null) {
                    %>
                    <div class="selected-news">
                        <h1><%= selectedNews.getTitle() %></h1>
                        <img src="<%= selectedNews.getImage() %>" alt="<%= selectedNews.getTitle() %>">
                        <p><%= selectedNews.getContent() %></p>

                    </div>

                    <% 
                        }
                            } catch (NumberFormatException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>

                <div class="col-md-4" style="margin: 130px 0">
                    <div class="news-list">
                        <% 
                            if (listNew != null) {
                                for (int i = listNew.size() - 1; i >= 0; i--) {
                                    News n = listNew.get(i);
                        %>
                        <div class="news-item-small" onclick="viewNews('<%= n.getId() %>');">
                            <img src="<%= n.getImage() %>" alt="<%= n.getTitle() %>">
                            <h2><%= n.getTitle() %></h2>

                        </div>
                        <% 
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script>
            function viewNews(newsId) {
                window.location.href = 'News?id=' + newsId;
            }
        </script>
    </body>
</html>
