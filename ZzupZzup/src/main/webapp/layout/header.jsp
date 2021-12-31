<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- start:Header -->
<header id="header">

	<a href="/" class="logo"><strong>ZZUPZZUPDUCE_101</strong></a>

	<ul class="icons">
		<c:if test="${ empty member}">
			<!-- Button trigger modal -->
			<input type="button" value="로그인" class="button"
				data-toggle="modal" data-target="#loginModal" />
		</c:if>
		<c:if test="${ ! empty member}">
			<input type="button" value="로그아웃" class="button" id="logout" />
		</c:if>
	</ul>


</header>
<!-- end:Header -->
