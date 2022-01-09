<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/chat/listChat")
				.submit();
	}

	$(function() {
		console.log("listChat.jsp");
		let chatMemberList = [];
		
		//============= "검색"  Event  처리 =============
		$(".search-btn").on("click", function() {
			fncGetList(1);
		});
		
		//============= "작성하기"  Event  처리 =============		
		$("a.button:contains(작성하기)").on("click", function(e) {
			e.preventDefault();
			window.open("/chat/addChat", "_self");
		});
		
		//============= "참여하기" Event 처리 ============
		$("a.button:contains(참여하기)").on("click", function(e) {
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
					let chatImg = JSONData.chatImage;
					let chatState = JSONData.chatState;
					let chatGender = genderReverseCng(JSONData.chatGender);
					let chatAge = JSONData.chatAge;
					let chatRegDate = JSONData.chatRegDate;
					let regdate = new Date(chatRegDate);
					let showStatus = "";
					let chatMember = JSONData.chatMember;
					let menuType = JSONData.chatRestaurant.menuType;
					chatMemberList = [];
					
					//채팅방에 유저 있는지 체크
					chatMember.map((o,i) => {
						o.index = i;
						if(o.inOutCheck){
							//console.log("채팅 멤버");
							chatMemberList.push(o.member.memberId);
						}
						//console.log(o.member.memberId);
						//return o;
					});
					
					//연령대 문구 변환
					let chatAgeList = "";
					chatAge = chatAge.split(",");
					$.each(chatAge, function(index, item){
						chatAgeList += ageReverseCng(item);
						if(chatAge.length != index+1){
							chatAgeList += ', ';
						}
					});
					
					//console.log(chatMemberList);
					//console.log(JSONData.chatMember);
					
					if(JSONData.chatShowStatus == false){
						showStatus = "<i class='fa fa-eye-slash' aria-hidden='true'></i>";
					}
					chatRegDate = regdate.getFullYear()+"-"+("0" + (regdate.getMonth()+1)).slice(-2)+"-"+("0"+regdate.getDate()).slice(-2);
					if(chatState == 1){
						chatState = "<span class='badge badge-success chat-state'>모집중</span>";
					}else if(chatState == 2){
						chatState = "<span class='badge badge-warning chat-state'>인원확정</span>";
					}else if(chatState == 3){
						chatState = "<span class='badge badge-info chat-state'>예약확정</span>";
					}else if(chatState == 4){
						chatState = "<span class='badge badge-danger chat-state'>모임완료</span>";
					}else if(chatState == 5){
						chatState = "<span class='badge badge-secondary chat-state'>폭파된방</span>";
					}
					
					if(menuType == 1){
						menuType = "한식";
					}else if(menuType == 2){
						menuType = "중식";
					}else if(menuType == 3){
						menuType = "양식";
					}else if(menuType == 4){
						menuType = "일식";
					}else if(menuType == 5){
						menuType = "카페";
					}
					
					let displayValueBd = 
						'<div class="get-chat-info mb-3">'
						+'<div class="d-flex justify-content-between">'
						+'<div><span class="badge badge-secondary chat-no">'+JSONData.chatNo+'</span></div>'
						+'<div id="getChatState">'+chatState+'</div>'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<h3 class="card-title mb-2">'+JSONData.chatTitle+'</h3>'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<h4 class="card-subtitle mb-2">'+JSONData.chatText+'</h4>'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<div>참가중인 인원수</div>'
						+'<div>'+JSONData.chatMemberCount+'</div>'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<div>참가가능한 성별</div>'
						+'<div id="getChatGender">'+chatGender+'</div>'
						+'<input type="hidden" name="chatGender" id="chatGender"  value="'+JSONData.chatGender+'">'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<div>참가가능한 연령대</div>'
						+'<div id="getChatAge">'+chatAgeList+'</div>'
						+'<input type="hidden" name="chatAge" id="chatAge" value="'+JSONData.chatAge+'">'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<div>개설일</div>'
						+'<div>'+chatRegDate+'</div>'
						+'</div>'
						+'<div class="d-flex justify-content-between">'
						+'<div>'+showStatus+ ' <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>' +JSONData.reportCount+' 회</div>'
						+'</div>'
						+'</div>'
						+'<div class="get-chat-user-info mb-3">'
						+'<div class="chatProfile d-flex flex-row align-items-center">'
						+'<img src="/resources/images/common/'+JSONData.chatLeaderId.profileImage+'">'
						+'<div class="dropdown-parent">'
						+'<a href="">'+JSONData.chatLeaderId.nickname+'</a>'
						+'<input type="hidden" id="chatLeaderId" name="chatLeaderId" value="'+JSONData.chatLeaderId.memberId+'">'
						+'</div>'
						+'<span class="badge badge-info gender">'+JSONData.chatLeaderId.gender+'</span>'
						+'<span class="badge badge-warning age">'+JSONData.chatLeaderId.ageRange+'</span>'
						+'</div>'
						+'<div>'+JSONData.chatLeaderId.statusMessage+'</div>'
						+'</div>'
						+'<div clas="get-chat-restaurant-info">'
						+'<div>'+JSONData.chatRestaurant.restaurantName+' ('+menuType+')</div>'
						+'<div>'+JSONData.chatRestaurant.restaurantTel+'</div>'
						+'<div>'+JSONData.chatRestaurant.streetAddress+'</div>'
						+'<div>'+JSONData.chatRestaurant.areaAddress+'</div>'
						+'</div>';
					let displayValueFt = "<input type='button' data-target="+JSONData.chatNo+" class='button small warning' value='대화기록보기'/>"
					+"<input type='button' data-target="+JSONData.chatNo+" class='button small info' value='수정하기'/>"
					+"<input type='button' class='button small secondary' data-dismiss='modal' value='닫기' />"
					+"<input type='button' data-target="+JSONData.chatNo+" class='button small primary' value='입장하기'>"
					$(".get-chat-con").html(displayValueBd);
					$("#getChatModal .modal-footer").html(displayValueFt);
					if(chatImg == 'chatimg.jpg'){
						$("#getChatModal .modal-body").css("background-image", "url(/resources/images/sub/"+chatImg+")");
					}else{
						$("#getChatModal .modal-body").css("background-image", "url(/resources/images/uploadImages/chat/"+chatImg+")");
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		});
		
		//============= "평가하기" Event 처리 ============
		$("a.button:contains(평가하기)").on("click", function(e) {
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
		$("button:contains(평가)").on("click", function(e) {
			console.log("제출 클릭");
			
			let ratingFlag = false;
			
			$('#ratingGoModal').modal('show');
			
		});
		
		//============= "평가하기 예" Event 처리 ============
		$("#ratingGo").on("click", function(e) {
		
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
				}
			});
		});
		
		
		//============= "대화기록보기" Event 처리 ============
		$("body").on("click", "input[value='대화기록보기']", function(){
			let chatNo = $(this).attr("data-target");
			location.href="/chat/getChatRecord?chatNo="+chatNo;
		});
			
		//============= "수정하기" Event 처리 ============
		$("body").on("click", "input[value='수정하기']", function(){
			console.log("수정하기");
			let chatNo = $(this).attr("data-target");
			location.href="/chat/updateChat?chatNo="+chatNo;
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
		
		//젠더 데이터 값 변경
		function genderCng(gender){
			switch(gender){				
				case 'female':
					return 2;
				case 'male':
					return 1;
			}
		}
		
		//젠더 데이터 값 변경
		function genderReverseCng(gender){
			switch(gender){				
				case 2:
					return '여자';
				case 1:
					return '남자';
				default :
					return '성별 무관';
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
		
		//연령대 데이터 값 변경
		function ageReverseCng(age){
			switch(age){
				case '1':
					return '10대';
				case '2':
					return '20대';
				case '3':
					return '30대';
				case '4':
					return '40대';
				case '5':
					return '50대';
				case '6':
					return '60대 이상';
				case '7':
					return '연령대 무관'
			}
		}
		/* let page = 1;
		//==> 페이징 스크롤
		$(function(){
			getList(page);
			page ++;
		});
		
		$(window).scroll(function(){
			if($(window).srollTop() + 200 >= $(document).height() - $(window).height()){
				getList(page);
				page++;
			}
		}); */
		
			
			
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

						<h3>쩝쩝친구 구하기</h3>

						<!-- S:Search -->
						<form class="form-inline" name="detailForm">
							<div class="container">
								<div class="row search-box gtr-uniform">
									<div class="col-md-4 col-sm-12">
										<a href="" class="button normal icon solid fa-sort"> 정렬</a> <a
											href="" class="button normal icon solid fa-filter"> 필터</a>
									</div>
									<div class="col-md-6 col-sm-12 d-flex">
										<select id="searchCondition" name="searchCondition">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
										</select> <input type="text" id="searchKeyword" name="searchKeyword"
											placeholder="검색어" autocomplete="off"
											value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#"
											class="button primary icon solid fa-search search-btn"></a>

										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage"
											value="" />
									</div>
									<div class="col-md-2 d-flex justify-content-end">
										<a href="" class="button svg-btn" ><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg>작성하기</a>
									</div>
								</div>
							</div>
						</form>
						<!-- E:Search -->

						<!-- S:Thumbnail -->
						<div class="container">
							<div class="row thumb-list">

								<c:forEach var="chat" items="${list}">
									<div class="col-md-6">
										<div class="card mb-4 shadow-sm chat-state${chat.chatState}">
											<div class="card-head d-flex">
												<span class="badge badge-secondary chat-no mr-1">${chat.chatNo }</span>
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
														<span class="badge badge-danger chat-state">모임완료</span>
													</c:when>
													<c:otherwise>
														<span class="badge badge-secondary chat-state">폭파된방</span>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="card-img">
												<img src="/resources/images/uploadImages/chat/${chat.chatImage}">
											</div>
											<div class="card-body">
												<div class="chat-rating-info">
													<c:if test="${chat.chatShowStatus == false }">
														<i class="fa fa-eye-slash" aria-hidden="true"></i>
													</c:if>

													<i class="fa fa-exclamation-triangle" aria-hidden="true">
														${chat.reportCount } 회</i>
												</div>
												<h4 class="card-title">${chat.chatTitle}</h4>
												<h5 class="card-text mb-2 text-muted">${chat.chatText}</h5>
													<div class="d-flex justify-content-between align-items-end">
														<div>
															<p class="card-text text-right">${chat.chatRestaurant.restaurantName}</p>
															<p class="card-text text-right">${chat.chatRestaurant.streetAddress}</p>
														</div>
														<div class="btn-group">
															<%-- <c:forEach var="chatMember" items="${chat.chatMember}">
																<c:if test="${member.memberId == chatMember.member.memberId && chat.chatState == 4 && chatMember.inOutCheck == true && chatMember.readyCheck == true}"> --%>
																<a href="/chat/json/listReadyCheckMember/chatNo=${chat.chatNo}" class="button small primary" data-toggle="modal" data-target="#chatRatingModal">평가하기</a> 
																<%-- </c:if>
															</c:forEach> --%>
															<a href="/chat/json/getChat/${chat.chatNo}" class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal">참여하기</a>
														</div>
													</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- E:Thumbnail -->

							<!-- S:Infinity page -->
							<div class="col-12 text-center thumb-more">
								<a href="#" class="icon solid fa fa-plus-circle"></a>
							</div>
							<!-- E:Infinity page -->

							<!-- S:Modal -->
							<!-- 채팅 정보자세히 보기 모달 -->
							<div class="modal fade" id="getChatModal" tabindex="-1"
								aria-labelledby="getChatModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="getChatModalLabel">채팅방 정보 상세보기</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="get-chat-con"></div>
										</div>
										<div class="modal-footer">
											
										</div>
									</div>
								</div>
							</div>
							
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