<%-- 
    Document   : buyingHistory
    Created on : Oct 17, 2024, 5:20:41 PM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.TicketDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.PassengerTypeDAO"%>
<%@page import="dal.PlaneCategoryDAO"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.BaggageManageDAO"%>
<%@page import="dal.FeedbackDao"%>
<%@page import="java.util.List"%>
<%@page import="model.Status"%>
<%@page import="model.Order"%>
<%@page import="model.Flights"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.FlightType"%>
<%@page import="model.PassengerType"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="model.Baggages"%>
<%@page import="model.Feedbacks"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>JSP Page</title>
        <style>
            .star {
                cursor: pointer;
                display: inline-block;
            }

            .star svg {
                width: 20px;
                height: 20px;
                margin-bottom: 5px;
                fill: #000;
                transition: transform 0.2s;
            }

            .selected path {
                fill: #ffb91e;
            }

            .star:hover svg {
                transform: scale(1.2); /* Example of hover effect */
            }

            h1 {
                color: #333;
                font-size: 24px;
                margin-bottom: 10px;
            }

            p {
                color: #666;
                font-size: 16px;
                line-height: 1.6;
            }

            #star-text {
                color: #ffb91e;
                font-weight: bold;
                margin-left: 10px;
            }

            textarea {
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            input[type="submit"] {
                background-color: white;
                color: rgb(71, 143, 192);
                font-size: 16px;
                padding: 10px 20px;
                border: 2px solid rgb(71, 143, 192);
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 20px;
            }

            input[type="submit"]:hover {
                background-color: rgb(71, 143, 192);
                color: white
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div style="margin-top: 120px;margin-bottom: 68.5px" class="container">
            <form method="get" action="evaluateController"> 
                <div class="rating">
                    <h1 style="margin-bottom: 25px;">Service Review</h1>
                    <p>Quality of trip: 
                        <span class="star"  data-value="1">
                            <svg style="margin-bottom: 5px" class="selected" onclick="chooseStar(this)" width="20px" height="20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="white" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                        </span>
                        <span class="star" data-value="2">
                            <svg style="margin-bottom: 5px" class="selected" onclick="chooseStar(this)" width="20px" height="20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="white" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                        </span>
                        <span class="star" data-value="3">
                            <svg style="margin-bottom: 5px" class="selected" onclick="chooseStar(this)" width="20px" height="20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="white" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                        </span>
                        <span class="star" data-value="4">
                            <svg style="margin-bottom: 5px" class="selected" onclick="chooseStar(this)" width="20px" height="20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="white" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                        </span>
                        <span class="star" data-value="5">
                            <svg style="margin-bottom: 5px" class="selected" onclick="chooseStar(this)" width="20px" height="20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="white" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                        </span>
                        <span style="color: #ffb91e" id="star-text">Very good</span>
                    </p>
                </div>  
                <input type="hidden" id="rating-value" name="ratingValue" value="5"/>
                <input type="hidden" name="accountId" value="${sessionScope.id}"/>
                <input type="hidden" name="routeDetailId" value="${requestScope.routeDetailId}"/>
                <textarea id="editor" name="editor" rows="5" cols="10" >${comment}</textarea>
                <input type="submit" value="Submit" style="background-color:green ;color:white"/>

                <%FeedbackDao fd1 = new FeedbackDao();
                Integer orderId = (Integer) session.getAttribute("orderId");
                Integer id = (Integer) session.getAttribute("id");
                  Feedbacks f = fd1.getFeedbakByOrderId(orderId,id);
                  if(f==null){%>
                <input type="hidden" name="action" value="evaluate"/>
                <%}else{%>
                <input type="hidden" name="action" value="update"/>
                <input type="submit" name="action1" value="Delete" style="background-color:red ;color:white"/>
                <%}%>
            </form>
        </div>
        <div class="loader" style=" background-image: url('image/background.png')"></div>
        <script src="https://cdn.ckeditor.com/ckeditor5/12.3.1/classic/ckeditor.js"></script>
        <script>
                                ClassicEditor.create(document.querySelector('#editor')).catch(error => {
                                    console.error(error);
                                });
                                function validateComment() {
                                    const comment = document.getElementById("editor").value.trim();

                                    if (comment.length < 4) {
                                        alert("Content must contain at least 4 characters.");
                                        return false;
                                    }
                                    alert("ok");
                                    return true;
                                }
                                function chooseStar(star) {
                                    const stars = document.querySelectorAll('.star svg');
                                    const ratingValue = parseInt(star.parentElement.getAttribute('data-value'));
                                    const ratingValueInput = document.getElementById('rating-value');
                                    const starText = document.getElementById('star-text');

                                    stars.forEach((s, index) => {
                                        if (index < ratingValue) {
                                            s.classList.add('selected');
                                            s.innerHTML = '<path fill="#ffb91e" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/>';
                                        } else {
                                            s.classList.remove('selected');
                                            s.innerHTML = '<path fill="#ffb91e" d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.7 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/>';

                                        }
                                    });
                                    ratingValueInput.value = ratingValue;
                                    switch (ratingValue) {
                                        case 1:
                                            starText.textContent = "Very Bad";
                                            break;
                                        case 2:
                                            starText.textContent = "Bad";
                                            break;
                                        case 3:
                                            starText.textContent = "Normal";
                                            break;
                                        case 4:
                                            starText.textContent = "Good";
                                            break;
                                        case 5:
                                            starText.textContent = "Very Good";
                                            break;
                                        default:
                                            starText.textContent = "";
                                            break;
                                    }
                                }
        </script>
    </body>
</html>
