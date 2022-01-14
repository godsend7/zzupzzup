<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>${restaurant.restaurantName}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

.checked {
 	fill : green;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

//	window.onload = function(){
		$(function() {
			// 목록으로 버튼
			$("button.btn.btn-warning").on("click", function() {
				if(${member.memberRole == 'owner'}) {
					self.location = "/member/getMember?memberId=${member.memberId}"
				} else if(${member.memberRole == 'admin'}) {
					self.location = "/restaurant/listRestaurant"
				} else {
					self.location = "/restaurant/listMyCallDibs"
				}
				/* history.go(-1); */
			});
			
			// 수정하기 버튼
			$("button.btn.btn-info").on("click", function() {
				self.location = "/restaurant/updateRestaurant?restaurantNo=${restaurant.restaurantNo}"
			});
			
			// 삭제하기 버튼
			$("button.btn.btn-link").on("click", function() {
				if(confirm('해당 음식점 정보를 삭제하시겠습니까?')) {
					self.location = "/restaurant/deleteRestaurant?restaurantNo=${restaurant.restaurantNo}"
					/* $("#restaurant").attr("method", "POST").attr("action","/restaurant/deleteRestaurant").submit(); */
				}
			});
			
		});
		
		// carousel prev & next
		$("#car_prev").click(function(){
			$("#carouselExampleFade").carousel("prev");
		});
		
		$("#car_next").click(function(){
			$("#carouselExampleFade").carousel("next");
		});
//	}
	
	// 찜하기 기능
	$(function() {
		$(".zzim").on("click", function() {
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			if ($(this).hasClass("checked") === true) {
				var zzimCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/restaurant/json/cancelCallDibs/"+$(this).closest("div").find("input[name='restaurantNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','zzim');
					}
				});	
			} else {
				var zzimCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/restaurant/json/checkCallDibs/"+$(this).closest("div").find("input[name='restaurantNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','zzim checked');
					}
				});
			}
		});
		
		// 신고하기 Modal
		$(".reportModal").on("click", function() {
			$("#reportModal").modal("show");
		});
	});
	
</script>

