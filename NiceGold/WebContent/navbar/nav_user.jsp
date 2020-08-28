<%@page import="com.nicegold.dao.CardDao"%>
<%@page import="com.nicegold.helper.ConnectionProvider"%>
<%@page import="com.nicegold.dao.UserDao"%>
<%@page import="com.nicegold.model.Category"%>
<%@page import="com.nicegold.model.User"%>
<%@page import="com.nicegold.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="error.jsp"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

<!--Navbar starts here--> 

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand mb-0 ml-3 mr-2" href="Home.jsp"><h5>Nice Gold Pvt. Ltd</h5></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item " id="navhome">
                <a class="nav-link ml-3" href="Home.jsp">Home </a>
            </li>
            <li class="nav-item ml-3" id="navcontact">
                <a class="nav-link" href="ContactUs.jsp">Contact Us</a>
            </li>
            <li class="nav-item ml-3 " id="navproduct">
                <a class="nav-link" href="Products.jsp" >Our Products</a>
            </li>
            <%
                user = (User) session.getAttribute("user");
                if (user != null) {
                    String b = (String) user.getUserrole().trim();
                    if (b.equals("ADMIN")) {
            %>
            <div class="mt-1 mb-1 mr-5">
                <div class="btn-group">
                    <button class=" btn text-light " data-toggle="dropdown">Add / Delete </button>
                    <button class="btn text-light dropdown-toggle" data-toggle="dropdown">
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        <a data-toggle="modal" data-target="#modalcategory" class="text-dark btn dropdown-item">Category</a>
                        <a href="AddProducts.jsp" class="text-dark btn dropdown-item">Products</a>
                        <a href="EditCardDeck.jsp" method="get" class="text-dark btn dropdown-item">Home Card</a>
                        <a href="AddProductsCard.jsp" class="text-dark btn dropdown-item">Products Card</a>
                    </ul>
                </div>
            </div>
            <% }
                }
            %>
        </ul> 
        <div class="mt-1 mb-1 mr-5">
            <div class="btn-group">
                <button class=" btn text-light " data-toggle="dropdown">Hello! <%= user.getUsername()%></button>
                <button class="btn text-light dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <a data-toggle="modal" data-target="#modaledit" class="text-dark btn dropdown-item">My Profile</a>
                    <a href="LogoutServlet" method="post" class="text-dark btn dropdown-item">Logout</a>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!--navbar ends here-->

<!--alert-->
<%
    Message msgg = (Message) session.getAttribute("msg");
    if (msgg != null) {
%>
<div class="alert alert-dismissible mb-0 <%= msgg.getCssStyle()%>  fade show" id="successalert" role="alert">
    <strong><div id="resptxt"><%= msgg.getContent()%></div></strong>           
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<%
        session.removeAttribute("msg");
    }
%>
<!--end of alert-->


<!--modal edit category starts here-->
<div class="modal fade " id="modalcategory" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header text-center bg-dark text-light">
                <h3 class="modal-title"> Nice Gold Pvt. Ltd</h3>
                <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="errordivcategory">
                    <%
                        Message msgcategory = (Message) session.getAttribute("msgcategoryedit");
                        if (msgcategory != null) {
                    %>
                    <div class="alert alert-dismissible <%= msgcategory.getCssStyle()%> fade show" id="successalert" role="alert">
                        <strong><div id="resptxt"><%= msgcategory.getContent()%></div></strong>           
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <%
                            session.removeAttribute("msgcategoryedit");
                        }
                    %>
                </div>
                <div class="container text-center">
                    <h3 class="modal-title mt-2 text-center">Edit Category</h3>
                </div>
                <div id="showcategory">
                    <table class="table">
                        <%
                            ArrayList<Category> cats = new ArrayList<Category>();
                            CardDao dao = new CardDao(ConnectionProvider.getConnection());
                            cats = dao.getCategory();
                            if (cats.size() > 0) {
                                for (Category c : cats) {
                        %>
                        <tr>
                            <td> <%= c.getCat()%> </td>
                            <td> <a class="btn btn-danger text-light btn-sm" onclick="delCategory(<%=c.getCatid()%>)">Delete</a> </td>
                        </tr>
                        <% }
                            }%>
                    </table>
                </div>
                <div id="addcategory">
                    <form id="addcategoryform" name="addcategoryform" method="post" action="AddCategory">
                        <div class="form-group">
                            <label for="catname">Add Category </label>
                            <input type="text"class="form-control" name="catname" placeholder="Enter Category">
                        </div>
                        <div class="form-group">
                            <button class="btn btn-success" type="submit">Add Category</button>
                        </div>

                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!--modal edit category ends here-->

