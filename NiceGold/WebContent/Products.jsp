<%@page import="com.nicegold.model.ProductCard"%>
<%@page import="com.nicegold.dao.ProductDao"%>
<%@page import="com.nicegold.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Our Products</title>
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
            if (user == null) {
                response.sendRedirect("Home.jsp");
            } else {
        %>
        <%@include file="navbar/nav_user.jsp" %>
        <% }%>

        <script>
            $("#navproduct").addClass("active");
        </script>

        <!--Card deck begins-->
        <div class="container mt-3" id="editcardmaincontainer">
            <div class="row">
                <%
                    ArrayList<Category> cat = new ArrayList<>();
                    ProductDao pdao = new ProductDao(ConnectionProvider.getConnection());
                    ArrayList<ProductCard> cards = new ArrayList<>();
                    cards = pdao.getAllProductCard();
                    if (cards.size() > 0 && cards != null) {
                        for (int i = 0; i < cards.size(); i++) {
                            ProductCard card = cards.get(i);
                %> 
                <div class="mt-5 col-xs-10 col-sm-6 col-md-6 h-50 col-lg-4">
                    <div class="card img-fluid img-responsive" >
                        <div class="text-center">
                            <img class="card-img-top img-fluid img-responsive" style="max-height:300px; width:auto;" src="ProductCard/<%=card.getProductsrc()%>" alt="Card image cap">
                        </div>. 
                        <div class="card-body">
                            <h5 class="card-title"><%= card.getProductdesc()%></h5>
                        </div>
                        <div class="card-footer">
                            <button onclick="seeAllInCat(<%=card.getCatid()%>)" class="btn btn-success" method="delete">See All</button>
                        </div>
                    </div>
                </div>
                <%      }
                    }%>
            </div>
        </div>
        <script>
            function seeAllInCat(id) {
                $.ajax({
                    url: "SeeAllPostServlet",
                    type: 'POST',
                    data: {catid: id},
                    success: function (data, textStatus, jqXHR) {
                      window.location="AllProducts.jsp" 
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                       window.location="Home.jsp" 
                    }
                });
            }
        </script>
    </body>
</html>