<!--  ///////////////////////// review Script ////////////////////////// -->
<script type="text/javascript">
	var searchSort = null;
	
	$(function() {
		$(".reviewModal").on("click", function() {
			console.log("reviewModal click");
			if (${empty member}) {
				alert("로그인이 필요한 서비스입니다.");
				$("#reviewModal").on('show.bs.modal', function(e) {
					e.preventDefault();
				});
			} 
		});
		
		$("body").on("click", '.reviewLike', function() {
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			if ($(this).hasClass("check") === true) {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/review/json/deleteLike/"+$(this).closest("div").find("input[name='reviewNo']").val(),
					method : "GET",
					context : this,
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','reviewLike');
					}
				});	
			} else {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/review/json/addLike/"+$(this).closest("div").find("input[name='reviewNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','reviewLike check'); 
					}
				});
			}
		});
		
		var count = 2;
		if (${!empty list}) {
			console.log(searchSort);
		    window.onscroll = function() {
		    	if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		    		if (${!empty member}) {
			    		$("#currentPage").val(count);
			    		$.ajax(
			    			{
			    				url : "/review/json/listReview",
			    				type : "POST",
			    				dataType : "json",
			    				contentType: 'application/json',
								data : JSON.stringify({
									currentPage : $("#currentPage").val(),
									searchSort : $("input[name='searchSort']").val(),
									searchFilter : $("input[name='searchFilter']:checked").val(),
									no : ${param.restaurantNo}
								}),
								success : function(data) {
			    					
			    					var append_nod = "";
			    					$.each(data.list, function(index, item) {
			    						if (${member.memberRole != 'admin'} && !item.reviewShowStatus) {
			    						} else {
			    							append_nod += '<div class="col-md-12">';
			    							append_nod += '<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">';
			    							append_nod += '<div class="col p-4 d-flex flex-column position-static divBox">';
			    							if (${member.memberRole == 'admin'}) {
			    								append_nod += '<div class="review-report-info">';
			    								if (!item.reviewShowStatus) {
				    								append_nod += '<i class="fa fa-eye-slash" aria-hidden="true"></i>';
												}
			    								append_nod += '<i class="fa fa-exclamation-triangle" aria-hidden="true"> ';
			    								append_nod += item.reportCount + ' 회 '; 
			    								append_nod += ' </i> </div>'; 
			    							}
			    							
			    							append_nod += '<div class="row listStarBox">';
				    						append_nod += '<label for="scopeAvg" class="label listLabel">평점</label>';
				    						append_nod += '<div class="star-in">';
				    						
				    						for (var i = 0; i < Math.round(item.avgScope); i++) {
				    							append_nod += '<span class="star-small on"></span>';
											}
				    						
				    						for (var i = 0; i < 5 - Math.round(item.avgScope); i++) {
				    							append_nod += '<span class="star-small"></span>';
											}
				    					
				    						
				    						append_nod += '</div>';
				    						append_nod += '<label for="scopeClean" class="label">청결해요</label>';
				    						append_nod += '<div class="star-in">';
				    						
				    						for (var i = 0; i < Math.round(item.scopeClean); i++) {
				    							append_nod += '<span class="star-small on"></span>';
											}
				    						
				    						for (var i = 0; i < 5 - Math.round(item.scopeClean); i++) {
				    							append_nod += '<span class="star-small"></span>';
											}
				    						
				    						append_nod += '</div>';
				    						append_nod += '<label for="scopeTaste" class="label">맛있어요</label>';
				    						append_nod += '<div class="star-in">';
				    						
				    						for (var i = 0; i < Math.round(item.scopeTaste); i++) {
				    							append_nod += '<span class="star-small on"></span>';
											}
				    						
				    						for (var i = 0; i < 5 - Math.round(item.scopeTaste); i++) {
				    							append_nod += '<span class="star-small"></span>';
											}
				    						
				    						append_nod += '</div>';
				    						append_nod += '<label for="scopeKind" class="label">친절해요</label>';
				    						append_nod += '<div class="star-in">';
				    						
				    						for (var i = 0; i < Math.round(item.scopeKind); i++) {
				    							append_nod += '<span class="star-small on"></span>';
											}
				    						
				    						for (var i = 0; i < 5 - Math.round(item.scopeKind); i++) {
				    							append_nod += '<span class="star-small"></span>';
											}
				    						
				    						append_nod += '</div></div>';
				    						
				    						append_nod += '<h3 class="mb-0 getOtherUserModal"  data-toggle="modal" data-target="#getOtherUserModal" data-id="' + item.member.memberId + '">';
				    						append_nod += '<span class="badge badge-pill badge-primary">';
				    						append_nod += item.member.memberRank + '</span>';
				    						append_nod += '  ' + item.member.nickname;
				    						append_nod += '</h3>';
				    						append_nod += '<p class="card-text mb-auto">' + item.reviewDetail + '</p>';
				    						append_nod += '<div class="mb-1 text-muted">';
				    						
				    						console.log(item.hashTag);
				    						
				    						$.each(item.hashTag, function(index, hash) {
				    							append_nod += '<span class="badge badge-pill badge-secondary">' + hash.hashTag + '</span>';
				    						});
				    						
				    						append_nod += '</div><br>';
				    						append_nod += '<div class="review-info-bottom">';
				    						append_nod += '<a href="#reviewModal" class="reviewModal" data-toggle="modal" data-id="'+item.reviewNo + '"> 상세보기</a>';
				    						append_nod += '<div class="review-info-bottom-right">';
				    						append_nod += '<div class="likeBox">';
				    						append_nod += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill reviewLike ';
				    						
				    						$.each(data.listLike, function(index, like) {
				    							if ((item.reviewNo == like.reviewNo) && "${member.memberId}" == like.memberId) {
				    								append_nod += ' check';
				    								console.log("내꺼");
				    							} 
				    						});
				    						
				    						append_nod += '" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>';
				    						append_nod += '<span class="reviewCount">' + item.likeCount + '</span>';
				    						append_nod += '<input type="hidden" name="reviewNo" value="' + item.reviewNo + '">';
				    						append_nod += '</div>';
				    						append_nod += '<span>작성일&nbsp;&nbsp;'+item.reviewRegDate+'</span>';
				    						append_nod += '</div></div></div></div></div>';
			    						}
			    					});
			    					
			    					$('.reviewListBox').append(append_nod); 
			    					count++;
								},
								error:function(request,status,error){
							       console.log("실패");
							    }
	
			    		}); 
		    		} else {
						alert("더 많은 리뷰를 확인하기 위해서 로그인해주세요!");
					}
				}
			} 
		}
		
		$(".search-sort").on("click", function(e){
			var sort = $(this).attr("data-sort");
			console.log(sort);
			
			$("input[name='searchSort']").val(sort);
			searchSort = $("input[name='searchSort']").val();
			 $("#currentPage").val(1);
			
			$("#review").attr("action","/restaurant/getRestaurant?restaurantNo=${param.restaurantNo}").attr("method", "POST").submit();
		});
		
		//해시태그 검색
		/* $("#hashtag").on("change", function(e){
			//fncPageNavigation(1);
			
			$("#review").attr("action","/restaurant/getRestaurant?restaurantNo=${param.restaurantNo}").attr("method", "POST").submit();
		}); */
	});