<!--modal edit details-->
<div class="modal fade " id="modaledit" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header text-center bg-dark text-light">
                <h3 class="modal-title"> Nice Gold Pvt. Ltd</h3>
                <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="errordivupdatedetails">
                    <%
                        Message msgdetails = (Message) session.getAttribute("msgdetailsalert");
                        if (msgdetails != null) {
                    %>
                    <div class="alert alert-dismissible <%= msgdetails.getCssStyle()%> fade show" id="succesalert" role="alert">
                        <strong><div id="resptxt"><%= msgdetails.getContent()%></div></strong>           
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <%
                            session.removeAttribute("msgdetailsalert");
                        }
                    %>
                </div>
                <div class="container text-center">
                    <h3 class="modal-title mt-2 text-center"><%= user.getFirmname()%></h3>
                </div>
                <div id="editprofile" style="display: none;">
                    <form name="formedit" action="UpdateDetailsServlet" method="post" id="formedit" >
                        <div class="form-group">
                            <label for="username">Name</label>
                            <input type="text" class="form-control" required="true" value="<%= user.getUsername()%>" id="username" name="username" >

                            <label for="firmname"> Company Name</label>
                            <input type="text" class="form-control" required id="firmname" name="firmname" value="<%= user.getFirmname()%>"> 

                            <label for="useremail">Email ID</label>
                            <input type="text" class="form-control" required="true" value="<%= user.getEmailid()%>" pattern="[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$" name="useremail" id="useremail">

                            <label for="mobile">Mobile No</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <div class="input-group-text" id="btnGroupAddon">+91</div>
                                </div>
                                <input type="text" class="form-control" required
                                       pattern="^[789]\d{9}$" name="mobile" value="<%= user.getMobile()%>" disabled id="mobile" />
                            </div>
                            <br>
                            <button type="button" class="btn btn-outline-success" data-dismiss="modal" data-toggle="modal" data-target="#modaleditpassword" id="changepassword">Change Password</button>
                            <button type="submit" class="btn float-right btn-success" id="bttnsaveupdate">Update Details</button>
                        </div>
                    </form>
                </div>
                <div id="showprofile">
                    <table class="table">
                        <tr>
                            <td>Name : </td>
                            <td> <%= user.getUsername()%></td>
                        </tr>
                        <tr>
                            <td>Company Name : </td>
                            <td> <%= user.getFirmname()%></td>
                        </tr>
                        <tr>
                            <td>Email : </td>
                            <td> <%= user.getEmailid()%></td>
                        </tr>
                        <tr>
                            <td>Mobile No : </td>
                            <td> <%= user.getMobile()%></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-secondary" id="bttnback">Edit</button>
            </div>
        </div>
    </div>
</div>
<!--end of modal edit details-->    

<!-------------------Modal change password-------------->

<div class="modal fade" id="modaleditpassword" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header text-center bg-dark text-light">
                <h3 class="modal-title"> Jinal</h3>
                <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="errordivpassword">
                    <%
                        Message msg = (Message) session.getAttribute("msgpassword");
                        if (msg != null) {
                    %>
                    <div class="alert alert-dismissible <%= msg.getCssStyle()%> fade show" id="succes" role="alert">
                        <strong><div id="resptxt"><%= msg.getContent()%></div></strong>           
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <%
                            session.removeAttribute("msgpassword");
                        }
                    %>
                </div>
                <div class="container text-center">
                    <h3 class="modal-title mt-2 text-center"><%= user.getUsername()%></h3>
                </div>
                <form name="formeditpassword" action="ChangePasswordServlet" method="post" id="formeditpassword" >
                    <div class="form-group">
                        <label for="oldpassword">Old Password</label>
                        <input type="password" class="form-control" required="true"  id="oldpassword" name="oldpassword" title="Min 8 Letter, 1 in UpperCase, 1 in LowerCase and Number " pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" >
                        <label for="newpassword">New Password</label>
                        <input type="password" class="form-control" required="true"  name="newpassword" id="newpassword" title="Min 8 Letter, 1 in UpperCase, 1 in LowerCase and Number " pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$">
                        <br>
                        <button type="submit" class="btn btn-success" id="bttnsaveupdatepass">Update Password</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!--modal edit password ends here-->

