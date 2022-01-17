<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 목록</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />


<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
	function fncPageNavigation(currentPage) {
		console.log(currentPage);
		$("#currentPage").val(currentPage);
		$("#chatForm").attr("method", "POST").attr("action", "/chat/listChat").submit();
	}
	
	$(function() {
		console.log("listChat.jsp");
		let chatMemberList = [];
		
		//============= 페이지 로딩시 정렬 조건이 있다면 주입 =========
		/* if(localStorage.getItem('sortType')){
			//console.log(localStorage.getItem('sortType'));
			//$("input[name=searchSort]").val(localStorage.getItem('sortType'));
			$("input[name=searchSort]").val("${search.searchSort}");
		} */
		
		//============= 페이지 로딩시 필터 조건이 있다면 표시 ========
		if("${search.searchFilter}" != null && "${search.searchFilter}" != ""){
			//console.log("필터 조건?? ${search.searchFilter}");
			$("input:checkbox[value=${search.searchFilter}]").prop("checked", true);
			$("input:checkbox[value=${search.searchFilter}]").addClass("active");
		}
		
		//============= "검색"  Event  처리 =============
		$(".search-btn").on("click", function() {
			fncPageNavigation(1);
		});
		
		//============= "작성하기"  Event  처리 =============		
		$("a.button:contains(작성하기)").on("click", function(e) {
			e.preventDefault();
			window.open("/chat/addChat", "_self");
		});
		
		//============= "무한스크롤"  Event  처리 =============
		let count = 2;
		$(window).on("scroll", function(){
			
			let scrTop = $(window).scrollTop();
			let scrBtm = $(document).height() - $(window).height() - $(window).scrollTop();
			let currentPage = $("#currentPage").val();
			$("#currentPage").val(count);
			//console.log("top : " + scrTop);
			//console.log("bottom : " + scrBtm);
			//console.log("count : " + count);
			if(scrBtm <= 0 ){
				//console.log("바닥이야");
				//console.log($("#chatForm"));
				//console.log($("#searchKeyword").val());
				let queryStr = $("#chatForm").serialize();
				console.log(queryStr);
				
				$.ajax({
					url: "/chat/json/listChat",
					method: "POST",
					dataType: "json",
					data: queryStr,
					beforeSend : function() {
						
					},
					success : function(JSONData, status) {
						console.log(JSONData);
						
						let dom ='';
						$.each(JSONData, function(index, item){
							//console.log(item);
							//console.log(item.chatShowStatus);
							//미노출 게시판일시 관리자만 보이기
							if("${member.memberRole}" != 'admin' && item.chatShowStatus == false){
								return true;
							}
							
							dom += '<div class="col-md-6">'
								+'<div class="card mb-4 shadow-sm chat-state'+item.chatState+'">'
								+'<div class="card-head d-flex">'
								+'<span class="badge badge-secondary chat-no mr-2">'+item.chatNo+'</span>';
								if(item.chatLeaderId.memberId == "${member.memberId}"){
									dom += '<span class="badge badge-secondary mr-1">개설자</span>';
								}
								$.each(item.chatMember, function(indexx, itemm){
									if("${member.memberId}" == itemm.member.memberId && itemm.member.memberId != item.chatLeaderId.memberId && itemm.inOutCheck == true){
										dom += '<span class="badge badge-secondary mr-1">참가중</span>';
									}
								});
								if(item.chatShowStatus == false){
									dom += '<span class="badge badge-danger mr-1">미노출</span>';
								}
								switch(item.chatState){
								case 1:
									dom += '<span class="badge badge-success chat-state">모집중</span>';
								break
								case 2:
									dom += '<span class="badge badge-warning chat-state">인원확정</span>';
								break
								case 3:
									dom += '<span class="badge badge-info chat-state">예약확정</span>';
								break
								case 4:
									dom += '<span class="badge badge-warning chat-state">모임완료</span>';
								break
								case 5:
									dom += '<span class="badge badge-danger chat-state">폭파된방</span>';
								break
								}
								dom += '</div>'
								+'<div class="card-img">';
								//이미지 경로 변경
								/* +'<img src="/resources/images/uploadImages/chat/'+item.chatImage+'">' */
								if(item.chatImage == 'chatimg.jpg'){
									dom +='<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/'+item.chatImage+'">';
								}else if(item.chatImage != 'chatimg.jpg'){
									dom +='<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/chat/'+item.chatImage+'">';
								}
								dom += '</div>'
								+'<div class="card-body">';
								if("${member.memberRole}" == 'admin'){
									dom += '<div class="chat-rating-info">';
									if(item.chatShowStatus == false){
										dom += '<i class="fa fa-eye-slash" aria-hidden="true"></i>';
									}
									dom += '<i class="fa fa-exclamation-triangle" aria-hidden="true">'
									+item.reportCount +' 회</i>'
									+'</div>';
								}
								dom += '<h4 class="card-title">'+item.chatTitle+'</h4>'
								+'<h5 class="card-text mb-2 text-muted">'+item.chatText+'</h5>'
								+'<div class="d-flex justify-content-between align-items-end">'
								+'<div>'
								+'<p class="card-text text-right">'+item.chatRestaurant.restaurantName;
								switch(item.chatRestaurant.menuType){
									case 1:
										dom += '<span>(한식)</span></p>';
									break
									case 2:
										dom += '<span>(중식)</span></p>';
									break
									case 3:
										dom += '<span>(양식)</span></p>';
									break
									case 4:
										dom += '<span>(일식)</span></p>';
									break
									case 5:
										dom += '<span>(카페)</span></p>';
									break
								}
								dom += '<p class="card-text text-right">'+item.chatRestaurant.streetAddress+'</p>'
								+'</div>'
								+'<div class="btn-group">';
								if(item.chatMember != [] && item.chatMember != null && item.chatMember.length > 0){
									let isChatMember = false;
									$.each(item.chatMember, function(indexxx, itemmm){
										//console.log("indexxx : " + indexxx);
										//console.log("length : " + item.chatMember.length);
										if("${member.memberId}" == itemmm.member.memberId){
											isChatMember = true;
										}
										if("${member.memberId}" == itemmm.member.memberId && item.chatState == 4 && itemmm.inOutCheck == true && itemmm.readyCheck == true && item.chatMember.length >= 1){
											dom += '<a href="/chat/json/listReadyCheckMember/chatNo='+item.chatNo+'" class="button small primary" data-toggle="modal" data-target="#chatRatingModal">평가하기</a>';
										}
									});
									if(isChatMember == false){
										dom	+= '<a href="/chat/json/getChat/'+item.chatNo+'" class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal" data-no="'+item.chatNo+'" data-id="${member.memberId}" id="getChatEntranceBtn">참여하기</a>';
									}else if(isChatMember == true && item.chatState != 5){
										dom += '<a href="/chat/getChatEntrance?chatNo='+item.chatNo+'" class="button small success get-chat-btn">입장하기</a>';
									}
								}else{
									dom	+= '<a href="/chat/json/getChat/'+item.chatNo+'" class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal" id="getChatEntranceBtn">참여하기</a>';
								}
								dom += '</div>'
								+'</div>'
								+'</div>'
								+'</div>'
								+'</div>';
						});
						$(".thumb-list").append(dom);
						if(JSONData.length != 0){
							count++;
						}else{
							if(!$("#listChat .alert").length){
								alert_dom = '<div class="alert alert-danger alert-dismissible thumb-list-alert" role="alert"><strong>스크롤 중지!</strong> 리스트가 더 존재하지 않습니다.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>	</div>';							
								$("#listChat").append(alert_dom);
								$("#listChat .alert").fadeIn();
							}
						}
					},
					error : function(request, status, error) {
						let errorMsg = "로그인이 필요합니다!";
						if(request.status == 200 && request.responseText.indexOf(errorMsg) != -1 ){					
							alert("로그인이 필요합니다!");
							location.href='/';
						}
					}
				});
			}
		});
		
		//============= "평가하기" Event 처리 ============
		$("body").on("click", "a.button:contains(평가하기)", function(e) {
			e.preventDefault();
			let url = $(this).attr("href");
			$.ajax({
				url : url,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {
					console.log("평가하기 가져온 데이터 :"+ JSONData);
					console.log()
					let dom ='<form id="addRating"><input type="hidden" name="ratingFromId" value="${member.memberId}"/><input type="hidden" name="chatNo" value="'+JSONData.list[0].chatNo+'"/>';
					let i = 0;
					$.each(JSONData.list, function(index, item){
						console.log(item);
						if("${member.memberId}" != item.member.memberId){
							dom += '<dl>'
								+'<dt>'+item.member.nickname+'<input type="hidden" name="ratingToId" value="'+item.member.memberId+'"/></dt>'
								+'<dd class="d-flex flex-column">'
								+'<input type="radio" id="bad'+i+'" name="ratingType['+i+']" value=1 checked>'
								+'<label for="bad'+i+'">별로에요</label>'
								+'<input type="radio" id="good'+i+'" name="ratingType['+i+']" value=2>'
								+'<label for="good'+i+'">좋아요</label>'
								+'<input type="radio" id="best'+i+'" name="ratingType['+i+']" value=3>'
								+'<label for="best'+i+'">최고에요</label>'
								+'</dd>'
								+'</dl>';
							i++;
						}
						//console.log(dom);
					});
					dom +='</form>';
					$("#chatRatingModal").find(".modal-body").html(dom);
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		});
		
		//============= "평가하기" Event 처리 ============
		$("body").on("click", "button:contains(평가)", function(e) {
			console.log("제출 클릭");
			
			let ratingFlag = false;
			
			//$('#ratingGoModal').modal('show');
			
			let url = "/rating/json/addRating";
			let ratingArr = [];
			let ratingDataObj = {};
			
			for( let i=0; i<$("#addRating dl").length; i++ ){
				let ratingToId = $("#addRating dl").eq(i).find("input[name=ratingToId]").val();
				let ratingType = $("input[name='ratingType["+i+"]']:checked").val();
				
				ratingDataObj.chatNo = $("input[name=chatNo]").val();
				ratingDataObj.ratingFromId = $("input[name=ratingFromId]").val();
				ratingDataObj.ratingToId = ratingToId;
				ratingDataObj.ratingType = ratingType;
				
				ratingArr.push(ratingDataObj);
				
				ratingDataObj = {};
			}
			
			//console.log(ratingArr);
			let jsonData = JSON.stringify(ratingArr);
			//console.log({ratingArrObj : jsonData});
			
			$.ajax({
				url : url,
				type : "POST",
				traditional: true,
				data: JSON.stringify ({
					ratingArrObj : jsonData
				}),
				contentType: "application/json",
				dataType : "JSON",
				success : function(JSONData, status) {
					console.log("success");
					//$("#ratingGoModal").modal('hide');
					$("#chatRatingModal").modal('hide');
					$("#chatRatingModal").find(".modal-body").html("");
					$("#ratingEndModal").modal('show');
					//$("a.button:contains(평가하기)").remove();
				},
				error : function(request, status, error) {
					/* alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error); */
					
					let errorMsg = "Duplicate entry";
					if(request.status == 500 && request.responseText.indexOf(errorMsg) != -1 ){					
						alert("이미 평가를 하셨습니다");
						$('#ratingGoModal').modal('hide');
						$('#chatRatingModal').modal('hide');
					}
				}
			});
			
		});
		
		//============= "평가하기 예" Event 처리 ============ 없앰
		$("body").on("click", "#ratingGo", function(e) {
		
			let url = "/rating/json/addRating";
			let ratingArr = [];
			let ratingDataObj = {};
			
			for( let i=0; i<$("#addRating dl").length; i++ ){
				let ratingToId = $("#addRating dl").eq(i).find("input[name=ratingToId]").val();
				let ratingType = $("input[name='ratingType["+i+"]']:checked").val();
				
				ratingDataObj.chatNo = $("input[name=chatNo]").val();
				ratingDataObj.ratingFromId = $("input[name=ratingFromId]").val();
				ratingDataObj.ratingToId = ratingToId;
				ratingDataObj.ratingType = ratingType;
				
				ratingArr.push(ratingDataObj);
				
				ratingDataObj = {};
			}
			
			//console.log(ratingArr);
			let jsonData = JSON.stringify(ratingArr);
			//console.log({ratingArrObj : jsonData});
			
			$.ajax({
				url : url,
				type : "POST",
				traditional: true,
				data: JSON.stringify ({
					ratingArrObj : jsonData
				}),
				contentType: "application/json",
				dataType : "JSON",
				success : function(JSONData, status) {
					console.log("success");
					$("#ratingGoModal").modal('hide');
					$("#chatRatingModal").modal('hide');
					$("#chatRatingModal").find(".modal-body").html("");
					$("#ratingEndModal").modal('show');
					$("a.button:contains(평가하기)").remove();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
					
					let errorMsg = "Duplicate entry";
					if(request.status == 500 && request.responseText.indexOf(errorMsg) != -1 ){					
						alert("이미 평가를 하셨습니다");
						$('#ratingGoModal').modal('hide');
						$('#chatRatingModal').modal('hide');
					}
				}
			});
		});
		
		//============= "입장하기" Event 처리 ============
		$("body").on("click", "input[value='입장하기']", function(){
			console.log("${member}");
			
			//채팅방 상태
			const chatState = $(this).parents(".modal-content").find("#getChatState").children("span").text();
			//채팅방 성별
			const chatGender = $(this).parents(".modal-content").find("#chatGender").val();
			//채팅방 연령대
			const chatAge = $(this).parents(".modal-content").find("#chatAge").val();
			//채팅방 개설자 아이디 현재 쓰이지 않음
			const chatLeaderId = $(this).parents(".modal-content").find("#chatLeaderId").val();
			//입장하는 사람 아이디
			const chatMemberId = "${member.memberId}";
			//입장하는 사람 성별
			let chatMemberGender = "${member.gender}";
			//입장하는 사람 연령대
			let chatMemberAge = "${member.ageRange}";
						
			chatMemberGender = genderCng(chatMemberGender);
			chatMemberAge = ageCng(chatMemberAge);
			
			//console.log("바뀐 성별 : " + chatMemberGender);
			//console.log("바뀐 나이 : " + chatMemberAge);
			//console.log(chatMemberList);
			
			//채팅 멤버 체크 플래그			
			let flag = false;
			//현재 들어가있는 채팅 멤버는 필터링 되면 안됨
			$.each(chatMemberList, function(index, item){
				if(item == chatMemberId){
					flag = true;
				}
			});
			
			//참여가능 연령대 배열로 변경
			let chatAgeArr = chatAge.split(",");
			//참여가능 연령대와 유저 연령대가 맞는지 체크 플래그
			let ageFlag = false;
			$.each(chatAgeArr, function(index, item){
				if(item == chatMemberAge){
					ageFlag = true;
				}
				
			});
			
			// 현재 참여중이 아닌 유저 필터링
			if(!flag){
				//모집중이 아닌 채팅방은 들어갈 수 없다.
				if(chatState != "모집중"){
					$('#chatStateModal').modal('show');
					return;
				}
				//성별 무관이 아닐때 채팅방 성별과 유저 성별 필터링
				if(chatGender != 3 ){
					if(chatGender != chatMemberGender){
						$('#chatGenderModal').modal('show');
						return;
					}
				}
				//연령대 무관이 아닐 때 채팅방 연령대와 유저 연령대 필터링
				if(chatAge != 7 ){
					if(!ageFlag){
						$('#chatAgeModal').modal('show');
						return;
					}
				}
			}
			
			let chatNo = $(this).attr("data-target");
			location.href="/chat/getChatEntrance?chatNo="+chatNo;
		});
		
		//정렬 클릭
		$(".search-sort").on("click", function(e){
			e.preventDefault();
			let sortType = $(this).attr("data-sort");
			console.log(sortType);
			
			//let localStorage = window.localStorage;
			//localStorage.setItem('sortType', sortType);
			
			//$("input[name=searchSort]").val(localStorage.getItem('sortType'));
			$("input[name=searchSort]").val(sortType);
			
			console.log(localStorage.getItem('sortType'));
			
			fncPageNavigation(1);
		});
		
		//필터 클릭
		$("input:checkbox[name='searchFilter']").on("click", function(e){
			//console.log("클릭함");
			let isActive = $(this).hasClass("active");
			if(isActive){
				$("input:checkbox[name='searchFilter']").prop("checked", false);
				$("input:checkbox[name='searchFilter']").removeClass("active");
			}else{
				$("input:checkbox[name='searchFilter']").prop("checked", false);
				$("input:checkbox[name='searchFilter']").removeClass("active");
				$(this).prop("checked", true);
				$(this).addClass("active");
				fncPageNavigation(1);
			}
		});
		//젠더 데이터 값 변경
		function genderCng(gender){
			switch(gender){				
				case 'female':
					return 2;
				case 'male':
					return 1;
			}
		}
		
		//연령대 데이터 값 변경
		function ageCng(age){
			switch(age){
				case '10대':
					return 1;
				case '20대':
					return 2;
				case '30대':
					return 3;
				case '40대':
					return 4;
				case '50대':
					return 5;
				case '60대':
					return 6;
			}
		}
			
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

				<section id="listChat" class="chatting">

					<div class="container">

						<h2>쩝쩝친구 구하기</h2>
						<!-- S:Search -->
						<form id="chatForm" name="chatForm">
							<div class="container">
								<div class="row search-box gtr-uniform">
									<div class="col-md-4 d-flex">
										
										<div class="dropmenu float-left mr-2">
											<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순</a>
												<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
												<input type="hidden" name="searchSort" value="${search.searchSort}">
											</div>
										</div>
										<div class="dropmenu float-left">
											<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
											
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<input type="checkbox" id="filterMy" class="search-filter" name="searchFilter" value="11"><label for="filterMy">내가 참여중인 채팅방</label>
												<hr class="dropdown-divider">
												<input type="checkbox" id="chatAge1" class="search-filter" name="searchFilter" value="1"><label for="chatAge1">10대</label>
												<input type="checkbox" id="chatAge2" class="search-filter" name="searchFilter" value="2"><label for="chatAge2">20대</label>
												<input type="checkbox" id="chatAge3" class="search-filter" name="searchFilter" value="3"><label for="chatAge3">30대</label>
												<input type="checkbox" id="chatAge4" class="search-filter" name="searchFilter" value="4"><label for="chatAge4">40대</label>
												<input type="checkbox" id="chatAge5" class="search-filter" name="searchFilter" value="5"><label for="chatAge5">50대</label>
												<input type="checkbox" id="chatAge6" class="search-filter" name="searchFilter" value="6"><label for="chatAge6">60대 이상</label>
												<input type="checkbox" id="chatAge7" class="search-filter" name="searchFilter" value="7"><label for="chatAge7">연령대 무관</label>
												<hr class="dropdown-divider">
												<input type="checkbox" id="male" class="search-filter" name="searchFilter" value="8"><label for="male">남자</label>
												<input type="checkbox" id="female" class="search-filter" name="searchFilter" value="9"><label for="female">여자</label>
												<input type="checkbox" id="malefemale" class="search-filter" name="searchFilter" value="10"><label for="malefemale">성별 무관</label>
												<c:if test='${member.memberRole eq "admin"}'>
												<hr class="dropdown-divider">
												<input type="checkbox" id="filterReport" class="search-filter" name="searchFilter" value="12"><label for="filterReport">신고횟수 5회 이상</label>
												</c:if>
											</div>
										</div>
									</div>
									<div class="col-md-5 d-flex align-items-center">
										<select id="searchCondition" name="searchCondition" class="mr-2">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
										</select> <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어" class="pr-5" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#" class="button primary icon solid fa-search search-btn"></a>

										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value="1" />
									</div>
									<div class="col-md-3 d-flex justify-content-end align-items-center">
										<c:if test="${member.memberRole != 'admin'}">
											<a href="" class="button svg-btn" >
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
													<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
													<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
												</svg> 작성하기
											</a>
										</c:if>
									</div>
								</div>
							</div>
						</form>
						<!-- E:Search -->

						<!-- S:Thumbnail -->
						<div class="container">
							<div class="row thumb-list">

								<c:if test="${empty list }">
									<div class="col-md-12 text-center">
										찾으시는 채팅방이 없습니다.
									</div>
								</c:if>
								<c:if test="${!empty list }">
									<c:forEach var="chat" items="${list}">
										<c:set var="showStatus" value="false"/>
										<c:if test="${chat.chatShowStatus == false and member.memberRole eq 'admin' }">
											<c:set var="showStatus" value="false"/>
										</c:if>
										<c:if test="${chat.chatShowStatus == false and member.memberRole eq 'user' }">
											<c:set var="showStatus" value="true"/>
										</c:if>
										<c:if test="${not showStatus}">
										<div class="col-md-6">
											<div class="card mb-4 shadow-sm chat-state${chat.chatState}">
												<div class="card-head d-flex">
													<span class="badge badge-secondary chat-no mr-2">${chat.chatNo }</span>
													<c:if test="${chat.chatLeaderId.memberId == member.memberId }">
													<span class="badge badge-secondary mr-1">개설자</span>
													</c:if>
													<c:set var="i" value="0" />
													<c:forEach var="chatMember" items="${chat.chatMember}">
													<c:set var="i" value="${ i+1 }" />
														<c:if test="${member.memberId == chatMember.member.memberId && chatMember.member.memberId != chat.chatLeaderId.memberId && chatMember.inOutCheck == true}">
														<span class="badge badge-secondary mr-1">참가중</span>
														</c:if>
													</c:forEach>
													<c:if test="${chat.chatShowStatus == false }">
														<span class="badge badge-danger mr-1">미노출</span>
													</c:if>
													<c:choose>
														<c:when test="${chat.chatState=='1'}">
															<span class="badge badge-success chat-state">모집중</span>
														</c:when>
														<c:when test="${chat.chatState=='2'}">
															<span class="badge badge-warning chat-state">인원확정</span>
														</c:when>
														<c:when test="${chat.chatState=='3'}">
															<span class="badge badge-info chat-state">예약확정</span>
														</c:when>
														<c:when test="${chat.chatState=='4'}">
															<span class="badge badge-warning chat-state">모임완료</span>
														</c:when>
														<c:when test="${chat.chatState=='5'}">
															<span class="badge badge-danger chat-state">폭파된방</span>
														</c:when>
													</c:choose>
												</div>
												<div class="card-img">
													<!-- 이미지 경로 변경 -->
													<%-- <img src="/resources/images/uploadImages/chat/${chat.chatImage}"> --%>
													<c:if test="${chat.chatImage == 'chatimg.jpg' }">
													<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/${chat.chatImage}">
													</c:if>
													<c:if test="${chat.chatImage != 'chatimg.jpg' }">
													<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/chat/${chat.chatImage}">
													</c:if>
												</div>
												<div class="card-body">
													<c:if test="${member.memberRole == 'admin'}">
													<div class="chat-rating-info">
														<c:if test="${chat.chatShowStatus == false }">
															<i class="fa fa-eye-slash" aria-hidden="true"></i>
														</c:if>
	
														<i class="fa fa-exclamation-triangle" aria-hidden="true">
															${chat.reportCount } 회</i>
													</div>
													</c:if>
													<h4 class="card-title">${chat.chatTitle}</h4>
													<h5 class="card-text mb-2 text-muted">${chat.chatText}</h5>
													<div class="d-flex justify-content-between align-items-end">
														<div>
															<p class="card-text text-right">${chat.chatRestaurant.restaurantName}
															<c:choose>
																<c:when test="${chat.chatRestaurant.menuType==1}">
																	<span>(한식)</span></p>
																</c:when>
																<c:when test="${chat.chatRestaurant.menuType==2}">
																	<span>(중식)</span></p>
																</c:when>
																<c:when test="${chat.chatRestaurant.menuType==3}">
																	<span>(양식)</span></p>
																</c:when>
																<c:when test="${chat.chatRestaurant.menuType==4}">
																	<span>(일식)</span></p>
																</c:when>
																<c:otherwise>
																	<span>(카페)</span></p>
																</c:otherwise>
															</c:choose>
															<p class="card-text text-right">${chat.chatRestaurant.streetAddress}</p>
														</div>
														<div class="btn-group">
															<c:if test="${!empty chat.chatMember}">
																<c:set var="isChatMember" value="false" />
																<c:forEach var="chatMember" items="${chat.chatMember}">
																	<c:set var="chatMemCnt" value="${fn:length(chat.chatMember)}"/>
																	<c:if test="${member.memberId == chatMember.member.memberId}">
																		<c:set var="isChatMember" value="true" />
																	</c:if>
																	<c:if test="${member.memberId == chatMember.member.memberId && chat.chatState == 4 && chatMember.inOutCheck == true && chatMember.readyCheck == true && chatMemCnt > 1}">
																	<a href="/chat/json/listReadyCheckMember/chatNo=${chat.chatNo}" class="button small primary" data-toggle="modal" data-target="#chatRatingModal">평가하기</a> 
																	</c:if>
																</c:forEach>
																<c:if test="${isChatMember eq 'false' }">
																	<a href="/chat/json/getChat/${chat.chatNo}" class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal" data-no="${chat.chatNo}" data-id="${member.memberId}" id="getChatEntranceBtn">참여하기</a>
																</c:if>
																<c:if test="${isChatMember eq 'true' && chat.chatState != 5}">
																	<a href="/chat/getChatEntrance?chatNo=${chat.chatNo}" class="button small success get-chat-btn">입장하기</a>
																</c:if>
															</c:if>
															<c:if test="${empty chat.chatMember}">
																<a href="/chat/json/getChat/${chat.chatNo}" class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal" data-no="${chat.chatNo}" data-id="${member.memberId}" id="getChatEntranceBtn">참여하기</a>
															</c:if>
														</div>
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</c:forEach>
								</c:if>
							</div>
							<!-- E:Thumbnail -->

							<!-- S:Modal -->
							<!-- 채팅방 정보보기 모달 -->
							<jsp:include page='/chat/getChatModal.jsp'/>
							
							<!-- 모임중에만 입장 모달 -->
							<div class="modal fade" id="chatStateModal" tabindex="-1" aria-labelledby="chatStateModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header justify-content-end">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											채팅방 상태가 모집중일 때만 입장 가능합니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- 성별 다를때 모달 -->
							<div class="modal fade" id="chatGenderModal" tabindex="-1" aria-labelledby="chatGenderModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header justify-content-end">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											참여가능 성별에 맞지 않아 입장할 수 없습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- 연령대 다를때 모달 -->
							<div class="modal fade" id="chatAgeModal" tabindex="-1" aria-labelledby="chatAgeModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header justify-content-end">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											참여가능 연령대에 맞지 않아 입장할 수 없습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- 쩝쩝친구 평가 모달-->
							<div class="modal fade" id="chatRatingModal" tabindex="-1" aria-labelledby="chatRatingModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm modal-dialog-scrollable">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="getChatModalLabel">쩝쩝친구 평가하기</h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											
										</div>
										<div class="modal-footer">
											<button type="button" class="button small" data-dismiss="modal">닫기</button>
											<button type="button" class="button primary small">평가</button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- 평가진행 모달 -->
							<div class="modal fade" id="ratingGoModal" tabindex="-1" aria-labelledby="ratingGoModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header justify-content-end">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											평가를 진행하시겠습니까?</br/>
											평가가 이루어지면 수정할 수 없습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="button small" data-dismiss="modal">아니오</button>
											<button type="button" id="ratingGo" class="button primary small">확인</button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- 평가완료 모달 -->
							<div class="modal fade" id="ratingEndModal" tabindex="-1" aria-labelledby="ratingEndModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header justify-content-end">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
										</div>
										<div class="modal-body">
											평가가 완료되었습니다.
										</div>
										<div class="modal-footer">
											<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
										</div>
									</div>
								</div>
							</div>
							<!-- E:Modal -->
							
						</div>
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