<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<h4>Pagination</h4>
	<ul class="pagination">
		<li><span class="button disabled">Prev</span></li>
		<li><a href="#" class="page active">1</a></li>
		<li><a href="#" class="page">2</a></li>
		<li><a href="#" class="page">3</a></li>
		<li><span>&hellip;</span></li>
		<li><a href="#" class="page">8</a></li>
		<li><a href="#" class="page">9</a></li>
		<li><a href="#" class="page">10</a></li>
		<li><a href="#" class="button">Next</a></li>
	</ul>

</div>

<jsp:include page="/layout/sidebar.jsp" />