<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.nicegold.model.Message"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>-->
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>-->
<script>
	$(document).ready(function() {
		$("#form1").on('submit', function(event) {
			event.preventDefault();
			$("#form1").hide();
			$("#spinregister").show();
			var f = $(this).serialize();
			$.ajax({
				url : "RegisterServlet",
				type : 'POST',
				data : f,
				success : function(data, textStatus, jqXHR) {
					$("#spinregister").hide();

					$('#staticRegister').modal({
						refresh : true
					});
					$("#errordivreg").load(location.href + " #errordivreg");
					if (data.trim() === 'error') {
						$("#form1").show();

					} else {
						$("#bothformdiv").load(location.href + " #bothformdiv");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$("#form1").show();
					$("#spinregister").hide();
				}
			});
		});
		$("#form2").on('submit', function(event) {
			event.preventDefault();
			$("#form2").hide();
			$("#spinlogin").show();
			var f = $(this).serialize();
			$.ajax({
				url : "LoginServlet",
				type : 'POST',
				data : f,
				success : function(data, textStatus, jqXHR) {
					if ($.trim(data) === 'error') {
						$('#staticLogin').modal({
							refresh : true
						});
						$("#errordivlogin").load(location.href + " #errordivlogin");
						$("#form2").show();
						$("#spinlogin").hide();
					} else {
						window.location = "Home.jsp"
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$("#form2").show();
					$("#spinlogin").hide();
				}
			});
		});
		$("#formotp").submit(function(event) {
			event.preventDefault();
			$("#formotp").hide();
			$("#spinregister").show();
			var f = $(this).serialize();
			$.ajax({
				url : "OtpRegistrationSrevlet",
				type : 'POST',
				data : f,
				success : function(data, textStatus, jqXHR) {
					$("#spinregister").hide();
					$('#staticRegister').modal({
						refresh : true
					});
					$("#errordivreg").load(location.href + " #errordivreg");
					if (data.trim() === 'error') {
						$("#formotp").show();
						$("#bothformdiv").load(location.href + " #bothformdiv");
					} else {
						$("#bothformdiv").load(location.href + " #bothformdiv");
						window.location = "Home.jsp";
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$("#formotp").show();
					$("#spinregister").hide();
				}
			});
		});
	});
</script>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<a class="navbar-brand mb-0 ml-3 mr-2" href="Home.jsp"><h5>NICE
			GOLD Pvt. Ltd</h5></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item " id="navhome"><a class="nav-link ml-3"
				href="Home.jsp"> Home </a></li>
			<li class="nav-item ml-3" id="navcontact"><a class="nav-link"
				href="ContactUs.jsp">Contact Us</a></li>
			<li class="nav-item ml-3 "><a class="nav-link" href=""
				data-toggle="modal" data-target="#staticblog">Our Products</a></li>
		</ul>
		<div class="mt-1 mb-1 mr-4">
			<button type="button" class=" mr-3 btn btn-outline-light"
				data-toggle="modal" data-target="#staticLogin">Login</button>
			<button type="button" class="btn btn-outline-light"
				data-toggle="modal" data-target="#staticRegister">Register</button>
		</div>
	</div>
</nav>
<%
	Message msgg = (Message) session.getAttribute("msg");
if (msgg != null) {
%>
<div
	class="alert alert-dismissible mb-0 <%=msgg.getCssStyle()%>  fade show"
	id="successalert" role="alert">
	<strong><div id="resptxt"><%=msgg.getContent()%></div></strong>
	<button type="button" class="close" data-dismiss="alert"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<%
	session.removeAttribute("msg");
}
%>
<!--Register modal-->
<div class="modal fade " id="staticRegister" data-backdrop="static"
	data-keyboard="false" tabindex="-1" role="dialog"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">Register</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="errordivreg">
				<%
					msgg = (Message) session.getAttribute("msgreg");
				if (msgg != null) {
				%>
				<div
					class="alert alert-dismissible <%=msgg.getCssStyle()%> fade show"
					id="successalert" role="alert">
					<strong><div id="resptxt"><%=msgg.getContent()%></div></strong>
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<%
					session.removeAttribute("msgreg");
				}
				%>
			</div>
			<div class="modal-body">
				<div id="spinregister" name="spinregister" style="display: none;"
					class="container text-center">
					<div class="spinner-grow" role="status">
						<span class="sr-only"></span>
					</div>
				</div>
				<div id="bothformdiv">
					<c:if test="${userotp ==null}">
						<form name="form1" action="RegisterServlet" method="post" id="form1">
							<div class="form-group">
								<label for="username">Name</label> <input type="text"
									class="form-control" required="true" id="username"
									name="username" /> <label for="firmname"> Company Name</label>
								<input type="text" class="form-control" required id="firmname"
									name="firmname"> <label for="useremail">Email
									ID</label> <input type="text" class="form-control" required
									pattern="[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
									name="useremail" id="useremail" /> <label for="mobile">Mobile
									No</label>
								<div class="input-group">
									<div class="input-group-prepend">
										<div class="input-group-text" id="btnGroupAddon">+91</div>
									</div>
									<input type="text" class="form-control" required
										pattern="^[789]\d{9}$" name="mobile" id="mobile" />
								</div>
								<div class="input-group mt-3 mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text" for="userstate">State</label>
									</div>
									<select name="userstate" id="userstate" class="form-control">
										<option value="Andhra Pradesh">Andhra Pradesh</option>
										<option value="Andaman and Nicobar Islands">Andaman
											and Nicobar Islands</option>
										<option value="Arunachal Pradesh">Arunachal Pradesh</option>
										<option value="Assam">Assam</option>
										<option value="Bihar">Bihar</option>
										<option value="Chandigarh">Chandigarh</option>
										<option value="Chhattisgarh">Chhattisgarh</option>
										<option value="Dadar and Nagar Haveli">Dadar and
											Nagar Haveli</option>
										<option value="Daman and Diu">Daman and Diu</option>
										<option value="Delhi">Delhi</option>
										<option value="Lakshadweep">Lakshadweep</option>
										<option value="Puducherry">Puducherry</option>
										<option value="Goa">Goa</option>
										<option value="Gujarat" selected>Gujarat</option>
										<option value="Haryana">Haryana</option>
										<option value="Himachal Pradesh">Himachal Pradesh</option>
										<option value="Jammu and Kashmir">Jammu and Kashmir</option>
										<option value="Jharkhand">Jharkhand</option>
										<option value="Karnataka">Karnataka</option>
										<option value="Kerala">Kerala</option>
										<option value="Madhya Pradesh">Madhya Pradesh</option>
										<option value="Maharashtra">Maharashtra</option>
										<option value="Manipur">Manipur</option>
										<option value="Meghalaya">Meghalaya</option>
										<option value="Mizoram">Mizoram</option>
										<option value="Nagaland">Nagaland</option>
										<option value="Odisha">Odisha</option>
										<option value="Punjab">Punjab</option>
										<option value="Rajasthan">Rajasthan</option>
										<option value="Sikkim">Sikkim</option>
										<option value="Tamil Nadu">Tamil Nadu</option>
										<option value="Telangana">Telangana</option>
										<option value="Tripura">Tripura</option>
										<option value="Uttar Pradesh">Uttar Pradesh</option>
										<option value="Uttarakhand">Uttarakhand</option>
										<option value="West Bengal">West Bengal</option>
									</select>
								</div>
								<label for="userpassword">Password</label> <input
									type="password" class="form-control"
									title="Min 8 Letter, 1 in UpperCase, 1 in LowerCase and Number "
									pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
									required name="password" id="password"> <br> <br>

								<button type="submit" class="btn btn-success" id="bttnregister">Register</button>
							</div>
						</form>
					</c:if>
					<c:if test="${userotp!=null }">
						<form name="formotp" action="OtpRegistrationSrevlet" method="post" id="formotp">
							<div class="form-group">
								<label for="otp">Enter OTP</label> <input type="text"
									class="form-control" required pattern="\d{6}" name="otp"
									id="otp" title="Enter Valid OTP" />
								<button type="submit" class="btn btn-success" id="bttnotp">Submit</button>
							</div>
						</form>
					</c:if>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>

<!--modal login-->
<div class="modal fade " id="staticLogin" data-backdrop="static"
	data-keyboard="false" tabindex="-1" role="dialog"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">Login</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="errordivlogin">
				<%
					msgg = (Message) session.getAttribute("msglogin");
				if (msgg != null) {
				%>
				<div
					class="alert alert-dismissible <%=msgg.getCssStyle()%> fade show"
					id="successalert" role="alert">
					<strong><div id="resptxt"><%=msgg.getContent()%></div></strong>
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<%
					session.removeAttribute("msglogin");
				}
				%>
			</div>
			<div class="modal-body">
				<div class="container text-center" name="spinlogin"
					style="display: none;" id="spinlogin">
					<div class="spinner-grow" role="status">
						<span class="sr-only"></span>
					</div>
				</div>
				<form name="form2" action="LoginServlet" method="post" id="form2">
					<div class="form-group">
						<label for="useremail2">Email ID</label> <input type="text"
							class="form-control" required="true"
							pattern="[a-z0-9A-Z._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$"
							name="useremail2" id="useremail2"> <label
							for="userpassword2">Password</label> <input type="password"
							title="Min 8 Letter, 1 in UpperCase, 1 in LowerCase and Number "
							pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
							class="form-control" required name="userpassword2"
							id="userpassword2"> <br>
						<button type="submit" class="btn btn-success" id="bttnlogin">Login</button>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!--Blog modal-->
<div class="modal fade " id="staticblog" data-backdrop="static"
	data-keyboard="false" tabindex="-1" role="dialog"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">You Need To
					Login / Register</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center p-3">
					<div class="container">
						<div class="row w-100">
							<div class="col-xs-6 text-center w-50">
								<button type="button" class="btn btn-outline-dark"
									data-dismiss="modal" data-toggle="modal"
									data-target="#staticLogin">Login</button>
							</div>
							<div class="col-xs-6 text-center w-50">
								<button type="button" class="btn btn-outline-dark"
									data-dismiss="modal" data-toggle="modal"
									data-target="#staticRegister">Register</button>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>

			<div class="spinner-grow justify-content-center text-primary"
				id="spinlogin" hidden role="status">
				<span class="sr-only"></span>
			</div>
		</div>
	</div>
</div>
