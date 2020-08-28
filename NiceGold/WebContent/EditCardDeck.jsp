
<%@page import="com.nicegold.model.Category"%>
<%@page import="com.nicegold.helper.ConnectionProvider"%>
<%@page import="com.nicegold.dao.CardDao"%>
<%@page import="com.nicegold.model.CardDeck"%>
<%@page import="com.nicegold.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title> Cards</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    </head>
    <body class="mb-5">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("Home.jsp");
                return;
            } else {
                String roleforcardpage = user.getUserrole().trim();
                if (roleforcardpage.equals("ADMIN")) {
        %>
        <%@include file="navbar/nav_user.jsp" %>

        <%      } else {
                    response.sendRedirect("Home.jsp");
                    return;
                }
            } %>


        <!--Card deck begins-->
        <div class="container mt-3" id="editcardmaincontainer">
            <button name="addcardbttn" class="btn  btn-dark text-light btn-block" data-toggle="modal" data-target="#addcardmodal">Add Card</button>

            <div class="row">
                <%
                    ArrayList<CardDeck> cards = new ArrayList<>();
                    CardDao dao = new CardDao(ConnectionProvider.getConnection());
                    cards = dao.getCard();
                    if (cards.size() > 0 && cards != null) {
                        for (int i = 0; i < cards.size(); i++) {
                            CardDeck card = cards.get(i);
                %> 
                <div class="mt-5 col-xs-10 col-sm-6 col-md-6 h-50 col-lg-4">
                    <div class="card img-fluid img-responsive" >
                        <div class="text-center p-3">
                            <img class="card-img-top img-fluid img-responsive" style="max-height:300px; width:auto;" src="CardImages/<%= card.getCardimg()%>" alt="Card image cap">
                        </div>. 
                        <div class="card-body">
                            <h5 class="card-title"><%= card.getCategory()%></h5>
                            <p class="card-text"><%= card.getCardtitle()%></p>
                        </div>
                        <div class="card-footer">
                            <button onclick="deleteCard(<%= card.getCardid()%>)" class="btn btn-danger" method="delete">Delete</button>
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
                        <h3 class="modal-title"> Add Post</h3>
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
                        <form enctype="multipart/form-data" action="CardServlet" method="post" id="formaddcard" name="formaddcard">
                            <div class="form-group">
                                <label for="category"> Category</label>
                                <select class="form-control" required name="category">
                                    <option disabled="true" selected>Select One</option>
                                    <%
                                        ArrayList<Category> list = dao.getCategory();
                                        if (list.size() > 0) {
                                            for (Category listitem : list) {
                                    %>
                                    <option value="<%= listitem.getCat()%>"><%= listitem.getCat()%></option>
                                    <% }
                                        }%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cardtitle">Enter Title</label>
                                <input  class="form-control" required name="cardtitle"  type="text" placeholder="Enter Title" title="Enter Tilte">
                            </div>
                            <div class="form-group">
                                <label for="cardcontent">Enter Content</label>
                                <textarea class="form-control" required rows="3" name="cardcontent" type="text" placeholder="Enter Content" title="Enter Content"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="cardimg">Image</label>
                                <input class="form-control" required name="cardimg" type="file" accept="image/*"  title="Enter Picture">
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
                    url: "DeleteCardServlet",
                    type: 'POST',
                    data: {cardid: id},
                    success: function (data, textStatus, jqXHR) {
                        if (data.trim() === 'error') {
                            $("#editcardmaincontainer").load(location.href + " #editcardmaincontainer");
                        } else {
                            $("#formaddcard").get(0).reset();
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
                        url: "CardServlet",
                        type: 'POST',
                        data: f,
                        success: function (data, textStatus, jqXHR) {
                            $("#formaddcard").show();
                            $("#spinaddpost").hide();
                            if (data.trim() === 'error')
                            {
                                $('#addcardmodal').modal({
                                    refresh: true
                                });
                                $("#errordivpost").load(location.href + " #errordivpost");
                            } else {
                                $('#addcardmodal').modal({
                                    refresh: true
                                });
                                $("#formaddcard").get(0).reset();
                                $("#errordivpost").load(location.href + " #errordivpost");

                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#addcardmodal').modal({
                                refresh: true
                            });
                            $("#errordivpost").load(location.href + " #errordivpost");
                        },
                        contentType: false,
                        processData: false
                    });
                });
            });
        </script>
    </body>
</html>
