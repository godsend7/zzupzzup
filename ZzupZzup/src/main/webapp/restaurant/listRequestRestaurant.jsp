<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>심사 대기중인 음식점</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	function fncPageNavigation(currentPage) {
		$("#currentPage").val(currentPage);
		
		$("#restaurant").attr("action","/restaurant/listRequestRestaurant").attr("method", "POST").submit();
	}
	
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
					
					<h2>심사 대기중인 음식점 목록</h2><hr>
					<form id="restaurant">
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
					</form>
					
					<c:set var="i" value="0" />
					<c:forEach var="restaurant" items="${list}">
					<c:if test="${!empty restaurant.requestDate && empty restaurant.judgeDate && empty restaurant.restaurantRegDate}">
					
					<div class="col-md-12">
						<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						
							<div class="col p-4 d-flex flex-column position-static">
								<c:if test="${restaurant.judgeStatus == 1}">
									<div style="text-align: right;"><span class="badge badge-warning">심사 대기중</span></div>
								</c:if>
								<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.returnMenuType}</small></h2><hr>
								<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberName}</div>
								<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
								<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
								<a href="/restaurant/getRequestRestaurant?restaurantNo=${restaurant.restaurantNo}" style="text-align: right;" class="stretched-link" id="restinfo">상세보기</a>
							</div>
						</div>
					</div>
					
					</c:if>
					</c:forEach>
					
					</div><br><br><br>
					
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