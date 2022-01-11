<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listMyActivityScore</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncPageNavigation(currentPage) {
		console.log(currentPage);
		$("#currentPage").val(currentPage);
		$("#listMyActivityScore").attr("method", "GET").attr("action","/member/listMyActivityScore").submit();
	}
	
	$(function() {
		console.log("listMyActivityScore.jsp");
		
	})
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

				<section id="list-my-activity-score">
					<div class="container">

						<h2>내 활동점수 적립 내역</h2><hr>
						<form id="listMyActivityScore">
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
						</form>
						<h4 class="mb-0" style="float:left;">활동점수&nbsp;<small style="color:gray;">${getMember.accumulAllScore}</small></h4>
						<br/><br/>
						
						<c:set var="i" value="0" />
						<c:forEach var="member" items="${listMyActivityScore}">
						
						<%-- <c:if test="${!empty restaurant.restaurantRegDate || !empty restaurant.judgeDate}"> --%>
							
						<div class="col-md-12">
							<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
								<div class="col p-4 d-flex flex-column position-static">
									<div class="col-md-12">
										<%-- <h2 class="mb-0">${member.memberId}&nbsp;<small style="color:gray;">${member.accumulAllScore}</small></h2><hr> --%>
										<div class="col-md-12 mb-1 text-muted"><strong>적립 내용</strong> | ${member.accumulContents}</div>
										<div class="col-md-12 mb-1 text-muted"><strong>점수</strong> | ${member.accumulScore}</div>
										<div class="col-md-12 mb-1 text-muted"><strong>적립일</strong> | ${member.accumulDate}</div>
									</div>
								</div>
							</div>
						</div>
						</c:forEach>
						<c:if test="${listMyActivityScore == '[]'}">
							<h4 align="center">활동점수 적립 내역이 없습니다.</h4>
						</c:if>
	
					</div><br><br><br>
					<!-- 관우님 src end -->
					<jsp:include page="../common/pageNavigator.jsp"/>
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