<%@page import="com.nicegold.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Add Products</title>
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
        <%      } else {
                    response.sendRedirect("Home.jsp");
                }
            } else {
                response.sendRedirect("Home.jsp");
            }
        %>

        <!--Add Products Form Starts Here-->

        <div class="container  mt-5">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">

                    <!--delete products modal button starts here-->
                    <button class="btn btn-danger btn-block mb-5" id="btndeleteproducts" name="btndeleteproducts" data-toggle="modal" data-target="#modaldeleteproducts">Delete Products</button>
                    <!--delete products modal button ends here-->

                    <form enctype="multipart/form-data" method="post" action="AddProductsServlet" id="addproducts" name="addproducts">
                        <div class="form-group">
                            <label for="category">Select Category</label>
                            <select class="form-control" required id="categoryselect" name="categoryselect">
                                <option disabled="true" selected>Select One</option>
                                <%
                                    CardDao dao = new CardDao(ConnectionProvider.getConnection());
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
                            <label for="usercategory">User Category</label>
                            <select class="form-control" required id="usercat" name="usercat">
                                <option value="GOLD" selected>Gold User</option>
                                <option value="PLATINIUM">Platinum User</option>
                            </select>
                        </div>
                        <div class="form-group mt-3">
                            <label for="files"></label>
                            <input name="file" id="file" class="form-control" type="file" multiple accept="image/*" required>
                        </div>
                        <button type="submit" class="mt-3 btn btn-success"> Submit</button>
                        <button type="reset" class="mt-3 ml-4 btn btn-danger">Reset</button>
                    </form>
                </div>
            </div>
        </div>


        <!--Add Products ends here-->

        <!--modal delete products starts here-->

        <div class="modal fade" id="modaldeleteproducts" tabindex="-1" role="dialog" aria-labelledby="modaldeleteproducts" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Delete Products</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="errorproductdelete">
                            <%
                                Message msgproduct = (Message) session.getAttribute("msgproductdelete");
                                if (msgproduct != null) {
                            %>
                            <div class="alert alert-dismissible <%= msgproduct.getCssStyle()%> fade show" id="alertmsg" role="alert">
                                <strong><div id="resptxt"><%= msgproduct.getContent()%></div></strong>           
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <%
                                    session.removeAttribute("msgproductdelete");
                                }
                            %>
                        </div>
                        <div id="spinaddproduct" name="spinaddproduct" style="display:none;" class="container text-center">
                            <div class="spinner-grow" role="status">
                                <span class="sr-only"></span>
                            </div>
                        </div>
                        <form method="post" action="DeleteProductServlet" name="formdeleteproduct" id="formdeleteproduct">
                            <div class="form-group">
                                <label for="category"> Category</label>
                                <select class="form-control" required id="category" name="category">
                                    <option disabled="true" selected>Select One</option>
                                    <%
                                        if (list.size() > 0) {
                                            for (Category listitem : list) {
                                    %>
                                    <option value="<%= listitem.getCatid()%>"><%= listitem.getCat()%></option>
                                    <% }
                                        }%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="productid">Product Id</label>
                                <input type="text" class="form-control" required name="productid" id="productid">
                            </div>
                            <button class="btn btn-danger" type="submit">Delete</button>
                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!--modal products ends here-->

        <script>

            $(document).ready(function ()
            {
                $("#formdeleteproduct").on('submit', function (event)
                {
                    event.preventDefault();
                    $("#formdeleteproduct").hide();
                    $("#spinaddproduct").show();
                    var f = $(this).serialize();
                    $.ajax({
                        url: "DeleteProductServlet",
                        type: 'POST',
                        data: f,
                        success: function (data, textStatus, jqXHR) {
                            $("#formdeleteproduct").show();
                            $("#spinaddproduct").hide();
                            if (data.trim() === 'error')
                            {
                                deleteProduct();
                            } else {
                                deleteProduct();
                                $("#formdeleteproduct")[0].reset();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            deleteProduct();
                        }
                    });
                });
            });
            function deleteProduct() {
                $('#modaldeleteproducts').modal({
                    refresh: true
                });
                $("#errorproductdelete").load(location.href + " #errorproductdelete");
            }

        </script>
    </body>
</html>
