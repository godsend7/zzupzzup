<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />



<div class="container">

	<!-- start:Form -->
	<h3>쩝쩝친구 생성</h3>

	<form method="post" action="#">
		<div class="row gtr-uniform">
			<div class="col-6 col-12-xsmall">
				<label for="restauratName">음식점명</label> <input type="text"
					name="restauratName" id="restauratName" value="" placeholder="" />
					
					<input type="hidden" name="restaurantNo" id="restaurantNo" value="1">
			</div>
			<div class="col-6 col-12-xsmall">
				<label for="chatTitle">채팅방 제목</label> <input type="text"
					name="chatTitle" id="chatTitle" placeholder="" />
			</div>
			<!-- Break -->
			<div class="col-4 col-12-small">
				<label for="chatLeaderId">개설자 닉네임</label> <input type="text"
					name="chatLeaderId" id="chatLeaderId" placeholder="" />
			</div>			
			<!-- Break -->
			<div class="col-12">
				<label for="chatGender">참여가능 성별</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="male" name="chatGender" value="1"
					checked> <label for="demo-priority-low">남</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="female" name="chatGender" value="2">
				<label for="demo-priority-normal">여</label>
			</div>
			<div class="col-4 col-12-small">
				<input type="radio" id="malefemale" name="chatGender" value="3">
				<label for="demo-priority-high">성별무관</label>
			</div>
			<!-- Break -->
			<div class="col-12">
				<label for="chatAge">참여가능 연령대</label>
			</div>
			<div class="col-1 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="1"> <label
					for="chatAge">10대</label>
			</div>
			<div class="col-1 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="2"> <label
					for="chatAge">20대</label>
			</div>
			<div class="col-1 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="3"> <label
					for="chatAge">30대</label>
			</div>
			<div class="col-1 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="4"> <label
					for="chatAge">40대</label>
			</div>
			<div class="col-1 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="5"> <label
					for="chatAge">50대</label>
			</div>
			<div class="col-2 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="6"> <label
					for="chatAge">60대 이상</label>
			</div>
			<div class="col-2 col-12-small">
				<input type="checkbox" id="chatAge" name="chatAge" value="7"> <label
					for="chatAge">연령대 무관</label>
			</div>
			<!-- Break -->
			<div class="col-12">
				<label for="chatText">채팅방 소개글</label>
				<textarea name="chatText" id="chatText"
					placeholder="Enter your message" rows="6"></textarea>
			</div>
			<!-- Break -->
			<div class="col-12">
				<ul class="actions">
					<li><input type="submit" value="채팅방 등록" class="primary" /></li>
					<li><input type="reset" value="취소" class="normal" /></li>
				</ul>
			</div>
		</div>
	</form>
	<!-- end -->

</div>

<jsp:include page="/layout/sidebar.jsp" />

<script>
function fncAddProduct(){
	
	
	//==> submit 기능
	$("form").attr("method", "POST").attr("action", "/chat/addChat").submit();
}

$(function() {
	
	//==> Form Submit 처리
	$("input[type='submit'].primary").on("click", function(){
		fncAddProduct();
	});
	
});
</script>