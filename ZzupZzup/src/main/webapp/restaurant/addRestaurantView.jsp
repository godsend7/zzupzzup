<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<jsp:include page="/layout/toolbar.jsp" />

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
		function daumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                //document.getElementById('sample4_postcode').value = data.zonecode;
	                
	                $("#streetAddress").val(roadAddr);
	                $("#areaAddress").val(data.jibunAddress);
	                
	               	$("#restAddress").attr("readonly",false);
	                $("#restAddress").focus();
	                //self.close();
	                /* 
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                	addr += extraRoadAddr;
	                } else {
	                	addr += ' ';
	                }
	
	              	var guideTextBox = $("#guide").val();
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                } */
	            }
	        }).open();
	    }
	</script>

	<script type="text/javascript">
	
		function fncAddRestaurant(){
			
			var restaurantName = $("input[name='restaurantName']").val();
			var restaurantTel = $("input[name='restaurantTel']").val();
			var streetAddress = $("input[name='streetAddress']").val();
			var areaAddress = $("input[name='areaAddress']").val();
			var restAddress = $("input[name='restAddress']").val();
			var menuType = $("select[name='menuType']").val();
			
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
		
			$("#restaurant").attr("method" , "POST").attr("action" , "/restaurant/addRestaurant").submit();
			
		}
		
		window.onload = function(){
			// 등록 버튼 실행
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "#button1" ).on("click" , function() {
					fncAddRestaurant();
				});
				
			});
			
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "#button2" ).on("click" , function() {
					daumPostcode();
				});
				
			});
		}
	</script>

<div class="container">

	<h2>음식점 등록하기</h2>
	
	<form class="form-horizontal" id="restaurant">
	
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
		<label for="streetAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 주소</label>
		<div class="col-sm-7">
			<input type="text" class="form-control" id="streetAddress" name="streetAddress" placeholder="음식점 도로명주소" readonly="readonly">
			<input type="text" class="form-control" id="areaAddress" name="areaAddress" placeholder="음식점 지번주소" readonly="readonly">
			<input type="text" class="form-control" id="restAddress" name="restAddress" placeholder="음식점 상세주소" readonly="readonly">
			<button type="button" class="btn btn-warning btn-sm" id="button2">주소찾기</button>
		</div>
	</div>
	
	<!-- <div class="form-group">
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
	</div> -->
	
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
	
	<div class="col-sm-4">음식점 메뉴
		<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[0].menuTitle" placeholder="음식점 메뉴이름">
		<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[0].menuPrice" placeholder="음식점 메뉴가격">
		<input type="text" class="form-control" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" placeholder="대표메뉴 여부">
	</div><br>
	
	<div class="col-sm-4">음식점 운영시간
		<input type="text" name="restaurantTimes[0].restaurantDay" placeholder="음식점 운영요일">
		<input type="text" name="restaurantTimes[0].restaurantOpen" placeholder="음식점 오픈시간">
		<input type="text" name="restaurantTimes[0].restaurantClose" placeholder="음식점 폐점시간">
		<input type="text" name="restaurantTimes[0].restaurantBreak" placeholder="음식점 브레이크타임">
		<input type="text" name="restaurantTimes[0].restaurantLastOrder" placeholder="음식점 마지막주문시간">
		<input type="text" name="restaurantTimes[0].restaurantDayOff" placeholder="음식점 휴무일">
	</div><hr>
	
	<div class="col-sm-4">음식점 사진
		<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
		<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
		<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
	</div><br>
	
	<!-- <div class="form-group"> -->
		<div class="text-center">
			<!-- <button type="button" class="btn btn-warning" id="button1">등 &nbsp;록</button> -->
			<input type='submit' id="button1">
		</div>
	<!-- </div> -->
	
	</form>
	
</div>
<jsp:include page="/layout/sidebar.jsp" />