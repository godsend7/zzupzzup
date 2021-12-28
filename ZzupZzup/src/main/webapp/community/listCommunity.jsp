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
				
				<section id="">
					<div class="container">
						
						<div class="row thumb-list">
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="/resources/images/uploadimages/default.jpg"
										alt=""></a>

									<div class="card-body">
										<h4 class="card-title">Card with stretched links</h4>
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<a href="#" class="button small primary stretched-link">Go
												somewhere</a> <small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
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