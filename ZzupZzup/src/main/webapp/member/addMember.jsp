<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("template.jsp");
	});
</script>
</head>

<body class="is-preload">

	<!-- S:Wrapper -->
	<div id="wrapper">

		<!-- S:Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />

				<section id="addMember">
					<div class="container">

						<div class="row">

							<div>
								<h4 class="mb-3">Billing address</h4>
								<form class="needs-validation" novalidate>
									<div class="row">
										<div class="col-md-6 mb-3">
											<label for="firstName">First name</label> <input type="text"
												class="form-control" id="firstName" placeholder="" value=""
												required>
											<div class="invalid-feedback">Valid first name is
												required.</div>
										</div>
										<div class="col-md-6 mb-3">
											<label for="lastName">Last name</label> <input type="text"
												class="form-control" id="lastName" placeholder="" value=""
												required>
											<div class="invalid-feedback">Valid last name is
												required.</div>
										</div>
									</div>

									<div class="mb-3">
										<label for="username">Username</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text">@</span>
											</div>
											<input type="text" class="form-control" id="username"
												placeholder="Username" required>
											<div class="invalid-feedback" style="width: 100%;">
												Your username is required.</div>
										</div>
									</div>

									<div class="mb-3">
										<label for="email">Email</label>
										<input type="email" class="form-control" id="email"
											placeholder="you@example.com" required>
										<div class="invalid-feedback">Please enter a valid email
											address for shipping updates.</div>
									</div>

									<div class="mb-3">
										<label for="address">Address</label> <input type="text"
											class="form-control" id="address" placeholder="1234 Main St"
											required>
										<div class="invalid-feedback">Please enter your shipping
											address.</div>
									</div>

									<div class="mb-3">
										<label for="address2">Address 2 <span
											class="text-muted">(Optional)</span></label> <input type="text"
											class="form-control" id="address2"
											placeholder="Apartment or suite">
									</div>

									<div class="row">
										<div class="col-md-3 mb-3">
											<label for="zip">Zip</label> <input type="text"
												class="form-control" id="zip" placeholder="" required>
											<div class="invalid-feedback">Zip code required.</div>
										</div>
									</div>
									<hr class="mb-4">
									<div class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input"
											id="same-address"> <label
											class="custom-control-label" for="same-address">Shipping
											address is the same as my billing address</label>
									</div>
									<div class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input"
											id="save-info"> <label class="custom-control-label"
											for="save-info">Save this information for next time</label>
									</div>
									<hr class="mb-4">
									<button class="btn btn-primary btn-lg btn-block" type="submit">Continue
										to checkout</button>
								</form>
							</div>
						</div>
				</section>
			</div>
		</div>
		<!-- E:Main -->

		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
	</div>
	<!-- E:Wrapper -->
</body>
</html>