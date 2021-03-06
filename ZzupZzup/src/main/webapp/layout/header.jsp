<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<!-- CSS -->
<style>
.mapSearch {
	position: absolute;
	left : 50%;
	margin-left: -220px;
}

.mapSearch .searchKeyword {
	width: 250px;
	margin-right: 10px;
	height: 42px;
	padding-right: 50px;
}

.mapSearch #searchCondition {
	width: 145px;
	height: 42px;
}

.mapSearch .search-btn {
	height: 42px;
	line-height: 42px;
	position: absolute;
	top: 0;
	right: -30px;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
	padding: 0 30px;
}

.mapSearch .search-btn:before {
	margin-right: 0px;
}

@media screen and (max-width: 1680px) {
   	.mapSearch .searchKeyword { width: 200px; }
}

</style>

<!-- start: Header -->
<header id="header" >
	<!-- 현재 나의 PATH 가져오기 -->
	<c:set var="URI" value="${pageContext.request.requestURI}" />
	<c:set var="path" value='${requestScope["javax.servlet.forward.request_uri"]}' />
	
	<a href="/" class="logo">
		<strong><svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-piggy-bank" viewBox="0 0 16 16">
  		<path d="M5 6.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0zm1.138-1.496A6.613 6.613 0 0 1 7.964 4.5c.666 0 1.303.097 1.893.273a.5.5 0 0 0 .286-.958A7.602 7.602 0 0 0 7.964 3.5c-.734 0-1.441.103-2.102.292a.5.5 0 1 0 .276.962z"/>
  		<path fill-rule="evenodd" d="M7.964 1.527c-2.977 0-5.571 1.704-6.32 4.125h-.55A1 1 0 0 0 .11 6.824l.254 1.46a1.5 1.5 0 0 0 1.478 1.243h.263c.3.513.688.978 1.145 1.382l-.729 2.477a.5.5 0 0 0 .48.641h2a.5.5 0 0 0 .471-.332l.482-1.351c.635.173 1.31.267 2.011.267.707 0 1.388-.095 2.028-.272l.543 1.372a.5.5 0 0 0 .465.316h2a.5.5 0 0 0 .478-.645l-.761-2.506C13.81 9.895 14.5 8.559 14.5 7.069c0-.145-.007-.29-.02-.431.261-.11.508-.266.705-.444.315.306.815.306.815-.417 0 .223-.5.223-.461-.026a.95.95 0 0 0 .09-.255.7.7 0 0 0-.202-.645.58.58 0 0 0-.707-.098.735.735 0 0 0-.375.562c-.024.243.082.48.32.654a2.112 2.112 0 0 1-.259.153c-.534-2.664-3.284-4.595-6.442-4.595zM2.516 6.26c.455-2.066 2.667-3.733 5.448-3.733 3.146 0 5.536 2.114 5.536 4.542 0 1.254-.624 2.41-1.67 3.248a.5.5 0 0 0-.165.535l.66 2.175h-.985l-.59-1.487a.5.5 0 0 0-.629-.288c-.661.23-1.39.359-2.157.359a6.558 6.558 0 0 1-2.157-.359.5.5 0 0 0-.635.304l-.525 1.471h-.979l.633-2.15a.5.5 0 0 0-.17-.534 4.649 4.649 0 0 1-1.284-1.541.5.5 0 0 0-.446-.275h-.56a.5.5 0 0 1-.492-.414l-.254-1.46h.933a.5.5 0 0 0 .488-.393zm12.621-.857a.565.565 0 0 1-.098.21.704.704 0 0 1-.044-.025c-.146-.09-.157-.175-.152-.223a.236.236 0 0 1 .117-.173c.049-.027.08-.021.113.012a.202.202 0 0 1 .064.199z"/>
		</svg><svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-piggy-bank" viewBox="0 0 16 16">
  		<path d="M5 6.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0zm1.138-1.496A6.613 6.613 0 0 1 7.964 4.5c.666 0 1.303.097 1.893.273a.5.5 0 0 0 .286-.958A7.602 7.602 0 0 0 7.964 3.5c-.734 0-1.441.103-2.102.292a.5.5 0 1 0 .276.962z"/>
  		<path fill-rule="evenodd" d="M7.964 1.527c-2.977 0-5.571 1.704-6.32 4.125h-.55A1 1 0 0 0 .11 6.824l.254 1.46a1.5 1.5 0 0 0 1.478 1.243h.263c.3.513.688.978 1.145 1.382l-.729 2.477a.5.5 0 0 0 .48.641h2a.5.5 0 0 0 .471-.332l.482-1.351c.635.173 1.31.267 2.011.267.707 0 1.388-.095 2.028-.272l.543 1.372a.5.5 0 0 0 .465.316h2a.5.5 0 0 0 .478-.645l-.761-2.506C13.81 9.895 14.5 8.559 14.5 7.069c0-.145-.007-.29-.02-.431.261-.11.508-.266.705-.444.315.306.815.306.815-.417 0 .223-.5.223-.461-.026a.95.95 0 0 0 .09-.255.7.7 0 0 0-.202-.645.58.58 0 0 0-.707-.098.735.735 0 0 0-.375.562c-.024.243.082.48.32.654a2.112 2.112 0 0 1-.259.153c-.534-2.664-3.284-4.595-6.442-4.595zM2.516 6.26c.455-2.066 2.667-3.733 5.448-3.733 3.146 0 5.536 2.114 5.536 4.542 0 1.254-.624 2.41-1.67 3.248a.5.5 0 0 0-.165.535l.66 2.175h-.985l-.59-1.487a.5.5 0 0 0-.629-.288c-.661.23-1.39.359-2.157.359a6.558 6.558 0 0 1-2.157-.359.5.5 0 0 0-.635.304l-.525 1.471h-.979l.633-2.15a.5.5 0 0 0-.17-.534 4.649 4.649 0 0 1-1.284-1.541.5.5 0 0 0-.446-.275h-.56a.5.5 0 0 1-.492-.414l-.254-1.46h.933a.5.5 0 0 0 .488-.393zm12.621-.857a.565.565 0 0 1-.098.21.704.704 0 0 1-.044-.025c-.146-.09-.157-.175-.152-.223a.236.236 0 0 1 .117-.173c.049-.027.08-.021.113.012a.202.202 0 0 1 .064.199z"/>
		</svg> ZZUPZZUPDUCE_101</strong>
	</a>
	
	<%-- <c:if test = "${empty path}"> --%>
	<c:if test = "${empty path && (URI eq '/' || fn:contains(URI, 'main'))}">
		<form class="col-12 col-lg-auto mb-3 mb-lg-0 mapSearch" id="mapSearch">
			<div class="col-md-12 col-sm-12 d-flex">
				<div class="searchCondition mr-2">
					<select id="searchCondition" name="searchCondition">
						<option value="0"
							${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
						<option value="1"
							${!empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
					</select>
				</div>
				<div class="position-relative">
		    		<input type="search" id="searchKeyword" class="form-control searchKeyword" placeholder="검색어를 입력해주세요" aria-label="Search" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
		    		<a href="javascript:searchMap();" class="button primary icon solid fa-search search-btn" id="searchButton"></a>
		    	</div>
	    	</div>
	    </form>
	</c:if>
	<ul class="icons">
		<c:if test="${ empty member || fn:contains(URI, 'addMember')}">
			<!-- Button trigger modal -->
			<button type="button" class="button primary login" data-toggle="modal" data-target="#loginModal" style="padding-left: 15px; padding-right: 15px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-door-closed-fill" viewBox="0 0 16 16">
  					<path d="M12 1a1 1 0 0 1 1 1v13h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V2a1 1 0 0 1 1-1h8zm-2 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				</svg> LOGIN
			</button>
		</c:if>
		<c:if test="${ ! empty member && ! fn:contains(URI, 'addMember')}">
			<button type="button" class="button primary logout" id="logout" style="padding-left: 15px; padding-right: 15px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-door-open-fill" viewBox="0 0 16 16">
  					<path d="M1.5 15a.5.5 0 0 0 0 1h13a.5.5 0 0 0 0-1H13V2.5A1.5 1.5 0 0 0 11.5 1H11V.5a.5.5 0 0 0-.57-.495l-7 1A.5.5 0 0 0 3 1.5V15H1.5zM11 2h.5a.5.5 0 0 1 .5.5V15h-1V2zm-2.5 8c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
				</svg> LOGOUT
			</button>
		</c:if>
	</ul>
</header>
<!-- end: Header -->
