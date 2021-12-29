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

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
var review = "";
	/* $(function() {
		
	});
	
	$(document).ready(function() {     
        $('#insertBlack').on('show.bs.modal', function(event) {          
            NOTIFYID = $(event.relatedTarget).data('notifyid');
            NONNOTIFYID = $(event.relatedTarget).data('nonnotifyid');
            NCONTENT = $(event.relatedTarget).data('ncontent');
        });
    }); */
    
    $(document).on("click", ".stretched-link", function () { 
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
				
				
				$.each(data.hashTag, function(index, item) {
					$("#hashtagBox").append("<span class='badge badge-pill badge-secondary'>" + item.hashTag + "</span>")
				});
			}
		}); 
    });
    
    window.onload = function () {
    	$("#reviewDelete").on("click", function() {
   	    	console.log("삭제 클릭");
   	    });
   	    
   	    $("#reviewUpdate").on("click", function() {
   	    	console.log("수정 클릭");
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
					<!-- <div class="col-12" style="float: right;">
						<span>수정</span>    <span>삭제</span>	
					</div> -->
					<div class="mb-6" style="float: right;">
						<span id="reviewRegDate"></span>
					</div>
					<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
					<h5 class="h6 mb-6 font-weight-normal">
						<span id="memberRank"></span> <span id="nickname"></span> 
					</h5>
					<br/>
					<div class="row">
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
					
					<label for="reviewDetail" >리뷰 상세내용</label>
					<p id="reviewDetail"></p>
					
					<br/>
					
					<label for="hashTag">해시태그</label>
					<div id="hashtagBox"></div>
					
					<div class="checkbox mb-6">
						<input type="checkbox" class="custom-control-input" id="persistLogin" value="" /> 
						<label for="persistLogin">로그인 유지(구현 예정)</label>
					</div>
					<br/>
					<input class="btn btn-lg btn-primary btn-block" id="login"
						type="button" value="login" /> <input
						class="btn btn-lg btn-primary btn-block" id="kakaoLogin"
						type="button" value="카카오 로그인 (구현 예정)" /> <input
						class="btn btn-lg btn-primary btn-block" id="naverLogin"
						type="button" value="네이버 로그인 (구현 예정)" /><br/><br/>
						회원이 아니신가요? > 
						<a href="/member/addMember/user">
						<input type="hidden" value="user"/>유저</a>&nbsp;/
						<a href="/member/addMember/owner">
						<input type="hidden" value="owner"/>업주</a>
					<p class="mt-5 mb-3 text-muted" style="text-align: right;" id="reviewLike"></p>
				
			</div>
			<div class="modal-footer">
		        <input type="button" class="normal" id="reviewDelete" value="삭제"></input>
		        <input type="button" class="primary" id="reviewUpdate" value="수정"></input>
		    </div>
		</div>
	</div>
</div>