<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- start:Header -->
<header id="header">
	<a href="/main.jsp" class="logo"><strong>쩝쩝듀스101</strong></a>
	
	
	<ul class="icons">
		<c:if test="${ empty member}">
			<jsp:include page="/member/loginView.jsp" />	
		</c:if>
		<c:if test="${ ! empty member}">
			로그아웃 안 됩니다.
		</c:if>
	</ul>
	
	
</header>
<!-- end:Header -->	