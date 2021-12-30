<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("template.jsp");
	});
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
				
				<section id="">
					<div class="container">
						
						<h2>음식점 등록하기</h2><hr>
	
						<form class="form-horizontal" id="restaurant">
						
						<input type="hidden" name="member.memberId" value="${member.memberId}">
						<input type="hidden" name="member.memberName" value="${member.memberName}">
						
						<div class="form-group">
							<label for="restaurantName" class="col-sm-offset-1 col-sm-3 control-label">음식점명</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="restaurantName" name="restaurantName" value="${restaurant.restaurantName}">
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
								<button type="button" class="normal btn-sm" id="button2">주소찾기</button>
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
						
						<div class="col-sm-4">
							<label>음식점 메뉴</label>
						</div>
						<div class="col-9 row">
							<div class="col">
								<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[0].menuTitle" placeholder="음식점 메뉴이름">
							</div>
							<div class="col">
								<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[0].menuPrice" placeholder="음식점 메뉴가격">
							</div>
							<div class="col">	
								<!-- <input type="text" class="form-control" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" placeholder="대표메뉴 여부"> -->
								<input type="checkbox" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" value="1">
								<label for="mainMenuStatus">메인메뉴</label>
							</div>
						</div><br>
						
						<div class="col-9 row">
							<div class="col">
								<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[1].menuTitle" placeholder="음식점 메뉴이름">
							</div>
							<div class="col">
								<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[1].menuPrice" placeholder="음식점 메뉴가격">
							</div>
							<div class="col">	
								<!-- <input type="text" class="form-control" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" placeholder="대표메뉴 여부"> -->
								<input type="checkbox" id="mainMenuStatus1" name="restaurantMenus[1].mainMenuStatus" value="1">
								<label for="mainMenuStatus1">메인메뉴</label>
							</div>
						</div><br>
						
						<div class="col-sm-8">
							<label>음식점 운영요일</label>
							<!-- <input type="text" name="restaurantTimes[0].restaurantDay" placeholder="음식점 운영요일"> -->
							<div>
								<input type="radio" id="monday" name="restaurantTimes[0].restaurantDay" value="1" checked> <label for="monday">월</label>
								<input type="radio" id="tuesday" name="restaurantTimes[0].restaurantDay" value="2"> <label for="tuesday">화</label>
								<input type="radio" id="wednesday" name="restaurantTimes[0].restaurantDay" value="3"> <label for="wednesday">수</label>
								<input type="radio" id="thursday" name="restaurantTimes[0].restaurantDay" value="4"> <label for="thursday">목</label>
								<input type="radio" id="friday" name="restaurantTimes[0].restaurantDay" value="5"> <label for="friday">금</label>
								<input type="radio" id="saturday" name="restaurantTimes[0].restaurantDay" value="6"> <label for="saturday">토</label>
								<input type="radio" id="sunday" name="restaurantTimes[0].restaurantDay" value="7"> <label for="sunday">일</label>
						    	<input type="checkbox" id="dayoff" name="restaurantMenus[0].restaurantDayOff" value="1"> <label for="dayoff">휴무일</label>
						    </div>
						</div><br>
						
						<div class="col-sm-8">
							<label>음식점 운영요일</label>
							<!-- <input type="text" name="restaurantTimes[0].restaurantDay" placeholder="음식점 운영요일"> -->
							<div>
								<input type="radio" id="monday1" name="restaurantTimes[1].restaurantDay" value="1" checked> <label for="monday1">월</label>
								<input type="radio" id="tuesday1" name="restaurantTimes[1].restaurantDay" value="2"> <label for="tuesday1">화</label>
								<input type="radio" id="wednesday1" name="restaurantTimes[1].restaurantDay" value="3"> <label for="wednesday1">수</label>
								<input type="radio" id="thursday1" name="restaurantTimes[1].restaurantDay" value="4"> <label for="thursday1">목</label>
								<input type="radio" id="friday1" name="restaurantTimes[1].restaurantDay" value="5"> <label for="friday1">금</label>
								<input type="radio" id="saturday1" name="restaurantTimes[1].restaurantDay" value="6"> <label for="saturday1">토</label>
								<input type="radio" id="sunday1" name="restaurantTimes[1].restaurantDay" value="7"> <label for="sunday1">일</label>
						    	<input type="checkbox" id="dayoff1" name="restaurantMenus[1].restaurantDayOff" value="1"> <label for="dayoff1">휴무일</label>
						    </div>
						</div><br>
						
						<div class="col-sm-4">
							<label>음식점 운영시간</label>
						</div>
						<div class="col-8 row">
						    <div class="col">오픈시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantOpen">
						    </div>
						    <div class="col">마감시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantClose">
						    </div>
						    <div class="col">브레이크타임
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantBreak">
						    </div>
						    <div class="col">라스트오더
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantLastOrder">
						    </div>
						</div><br>
						
						<div class="col-8 row">
						    <div class="col">오픈시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[1].restaurantOpen">
						    </div>
						    <div class="col">마감시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[1].restaurantClose">
						    </div>
						    <div class="col">브레이크타임
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[1].restaurantBreak">
						    </div>
						    <div class="col">라스트오더
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[1].restaurantLastOrder">
						    </div>
						</div><br><br>
						
						<!-- <div class="col-sm-4">음식점 운영시간
							<input type="text" name="restaurantTimes[0].restaurantOpen" placeholder="음식점 오픈시간">
							<input type="text" name="restaurantTimes[0].restaurantClose" placeholder="음식점 폐점시간">
							<input type="text" name="restaurantTimes[0].restaurantBreak" placeholder="음식점 브레이크타임">
							<input type="text" name="restaurantTimes[0].restaurantLastOrder" placeholder="음식점 마지막주문시간">
							<input type="text" name="restaurantTimes[0].restaurantDayOff" placeholder="음식점 휴무일">
						</div> -->
						
						<div class="col-sm-4">
							<label for="restaurantImage">음식점 이미지</label>
							<input type="file" id="file" name="file" multiple="multiple">
							
							<!-- <input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
							<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
							<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진"> -->
						</div><br><br>
						
						<div class="col-sm-12">
							<label for="restaurantText">음식점 소개글</label>
							<textarea id="restaurantText" name="restaurantText" placeholder="음식점 소개글" rows="3" style="resize: none; height: 10em;"></textarea>
						</div><br><hr>
						
						<!-- <div class="form-group"> -->
							<div class="text-center">
								<!-- <button type="button" class="btn btn-warning" id="button1">등 &nbsp;록</button> -->
								<input type='submit' id="button1" class="primary" />
							</div>
						<!-- </div> -->
						
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