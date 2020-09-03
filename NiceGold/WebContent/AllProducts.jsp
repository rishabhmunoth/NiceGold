<%@page import="com.nicegold.model.User"%>
<%@page import="java.io.File"%>
<%@page import="com.nicegold.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>
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
                response.sendRedirect("Home.jsp");
                return;
            }
        %>

        <!--Card deck begins-->
        <div class="container mt-3" id="editcardmaincontainer">
            <div class="row">
                <%
                    ArrayList<Product> products = new ArrayList<>();
                    products = (ArrayList<Product>) session.getAttribute("products");
                    if (products == null) {
                        response.sendRedirect("Home.jsp");
                    } else {
                        for (Product p : products) {
                %>
                <div class="mt-5 col-xs-10 col-sm-6 col-md-6 h-50 col-lg-4">
                    <div class="card img-fluid img-responsive" >
                        <div class="text-center">
                            <img class="card-img-top img-fluid img-responsive" style="max-height:300px; width:auto;" src="Product<%=File.separator + p.getProductsrc() + File.separator + p.getProductid()%>" alt="Card image cap">
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-success" onclick="addtocart(<%=user.getUserid()%>,<%=p.getProductid()%>,<%=p.getProductsrc()%>)" >Add To Cart</button>
                        </div>
                    </div>
                </div>
                <% }
            }%>
            </div>
        </div>
        <!--card deck ends-->
        <script>
        
        </script>
    </body>
</html>
