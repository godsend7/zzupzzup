<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-addReviewView</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	*{margin:0; padding:0;}
	.starClean{
	 background: url(http://gahyun.wooga.kr/main/img/testImg/star.png);
	  display:inline-block;
	  width: 50px;height: 50px;
	  background-size: contain;
	  cursor: pointer;
	}
	
	.starClean.on{
	  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
	}
	
	.starTaste{
	 background: url(http://gahyun.wooga.kr/main/img/testImg/star.png);
	  display:inline-block;
	  width: 50px;height: 50px;
	  background-size: contain;
	  cursor: pointer;
	}
	
	.starTaste.on{
	  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
	}
	
	.starKind{
	 background: url(http://gahyun.wooga.kr/main/img/testImg/star.png);
	  display:inline-block;
	  width: 50px;height: 50px;
	  background-size: contain;
	  cursor: pointer;
	}
	
	.starKind.on{
	  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
	}
	
	@media screen and (max-width: 480px){
		.star { width: 40px; height: 40px;}
	
	}
	
	.starLabel {
		text-align: center;
	}
	
	.star-box {
		margin-right: 80px;
	}
	
	textarea {
		resize: none;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var scopeClean = 0;
	var scopeTaste = 0;
	var scopeKind = 0;
	
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

	window.onload = function() {
		
		$(".starClean").on('click',function(){
			var idx = $(this).index();
			scopeClean = idx+1;
	  		$(".starClean").removeClass("on");
	  		for(var i=0; i<=idx; i++){
	        	$(".starClean").eq(i).addClass("on");
	   		}
		});
		
		$(".starTaste").on('click',function(){
			var idx = $(this).index();
			scopeTaste = idx+1;
	  		$(".starTaste").removeClass("on");
	  		for(var i=0; i<=idx; i++){
	        	$(".starTaste").eq(i).addClass("on");
	   		}
		});
		
		$(".starKind").on('click',function(){
			var idx = $(this).index();
			scopeKind = idx+1;
	  		$(".starKind").removeClass("on");
	  		for(var i=0; i<=idx; i++){
	        	$(".starKind").eq(i).addClass("on");
	   		}
		});
		
		$("#addBtn").on("click", function() {
			console.log("button");
			funAddReview();
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
							 
							 	<div class="star-box">
							 		<label for="scopeClean" class="starLabel">청결해요</label>
									<div>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
									</div>
									<input type="hidden" id="scopeClean" name="scopeClean" />
							 	</div>
							 	
								<div class="star-box">
									<label for="scopeTaste" class="starLabel">맛있해요</label>
									<div >
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
									</div>
									<input type="hidden" id="scopeTaste" name="scopeTaste" />
								</div>
								
								<div class="star-box">
									<label for="scopeKind" class="starLabel">친절해요</label>
									<div>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
									</div>
									<input type="hidden" id="scopeKind" name="scopeKind" />
								</div>
								
								<div class="col-6 col-12-small">
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
									<textarea name="review.hashTag" id="review.hashTag" placeholder="#을 입력하여 해시태그를 선택해주세요." rows="2"></textarea>
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