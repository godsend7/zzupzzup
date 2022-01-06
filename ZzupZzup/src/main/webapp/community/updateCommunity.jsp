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
						
						<h2>게시물 수정하기</h2><hr>
					
						<form class="form-horizontal" id="community">
						<!-- 
						<div class="form-group">
							<label for="memberId" class="col-sm-offset-1 col-sm-3 control-label">작성자 아이디</label>
							<div class="col-sm-4">
								
							</div>
						</div> -->
						
						<input type="hidden" class="form-control" id="member.memberId" name="member.memberId" value="${member.memberId}">
						<input type="hidden" class="form-control" id="member.nickname" name="member.nickname" value="${member.nickname}">
						
						<div class="form-group">
							<label for="postTitle" class="col-sm-offset-1 col-sm-3 control-label">게시물 제목</label>
							<div class="col-sm-12">
								<input type="text" class="form-control" id="postTitle" name="postTitle" value="${community.postTitle}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="postText" class="col-sm-offset-1 col-sm-3 control-label">게시물 소개글</label>
							<div class="col-sm-12">
								<!-- <label for="textarea">게시물 소개글</label> -->
								<textarea id="postText" name="postText" rows="3" style="resize: none; height: 50em;">${community.postText}</textarea>
								<!-- <input type="text" class="form-control" id="postText" name="postText" placeholder="게시물 소개글"> -->
							</div>
						</div><hr>
						
						<div class="form-group">
							<label for="restaurantName" class="col-sm-offset-1 col-sm-3 control-label">음식점명</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="restaurantName" name="restaurantName" value="${community.restaurantName}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="restaurantTel" class="col-sm-offset-1 col-sm-3 control-label">음식점 전화번호</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="restaurantTel" name="restaurantTel" value="${community.restaurantTel}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="streetAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="streetAddress" name="streetAddress" value="${community.streetAddress}" readonly="readonly">
								<input type="text" class="form-control" id="areaAddress" name="areaAddress" value="${community.areaAddress}" readonly="readonly">
								<input type="text" class="form-control" id="restAddress" name="restAddress" value="${community.restAddress}" readonly="readonly">
								<button type="button" class="normal btn-sm" id="button2">주소찾기</button>
							</div>
						</div>
						
						<!-- <div class="form-group">
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
						</div> -->
						
						<div class="col-sm-4">
							<label for="country">음식 종류</label>
							<select class="custom-select d-block w-100" id="menuType" name="menuType" required>
								<option value="">음식 종류</option>
								<option value="1" ${!empty community.menuType && community.menuType == "1" ? "selected" : ""}>한식</option>
								<option value="2" ${!empty community.menuType && community.menuType == "2" ? "selected" : ""}>중식</option>
								<option value="3" ${!empty community.menuType && community.menuType == "3" ? "selected" : ""}>일식</option>
								<option value="4" ${!empty community.menuType && community.menuType == "4" ? "selected" : ""}>양식</option>
								<option value="5" ${!empty community.menuType && community.menuType == "5" ? "selected" : ""}>카페</option>
							</select>
							<div class="invalid-feedback">
								Please select a menu type
							</div>
						</div><br>
						
						<div class="form-group">
							<label for="mainMenuTitle" class="col-sm-offset-1 col-sm-3 control-label">음식점 메인메뉴 이름</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="mainMenuTitle" name="mainMenuTitle" value="${community.mainMenuTitle}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="mainMenuPrice" class="col-sm-offset-1 col-sm-3 control-label">음식점 메인메뉴 가격</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="mainMenuPrice" name="mainMenuPrice" value="${community.mainMenuPrice}">
							</div>
						</div><hr>
						
						<div class="col-sm-8">
							<label>음식점 운영요일</label>
							<!-- <input type="text" name="restaurantTimes[0].restaurantDay" placeholder="음식점 운영요일"> -->
							<div>
								<input type="radio" id="monday" name="restaurantTimes[0].restaurantDay" value="1" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "1" ? "checked" : ""}>
								<label for="monday">월</label>
								<input type="radio" id="tuesday" name="restaurantTimes[0].restaurantDay" value="2" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "2" ? "checked" : ""}>
								<label for="tuesday">화</label>
								<input type="radio" id="wednesday" name="restaurantTimes[0].restaurantDay" value="3" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "3" ? "checked" : ""}>
								<label for="wednesday">수</label>
								<input type="radio" id="thursday" name="restaurantTimes[0].restaurantDay" value="4" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "4" ? "checked" : ""}>
								<label for="thursday">목</label>
								<input type="radio" id="friday" name="restaurantTimes[0].restaurantDay" value="5" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "5" ? "checked" : ""}>
								<label for="friday">금</label>
								<input type="radio" id="saturday" name="restaurantTimes[0].restaurantDay" value="6" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "6" ? "checked" : ""}>
								<label for="saturday">토</label>
								<input type="radio" id="sunday" name="restaurantTimes[0].restaurantDay" value="7" 
								${!empty community.restaurantTimes[0].restaurantDay && community.restaurantTimes[0].restaurantDay == "7" ? "checked" : ""}>
								<label for="sunday">일</label>
						    	<input type="checkbox" id="dayoff" name="restaurantTimes[0].restaurantDayOff" value="1" 
						    	${!empty community.restaurantTimes[0].restaurantDayOff && community.restaurantTimes[0].restaurantDayOff == "1" ? "checked" : ""}>
						    	<label for="dayoff">휴무일</label>
						    </div>
						</div><br>
						
						<div class="col-sm-4">
							<label>음식점 운영시간</label>
						</div>
						<div class="col-8 row">
						    <div class="col">오픈시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantOpen" value="${community.restaurantTimes[0].restaurantOpen}">
						    </div>
						    <div class="col">마감시간
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantClose" value="${community.restaurantTimes[0].restaurantClose}">
						    </div>
						    <div class="col">브레이크타임
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantBreak" value="${community.restaurantTimes[0].restaurantBreak}">
						    </div>
						    <div class="col">라스트오더
						    	<label for="time"></label>
						    	<input type="time" id="time" name="restaurantTimes[0].restaurantLastOrder" value="${community.restaurantTimes[0].restaurantLastOrder}">
						    </div>
						</div><br><hr>
						
						<!-- <div class="form-group"> -->
							<div class="text-center">
								<button type="button" class="btn btn-warning" id="button1">수 &nbsp;정</button>
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