</script>
<!--  ///////////////////////// review Script ////////////////////////// -->

</head>

<body class="is-preload">

	<!-- S:Wrapper -->
	<div id="wrapper">

		<!-- S:Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />
				
				<section id="restaurant">
					<div class="container">
					
					<c:if test="${restaurant.reservationStatus = true}">
						<span class="badge badge-info" id="reservationStatus">예약 및 결제 가능</span>
					</c:if>
					<div class="row">
						<div class="col-md-8">
							<h1 class="text-warning">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.returnMenuType}</small></h1>
						</div>

						<div class="col-md-4" style="text-align:right; padding-right: 22px;">
							<!-- <button type="button" id="callDibs" class="btn btn-outline-link btn-sm" style="border: none; outline: none; box-shadow: none;"> -->
                			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-bookmark-star zzim <c:forEach var="zzim" items="${listCallDibs}">${(restaurant.restaurantNo == zzim.restaurantNo && !empty member && member.memberId == zzim.memberId )? ' checked' : ''}</c:forEach>" viewBox="0 0 16 16"><path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/><path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/></svg>
							<!-- </button> -->
							<input type="hidden" name="restaurantNo" value="${restaurant.restaurantNo}">&nbsp;&nbsp;
							
							<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="Crimson" class="bi bi-flag-fill reportModal" data-toggle='modal' data-target='#reportModal' viewBox="0 0 16 16" data-id="[5,${restaurant.restaurantNo}]">
							  <path d="M14.778.085A.5.5 0 0 1 15 .5V8a.5.5 0 0 1-.314.464L14.5 8l.186.464-.003.001-.006.003-.023.009a12.435 12.435 0 0 1-.397.15c-.264.095-.631.223-1.047.35-.816.252-1.879.523-2.71.523-.847 0-1.548-.28-2.158-.525l-.028-.01C7.68 8.71 7.14 8.5 6.5 8.5c-.7 0-1.638.23-2.437.477A19.626 19.626 0 0 0 3 9.342V15.5a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 1 0v.282c.226-.079.496-.17.79-.26C4.606.272 5.67 0 6.5 0c.84 0 1.524.277 2.121.519l.043.018C9.286.788 9.828 1 10.5 1c.7 0 1.638-.23 2.437-.477a19.587 19.587 0 0 0 1.349-.476l.019-.007.004-.002h.001"/>
							</svg>
						</div>
					</div><hr style="margin-top: 10px;">
					
					<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
					  <div class="carousel-inner">
					  	<c:if test="${!empty restaurant.restaurantImage}">
						  	<c:forEach var="image" items="${restaurant.restaurantImage}" varStatus="status">
						  		<c:choose>
						  			<c:when test="${status.index == 0}">
						  				<div class="carousel-item active">
						  					<%-- <img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100"> --%>
						  					<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/restaurant/${image}" height="600" class="d-block w-100">
						  				</div>
						  			</c:when>
						  			<c:otherwise>
						  				<div class="carousel-item">
						  					<%-- <img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100"> --%>
						  					<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/restaurant/${image}" height="600" class="d-block w-100">
						  				</div>
						  			</c:otherwise>
						  		</c:choose>
						  			<%-- <img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100"> --%>	
						  	</c:forEach>
						  </c:if>	
						  <c:if test="${empty restaurant.restaurantImage}">
						  	<div class="carousel-item active">
						  		<!-- <img src="/resources/images/uploadImages/default.png" height="600" class="d-block w-100"> -->
						  		<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/restaurant/default.png" height="600" class="d-block w-100">
						  	</div>
						  </c:if>	
					  </div>
					  <button class="carousel-control-prev btn-outline-link" type="button" id="car_prev" data-target="#carouselExampleFade" data-slide="prev"
					  style="border: none; outline: none; box-shadow: none; height: 600px; background-color:transparent;">
					    <span class="carousel-control-prev-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
					    <span class="sr-only">Previous</span>
					  </button>
					  <button class="carousel-control-next btn-outline-link" type="button" id="car_next" data-target="#carouselExampleFade" data-slide="next"
					  style="border: none; outline: none; box-shadow: none; height: 600px; background-color:transparent;">
					    <span class="carousel-control-next-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
					    <span class="sr-only">Next</span>
					  </button>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  				<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16">
  						<path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
						</svg> 전화번호</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
					</div><br><br>
					
					<div class="row col-xs-4">
		  				<div class="col-md-2">
		  					<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt" viewBox="0 0 16 16">
  							<path d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94zM8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10z"/>
 							<path d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
							</svg> 위치</strong></div>
						<div class="col-md-3"><span class="badge badge-secondary">도로명주소</span> ${restaurant.streetAddress}</div>
						<div class="col-md-3"><span class="badge badge-secondary">지번주소</span> ${restaurant.areaAddress}</div>
						<c:if test="${empty restaurant.restAddress}">
							
						</c:if>
						<c:if test="${!empty restaurant.restAddress}">
							<div class="col-md-3"><span class="badge badge-secondary">상세주소</span> ${restaurant.restAddress}</div>
						</c:if>
					</div><br><br>
					
					<div class="row">
						<div class="col-xs-4 col-md-2">
							<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">
  							<path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5z"/>
  							<path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1h-3zm1.038 3.018a6.093 6.093 0 0 1 .924 0 6 6 0 1 1-.924 0zM0 3.5c0 .753.333 1.429.86 1.887A8.035 8.035 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5zM13.5 1c-.753 0-1.429.333-1.887.86a8.035 8.035 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1z"/>
							</svg> 영업시간</strong></div>
		  				<div class="col-xs-8 col-md-10">
		  					<!-- ************* 월요일 ************* -->
		  					<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'true'}">
									월요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'false'}">
									월요일 | ${restaurant.restaurantTimes[0].restaurantOpen} ~ ${restaurant.restaurantTimes[0].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[0].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[0].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[0].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[0].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[0].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[0].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 화요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'true'}">
									화요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'false'}">
									화요일 | ${restaurant.restaurantTimes[1].restaurantOpen} ~ ${restaurant.restaurantTimes[1].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[1].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[1].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[1].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[1].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[1].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[1].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 수요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'true'}">
									수요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'false'}">
									수요일 | ${restaurant.restaurantTimes[2].restaurantOpen} ~ ${restaurant.restaurantTimes[2].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[2].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[2].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[2].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[2].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[2].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[2].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 목요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'true'}">
									목요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'false'}">
									목요일 | ${restaurant.restaurantTimes[3].restaurantOpen} ~ ${restaurant.restaurantTimes[3].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[3].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[3].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[3].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[3].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[3].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[3].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 금요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'true'}">
									금요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'false'}">
									금요일 | ${restaurant.restaurantTimes[4].restaurantOpen} ~ ${restaurant.restaurantTimes[4].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[4].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[4].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[4].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[4].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[4].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[4].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 토요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'true'}">
									토요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'false'}">
									토요일 | ${restaurant.restaurantTimes[5].restaurantOpen} ~ ${restaurant.restaurantTimes[5].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[5].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[5].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[5].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[5].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[5].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[5].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 일요일 ************* -->
							<div class="col" style="padding-left: 0px;">
								<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'true'}">
									일요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'false'}">
									일요일 | ${restaurant.restaurantTimes[6].restaurantOpen} ~ ${restaurant.restaurantTimes[6].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[6].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[6].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[6].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[6].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[6].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[6].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
						</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  					<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket" viewBox="0 0 16 16">
  							<path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1v4.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 13.5V9a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h1.217L5.07 1.243a.5.5 0 0 1 .686-.172zM2 9v4.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V9H2zM1 7v1h14V7H1zm3 3a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 4 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 6 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 8 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5z"/>
  							</svg> 음식점 메뉴</strong></div>
  							<div class="col-xs-8 col-md-4">
							<c:set var="i" value="0"/>
							<c:forEach var="menus" items="${restaurant.restaurantMenus}">
								<div>
								${menus.menuTitle} &nbsp; ${menus.menuPrice}원 &nbsp;
								<c:if test="${menus.mainMenuStatus}">
									<span class="badge badge-success">메인메뉴</span>
								</c:if>
								</div>
							</c:forEach>
							</div>
						<%-- <div class="col-xs-8 col-md-4">${restaurant.restaurantMenus[0].menuTitle} ${restaurant.restaurantMenus[0].menuPrice}원 &nbsp;
							<c:if test="${restaurant.restaurantMenus[0].mainMenuStatus eq 'true'}">
								<span class="badge badge-success">메인메뉴</span>
							</c:if>
							<c:if test="${restaurant.restaurantMenus[0].mainMenuStatus eq 'false'}">
								
							</c:if>
						</div> --%>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
							<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-megaphone" viewBox="0 0 16 16">
  							<path d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-.214c-2.162-1.241-4.49-1.843-6.912-2.083l.405 2.712A1 1 0 0 1 5.51 15.1h-.548a1 1 0 0 1-.916-.599l-1.85-3.49a68.14 68.14 0 0 0-.202-.003A2.014 2.014 0 0 1 0 9V7a2.02 2.02 0 0 1 1.992-2.013 74.663 74.663 0 0 0 2.483-.075c3.043-.154 6.148-.849 8.525-2.199V2.5zm1 0v11a.5.5 0 0 0 1 0v-11a.5.5 0 0 0-1 0zm-1 1.35c-2.344 1.205-5.209 1.842-8 2.033v4.233c.18.01.359.022.537.036 2.568.189 5.093.744 7.463 1.993V3.85zm-9 6.215v-4.13a95.09 95.09 0 0 1-1.992.052A1.02 1.02 0 0 0 1 7v2c0 .55.448 1.002 1.006 1.009A60.49 60.49 0 0 1 4 10.065zm-.657.975 1.609 3.037.01.024h.548l-.002-.014-.443-2.966a68.019 68.019 0 0 0-1.722-.082z"/>
							</svg> 음식점 소개글</strong></div>
						<div class="col-xs-8 col-md-10">${restaurant.restaurantText}</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  				<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar2-week" viewBox="0 0 16 16">
  						<path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
  						<path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4zM11 7.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
						</svg> 음식점 등록일</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantRegDate}</div>
					</div><br>
					
					<div class="text-center">
						
						<c:if test="${member.memberRole == 'admin' || member.memberId == restaurant.member.memberId}">
							<button type="button" class="btn btn-link btn-sm">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
	  						<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
	  						<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
							</svg> 삭제하기</button>
							
							<button type="button" class="btn btn-info btn-sm">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bug" viewBox="0 0 16 16">
	  						<path d="M4.355.522a.5.5 0 0 1 .623.333l.291.956A4.979 4.979 0 0 1 8 1c1.007 0 1.946.298 2.731.811l.29-.956a.5.5 0 1 1 .957.29l-.41 1.352A4.985 4.985 0 0 1 13 6h.5a.5.5 0 0 0 .5-.5V5a.5.5 0 0 1 1 0v.5A1.5 1.5 0 0 1 13.5 7H13v1h1.5a.5.5 0 0 1 0 1H13v1h.5a1.5 1.5 0 0 1 1.5 1.5v.5a.5.5 0 1 1-1 0v-.5a.5.5 0 0 0-.5-.5H13a5 5 0 0 1-10 0h-.5a.5.5 0 0 0-.5.5v.5a.5.5 0 1 1-1 0v-.5A1.5 1.5 0 0 1 2.5 10H3V9H1.5a.5.5 0 0 1 0-1H3V7h-.5A1.5 1.5 0 0 1 1 5.5V5a.5.5 0 0 1 1 0v.5a.5.5 0 0 0 .5.5H3c0-1.364.547-2.601 1.432-3.503l-.41-1.352a.5.5 0 0 1 .333-.623zM4 7v4a4 4 0 0 0 3.5 3.97V7H4zm4.5 0v7.97A4 4 0 0 0 12 11V7H8.5zM12 6a3.989 3.989 0 0 0-1.334-2.982A3.983 3.983 0 0 0 8 2a3.983 3.983 0 0 0-2.667 1.018A3.989 3.989 0 0 0 4 6h8z"/>
							</svg> 수정하기</button>
						</c:if>
						
						<button type="button" class="btn btn-warning btn-sm">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
  						<path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
  						<path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
						</svg> 목록으로</button>
						
					</div>
					
					</div>
					<hr>

					<jsp:include page="/review/restaurantReview.jsp"></jsp:include>

				</section>
			</div>
		</div>
		<!-- E:Main -->
		
		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
		
		<!-- Report -->
		<ul class='icons'> 
			<jsp:include page='/report/addReportView.jsp'/>
		</ul>
		
	</div>
	<!-- E:Wrapper -->
</body>
</html>