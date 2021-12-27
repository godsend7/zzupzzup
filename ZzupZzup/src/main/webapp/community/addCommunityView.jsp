<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/layout/toolbar.jsp" />

	<script type="text/javascript">
	
		function fncAddCommunity(){
			
			var memberId = $("input[name='memberId']").val();
			var postTitle = $("input[name='postTitle']").val();
			var postText = $("input[name='postText']").val();
			var restaurantName = $("input[name='restaurantName']").val();
			var restaurantTel = $("input[name='restaurantTel']").val();
			var streetAddress = $("input[name='streetAddress']").val();
			var areaAddress = $("input[name='areaAddress']").val();
			var restAddress = $("input[name='restAddress']").val();
			var menuType = $("select[name='menuType']").val();
			var mainMenuTitle = $("input[name='mainMenuTitle']").val();
			var mainMenuPrice = $("input[name='mainMenuPrice']").val();
			
			console.log(restaurantName);
			
		
			if(restaurantName == null || restaurantName.length<1){
				alert("음식점명을 입력해주세요");
				return;
			}
			
			if(restaurantTel == null || restaurantTel.length<1){
				alert("음식점 전화번호를 입력해주세요");
				return;
			}
			
			if(streetAddress == null || streetAddress.length<1){
				alert("음식점 도로명 주소를 입력해주세요");
				return;
			}
			
			if(areaAddress == null || areaAddress.length<1){
				alert("음식점 지번 주소를 입력해주세요");
				return;
			}
			
			if(restAddress == null || restAddress.length<1){
				alert("음식점 상세 주소를 입력해주세요");
				return;
			}
			
			if(menuType == null || menuType.length<1){
				alert("음식 종류를 선책해주세요");
				return;
			}
			
		
			$("#community").attr("method" , "POST").attr("action" , "/community/addCommunity").submit();
			
		}
		
		window.onload = function(){
		// 등록 버튼 실행
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#button" ).on("click" , function() {
				fncAddCommunity();
			});
			
		});
		
		}
	</script>

<div class="container">

	<h2>게시물 등록하기</h2>
	
	<form class="form-horizontal" id="community">
	
	<div class="form-group">
		<label for="memberId" class="col-sm-offset-1 col-sm-3 control-label">작성자 아이디</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="memberId" name="memberId" placeholder="작성자 아이디">
		</div>
	</div>
	
	<div class="form-group">
		<label for="postTitle" class="col-sm-offset-1 col-sm-3 control-label">게시물 제목</label>
		<div class="col-sm-12">
			<input type="text" class="form-control" id="postTitle" name="postTitle" placeholder="게시물 제목">
		</div>
	</div>
	
	<div class="form-group">
		<label for="postText" class="col-sm-offset-1 col-sm-3 control-label">게시물 소개글</label>
		<div class="col-sm-12">
			<!-- <label for="textarea">게시물 소개글</label> -->
			<textarea id="postText" name="postText" placeholder="게시물 소개글" rows="3" style="resize: none; height: 50em;"></textarea>
			<!-- <input type="text" class="form-control" id="postText" name="postText" placeholder="게시물 소개글"> -->
		</div>
	</div><hr>
	
	<div class="form-group">
		<label for="restaurantName" class="col-sm-offset-1 col-sm-3 control-label">음식점명</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="restaurantName" name="restaurantName" placeholder="음식점명">
		</div>
	</div>
	
	<div class="form-group">
		<label for="restaurantTel" class="col-sm-offset-1 col-sm-3 control-label">음식점 전화번호</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="restaurantTel" name="restaurantTel" placeholder="음식점 전화번호">
		</div>
	</div>
	
	<div class="form-group">
		<label for="streetAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 도로명주소</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="streetAddress" name="streetAddress" placeholder="음식점 도로명주소">
		</div>
	</div>
	
	<div class="form-group">
		<label for="areaAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 지번주소</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="areaAddress" name="areaAddress" placeholder="음식점 지번주소">
		</div>
	</div>
	
	<div class="form-group">
		<label for="restAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 상세주소</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="restAddress" name="restAddress" placeholder="음식점 상세주소">
		</div>
	</div>
	
	<div class="col-sm-4">
		<label for="country">음식 종류</label>
		<select class="custom-select d-block w-100" id="menuType" name="menuType" required>
			<option value="">음식 종류</option>
			<option value="1">한식</option>
			<option value="2">중식</option>
			<option value="3">일식</option>
			<option value="4">양식</option>
			<option value="5">카페</option>
		</select>
		<div class="invalid-feedback">
			Please select a menu type
		</div>
	</div><br>
	
	<div class="form-group">
		<label for="mainMenuTitle" class="col-sm-offset-1 col-sm-3 control-label">음식점 메인메뉴 이름</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="mainMenuTitle" name="mainMenuTitle" placeholder="음식점 메인메뉴 이름">
		</div>
	</div>
	
	<div class="form-group">
		<label for="mainMenuPrice" class="col-sm-offset-1 col-sm-3 control-label">음식점 메인메뉴 가격</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="mainMenuPrice" name="mainMenuPrice" placeholder="음식점 메인메뉴 가격">
		</div>
	</div><hr>
	
	<!-- <div class="form-group"> -->
		<div class="text-center">
			<button type="button" class="btn btn-warning" id="button">등 &nbsp;록</button>
		</div>
	<!-- </div> -->
	
	</form>
	
</div>
<jsp:include page="/layout/sidebar.jsp" />