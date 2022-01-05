<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<!-- start:Form -->
	<h3>쩝쩝친구 생성</h3>

	<form method="post" action="#">
		<div class="row gtr-uniform">
			<div class="col-6 col-12-xsmall">
				<label for="demo-name">음식점명</label> <input type="text"
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
					name="demo-email" id="demo-email2" value="" placeholder="Email" />
			</div>
			<div class="col-4 col-12-small">
				<label for="demo-email3">Email</label> <input type="email"
					name="demo-email" id="demo-email3" value="" placeholder="Email" />
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
				<input type="radio" id="demo-priority-normal" name="demo-priority">
				<label for="demo-priority-normal">Normal</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="demo-priority-high" name="demo-priority">
				<label for="demo-priority-high">High</label>
			</div>
			<!-- Break -->
			<div class="col-12">
				<label for="demo-priority">Check</label>
			</div>
			<div class="col-6 col-12-small">
				<input type="checkbox" id="demo-copy" name="demo-copy"> <label
					for="demo-copy">Email me a copy</label>
			</div>
			<div class="col-6 col-12-small">
				<input type="checkbox" id="demo-human" name="demo-human" checked>
				<label for="demo-human">I am a human</label>
			</div>
			<!-- Break -->
			<div class="col-12">
				<label for="demo-priority">Message</label>
				<textarea name="demo-message" id="demo-message"
					placeholder="Enter your message" rows="6"></textarea>
			</div>
			<!-- Break -->
			<div class="col-12">
				<ul class="actions">
					<li><input type="reset" value="Reset" class="normal" /></li>
					<li><input type="submit" value="Send Message" class="primary" /></li>
				</ul>
			</div>
		</div>
	</form>
	<!-- end -->

</div>

<jsp:include page="/layout/sidebar.jsp" />