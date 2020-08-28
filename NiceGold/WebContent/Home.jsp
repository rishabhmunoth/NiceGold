<%@page import="com.nicegold.model.*"%>
<%@ page errorPage="error.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Nice Gold Pvt. Ltd</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body class="mb-5">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

        <%
            User user = new User();
            user = (User) session.getAttribute("user");
            if (user != null) {
        %>
        <%@include file="navbar/nav_user.jsp" %>
        <% } else {
        %>
        <%@include file="navbar/HomeNav.jsp" %>
        <% }
        %>
        <script>
            $("#navhome").addClass("active");
        </script>

        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100 h-50" src="HomeImages/Bangle1.jpg" alt="First slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100 h-50" src="HomeImages/Choker1.png" alt="Second slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100 h-50" src="HomeImages/Necklace1.jpg" alt="Third slide">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <!--Card deck begins-->
        <div class="container mt-3">
            <div class="row">
                <%
                    ArrayList<CardDeck> cards = new ArrayList<>();
                    CardDao dao = new CardDao(ConnectionProvider.getConnection());
                    cards = dao.getCard();
                    if (cards.size()>0 && cards != null) {
                        for (int i = 0; i < cards.size(); i++) {
                            CardDeck card = cards.get(i);
                %>                
                <div class="mt-5 col-xs-10 col-sm-6 col-md-6 h-50 col-lg-4">
                    <div class="card img-fluid img-responsive" >
                        <div class="text-center">
                            <img class="card-img-top img-fluid img-responsive" style="max-height:300px; width:auto;" src="CardImages/<%= card.getCardimg()%>" alt="Card image cap">
                        </div>. 
                        <div class="card-body">
                            <h5 class="card-title"> <%=card.getCategory()%></h5>
                        </div>
                        <div class="card-footer">
                            <p class="card-text"> <%=card.getCardtitle()%></p>
                        </div>
                    </div>
                </div>
                <%}
                    }%>
            </div>
        </div>
        <!--card deck ends-->
    </body>
</html>