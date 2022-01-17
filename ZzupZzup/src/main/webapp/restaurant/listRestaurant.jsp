<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-LISTRESTAURANT</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	window.onload = function(){
		
		function fncPageNavigation(currentPage) {
			console.log(currentPage);
			$("#currentPage").val(currentPage);
			$("#restaurantList").attr("action","/restaurant/listRestaurant").attr("method", "POST").submit();
		}
		
		// 상세조회 버튼 실행
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#restinfo" ).on("click" , function() {
				self.location = "/restaurant/getRestaurant?restaurantNo=${restaurant.restaurantNo}";
			});
			
			// 페이지 로딩시 필터 조건이 있다면 표시
			if("${search.searchFilter}" != null && "${search.searchFilter}" != ""){
				console.log("필터 조건?? ${search.searchFilter}");
				$("input:checkbox[value=${search.searchFilter}]").prop("checked", true);
				$("input:checkbox[value=${search.searchFilter}]").addClass("active");
			}
			
			// SEARCH OPERATE
			document.getElementById("searchByEnter").addEventListener("keydown", function(evant) {
				//console.log("keydown");
				if (evant.keyCode === 13) {
					evant.preventDefault();
					//document.getElementById("searchButton").click();
					fncPageNavigation(1);
				}
			});
			
			// Filter
			$("input:checkbox[name='searchFilter']").on("click", function(e){
				//console.log("클릭함");
				let isActive = $(this).hasClass("active");
				if(isActive){
					$("input:checkbox[name='searchFilter']").prop("checked", false);
					$("input:checkbox[name='searchFilter']").removeClass("active");
				}else{
					$("input:checkbox[name='searchFilter']").prop("checked", false);
					$("input:checkbox[name='searchFilter']").removeClass("active");
					$(this).prop("checked", true);
					$(this).addClass("active");
					fncPageNavigation(1);
				}
			});
			
		});
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

				<section id="listRestaurant">
					<div class="container">
					
					<h2>등록된 음식점 목록</h2><hr>
					<form id="restaurantList">
					
						<div class="row">
							<div class="col-md-7">
								<a href="#" class="badge badge-dark dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">
								<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-filter" viewBox="0 0 16 16">
								<path d="M6 10.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
								</svg>&nbsp;필터&nbsp;</a>
								<div class="dropmenu-list" aria-labelledby="dropmenuList">
									<input type="checkbox" id="permission" class="search-filter" name="searchFilter" value="1"><label for="permission">요청승인</label>
									<input type="checkbox" id="rejection" class="search-filter" name="searchFilter" value="2"><label for="rejection">요청거절</label>
								</div>
							</div>
							
							<div class="col-md-5 row">
								<select class="searchCondition my-2 my-md-0" id="searchCondition" name="searchCondition" style="width: 124px; padding-left: 10px;">
								  <!-- <option selected>Open this select menu</option> -->
								  <option value="0" ${!empty search.searchCondition && search.searchCondition == 0 ? "selected" : ""}> 음식점명</option>
								  <option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected" : ""}> 대표자명</option>
								</select>
								
							      <input class="form-control" type="text" id="searchByEnter" name="searchKeyword" placeholder="검색" aria-label="Search" style="width: 234px;" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
							    
						    	 <input type="hidden" id="currentPage" name="currentPage" value="1"/>
						    </div>
							
						</div>
					</form>
					
					<c:set var="i" value="0" />
					<c:forEach var="restaurant" items="${list}">
					<c:if test="${!empty restaurant.restaurantRegDate || !empty restaurant.judgeDate}">
						
					<div class="col-md-12">
						<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							<div class="col p-4 d-flex flex-column position-static">
							
								<c:if test="${!empty restaurant.restaurantRegDate}">
									<div style="text-align: right;"><span class="badge badge-success">요청 승인된 음식점</span></div>
									<c:if test="${restaurant.reservationStatus}">
										<div style="text-align: right;"><span class="badge badge-info">예약 및 결제 가능</span></div>
									</c:if>
								</c:if>
								
								<c:if test="${!empty restaurant.judgeDate}">
									<div style="text-align: right;"><span class="badge badge-danger">요청 거절된 음식점</span></div>
								</c:if>
							
								<!-- <a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a> -->
								<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.returnMenuType}</small></h2><hr>
								<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberName}</div>
								<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
								<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
								<c:if test="${!empty restaurant.restaurantRegDate}">
									<a href="/restaurant/getRestaurant?restaurantNo=${restaurant.restaurantNo}" style="text-align: right;" class="stretched-link" id="restinfo">상세보기</a>
								</c:if>
								<c:if test="${!empty restaurant.judgeDate}">
									<p style="text-align: right;">자세한 내용은 고객센터(
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-headset" viewBox="0 0 16 16">
									<path d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5z"/>
									</svg> 010-4444-4444 )로 문의하시기 바랍니다.</p>
									<a href="/restaurant/getRestaurant?restaurantNo=${restaurant.restaurantNo}" style="text-align: right;" class="stretched-link" id="restinfo">상세보기</a>
								</c:if>
							</div>
						</div>
					</div>
					
					</c:if>
					</c:forEach>

					</div><br><br><br>
					
					<!-- <ul class="pagination">
						<li><span class="button disabled">Prev</span></li>
						<li><a href="#" class="page active">1</a></li>
						<li><a href="#" class="page">2</a></li>
						<li><a href="#" class="page">3</a></li>
						<li><span>&hellip;</span></li>
						<li><a href="#" class="page">8</a></li>
						<li><a href="#" class="page">9</a></li>
						<li><a href="#" class="page">10</a></li>
						<li><a href="#" class="button">Next</a></li>
					</ul> -->
					
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