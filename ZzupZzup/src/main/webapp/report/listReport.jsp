<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/report.css" />
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncPageNavigation(currentPage, category) {
		  /* document.getElementById("currentPage").value = currentPage;
	    document.detailForm.submit(); */
	    //console.log(currentPage);
	    //console.log(category)
	    $("#currentPage").val(currentPage);
	    
	    if (category == null) {
			category = ${category};
		}
	   
	    $("#report").attr("action","/report/listReport?reportCategory="+category).attr("method", "POST").submit();
	}
	
	
	$(function() {
		if (${member.memberRole != "owner"}) {
			if(${category == 1}) {
				$(".report-top-tabs").children('li:eq(0)').children("a").addClass("active");
			} else if(${category == 2}) {
				$(".report-top-tabs").children('li:eq(1)').children("a").addClass("active");
			} else if(${category == 3}) {
				$(".report-top-tabs").children('li:eq(2)').children("a").addClass("active");
			} else if(${category == 4}) {
				$(".report-top-tabs").children('li:eq(3)').children("a").addClass("active");
			} else if(${category == 5}) {
				$(".report-top-tabs").children('li:eq(4)').children("a").addClass("active");
			}
		} else {
			$(".report-top-tabs").children('li:eq(0)').children("a").addClass("active");
		}
		
		if (${member.memberRole eq "admin"}) {
			$('.divBox').mousedown(function(event) {
			    switch (event.which) {
			        case 3:
			            fncUpdateReport($(this).find("input[name='reportNo']").val());
			            break;
			    }
			});
		}
		
		function fncUpdateReport(items) {
			console.log(items);
			if (confirm("확인 처리하시겠습니까?")) {
				$.ajax({
					url : "/report/updateReport/"+items,
					method : "GET",
					success : function(data, status) {
						if (data == 1) {
							location.reload();
						}
					}
				});
   	    	}
		}
		
		$(".search-sort").on("click", function(e){
			var sort = $(this).attr("data-sort");
			console.log(sort);
			
			$("input[name='searchSort']").val(sort);
			
			fncPageNavigation(1,${param.reportCategory});
		});
	});
</script>
</head>

<body class="is-preload" oncontextmenu="return false">

	<!-- S:Wrapper -->
	<div id="wrapper">
		<!-- S:Main -->
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />

				<section id="listReport">
					<div class="container">
						<!-- start:Form -->
						<!-- <h2>신고/제보 목록</h2> -->
						
						<form id="report">
							<div class="row search-box gtr-uniform">
								<div class="col-md-4 col-sm-12">
									<div class="dropmenu float-left mr-2">
										<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
										<div class="dropmenu-list" aria-labelledby="dropmenuList">
											<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순 </a>
											<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
											<input type="hidden" name="searchSort" value="">
										</div>
									</div>
								</div>
							</div>
							<br>
							<ul class="nav nav-tabs report-top-tabs">
								<c:if test='${member.memberRole != "owner"}'>
								  	<li class="nav-item">
								    	<a class="nav-link" href="javascript:fncPageNavigation(1,1)">채팅방 신고</a>
								  	</li>
								  	<li class="nav-item">
								    	<a class="nav-link" href="javascript:fncPageNavigation(1,2)">채팅방 참여자 신고</a>
								  	</li>
								  	<li class="nav-item">
								    	<a class="nav-link" href="javascript:fncPageNavigation(1,3)">리뷰 신고</a>
								  	</li>
								  	<li class="nav-item">
								    	<a class="nav-link" href="javascript:fncPageNavigation(1,4)">게시물 신고</a>
									</li>
							 	</c:if>
							  <li class="nav-item">
							    <a class="nav-link" href="javascript:fncPageNavigation(1,5)">음식점 제보</a>
							  </li>
							</ul>
							
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<%-- <input type="hidden" id="restaurantNo" name="restaurantNo" value="${param.restaurantNo}"/> --%>
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
							<div class="row table-list mb-2">
					 		 	<c:forEach var="report" items= "${list}">
			 		 				<div class="col-md-12">
										<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
											<div class="col p-4 d-flex flex-column position-static divBox">
												<input type="hidden" name="reportNo" value="${report.reportNo}">
												<div class="report-info">
													<c:choose>
														<c:when test="${report.reportCheck}">
															
																<c:if test="${member.memberRole eq 'user'}">
																	<span class="badge badge-success">확인 완료</span>
																</c:if>
																<c:if test="${member.memberRole eq 'owner'}">
																	<span class="badge badge-danger">읽음</span>
																</c:if>
																<c:if test="${member.memberRole eq 'admin'}">
																	<span class="badge badge-danger">처리 완료</span>
																</c:if>
															
														</c:when>
														<c:otherwise>
															<c:if test="${member.memberRole eq 'user'}">
																<span class="badge badge-warning">확인 중</span>
															</c:if>
														</c:otherwise>
													</c:choose>
												</div>
												<input type="hidden" name="toReport" value="${report.toReport}">
												<h3 class="mb-0"><span>${report.toReportTitle}</span></h3>
												
												<br>
												
												<p class="card-text mb-auto"><strong>${report.returnReportType}</strong></p>
												<p class="card-text mb-auto">${report.reportDetail}</p>
												
												<br>
												
												<div class="report-info-bottom">
													<c:choose>
														<c:when test="${param.reportCategory == 1}">
															<c:if test="${member.memberRole eq 'admin'}">
																<a href="/chat/getChatRecord?chatNo=${report.reportChat.chatNo}">상세보기</a>
															</c:if>
														</c:when>
														<c:when test="${param.reportCategory == 2}">
															<a href="/member/getMember?memberId=${report.reportChatMember.memberId}">상세보기</a>
														</c:when>
														<c:when test="${param.reportCategory == 3}">
															<a href="#reviewModal" class="reviewModal" data-toggle="modal" data-id="${report.reportReview.reviewNo}">상세보기</a>
														</c:when>
														<c:when test="${param.reportCategory == 4}">
															<a href="/community/getCommunity?postNo=${report.reportPost.postNo}">상세보기</a>
														</c:when>
														<c:when test="${param.reportCategory == 5}">
															<a href="/restaurant/getRestaurant?restaurantNo=${report.reportRestaurant.restaurantNo}">상세보기</a>
														</c:when>
													</c:choose>
													
													<div class="report-info-bottom-right">
														<c:if test="${member.memberRole eq 'admin'}">
															<span><strong>제보자 아이디 : </strong>${report.memberId}</span>
														</c:if>
														<span><strong>작성일&nbsp;&nbsp;</strong>${report.reportRegDate}</span>													
													</div>		
												</div>										
											</div>
										</div>
									</div>
					 		 		
								</c:forEach>
								<ul class='icons'> 
									<jsp:include page='/review/getReview.jsp'/>
								</ul>
						</div>
					
						<jsp:include page="../common/pageNavigator.jsp"/>
					</div>
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