<script>

    $("#formeditpassword").on('submit', function (event) {
        event.preventDefault();
        $("#formeditpassword").hide();
        var f = $(this).serialize();
        $.ajax({
            url: "ChangePasswordServlet",
            type: 'POST',
            data: f,
            success: function (data, textStatus, jqXHR) {
                if (data.trim() === 'error') {
                    $("#formeditpassword").show();
                    $("#errordivpassword").load(location.href + " #errordivpassword");
                    $('#modaleditpassword').modal(
                            {
                                refresh: true
                            });
                } else {
                    window.location = "Home.jsp";
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $("#formeditpassword").show();
                $("#errordivpassword").load(location.href + " #errordivpassword");
                $('#modaleditpassword').modal(
                        {
                            refresh: true
                        });
            }
        });
    });

    $(document).ready(function () {
        $("#formedit").on('submit', function (event) {
            event.preventDefault();
            $("#formedit").hide();
            var f = $(this).serialize();
            $.ajax({
                url: "UpdateDetailsServlet",
                type: 'POST',
                data: f,
                success: function (data, textStatus, jqXHR) {
                    if (data.trim() === 'error') {
                        $("#formedit").show();
                        $("#errordivupdatedetails").load(location.href + " #errordivupdatedetails");
                        $('#modaledit').modal(
                                {
                                    refresh: true
                                });
                    } else {
                        window.location="Home.jsp";
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#formedit").show();
                    $("#errordivupdatedetails").load(location.href + " #errordivupdatedetails");
                    $('#modaledit').modal(
                            {
                                refresh: true
                            });
                }
            });
        });

    });
    $(document).ready(function () {
        $("#addcategoryform").on('submit', function (event) {
            event.preventDefault();
            $("#addcategoryform").hide();
            var f = $(this).serialize();
            $.ajax({
                url: "AddCategory",
                type: 'POST',
                data: f,
                success: function (data, textStatus, jqXHR) {
                    if (data.trim() === 'error') {
                    	$("#addcategoryform")[0].reset()
                    	refreshCategoryModal();
                        $("#addcategoryform").show();
                    } else {
                    	$("#addcategoryform")[0].reset()
                        refreshCategoryModal();
                        $("#addcategoryform").show();
                  	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    refreshCategoryModal();
                	$("#addcategoryform")[0].reset()
                    $("#addcategoryform").show();
                }
            });
        });

    });
    function refreshCategoryModal()
    {
        $('#modalcategory').modal(
                {
                    refresh: true
                });
        $("#errordivcategory").load(location.href + " #errordivcategory");
        $("#showcategory").load(location.href + " #showcategory");
    }

    function delCategory(id) {
        $.ajax({
            url: "DeleteCategory",
            type: 'POST',
            data: {catid: id},
            success: function (data, textStatus, jqXHR) {
                if (data.trim() === 'error') {
                    refreshCategoryModal();
                } else {
                    refreshCategoryModal();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                refreshCategoryModal();
            }
        });
    };
    
    $(document).ready(function () {
        let editstatus = false;
        $(bttnback).click(function () {
            if (editstatus === false)
            {
                $("#showprofile").hide();
                $("#editprofile").show();
                editstatus = true;
                $(this).text("Back");
            } else
            {
                $("#showprofile").show();
                $("#editprofile").hide();
                editstatus = false;
                $(this).text("Edit");
            }
        });
    });
</script>

