<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="pagination">
	<li>
		<c:choose>
			<c:when test="${ resultPage.currentPage <= resultPage.pageUnit }">
				<a href="javascript:fncPageNavigation('${resultPage.currentPage-1}')" class="button disabled">Prev</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:fncPageNavigation('${resultPage.currentPage-1}')" class="button">Prev</a>
			</c:otherwise>
		</c:choose>
	</li>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<li>
			<c:choose>
				<c:when test="${ resultPage.currentPage == i }">
					<a href="javascript:fncPageNavigation('${ i }');" class="page active">${ i }</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:fncPageNavigation('${ i }');" class="page">${ i }</a>
				</c:otherwise>
			</c:choose>
		</li>
	</c:forEach>
	
	<li>
	<%-- 	<c:if test="${resultPage.maxPage}">
		
		</c:if> --%>
		<c:choose>
			<c:when test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<a href="javascript:fncPageNavigation('${resultPage.endUnitPage+1}')" class="button">Next</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:fncPageNavigation('${resultPage.endUnitPage+1}')" class="button disabled">Next</a>
			</c:otherwise>
		</c:choose>
	</li>
</ul>