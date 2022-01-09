<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("listRatig.jsp");
		
		//============= "참여하기" Event 처리 ============
		$("a:contains(참여한 채팅방 정보)").on("click", function(e) {
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
					console.log(JSONData);
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

				<section id="listRating">
					<div class="container">
						<!-- start:Table -->
						<c:forEach var="rating" items="${list}">
						<div class="row table-list mb-2">
							<div class="col-md-12">
								<div
									class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
									<div class="col p-4 d-flex flex-column position-static">
										<h3 class=""><a href="/member/getMember?memberId=${rating.ratingToId.memberId} }">${rating.ratingToId.nickname}</a> <small>(${rating.ratingToId.memberRank} / 매너점수 : ${rating.ratingToId.mannerScore}점)</small></h3>
										<p class="card-text mb-auto"><a href="/chat/json/getChat/${rating.chatNo}" data-toggle="modal" data-target="#getChatModal">참여한 채팅방 정보</a><br/>평가 내용: <c:choose><c:when test="${rating.ratingType==1}">별로에요(-1점)</c:when><c:when test="${rating.ratingType==2}">좋아요(1점)</c:when><c:when test="${rating.ratingType==3}">최고에요(3점)</c:when></c:choose></p>
										<div class="text-right">
											<strong class="d-inline-block mr-2"><a href="/member/getMember?memberId=${rating.ratingFromId.memberId}">${rating.ratingFromId.nickname}</a> <small>(${rating.ratingFromId.memberRank} / 매너점수 : ${rating.ratingFromId.mannerScore}점)</small></strong><small>${rating.ratingRegDate}</small>
										</div>
									</div>

								</div>
							</div>
						</div>
						</c:forEach>
						<!-- end -->


						<ul class="pagination">
							<li><span class="button disabled">Prev</span></li>
							<li><a href="#" class="page active">1</a></li>
							<li><a href="#" class="page">2</a></li>
							<li><a href="#" class="page">3</a></li>
							<li><span>&hellip;</span></li>
							<li><a href="#" class="page">8</a></li>
							<li><a href="#" class="page">9</a></li>
							<li><a href="#" class="page">10</a></li>
							<li><a href="#" class="button">Next</a></li>
						</ul>
						
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
						<!-- E:Modal -->

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