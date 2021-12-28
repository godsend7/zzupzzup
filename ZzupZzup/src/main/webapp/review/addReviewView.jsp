<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-addReviewView</title>

<jsp:include page="/layout/toolbar.jsp" />
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/css/review.css" />
 
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var scopeClean = 0;
	var scopeTaste = 0;
	var scopeKind = 0;
	
	//hashTag id 초기화
	var hashTagCount = 0;
	
	function funAddReview() {
		console.log("funAddReview");
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
		
		$("#review").attr("method", "POST").attr("action" , "/review/addReview").attr("enctype", "multipart/form-data").submit();
	} 
	
	function funAddHashTag() {
		console.log("click!");
		
	}
	
	window.onload = function() {
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
		
		$("#addBtn").on("click", function() {
			console.log("button");
			funAddReview();
		});
		
		//button click 시 append
		$("#hashTagAppend").on("click", function() {
			$("#hashTagBox").append("<span class='badge badge-pill badge-secondary hashTag' id='hashtag" + hashTagCount + "'>#인스타 맛집  x</span>");
			hashTagCount++;
		});
		
		$("#hashTagBox").on("click", "span", function(e) {
			e.stopPropagation();
			
			$(this).remove();
			
			if ($("#hashTagBox").children().length == 0) {
				hashTagCount = 0;
			}
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
						var arrayLayout = new Array();
						
						$.each(data, function(index, item) {
							console.log(item.hashTag);
							arrayLayout.push(item.hashTag);
						});
						
						response(arrayLayout);//response 
					}
	      		});
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

				<section id="addReviewView">
					<div class="container">
					
						<!-- start:Form -->
						<h3>리뷰 등록</h3>
					
						<form id="review">
							<div class="row gtr-uniform">
							
								<input type="hidden" id="member.memberId" name="member.memberId" value="${member.memberId}">
								<input type="hidden" id="reservation.reservationNo" name="reservation.reservationNo" value="${review.reservation.reservationNo}">
								<input type="hidden" id="restaurant.restaurantNo" name="restaurant.restaurantNo" value="${review.restaurant.restaurantNo}">
							
								<div class="col-12 col-12-xsmall">
					 				<label for="order">주문 내역</label>
					 				<p>음식점명 : ${review.restaurant.restaurantName}<br>
					 				주문한 메뉴 : 
					 				<c:forEach var="order" items="${review.reservation.order}">
   										<c:out value="${order.menuTitle}"/>
   										<c:out value="${order.orderCount}"/>
									</c:forEach> <br>
					 				방문 확정일 : ${review.reservation.fixedDate}</p>
					 			</div>
							 
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
									<label for="scopeTaste" class="starLabel">맛있해요</label>
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
								
								<div class="col-12">
									<label for="reviewImage">리뷰 이미지</label>
									<input type="file" id="file" name="file" multiple="multiple">
								</div>
								
								<!-- Break -->
								<div class="col-12">
									<label for="reviewDetail">어떤 점이 좋았나요?</label>
									<textarea name="reviewDetail" id="reviewDetail" placeholder="100자 이내로 입력해주세요." maxlength='100' rows="2"></textarea>
								</div>
								
								<!-- Break -->
								<div class="col-12">
									<label for="hashTag">해시태그 등록</label>
									<input id="hashTagAuto" type="text"><br>
									
									<div class="box" id="hashTagBox">
										<!-- <span class='badge badge-pill badge-secondary' id="hashtag0">#인스타 맛집  x</span> -->
									</div>
									<!-- <input id="hashTagAppend" type="button" value="X"> -->
									<!-- <textarea name="review.hashTag" id="review.hashTag" placeholder="#을 입력하여 해시태그를 선택해주세요." rows="2"></textarea> -->
								</div>
								
					 	   		<!-- Break -->
								<div class="col-12">
									<ul class="actions">
										<li><input type="button" value="등록" class="primary" id="addBtn" /></li>
										<li><input type="reset" value="이전" class="normal" /></li>
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