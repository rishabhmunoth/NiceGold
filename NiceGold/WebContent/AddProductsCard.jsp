<%@page import="com.nicegold.model.ProductCard"%>
<%@page import="com.nicegold.dao.ProductDao"%>
<%@page import="com.nicegold.model.CardDeck"%>
<%@page import="com.nicegold.helper.ConnectionProvider"%>
<%@page import="com.nicegold.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nicegold.dao.CardDao"%>
<%@page errorPage="error.jsp" %>
<%@page import="com.nicegold.model.Message"%>
<%@page import="com.nicegold.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product Card</title>
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
                String role = user.getUserrole();
                if (role.equals("ADMIN")) {
        %>
        <%@include file="navbar/nav_user.jsp" %>
        <% } else {
                    response.sendRedirect("Home.jsp");
                }
            } else {
                response.sendRedirect("Home.jsp");
            } %>


        <!--Card deck begins-->
        <div class="container mt-3" id="editcardmaincontainer">
            <button name="addcardbttn" class="btn  btn-dark text-light btn-block" data-toggle="modal" data-target="#addcardmodal">Add Product Card</button>
            <div class="row">
                <%
                    ArrayList<Category> cat = new ArrayList<>();
                    CardDao dao = new CardDao(ConnectionProvider.getConnection());
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
                            <button onclick="deleteCard(<%= card.getProductcardid()%>)" class="btn btn-danger" method="delete">Delete</button>
                        </div>
                    </div>
                </div>
                <%      }
                    }%>
            </div>
        </div>
        <!--card deck ends-->

        <!--add card modal begins-->
        <div class="modal fade " id="addcardmodal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header text-center bg-dark text-light">
                        <h3 class="modal-title"> Add Product Card</h3>
                        <button type="button"  class="close text-light" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div id="errordivpost">
                        <%
                            Message msgcard = (Message) session.getAttribute("msgcardmodal");
                            if (msgcard != null) {
                        %>
                        <div class="alert alert-dismissible <%= msgcard.getCssStyle()%> fade show" id="alertmsg" role="alert">
                            <strong><div id="resptxt"><%= msgcard.getContent()%></div></strong>           
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <%
                                session.removeAttribute("msgcardmodal");
                            }
                        %>
                    </div>
                    <div class="modal-body">
                        <div id="spinaddpost" name="spinaddpost" style="display:none;" class="container text-center">
                            <div class="spinner-grow" role="status">
                                <span class="sr-only"></span>
                            </div>
                        </div>
                        <form  enctype="multipart/form-data" action="AddProductCardServlet" method="post" id="formaddcard" name="formaddcard">
                            <div class="form-group">
                                <label for="category"> Category</label>
                                <select class="form-control" required name="category">
                                    <option disabled="true" selected>Select One</option>
                                    <%
                                        ArrayList<Category> list = dao.getCategory();
                                        if (list.size() > 0) {
                                            for (Category listitem : list) {
                                    %>
                                    <option value="<%= listitem.getCatid()%>"><%= listitem.getCat()%></option>
                                    <% }
                                        }%>
                                </select>
                            </div>                            
                            <div class="form-group">
                                <label for="cardcontent">Enter Description</label>
                                <textarea class="form-control" required rows="3" name="carddesc" type="text" placeholder="Enter Content" title="Enter Content"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="cardimg">Image</label>
                                <input class="form-control" required name="img" type="file" accept="image/*"  title="Enter Picture">
                            </div>
                            <button type="submit" class="btn pl-4 pr-4 mt-2 btn-success">Add</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!--add card modal ends-->

        <script>

            function deleteCard(id) {
                $.ajax({
                    url: "DeleteProductCardServlet",
                    type: 'POST',
                    data: {cardid: id},
                    success: function (data, textStatus, jqXHR) {
                        if (data.trim() === 'error') {
                            $("#editcardmaincontainer").load(location.href + " #editcardmaincontainer");
                        } else {
                            $("#editcardmaincontainer").load(location.href + " #editcardmaincontainer");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#editcardmaincontainer").load(location.href + " #editcardmaincontainer");
                    }
                });
            }
            ;

            $(document).ready(function ()
            {
                $("#formaddcard").on('submit', function (event)
                {
                    event.preventDefault();
                    $("#formaddcard").hide();
                    $("#spinaddpost").show();
                    let f = new FormData(this);
                    $.ajax({
                        url: "AddProductCardServlet",
                        type: 'POST',
                        data: f,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === 'error')
                            {
                                addproductcard();
                            } else {
                                $("#formaddcard")[0].reset();
                                addproductcard();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            addproductcard();
                        },
                        contentType: false,
                        processData: false
                    });
                });
            });
            function addproductcard()
            {
                $("#formaddcard").show();
                $("#spinaddpost").hide();
                $('#addcardmodal').modal({
                    refresh: true
                });
                $("#errordivpost").load(location.href + " #errordivpost");
            }
        </script>
    </body>
</html>
