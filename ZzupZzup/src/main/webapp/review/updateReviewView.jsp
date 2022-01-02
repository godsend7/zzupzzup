<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/review.css" />
 
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	.reviewShowStatus {
		display: none;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var scopeClean = ${review.scopeClean};
	var scopeTaste = ${review.scopeTaste};
	var scopeKind = ${review.scopeKind};
	
	//hashTag id 초기화
	var hashTagCount = ${fn:length(review.hashTag)};
	
	console.log(${review.scopeTaste});
	
	
	
	function fncUpdateReview() {
		console.log("fncUpdateReview");
		//alert("선택하지 않은 평점이 존재합니다!");
		if(scopeClean != 0) {
			$("#scopeClean").val(scopeClean);
		}
		
		if(scopeTaste != 0) {
			$("#scopeTaste").val(scopeTaste);
		}
		
		if(scopeKind != 0) {
			$("#scopeKind").val(scopeKind);
		}
		
		if(scopeClean == 0 || scopeTaste == 0 || scopeKind == 0) {
			alert("선택하지 않은 평점이 존재합니다!");
			return;
		}
		
		if ($("#reviewShowStatus").is(':checked')) {
			$("#reviewShowStatus").val("true")
		} else {
			$("#reviewShowStatus").val("false")
		}
		
		$("#review").attr("method", "POST").attr("action" , "/review/updateReview").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
	} 
	
	window.onload = function() {
		for (var i = 0; i < ${review.scopeClean}; i++) {
	  		$(".starClean").eq(i).addClass("on");
		}
		
		for (var i = 0; i < ${review.scopeTaste}; i++) {
	  		$(".starTaste").eq(i).addClass("on");
		}
		
		for (var i = 0; i < ${review.scopeKind}; i++) {
	  		$(".starKind").eq(i).addClass("on");
		}
		
		if (${member.memberRole != 'admin'}) {
			$(".starClean").on('click',function(){
				var idx = $(this).index();
				scopeClean = idx+1;
				/* console.log(scopeClean); */
		  		$(".starClean").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starClean").eq(i).addClass("on");
		   		}
			});
			
			$(".starTaste").on('click',function(){
				var idx = $(this).index();
				scopeTaste = idx+1;
				/* console.log(scopeTaste); */
		  		$(".starTaste").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starTaste").eq(i).addClass("on");
		   		}
			});
			
			$(".starKind").on('click',function(){
				var idx = $(this).index();
				scopeKind = idx+1;
				/* console.log(scopeKind); */
		  		$(".starKind").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starKind").eq(i).addClass("on");
		   		}
			});
			
			$("#hashTagBox").on("click", "span", function(e) {
				e.stopPropagation();
				
				$(this).remove();
				
				if ($("#hashTagBox").children().length == 0) {
					hashTagCount = 0;
				}
			});
		}
		
		
		$("#updateBtn").on("click", function() {
			/* console.log("button"); */
			fncUpdateReview();
		});
		
		$("#cancelBtn").on("click", function() {
			window.history.back();
		});
		
			
		$("#hashTagAuto").autocomplete({
			source: function(request, response) {
		 		$.ajax({
		 			url:"/review/json/listHashTag",
	    	  		method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : {
						"keyWord" : $("#hashTagAuto").val()
					},
					success : function(data, status) {
						/* var arrayLayout = new Array();
						var arrayLayout2 = new Array();
						
						$.each(data, function(index, item) {
							console.log(item.hashTag);
							arrayLayout.push(item.hashTag);
							arrayLayout2.push(item.hashTagNo);
						}); */
						
						response(
							$.map(data, function(item) {
                                return {
                                    label: item.hashTag,
                                    value: item.hashTagNo
                                }
                            })
						);//response 
					}
	      		});
	 		},
	 		select : function(event, ui) {
	 			$("#hashTagBox").append("<span class='badge badge-pill badge-secondary hashTag' id='hashtag" 
	 									+ hashTagCount + "'>" + ui.item.label + " x <input type='hidden' name='hashTag[" 
	 										+ hashTagCount + "].hashTagNo' value='" + ui.item.value + "'></span>");
				hashTagCount++;
				
				$("#hashTagAuto").text('');
				$("#hashTagAuto").val('');
	 		}
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

				<section id="updateReviewView">
					<div class="container">
					
						<!-- start:Form -->
						<h3>리뷰 등록</h3>
					
						<form id="review">
							<div class="row gtr-uniform">
							
								<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo}">
							
								<%-- <div class="col-12 col-12-xsmall">
					 				<label for="order">주문 내역</label>
					 				<p>음식점명 : ${review.restaurant.restaurantName}<br>
					 				주문한 메뉴 : 
					 				<c:forEach var="order" items="${review.reservation.order}">
   										<c:out value="${order.menuTitle}"/>
   										<c:out value="${order.orderCount}"/>
									</c:forEach> <br>
					 				방문 확정일 : ${review.reservation.fixedDate}</p>
					 			</div> --%>
							 
							 	<div class="col-md-4 star-box">
							 		<label for="scopeClean" class="starLabel">청결해요</label>
									<div class="star-in">
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
									</div>
									<input type="hidden" id="scopeClean" name="scopeClean" />
							 	</div>
							 	
								<div class="col-md-4 star-box">
									<label for="scopeTaste" class="starLabel">맛있어요</label>
									<div class="star-in">
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
									</div>
									<input type="hidden" id="scopeTaste" name="scopeTaste" />
								</div>
								
								<div class="col-md-4 star-box">
									<label for="scopeKind" class="starLabel">친절해요</label>
									<div class="star-in">
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
									</div>
									<input type="hidden" id="scopeKind" name="scopeKind" />
								</div>
								
								<c:choose>
									<c:when test="${member.memberRole eq 'admin'}">
										<div class="col-12">
											<label for="reviewImage">리뷰 이미지</label>
											<ul>
												<c:forEach var="reviewImage" items="${review.reviewImage}">
													<li>
														<img src="/resources/images/uploadImages/${reviewImage}"/>
													</li>
												</c:forEach>
											</ul>
										</div>
										
										<!-- Break -->
										<div class="col-12">
											<label for="reviewDetail">어떤 점이 좋았나요?</label>
											<p>${review.reviewDetail}</p>
										</div>
										
										<!-- Break -->
										<div class="col-12">
											<label for="hashTag">해시태그</label>
											<div class="box" id="hashTagBox">
												<c:forEach var="hashtag" items="${review.hashTag}">
													<span class='badge badge-pill badge-secondary hashTag'>${hashtag.hashTag}</span>
												</c:forEach>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-12">
											<label for="reviewImage">리뷰 이미지</label>
											<input type="file" id="file" name="file" multiple="multiple">
										</div>
										
										<!-- Break -->
										<div class="col-12">
											<label for="reviewDetail">어떤 점이 좋았나요?</label>
											<textarea name="reviewDetail" id="reviewDetail" placeholder="100자 이내로 입력해주세요." maxlength='100' rows="2">${review.reviewDetail}</textarea>
										</div>
										
										<!-- Break -->
										<div class="col-12">
											<label for="hashTag">해시태그</label>
											<input id="hashTagAuto" type="text"><br>
											
											<div class="box" id="hashTagBox">
											<c:set var="i" value="0" />
											<c:forEach var="hashtag" items="${review.hashTag}">
												<span class='badge badge-pill badge-secondary hashTag' id='hashtag${i}'>${hashtag.hashTag} x 
													<input type='hidden' name='hashTag[${i}].hashTagNo' value='${hashtag.hashTagNo}'>
												</span>
												<c:set var="i" value="${ i+1 }" />
											</c:forEach>
											</div>
											<!-- <input id="hashTagAppend" type="button" value="X"> -->
											<!-- <textarea name="review.hashTag" id="review.hashTag" placeholder="#을 입력하여 해시태그를 선택해주세요." rows="2"></textarea> -->
										</div>
									</c:otherwise>
								</c:choose>
								
								
								<!-- Break -->
								<div class="col-12${member.memberRole eq 'admin' ? '' : ' reviewShowStatus'}">
									<input type="checkbox" id="reviewShowStatus" name="reviewShowStatus" ${review.reviewShowStatus ? 'checked' : ''}> 
									<label for="reviewShowStatus">리뷰 노출 여부</label>
								</div>
								
					 	   		<!-- Break -->
								<div class="col-12">
									<ul class="actions">
										<li><input type="button" value="취소" class="normal" id="cancelBtn" /></li>
										<li><input type="button" value="수정" class="primary" id="updateBtn" /></li>
									</ul>
								</div>
						  	</div>
						</form>
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