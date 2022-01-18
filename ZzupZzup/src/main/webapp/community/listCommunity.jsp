<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>나만의 작고 소중한 맛집</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.restaurant-menu-text {
	position: relative;
	text-overflow: ellipsis;
	overflow: hidden;
	height: 25px;
	padding-right: 10px;
	white-space: nowrap;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	var searchSort = '';

	// 상세조회 버튼 실행
	/* $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "#postinfo" ).on("click" , function() {
			self.location = "/community/getCommunity?postNo=${community.postNo}";
		});
	}); */
	
	function fncPageNavigation(currentPage) {
		$("#currentPage").val(currentPage);
		console.log($("#currentPage").val());
		$("#communityList").attr("method", "POST").attr("action", "/community/listCommunity").submit();
	}
	
	// 무한 스크롤
	$(function() {
		
		var count = 2;
		
		if(${!empty list}) {
			//console.log(searchSort);
			window.onscroll = function() {
				$("#currentPage").val(count);
				if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
					//console.log('checkpoint');
					if(${!empty member}) {
						
						let queryStr = $("#communityList").serialize();
						console.log("쿼리 스트링" + queryStr);
						
						console.log($("#searchCondition").val());
						
						$.ajax({
							
							url : "/community/json/listCommunity",
							type : "POST",
							dataType : "json",
							contentType : "application/json",
							data : JSON.stringify({
								currentPage : $("#currentPage").val(),
								searchSort : $("input[name='searchSort']").val(),
								searchFilter : $("input[name='searchFilter']:checked").val(),
								searchKeyword : $("input[name='searchKeyword']").val(),
								searchCondition : $("#searchCondition").val()
							}),
							success : function(data) {
								
								var append_nod = "";
								$.each(data.list, function(index, item) {
									
									console.log(data.list);
						
									
									console.log("2222: "+item.member.memberId)
									
									
									
									append_nod += '<div class="col-md-4">';
									append_nod += '<div class="card mb-1 shadow">';
									append_nod += '<a href="" class="thumb">';
									
									if(item.postImage[0] == null) {
										//append_nod += '<img src="/resources/images/uploadImages/default.png" height="100%">';
										append_nod += '<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/default.png" height="100%">';
									}
									
									if(item.postImage[0] != null) {
										//append_nod += '<img src="/resources/images/uploadImages/' + item.postImage[0] + '" height="100%">';
										append_nod += '<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/community/'+ item.postImage[0] +'" height="100%">';
									}
									
									append_nod += '</a> <div class="card-body">';
									
									if(${member.memberRole == 'admin'}) {
										append_nod += '<strong class="d-inline-block mb-2 text-primary">신고누적수: ' + item.postReportCount + '</strong> &nbsp;';
									}
									
									if(item.receiptImage != null) {
										append_nod += '<span class="badge badge-success" style="text-align: right;">영수증 첨부된 게시물</span>';
									}
									
									if(item.receiptImage == null) {
										append_nod += '<span class="badge badge-danger" style="text-align: right;">영수증 미첨부된 게시물</span>';
									}
									
									if(item.officialDate != null) {
										append_nod += '<span class="badge badge-warning" style="text-align: right;">정식맛집</span>';
									}
									
									append_nod += '<h3 class="card-title">' + item.postTitle + '</h3>';
									append_nod += '<p><strong>작성자:</strong> ' + item.member.nickname + '</p>';
									append_nod += '<p class="card-text restaurant-menu-text">' + item.postText + '</p>';
									append_nod += '<div class="d-flex justify-content-between align-items-center">';
									append_nod += '<a href="/community/getCommunity?postNo=' + item.postNo + '" class="button small primary stretched-link">더 보기</a>';
									append_nod += '<small class="text-muted">' + item.postRegDate + '</small>';
									append_nod += '</div></div></div>';
									
									append_nod += '<button type="button" class="btn btn-outline-danger btn-sm btn-block">';
									append_nod += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">';
									append_nod += '<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />';
									append_nod += '</svg> ' + item.likeCount + '';		
									append_nod += '</button><br> <br>';			
									append_nod += '</div>';
									
								});
								
								/* $(".thumb-list").append(append_nod);
								count++; */
								$(".thumb-list").append(append_nod);
								console.log("fdisodjfs : " + data.list.length);
								if(data.list != 0){
									count++;
								}else{
									if(!$("#listCommunity .alert").length){
										alert_dom = '<div class="alert alert-danger alert-dismissible thumb-list-alert" role="alert"><strong>리스트가 더 이상 존재하지 않습니다.</strong><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>	</div>';							
										$("#listCommunity").append(alert_dom);
										$("#listCommunity .alert").fadeIn();
										
										setTimeout(() => $("#listCommunity .alert").alert('close'), 1500);
									}
								}
								/* count++;
								console.log("fdisodjfs : " + data.list.length);
								if(data.list.length == 0){
									console.log("끝끝");
									if(!$("#listCommunity .alert").length){
										alert_dom = '<div class="alert alert-danger alert-dismissible thumb-list-alert" role="alert"><strong>스크롤 중지!</strong> 리스트가 더 존재하지 않습니다.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>	</div>';							
										$("#listCommunity").append(alert_dom);
										$("#listCommunity .alert").fadeIn();
									}
								} */
								
								
							},
							
							error:function(request,status,error) {
								console.log("append Fail");
							}
							
						});
						
					}
				}
			}
		}
		
		
		
		
		// 페이지 로딩시 필터 조건이 있다면 표시
		if("${search.searchFilter}" != null && "${search.searchFilter}" != ""){
			console.log("필터 조건?? ${search.searchFilter}");
			$("input:checkbox[value=${search.searchFilter}]").prop("checked", true);
			$("input:checkbox[value=${search.searchFilter}]").addClass("active");
		}
		
		// SEARCH OPERATE
		/* $(".search-btn").on("click", function() {
			fncPageNavigation(1);
		}); */
		/* $("#searchByEnter").keyup(function(e) {
			if(e.keyCode == 13) {
				console.log('eeeeeeeeee');
				fncPageNavigation(1);
				//self.location = "/community/listCommunity?searchCondition=${search.searchCondition}&searchKeyword=${search.searchKeyword}";
			}
		}); */
		
		document.getElementById("searchByEnter").addEventListener("keydown", function(evant) {
			//console.log("keydown");
			if (evant.keyCode === 13) {
				evant.preventDefault();
				//document.getElementById("searchButton").click();
				fncPageNavigation(1);
			}
		});
		
		/* 도윤 추가 검색버튼 클릭시 */
		$(".search-btn").on("click", function() {
			fncPageNavigation(1);
		});
		
		// SORT
		$(".search-sort").on("click", function(e){
			e.preventDefault();
			let sortType = $(this).attr("data-sort");
			console.log(sortType);
			
			$("input[name=searchSort]").val(sortType);
			
			console.log(localStorage.getItem('sortType'));
			
			fncPageNavigation(1);
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
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		if(${member.memberRole == 'user' || member.memberRole == 'admin'}) {
			// 게시물 작성하기 버튼 실행
			$("#write").on("click", function() {
				self.location = "/community/addCommunity";
			});	
			
		} else {
			alert("유저만 이용할 수 있는 서비스입니다."),
			self.location = "../main.jsp";
		}
		
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

				<section id="listCommunity">
					<div class="container">
					
						<h2>나만의 작고 소중한 맛집 리스트</h2>
						
						<form id="communityList">
							<div class="container">
								<div class="row search-box gtr-uniform">
								
									<div class="col-md-4 d-flex">
										<div class="dropmenu float-left mr-2">
											<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순</a>
												<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
												<input type="hidden" name="searchSort" value="${search.searchSort}">
											</div>
										</div>
										
										
										<div class="dropmenu float-left">
											<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
											
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<input type="checkbox" id="official" class="search-filter" name="searchFilter" value="1"><label for="official">정식맛집</label>
											<input type="checkbox" id="receipt" class="search-filter" name="searchFilter" value="2"><label for="receipt">영수증첨부</label>
											</div>
										</div>
									</div>
										
									<div class="col-md-5 d-flex align-items-center">
										
										<select class="searchCondition my-2 my-md-0 mr-2" id="searchCondition" name="searchCondition">
									  <!-- <option selected>Open this select menu</option> -->
									  <option value="0" ${!empty search.searchCondition && search.searchCondition == 0 ? "selected" : ""}> 작성자명</option>
									  <option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected" : ""}> 게시물제목</option>
									</select>
									
										<input type="text" id="searchByEnter" name="searchKeyword" placeholder="검색어" class="pr-5" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#" class="button primary icon solid fa-search search-btn"></a>
	
										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value="1" />
									</div>
										
									<div class="col-md-3 d-flex justify-content-end align-items-center">
										<c:if test="${member.memberRole == 'user'}">
											<a href="/community/addCommunity" id="write" class="button svg-btn btn-sm float-right">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
		  									<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
		  									<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
											</svg>작성하기</a>
										</c:if>
									</div>
									
								</div>
							</div>
						</form>
						<!-- </form> -->	
							
						<!-- <form id="communityList"> -->
						<div class="container">
							<div class="row thumb-list">
	
								<c:set var="i" value="0" />
								<c:forEach var="community" items="${list}">
	
									<div class="col-md-4">
										<div class="card mb-1 shadow">
											<a href="" class="thumb">
												<c:if test="${community.postImage[0] == null}">
													<!-- <img src="/resources/images/uploadImages/default.jpg" height="100%"> -->
													<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/default.png" height="100%">
												</c:if>
												<c:if test="${community.postImage[0] != null}">
													<%-- <img src="/resources/images/uploadImages/${community.postImage[0]}" height="100%"> --%>
													<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/community/${community.postImage[0]}" height="100%">
												</c:if>
											</a>
											<div class="card-body">
												<c:if test="${member.memberRole == 'admin'}">
													<strong class="d-inline-block mb-2 text-primary">신고누적수: ${community.postReportCount}</strong> &nbsp;
												</c:if>
												<c:if test="${!empty community.receiptImage}">
													<span class="badge badge-success" style="text-align: right;">영수증 첨부된 게시물</span>
												</c:if>
												<c:if test="${empty community.receiptImage}">
													<span class="badge badge-danger" style="text-align: right;">영수증 미첨부된 게시물</span>
												</c:if>
												<c:if test="${!empty community.officialDate}">
													<span class="badge badge-warning" style="text-align: right;">정식맛집</span>
												</c:if>
												<h3 class="card-title">${community.postTitle}</h3>
												<p><strong>작성자:</strong> ${community.member.nickname}</p>
												<p class="card-text restaurant-menu-text">${community.postText}</p>
												<div class="d-flex justify-content-between align-items-center">
													<a href="/community/getCommunity?postNo=${community.postNo}" class="button small primary stretched-link">더 보기</a>
													<small class="text-muted">${community.postRegDate}</small>
												</div>
											</div>
										</div>
	
										<button type="button" class="btn btn-outline-danger btn-sm btn-block">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
		  										<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
											</svg> <span class="likeCount">${community.likeCount}</span>
										</button><br> <br>
	
									</div>
								</c:forEach>
							</div>
						</div>
							
					</div>
					<br>

					<!-- <h3 style="text-align:center;">▽ 스크롤하여 더 많은 리스트 보기</h3> -->
					<!-- <div class="d-flex justify-content-center">
						<div class="spinner-border" role="status">
							<span class="sr-only">Loading...</span>
						</div>
					</div> -->

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