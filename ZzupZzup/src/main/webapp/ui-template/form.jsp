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

				<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
				<div class="row">
					<div class="col-12">
						<ul style="display: flex; list-style: none;">
							<li><a href="/ui-template/basic-template.jsp">기본 템플릿</a></li>
							<li><a href="/ui-template/button.jsp">버튼</a></li>
							<li><a href="/ui-template/form.jsp">등록양식</a></li>
							<li><a href="/ui-template/form-view.jsp">등록양식 결과</a></li>
							<li><a href="/ui-template/thumbnail.jsp">썸네일리스트</a></li>
							<li><a href="/ui-template/list.jsp">일반리스트</a></li>
							<li><a href="/ui-template/carousel.jsp">슬라이드</a></li>
							<li><a href="/ui-template/table.jsp">테이블</a></li>
							<li><a href="/ui-template/etc-ui.jsp">기타ui</a></li>
						</ul>
					</div>
				</div>
				<!-- end -->

				<section id="">
					<div class="container">

						<!-- start:Form -->
						<h3>Form</h3>

						<form method="post" action="#">
							<div class="row gtr-uniform">
								<div class="col-6 col-12-xsmall">
									<label for="demo-name">Name</label> <input type="text"
										name="demo-name" id="demo-name" value="" placeholder="Name" />
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="demo-email">Email</label> <input type="email"
										name="demo-email" id="demo-email" value="" placeholder="Email" />
								</div>
								<!-- Break -->
								<div class="col-4 col-12-small">
									<label for="demo-name2">Name</label> <input type="text"
										name="demo-name" id="demo-name2" value="" placeholder="Name" />
								</div>
								<div class="col-4 col-12-small">
									<label for="demo-email2">Email</label> <input type="email"
										name="demo-email" id="demo-email2" value=""
										placeholder="Email" />
								</div>
								<div class="col-4 col-12-small">
									<label for="demo-email3">Email</label> <input type="email"
										name="demo-email" id="demo-email3" value=""
										placeholder="Email" />
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-category">Category</label> <select
										name="demo-category" id="demo-category">
										<option value="">- Category -</option>
										<option value="1">Manufacturing</option>
										<option value="1">Shipping</option>
										<option value="1">Administration</option>
										<option value="1">Human Resources</option>
									</select>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">Radio</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="demo-priority-low" name="demo-priority"
										checked> <label for="demo-priority-low">Low</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="demo-priority-normal"
										name="demo-priority"> <label
										for="demo-priority-normal">Normal</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="demo-priority-high"
										name="demo-priority"> <label for="demo-priority-high">High</label>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">Check</label>
								</div>
								<div class="col-6 col-12-small">
									<input type="checkbox" id="demo-copy" name="demo-copy">
									<label for="demo-copy">Email me a copy</label>
								</div>
								<div class="col-6 col-12-small">
									<input type="checkbox" id="demo-human" name="demo-human"
										checked> <label for="demo-human">I am a human</label>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">Message</label>
									<textarea name="demo-message" id="demo-message"
										placeholder="Enter your message" rows="6"></textarea>
								</div>
								<!-- Break -->
								<div class="col-6">
									<label for="date">Example date</label> <input type="date"
										id="date">
								</div>
								<div class="col-6">
									<label for="time">Example time</label> <input type="time"
										id="time">
								</div>
								<!-- Break -->
								<div class="col-12">
									<ul class="actions">
										<li><input type="submit" value="Send Message"
											class="primary" /></li>
										<li><input type="reset" value="Reset" class="normal" /></li>
									</ul>
								</div>
							</div>
						</form>
						<!-- end -->

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