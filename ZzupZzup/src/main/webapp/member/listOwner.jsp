<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listOwner</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	function fncPageNavigation(currentPage) {
		console.log(currentPage);
		$("#currentPage").val(currentPage);
		$("#listOwner").attr("method", "POST").attr("action","/member/listOwner").submit();
	}
	
	$(function() {
		console.log("listOwner.jsp");
		
		// 상세조회 버튼 실행
		$( "#getMember" ).on("click" , function() {
			self.location = "/member/getMember?memberId=${member.memberId}";
		});
		
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

				<section id="listOwner-jsp">
					<div class="container">
					
						<!-- 관우님 src 참고 start -->
						<h2>업주 목록</h2>
						<form id="listOwner">
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
						</form>
						
						<c:set var="i" value="0" />
						<c:forEach var="member" items="${listOwner}">
						
						<%-- <c:if test="${!empty restaurant.restaurantRegDate || !empty restaurant.judgeDate}"> --%>
							
						<div class="col-md-12">
							<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow card h-md-250 position-relative">
								<div class="col p-4 d-flex flex-column position-static">
								
									<c:if test="${!empty member.deleteDate}">
										<div style="text-align: right;"><span class="badge badge-danger">탈퇴회원</span></div>
									</c:if>
								
									<!-- <a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a> -->
									<h2 class="mb-0"><small style="color:gray;">${member.memberId}</small>
									<small style="color:gray; float:right">${member.regRestaurantCount}</small></h2><hr>
									<div class="mb-1 text-muted"><strong>이름</strong> | ${member.memberName}</div>
									<div class="mb-1 text-muted"><strong>가입일</strong> | ${member.regDate}</div>
									<a href="/member/getMember?memberId=${member.memberId}" style="text-align: right;" class="stretched-link" id="getMember">상세정보</a>
								</div>
							</div>
						</div>
						</c:forEach>
	
						</div><br><br><br>
						<!-- 관우님 src 참고 end -->
						
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