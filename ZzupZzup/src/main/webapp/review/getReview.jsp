<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/resources/css/review.css" />


<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

#container {
    width: 400px;
    overflow: hidden;
    margin: 40px auto;
}

.thumbs {
    margin-top: 10px;
    display: flex;
    justify-content: center;
}

.thumbs li,
.thumbs li a {
    width: 65px;
    height: 55px;
    margin: 2px;
}

.thumbs a {
    /*display: block;*/
    position: relative;
    color: #515151;
    text-decoration: none;
    
}

.thumbs li a img {
    width: 65px;
    height: 45px;
  	opacity: 0.7;
}

.thumbs li a:hover span {
    position: absolute;
    z-index: 101;
    bottom: -30px;
    display: block;
    width: 100%;
    height: 50px;
    text-align: center;
    border-radius: 3px;
    box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.4);
    background: #fff;
    background: linear-gradient(top, #fff 0%,  #bcbcbc 100%);
}


.slide {
    overflow: hidden; 
}

.slide,
.slide li,
.slide img {
    width: 100%;
    height: 250px;
    position: relative;
  background-size: cover;
}

.slide li {
    position: absolute;
    z-index: 50;
}

/*Animation For Slider*/
@-webkit-keyframes slider {
    0% {left: -500px;}
    100% {left: 0;}
}

.slide li:target {
    z-index: 100;
    -webkit-animation: slider 1s 1;
}

/*Not Target*/
@-webkit-keyframes noTarget {
    0% {z-index: 75;}
    100% {z-index: 75;}
}

