<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listUser</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncPageNavigation(currentPage) {
		console.log(currentPage);
		$("#currentPage").val(currentPage);
		$("#listUser").attr("method", "POST").attr("action","/member/listUser").submit();
	}
	
	$(function() {
		console.log("listUser.jsp");
		console.log($("div a span")[0].id);
		console.log($("div a span")[1].id);
		
		 // 상세조회 버튼 실행
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "#getMember" ).on("click" , function() {
			self.location = "/member/getMember?memberId=${member.memberId}";
		});
		
		$("#all-btn").on("click", function() {
			$("#searchSort").val("");
			fncPageNavigation(1);
		})
		
		$("#eliminated-btn").on("click", function() {
			/* if($("div a span")[0].id == "unchecked-eliminated-btn") { */
				/* $("#eliminated-btn").html("<span class='badge' style='color:#721c24;' id='checked-eliminated-btn' data-sort='eliminated'>탈퇴회원</span>"); */
				$("#searchSort").val("eliminated");
				fncPageNavigation(1);
			/* } else if($("div a span")[0].id == "checked-eliminated-btn") {
				$("#eliminated-btn").html("<span class='badge badge-danger' id='unchecked-eliminated-btn'>탈퇴회원</span>");
				$("#searchSort").val("");
				fncPageNavigation(1);
			} */
		})
		
		$("#blacklist-btn").on("click", function() {
			/* if($("div a span")[1].id == "unchecked-blacklist-btn") {
				$("#blacklist-btn").html("<span class='badge' style='color:#343a40;' id='checked-blacklist-btn' data-sort='blacklist'>블랙리스트</span>"); */
				$("#searchSort").val("blacklist");
				fncPageNavigation(1);
			/* } else if($("div a span")[1].id == "checked-blacklist-btn") {
				$("#blacklist-btn").html("<span class='badge badge-dark' id='unchecked-blacklist-btn' data-sort='blacklist'>블랙리스트</span>");
				$("#searchSort").val("");
				fncPageNavigation(1);
			} */
		})
	
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

				<section id="listUser-jsp">
					<div class="container">
					
						<!-- 관우님 src start -->
						<h2>유저 목록</h2>
						<div class="form-row col-md-12" align="right">
							<div class="dropmenu float-left">
								<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
								
								<div class="dropmenu-list" aria-labelledby="dropmenuList">
									<a href="#" id="all-btn"><span class="badge badge-danger" id="check-all-btn" style="color:#fff;background-color:#f56a6a;">전체</span></a>
									<a href="#" id="eliminated-btn"><span class="badge badge-danger" id="check-eliminated-btn">탈퇴회원</span></a>
									<a href="#" id="blacklist-btn"><span class="badge badge-dark" id="check-blacklist-btn">블랙리스트</span></a>
								</div>
							</div>
						</div>
						<form id="listUser" name="listUser">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
							<input type="hidden" id="searchSort" name="searchSort" value="${search.searchSort}"/>
						</form>
						
						<c:set var="i" value="0" />
						<c:forEach var="member" items="${listUser}">
						
						<%-- <c:if test="${!empty restaurant.restaurantRegDate || !empty restaurant.judgeDate}"> --%>
							
						<div class="col-md-12">
							<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow card h-md-250 position-relative">
								<div class="col p-4 d-flex flex-column position-static">
								
									<c:if test="${!empty member.deleteDate}">
										<div style="text-align: right;"><span class="badge badge-danger">탈퇴회원</span></div>
									</c:if>
									
									<c:if test="${!empty member.blacklistDate}">
										<div style="text-align: right;"><span class="badge badge-dark">블랙리스트</span></div>
									</c:if>
								
									<!-- <a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a> -->
									<c:if test="${member.profileImage == 'defaultImage.png'}">
										<!-- <img src="/resources/images/defaultImage.png" class="rounded-circle" width="150" height="150"/> -->
										<img
											src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/defaultImage.png"
											class="avatar-img rounded-circle" width="50" height="50"/>
									</c:if>
									<c:if test="${member.profileImage != 'defaultImage.png'}">
										<%-- <img src="/resources/images/uploadImages/${member.profileImage}" class="rounded-circle" width="150" height="150"/> --%>
										<img
											src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/member/${member.profileImage}"
											class="avatar-img rounded-circle" width="50" height="50"/>
									</c:if>
									<h2 class="mb-0">${member.nickname}&nbsp;<small style="color:gray;">${member.memberId}</small></h2>
									<hr>
									<div class="mb-1 text-muted"><strong>이름</strong> | ${member.memberName}</div>
									<div class="mb-1 text-muted"><strong>가입일</strong> | ${member.regDate}</div>
									<a href="/member/getMember?memberId=${member.memberId}" style="text-align: right;" class="stretched-link" id="getMember">상세정보</a>
								</div>
							</div>
						</div>
						</c:forEach>
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