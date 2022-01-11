<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
$(function() {
	
	//============= "채팅방 정보보기" Event 처리 ============
	$("body").on("click", "#getChatEntranceBtn", function(e) {
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
					+'<a href="/member/getMember?memberId='+JSONData.chatLeaderId.memberId+'">'+JSONData.chatLeaderId.nickname+'</a>'
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
				+"<input type='button' class='button small secondary' data-dismiss='modal' value='닫기' />";
				if($('#listChat').length){
					displayValueFt += "<input type='button' data-target="+JSONData.chatNo+" class='button small primary' value='입장하기'>"
				}
				$(".get-chat-con").html(displayValueBd);
				$("#getChatModal .modal-footer").html(displayValueFt);
				if(chatImg == 'chatimg.jpg'){
					$("#getChatModal .modal-body").css("background-image", "url(/resources/images/sub/"+chatImg+")");
				}else{
					$("#getChatModal .modal-body").css("background-image", "url(/resources/images/uploadImages/chat/"+chatImg+")");
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