.slide li:not(:target) {
    -webkit-animation: noTarget 1s 1;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var reviewNo = "";
	
	
	
    $(document).on("click", ".reviewModal", function () { 
    	reviewNo = $(this).data('id'); 
    	//console.log(reviewNo);
    	
    	$("input[name='reviewNo']").val(reviewNo);
    	
    	$.ajax({
			url : "/review/json/getReview/"+reviewNo,
			method : "GET",
			dataType : "json",
			success : function(data, status) {
				//console.log(reviewNo);
				//console.log(data.list);
				//console.log(data.listLike);
				if (data == null) {
					alert("다시 시도해주세요");
					return;
				}
				
				//review = data;
				//console.log(data.list.reportCount);
				
				$("#reportCountTT").text(" " + data.list.reportCount + " 회");
				
				
				$("#reviewShowStatus").removeClass();
				if (!data.list.reviewShowStatus) {
					$("#reviewShowStatus").addClass("fa fa-eye-slash");
				}
				
				$("#reviewRegDate").text(data.list.reviewRegDate);
				$(".getOtherUserModal").attr("data-id", data.list.member.memberId);
				$("#nickname").text(data.list.member.nickname);
				$("#memberRank").text(data.list.member.memberRank);
				
				$("#reviewCount").text(data.list.likeCount);
				
				$(".starClean").removeClass('on'); 
				for (var i = 0; i < data.list.scopeClean; i++) {
			  		$(".starClean").eq(i).addClass("on");
				}
				
				$(".starTaste").removeClass('on'); 
				for (var i = 0; i < data.list.scopeTaste; i++) {
			  		$(".starTaste").eq(i).addClass("on");
				}
				
				$(".starKind").removeClass('on'); 
				for (var i = 0; i < data.list.scopeKind; i++) {
			  		$(".starKind").eq(i).addClass("on");
				}
				
				$("#reviewDetail").text(data.list.reviewDetail);
				
				reviewNo = data.list.reviewNo;
				
				$("#hashtagBox").empty();
				$.each(data.list.hashTag, function(index, item) {
					//console.log(item);
					$("#hashtagBox").append("<span class='badge badge-pill badge-secondary'>" + item.hashTag + "</span>")
				});
				
				$(".slide").empty();
		    	$(".thumbs").empty();
				if (data.list.reviewImage.length != 0) {
					$.each(data.list.reviewImage, function(index, item) {
						//console.log(item);
						imageOutPut(item, index);
					});
				} else {
					$("#container").text("등록된 이미지 없습니다.");
				}
				
				//좋아요
				$("#reviewLike").removeClass('check'); 
				$.each(data.listLike, function(index, item) {
					if(data.list.reviewNo == item.reviewNo) {
						$("#reviewLike").addClass('check'); 
					}
				});
			
				
				$(".footerBox").empty();
				$(".footer2").empty();
				if (${member.memberRole eq "user"} && ("${member.memberId}" == data.list.member.memberId)) {
					var footer = "<div class='footer2'><input type='button' class='normal' id='reviewDelete' value='삭제'></input> "
								+ "<input type='button' class='primary' id='reviewUpdate' value='수정'></input></div>";
					
					$(".review-modal-footer").append(footer);
				} else if (${member.memberRole eq "admin"}) {
					var footer = "<div class='modal-footer'>" 
						+ "<input type='button' class='primary' id='reviewUpdate' value='수정'></input>"
						+ "</div>";
			
					$(".footerBox").append(footer);
				}
				
				$("#reviewDelete").on("click", function() {
		   	    	//console.log("삭제 클릭");
		   	    	if (confirm("정말 삭제하시겠습니까?")) {
		   	    		self.location = "/review/deleteReview?reviewNo=" + reviewNo;
		   	    	}
		   	    });
		   	    
		   	    $("#reviewUpdate").on("click", function() {
		   	    	//console.log("수정 클릭");
		   	    	self.location = "/review/updateReview?reviewNo=" + reviewNo;
		   	    });
		   	    
		   	    //console.log(reviewNo);
		   	    //report data-id 값 등록
		   	    var dataId = "[3,"+reviewNo+"]";
		   	 	//console.log(dataId);
		   	 	//console.log("1 ::" + $(".reportModal").attr("data-id"));
		   	 	$(".reportModal").removeAttr("data-id");
		   	 	//console.log("2 ::" + $(".reportModal").attr("data-id"));
		   	    $(".reportModal").attr("data-id", dataId);
		   	 	//console.log("3 ::" + $(".reportModal").attr("data-id"));
			}
		}); 
    });
    
    function imageOutPut(item, index) {
    	//console.log(index);
    	
    	var sliderImage = "";
    	var thumbsImage = "";
    	/* if (index == 0) {
			image = "<div class='carousel-item active'>";
		} else {
			image = "<div class='carousel-item'>";
		} */
    	
    	if (index == 0) {
    		sliderImage = '<li class="first" id="slide-' + (index+1) +'">';
		} else {
			sliderImage = '<li id="slide-' + (index+1) +'">';
		}
    	
		
		
    	/* image += "<div class='imgBox'> <img src='/resources/images/uploadImages/review/" + item + "'> </div>"*/
    	//image += "<div class='imgBox'> <img src='https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/" + item + "'> </div>" 
    	//image = "<img src='https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/" + item + "'>" ;
    	sliderImage += "<img src='https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/" + item + "' alt='' /></li>" ;
    	thumbsImage = '<li><a href="#slide-'+ (index+1) +'"><img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/' + item + '" /></a></li>';
    	
    	$(".slide").append(sliderImage);
    	$(".thumbs").append(thumbsImage);
    
    }
    	
    $(function() {
   	    
   		// carousel prev & next
		$("#car_prev").on("click", function(){
			console.log("prev");
			$("#carouselExampleIndicators").carousel("prev");
		});
		
		$("#car_next").on("click", function(){
			console.log("next");
			$("#carouselExampleIndicators").carousel("next");
		});
		
		/* $(".reportModal").on("click", function(){
			$("#reviewModal").modal("hide");
		}); */
		
		$('#reviewModal').on('hidden.bs.modal', function () {
			console.log("reviewModal 종료");
			//location.reload();
    	});
    });
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
			<div class="modal-body" style="padding: 2rem;">
				<div class="col-sm-12 review-modal-top">
					<span id="reviewRegDate"></span>
					<c:if test="${member.memberRole eq 'admin'}">
						<i class="" aria-hidden="true" id="reviewShowStatus"></i>
						<i class="fa fa-exclamation-triangle" id="reportCount" aria-hidden="true">
							<span id="reportCountTT"></span>
						</i>
					</c:if>
				</div>
				<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
				<h3 class="mb-0 getOtherUserModal"  data-toggle="modal" data-target="#getOtherUserModal">
					<span id="memberRank" class="badge badge-pill badge-primary">
					</span>&nbsp; <span id="nickname"></span> 
				</h3>
				
				<br/>
				
				<label for="reviewImage">리뷰 이미지</label>
				<!-- <div class="bd-example">
					<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
						
						 <div class="carousel-inner" id="reviewImage">
							이미지 보여지는 곳
						</div> 
						<button class="carousel-control-prev btn-outline-link" type="button" id="car_prev" data-target="#carouselExampleIndicators" data-slide="prev"
					  		style="border: none; outline: none; box-shadow: none; height: 200px; background-color:transparent;">
					    	<span class="carousel-control-prev-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
					    	<span class="sr-only">Previous</span>
					  	</button>
					  	<button class="carousel-control-next btn-outline-link" type="button" id="car_next" data-target="#carouselExampleIndicators" data-slide="next"
					  		style="border: none; outline: none; box-shadow: none; height: 200px; background-color:transparent;">
					    	<span class="carousel-control-next-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
					    	<span class="sr-only">Next</span>
					  	</button>
						<a class="carousel-control-prev" data-target="#carouselExampleIndicators" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" data-target="#carouselExampleIndicators" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div> -->
				
				
		        <div id="container">
		        
		            <ul class="slide">
		                <!-- <li class="first" id="slide-1"><img src="https://placeimg.com/640/480/arch" alt="" /></li>
		                <li id="slide-2"><img src="https://placeimg.com/640/480/nature" alt="" /></li>
		                <li id="slide-3"><img src="https://placeimg.com/640/480/people" alt="" /></li>
		                <li id="slide-4"><img src="https://placeimg.com/640/480/tech" alt="" /></li> -->
		                
		            </ul>
		
		            <ul class="thumbs">
		                <!-- <li><a href="#slide-1"><img src="https://placeimg.com/640/480/arch" /></a></li>
		                <li><a href="#slide-2"><img src="https://placeimg.com/640/480/nature" /></a></li>
		                <li><a href="#slide-3"><img src="https://placeimg.com/640/480/people" /></a></li>
		                <li><a href="#slide-4"><img src="https://placeimg.com/640/480/tech" /></a></li> -->
		                
		            </ul>
		      </div>


				
				<br/>
				
				<label for="reviewStar">음식점 평가</label>
				<div class="row starBox">
					<div class="col-md-4">
						<label for="scopeClean" class="label star_label">청결해요</label>
						<div class="star-in">
							<span class="star-modal starClean"></span>
							<span class="star-modal starClean"></span>
							<span class="star-modal starClean"></span>
							<span class="star-modal starClean"></span>
							<span class="star-modal starClean"></span>
						</div>
					</div>
					<div class="col-md-4">
						<label for="scopeTaste" class="label star_label">맛있어요</label>
						<div class="star-in">
							<span class="star-modal starTaste"></span>
							<span class="star-modal starTaste"></span>
							<span class="star-modal starTaste"></span>
							<span class="star-modal starTaste"></span>
							<span class="star-modal starTaste"></span>
						</div>
					</div>
					<div class="col-md-4">
						<label for="scopeKind" class="label star_label">친절해요</label> 
						<div class="star-in">
							<span class="star-modal starKind"></span>
							<span class="star-modal starKind"></span>
							<span class="star-modal starKind"></span>
							<span class="star-modal starKind"></span>
							<span class="star-modal starKind"></span>
						</div>
					</div>
				</div>
				
				<br/>
				
				<label for="reviewDetail">어떤 점이 좋았나요?</label>
				<p id="reviewDetail"></p>
				
				<br/>
				
				<label for="hashTag">해시태그</label>
				<div class="box" id="hashtagBox">
				</div>
				
				<div class="bottom-like">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" id="reviewLike" class="bi bi-heart-fill reviewLike" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>
					<span class="reviewCount" id="reviewCount"></span>
					<input type="hidden" name="reviewNo" value="">
				</div>
				
			</div>
			<div class="footerBox">
			</div>
			<c:if test="${!empty member && member.memberRole eq 'user'}">
				<div class="modal-footer review-modal-footer">
					<div> 
						<input type='button' class='danger reportModal' value='신고' data-toggle='modal' data-target='#reportModal'></input>
					</div>
			    </div>
			</c:if>
		</div>
	</div>
</div>

<ul class='icons'> 
	<jsp:include page='/report/addReportView.jsp'/>
</ul>