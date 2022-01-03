<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.starBox .col-md-4 .label {
	font-size: 1.0em;
	text-align: center;
}

.starBox .col-md-4 .star_p {
	font-size: 1.0em;
	text-align: center;
}

.carousel-item {
	background: #dee2e6;
}

.carousel-item .imgBox {
	margin:auto;
	padding : 5px;
	width: 300px;
	height: 500px;
	text-align: center;
	line-height: 500px;
}

.carousel-item .imgBox:after {
	display:inline-block; 
	height:100%; 
	vertical-align:middle;
}

.carousel-item .imgBox img{
	width: 100%;
	vertical-align: middle;
}

.review-modal-top {
	text-align: right;
	padding-right: 0px;
}

.review-modal-top i {
	margin-left: 10px;
}

/* .bottom-like .check {
	fill: red;
} */

.bottom-like {
	text-align: right;
	margin-bottom: 10px;
}

.bottom-like span {
	margin-left: 10px;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var reviewNo = "";
	
    $(document).on("click", ".reviewModal", function () { 
    	reviewNo = $(this).data('id'); 
    	$("input[name='reviewNo']").val(reviewNo);
    	
    	$.ajax({
			url : "/review/json/getReview/"+reviewNo,
			method : "GET",
			dataType : "json",
			success : function(data, status) {
				console.log(data);
				console.log(data.list);
				console.log(data.listLike);
				if (data == null) {
					alert("다시 시도해주세요");
					return;
				}
				
				//review = data;
				//onsole.log(review.member.memberId);
				
				$("#reportCount").text(" " + data.list.reportCount + " 회");
				$("#reviewRegDate").text(data.list.reviewRegDate);
				$("#nickname").text(data.list.member.nickname);
				$("#memberRank").text(data.list.member.memberRank);
				
				$("#reviewCount").text(data.list.likeCount);
				
				
				$("#scopeClean").text(data.list.scopeClean);
				$("#scopeTaste").text(data.list.scopeTaste);
				$("#scopeKind").text(data.list.scopeKind);
				
				$("#reviewDetail").text(data.list.reviewDetail);
				
				reviewNo = data.list.reviewNo;
				
				$("#hashtagBox").empty();
				$.each(data.list.hashTag, function(index, item) {
					console.log(item);
					$("#hashtagBox").append("<span class='badge badge-pill badge-secondary'>" + item.hashTag + "</span>")
				});
				
				$("#reviewImage").empty();
				$.each(data.list.reviewImage, function(index, item) {
					//console.log(item);
					imageOutPut(item, index);
				});
				
				//$("#reviewImage").append("</div>");
				/* var imageControl = "<a class='carousel-control-prev' data-target='#carouselExampleIndicators' data-slide='prev'> "
								+ "<span class='carousel-control-prev-icon' aria-hidden='true'></span> " 
								+ "<span class='sr-only'>Previous</span> </a> "
								+ "<a class='carousel-control-next' data-target='#carouselExampleIndicators' data-slide='next'> "
								+ "<span class='carousel-control-next-icon' aria-hidden='true'></span>" 
								+ "<span class='sr-only'>Next</span> </a> </div> </div>";
								
				$("#reviewImage").append(imageControl); */
				
				/* for ( var item in ${listLike}) {
					if(${data.reviewNo == item.reviewNo && (!empty member && member.memberId) == item.memberId}) {
						console.log("내가 선택")
					}
				} */
				
				//좋아요
				$.each(data.listLike, function(index, item) {
					if(data.list.reviewNo == item.reviewNo) {
						$("#reviewLike").attr('class','reviewLike check'); 
					}
				});
				/* <c:forEach var="like" items="${listLike}">
					if(data.reviewNo == "${like.reviewNo}") {
						$(".reviewLike").attr('class','reviewLike check'); 
					}
				</c:forEach> */
				
				$(".footerBox").empty();
				if (${member.memberRole eq "user"} && ("${member.memberId}" == data.list.member.memberId)) {
					console.log("user");
					var footer = "<div class='modal-footer'>" 
								+ "<input type='button' class='normal' id='reviewDelete' value='삭제'></input> "
								+ "<input type='button' class='primary' id='reviewUpdate' value='수정'></input>"
								+ "</div>";
					
					$(".footerBox").append(footer);
				} else if (${member.memberRole eq "admin"}) {
					console.log("admin");
					var footer = "<div class='modal-footer'>" 
						+ "<input type='button' class='primary' id='reviewUpdate' value='수정'></input>"
						+ "</div>";
			
					$(".footerBox").append(footer);
				}
				
				$("#reviewDelete").on("click", function() {
		   	    	console.log("삭제 클릭");
		   	    	if (confirm("정말 삭제하시겠습니까?")) {
		   	    		self.location = "/review/deleteReview?reviewNo=" + reviewNo;
		   	    	}
		   	    });
		   	    
		   	    $("#reviewUpdate").on("click", function() {
		   	    	console.log("수정 클릭");
		   	    	self.location = "/review/updateReview?reviewNo=" + reviewNo;
		   	    });
			}
		}); 
    });
    
    function imageOutPut(item, index) {
    	console.log(index);
    	
    	var image = "";
    	
    	if (index == 0) {
    		console.log("active 필요");
			image = "<div class='carousel-item active'>";
		} else {
			console.log("active 필요없엉");
			image = "<div class='carousel-item'>";
		}
    	
    	/* image += " <svg class='bd-placeholder-img bd-placeholder-img-lg d-block w-100' width='100%' height='400' xmlns='http://www.w3.org/2000/svg' role='img' aria-label='Placeholder: Second slide' preserveAspectRatio='xMidYMid slice' focusable='false'> "
    			+ "<text x='50%' y='50%' fill='#444' dy='.3em'>" + item + "</text></svg> "
    			+ "</div>";  */
    			
    	image += "<div class='imgBox'> <img src='/resources/images/uploadImages/" + item + "'> </div>"
    	/* var image = "<div class='carousel-item'> <svg class='bd-placeholder-img bd-placeholder-img-lg d-block w-100' " 
    				+ "width='100%' height='400' xmlns='http://www.w3.org/2000/svg'	role='img' aria-label='Placeholder: Third slide' "
    				+ "preserveAspectRatio='xMidYMid slice' focusable='false'> <rect width='100%' height='100%' fill='#555'></rect> "
    				+ "<text x='50%' y='50%' fill='#333' dy='.3em'>" + item + "</text> </svg>"; */
		
    	/* image = "<div class='col-sm-2'> <img src='/resources/images/uploadImages/"+item+"'> </div>"; */
    	
    	$("#reviewImage").append(image);
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
			<div class="modal-body">
				<div class="col-sm-12 review-modal-top">
					<span id="reviewRegDate"></span>
					<c:if test="${member.memberRole == 'admin'}">
						<i class="fa fa-exclamation-triangle" id="reportCount" aria-hidden="true">
						</i>
					</c:if>
				</div>
				<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
				<h5 class="h6 mb-12 font-weight-normal">
					<span id="memberRank"></span> <span id="nickname"></span> 
				</h5>
				
				<br/>
				
				<div class="bd-example">
					<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
						
						 <div class="carousel-inner" id="reviewImage">
							<!-- 이미지 보여지는 곳 -->
						</div> 
						<a class="carousel-control-prev" data-target="#carouselExampleIndicators" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" data-target="#carouselExampleIndicators" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>  
					
				<br/>
					
				<div class="row starBox">
					<div class="col-md-4">
						<label for="scopeClean" class="label star_label">청결해요</label>
						<p id="scopeClean" class="star_p"></p>
					</div>
					<div class="col-md-4">
						<label for="scopeTaste" class="label star_label">맛있어요</label>
						<p id="scopeTaste" class="star_p"></p>
					</div>
					<div class="col-md-4">
						<label for="scopeKind" class="label star_label">친절해요</label> 
						<p id="scopeKind" class="star_p"></p>
					</div>
				</div>
				
				<br/>
				
				<label for="reviewDetail">어떤 점이 좋았나요?</label>
				<p id="reviewDetail"></p>
				
				<br/>
				
				<label for="hashTag">해시태그</label>
				<div class="box" id="hashtagBox" >
				</div>
				
				<div class="bottom-like">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" id="reviewLike" class="bi bi-heart-fill reviewLike" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>
					<span class="reviewCount" id="reviewCount"></span>
					<input type="hidden" name="reviewNo" value="">
				</div>
				
			</div>
			<div class="footerBox">
			</div>
			<%-- <c:if test="${!empty member}">
				<div class="modal-footer">
			        <input type="button" class="normal" id="reviewDelete" value="삭제"></input>
			        <input type="button" class="primary" id="reviewUpdate" value="수정"></input>
			    </div>
			</c:if> --%>
		</div>
	</div>
</div>