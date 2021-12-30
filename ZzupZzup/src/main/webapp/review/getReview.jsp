<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.label {
	font-size: 1.0em;
}

.star_label {
	text-align: center;
}

.star_p {
	font-size: 1.0em;
	text-align: center;
}

img {
	width: 100%;
	
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
    $(document).on("click", ".reviewModal", function () { 
    	var reviewNo = $(this).data('id'); 
    	
    	//console.log(reviewNo);
    	$.ajax({
			url : "/review/json/getReview/"+reviewNo,
			method : "GET",
			dataType : "json",
			success : function(data, status) {
				console.log(data);
				//review = data;
				//onsole.log(review.member.memberId);
				
				$("#nickname").text(data.member.nickname);
				$("#memberRank").text(data.member.memberRank);
				$("#reviewRegDate").text(data.reviewRegDate);
				$("#reviewLike").text("좋아요 수 : " + data.likeCount);
				
				$("#scopeClean").text(data.scopeClean);
				$("#scopeTaste").text(data.scopeTaste);
				$("#scopeKind").text(data.scopeKind);
				
				$("#reviewDetail").text(data.reviewDetail);
				$()
				
				
				$("#hashtagBox").empty();
				$.each(data.hashTag, function(index, item) {
					console.log(item);
					$("#hashtagBox").append("<span class='badge badge-pill badge-secondary'>" + item.hashTag + "</span>")
				});
				
				$("#reviewImage").empty();
				$.each(data.reviewImage, function(index, item) {
					console.log(item);
					imageOutPut(item);
				});
				
				if (!data) {
					alert("다시 시도해주세요");
				}
			}
		}); 
    });
    
    function imageOutPut(item) {
    	console.log(item);
    	/* var image = "<div class='carousel-item'> <svg class='bd-placeholder-img bd-placeholder-img-lg d-block w-100' " 
    				+ "width='100%' height='400' xmlns='http://www.w3.org/2000/svg'	role='img' aria-label='Placeholder: Third slide' "
    				+ "preserveAspectRatio='xMidYMid slice' focusable='false'> <rect width='100%' height='100%' fill='#555'></rect> "
    				+ "<text x='50%' y='50%' fill='#333' dy='.3em'>" + item + "</text> </svg>"; */
		
    	var image = "<div class='col-sm-2'> <img src='/resources/images/uploadImages/"+item+"'> </div>";
    	
    	$("#reviewImage").append(image);
    } 
    
    window.onload = function () {
    	$("#reviewDelete").on("click", function() {
   	    	console.log("삭제 클릭");
   	    });
   	    
   	    $("#reviewUpdate").on("click", function() {
   	    	console.log("수정 클릭");
   	    });
   	    
   	// carousel prev & next
		$("#car_prev").on("click", function(){
			console.log("prev");
			$("#carouselExampleIndicators").carousel("prev");
		});
		
		$("#car_next").on("click", function(){
			console.log("next");
			$("#carouselExampleIndicators").carousel("next");
		});
    }
   
</script>


<!-- Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog"
	aria-labelledby="reviewModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content modal-lg">
			<div class="modal-header">
				<h3 class="modal-title" id="reviewModalLabel">리뷰 상세보기</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="mb-6" style="float: right;">
					<span id="reviewRegDate">${sessionScope.review.reviewRegDate}</span>
				</div>
				<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
				<h5 class="h6 mb-6 font-weight-normal">
					<span id="memberRank">${sessionScope.review.member.memberRank}</span> <span id="nickname">${sessionScope.review.member.nickname}</span> 
				</h5>
				
				<br/>
				
				<div class="row" id="reviewImage">
				
				</div>
				
				<%-- <div class="bd-example">
					<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0" class=""></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1" class=""></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2" class="active"></li>
						</ol>
						
						<div class="carousel-inner" id="reviewImage">
							<c:forEach var="reviewImage" items="${sessionScope.review.reviewImage}">
								<div class="carousel-item active">
									<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
										role="img" aria-label="Placeholder: Third slide" preserveAspectRatio="xMidYMid slice" focusable="false">
										<rect width="100%" height="100%" fill="#555"></rect>
										<text x="50%" y="50%" fill="#333" dy=".3em">${reviewImage}</text>
									</svg>
								</div>
							</c:forEach> 
							<!-- <div class="carousel-item">
								<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
									role="img" aria-label="Placeholder: First slide" preserveAspectRatio="xMidYMid slice" focusable="false"> 
									<img alt="" src="" width="100%" height="50%">
									<rect width="100%" height="100%" fill="#777"></rect>
									<text x="50%" y="50%" fill="#555" dy=".3em">First slide</text>
								</svg>
							</div>
						
							<div class="carousel-item">
								<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
									role="img" aria-label="Placeholder: Second slide" preserveAspectRatio="xMidYMid slice" focusable="false">
									<rect width="100%" height="100%" fill="#666"></rect>
									<text x="50%" y="50%" fill="#444" dy=".3em">Second slide</text>
								</svg>
							</div>
								
							
							<div class="carousel-item active">
								<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
									role="img" aria-label="Placeholder: Third slide" preserveAspectRatio="xMidYMid slice" focusable="false">
									<rect width="100%" height="100%" fill="#555"></rect>
									<text x="50%" y="50%" fill="#333" dy=".3em">Third slide</text>
								</svg>
							</div> -->
						</div>
						<a class="carousel-control-prev" id="car_prev" data-target="#carouselExampleIndicators" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" id="car_next" data-target="#carouselExampleIndicators" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div> --%>
					
				<br/>
					
				<div class="row">
					<div class="col-md-4">
						<label for="scopeClean" class="label star_label">청결해요</label>
						<p id="scopeClean" class="star_p">${sessionScope.review.scopeClean}</p>
					</div>
					<div class="col-md-4">
						<label for="scopeTaste" class="label star_label">맛있어요</label>
						<p id="scopeTaste" class="star_p">${sessionScope.review.scopeTaste}</p>
					</div>
					<div class="col-md-4">
						<label for="scopeKind" class="label star_label">친절해요</label> 
						<p id="scopeKind" class="star_p">${sessionScope.review.scopeKind}</p>
					</div>
				</div>
				
				<br/>
				
				<label for="reviewDetail">리뷰 상세내용</label>
				<p id="reviewDetail">${sessionScope.review.reviewDetail}</p>
				
				<br/>
				
				<label for="hashTag">해시태그</label>
				<div class="box" id="hashtagBox" >
					<c:forEach var="hashtag" items="${sessionScope.review.hashTag}">
						<span class='badge badge-pill badge-secondary'>${hashtag.hashTag}</span>
					</c:forEach>
				</div>
				
				<p class="mt-5 mb-3 text-muted" style="text-align: right;" id="reviewLike"></p>
				
			</div>
			<div class="modal-footer">
		        <input type="button" class="normal" id="reviewDelete" value="삭제"></input>
		        <input type="button" class="secondary" id="reviewDelete" value="삭제"></input>
		        <input type="button" class="primary" id="reviewUpdate" value="수정"></input>
		    </div>
		</div>
	</div>
</div>