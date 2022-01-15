<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 생성</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("addCahtView.jsp");
		function fncAddChat() {

			//==> 유효성 체크
			let restaurantName = $("input[name='restaurantName']").val();
			let restaurantTel = $("input[name='restaurantTel']").val();
			let chatTitle = $("input[name='chatTitle']").val();
			let chatGender = $("input[name='chatGender']:checked").length;
			let chatAge = $("input[name='chatAge']:checked").length;

			/* console.log("restaurantName : " + restaurantName);
			console.log("chatTitle : " + chatTitle);
			console.log("chatGender : " + chatGender);
			console.log("chatAge : " + chatAge); */

			if (restaurantName == null || restaurantName.length < 1) {
				alert("음식점을 반드시 선택하여야 합니다.");
				$("input[name='restaurantName']").focus();
				return;
			}
			
			if (restaurantTel == null || restaurantTel.length < 1) {
				alert("음식점을 반드시 선택하여야 합니다.");
				$("input[name='restaurantName']").val('');
				$("input[name='restaurantName']").focus();
				return;
			}

			if (chatTitle == null || chatTitle.length < 1) {
				alert("채팅방 제목은 반드시 입력하여야 합니다.");
				$("input[name='chatTitle']").focus();
				return;
			}

			if (chatGender == null || chatGender < 1) {
				alert("참여가능 성별은 반드시 선택하여야 합니다.");
				$("input[name='chatGender']").focus();
				return;
			}

			if (chatAge == null || chatAge < 1) {
				alert("참여가능 연령대는 반드시 선택하여야 합니다.");
				$("input[name='chatAge']").focus();
				return;
			}

			//==> submit 기능
			$("form").attr("method", "POST").attr("action", "/chat/addChat")
					.submit();
		}

		//==> Form Submit 처리
		$("input[value='채팅방 등록']").on("click", function() {
			fncAddChat();
		});

		//==> 음식점 찾는 autocomplete
		var autoResArr = [];

		$("#restaurantName").autocomplete({
			source : function(request, response) {
				console.log($("#restaurantName").val());
				var searchKeyword = $("#restaurantName").val();
				searchKeyword = escape(encodeURIComponent(searchKeyword));
				$.ajax({
					url : "/chat/json/listRestaurantAutocomplete/searchKeyword="
							+ searchKeyword,
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(JSONData) {

						if (JSONData.list == null || JSONData.list == undefined || JSONData.list == "" || JSONData.list.length == 0) {
							//alert("자료가 없음");
							$(".find-restaurant-txt").text("");
							$(".find-restaurant-txt").text("선택할 수 있는 음식점이 없습니다.");
						} else {
							$(".find-restaurant-txt").text("");
							//console.log(JSONData);
							response(
								$.map(JSONData.list, function(item) {
									autoResArr = {
										"restaurantNo" : item.restaurantNo,
										"restaurantName" : item.restaurantName,
										"restaurantTel" : item.restaurantTel,
										"restaurantSAddr" : item.streetAddress,
										"restaurantAAddr" : item.areaAddress
									};

									/* console.log(item.restaurantNo)
									console.log(item.restaurantName);
									console.log(item.restaurantTel);
									console.log(item.streetAddress);
									console.log(item.areaAddress); */

									return {
										value : item.restaurantName,
										no : item.restaurantNo,
										tel : item.restaurantTel,
										sAddr : item.streetAddress,
										aAddr : item.areaAddress,
									}
								})
							);
						}

					},
					error : function(e) {
						alert(e.responseText);
					}
				});
			},
			minLength : 1,
			select: function(event, ui) {
	            $("#restaurantNo").val(ui.item.no);
				$("#restaurantTel").val(ui.item.tel);
				$("#streetAddress").val(ui.item.sAddr);
				$("#areaAddress").val(ui.item.aAddr);
	        },
	        focus: function(event, ui) {
	            $("#restaurantNo").val(ui.item.no);
				$("#restaurantTel").val(ui.item.tel);
				$("#streetAddress").val(ui.item.sAddr);
				$("#areaAddress").val(ui.item.aAddr);
	        },
	        autoFocus: true,
	        disable: true,
	        close:function(e){
	        	console.log(e);
	        }
		});

		//autocomplete 목록 클릭 했을 때 값 들어가기
		$("body").on("click", ".ui-menu-item-wrapper", function() {
			/* console.log("==============");
			console.log(autoResArr);
			console.log($(this).autoResArr);
			let restaurantNo = autoResArr.restaurantNo;
			let restaurantName = autoResArr.restaurantName;
			let restaurantTel = autoResArr.restaurantTel;
			let restaurantSAddr = autoResArr.restaurantSAddr;
			let restaurantAAddr = autoResArr.restaurantAAddr;

			$("#restaurantNo").val(restaurantNo);
			$("#restaurantTel").val(restaurantTel);
			$("#streetAddress").val(restaurantSAddr);
			$("#areaAddress").val(restaurantAAddr); */
			
			//$("#restaurantName").attr("disabled","disabled");
		});
		//autocomplete 목록 엔터 했을 때 값 들어가기
		$("body").on("keydown", "#restaurantName", function(e) {
			if(e.keyCode == 8){
				//console.log("지운다");
				/* console.log("1  ==  "+autoResArr.restaurantNo);
				console.log("2  ==  "+autoResArr.restaurantName);
				console.log("3  ==  "+autoResArr.restaurantTel);
				console.log("4  ==  "+autoResArr.restaurantSAddr);
				console.log("4  ==  "+autoResArr.restaurantAAddr); */
				/* let restaurantNo = autoResArr.restaurantNo;
				let restaurantName = autoResArr.restaurantName;
				let restaurantTel = autoResArr.restaurantTel;
				let restaurantSAddr = autoResArr.restaurantSAddr;
				let restaurantAAddr = autoResArr.restaurantAAddr;*/
	
				$("#restaurantNo").val("");
				$("#restaurantTel").val("");
				$("#streetAddress").val("");
				$("#areaAddress").val("");
				$("#restaurantName").val("");
				
				//$("#restaurantName").attr("disabled","disabled");
			}
			
		});

		//==>연령대 무관 클릭시 나머지 연령대 체크 해제
		$("input[name='chatAge']").on("click", function() {
			//console.log($(this).attr("id"));
			if ($(this).attr("id") == "chatAge7") {
				$("#chatAge1").prop("checked", false);
				$("#chatAge2").prop("checked", false);
				$("#chatAge3").prop("checked", false);
				$("#chatAge4").prop("checked", false);
				$("#chatAge5").prop("checked", false);
				$("#chatAge6").prop("checked", false);
			} else {
				$("#chatAge7").prop("checked", false);
			}

		});

		//==>연령대 클릭시 나머지 연령대 다 체크하면 해당 체크 해제 연령대 무관 체크
		$("input[name='chatAge']").change(function() {
			if ($("#chatAge6").is(":checked") && $("#chatAge5").is(":checked") && $("#chatAge4").is(":checked") && $("#chatAge3").is(":checked") && $("#chatAge2").is(":checked") && $("#chatAge1").is(":checked")) {
				//console.log("나이대 상관 없이 다 선택");
				$("#chatAge1").prop("checked", false);
				$("#chatAge2").prop("checked", false);
				$("#chatAge3").prop("checked", false);
				$("#chatAge4").prop("checked", false);
				$("#chatAge5").prop("checked", false);
				$("#chatAge6").prop("checked", false);
				$("#chatAge7").prop("checked", true);
			} else {
				//console.log("나이대 하나씩 선택");
			}
		});

		//==> drag 파일 업로드
		let $fileDragArea = $(".file-drag-area");
		let $fileDragBtn = $(".file-drag-btn");
		let $fileDragInput = $(".file-drag-input");
		let $fileDragMsg = $(".file-drag-msg");
		let $fileDragView = $(".file-drag-view");
		let $chatImage = $("#chatImage");
		
		//박스 안에 Drag 들어왔을 때
		$fileDragArea.on("dragenter", function(e){
			console.log("dragenter");
			$fileDragArea.addClass('is-active');
		});
		
		//박스 안에 Drag 하고 있을 때
		$fileDragArea.on("dragover", function(e){
			console.log("dragover");
			
			// 드래그 한 것이 파일인지 아닌지 체크
			let valid = e.originalEvent.dataTransfer.types.indexOf('Files')>= 0;
			console.log(valid);
			
			if(!valid){
				$fileDragArea.addClass('is-warning');
			}else{
				$fileDragArea.addClass('is-active');
			}
		});
		
		//박스 밖으로 Drag 나갈 때
		$fileDragArea.on("dragleave", function(e){
			console.log("dragleave");
			$fileDragArea.removeClass('is-active');
		});
		
		//박스 안에서 Drag를 Drop 했을 때
		$fileDragArea.on("drop", function(e){
			console.log("drop");
			$fileDragArea.removeClass('is-active');
			
		});

		// change inner text
		$fileDragInput.on('change', function(e) {
			var fileName = $(this).val().split('\\').pop();
			
			const data = e.target;
			console.dir(data);
			
			//유효성 체크
			if(!isValid(data)){
				return;
			}
			
			const formData = new FormData();
			formData.append('uploadFile', data.files[0]);
			
			const saveName = "";
			
			ajax({
				url: '/chat/json/addDragFile',
				method: 'POST',
				data: formData,
				progress: () => {
					
				},
				loadend: () => {
				}
			});
			
			/* $.ajax({
				url: '/chat/json/addDragFile',
				method: 'POST',
				data: formData,
				success:function(JSONData){
					console.log("성공");
			    },
			    error:function(e){
					console.log("실패");
			    }
			}); */
			
			$fileDragMsg.text(fileName);
			
		});

		function isValid(data){
			
			//파일인지 유효성 검사
			if(data.type.indexOf('file') < 0){
				alert("파일이 아닙니다.");
				return false;
			}
			
			//이미지인지 유효성 검사
			if(data.files[0].type.indexOf('image') < 0){
				alert('이미지 파일만 업로드 가능합니다.');
				return false;
			}
			
			//파일의 개수는 1개씩만 가능하도록 유효성 검사
			if(data.files.length > 1){
				alert('파일은 하나씩 전송이 가능합니다.');
				return false;
			}
			
			//파일의 사이즈는 10MB 미만
			if(data.files[0].size >= 1024 * 1024 * 10){
				alert('10MB 이상인 파일은 업로드할 수 없습니다.');
				return false;
			}
			
			return true;
		}
		
		//참고 ajax 커스텀 모듈
		function ajax(obj){
			
			const xhr = new XMLHttpRequest();
			
			var method = obj.method || 'GET';
			var url = obj.url || '';
			var data = obj.data || null;
			
			/* 성공/에러 */
			xhr.addEventListener('load', function() {
				
				const data = xhr.responseText;
				
				if(obj.load)
					obj.load(data);
			});
			
			/* 성공 */
			xhr.addEventListener('loadend', function() {
				
				const data = xhr.responseText;
				
				if(obj.loadend) {
					obj.loadend(data);
				}
				//이미지 경로 수정
				/* saveName = JSON.parse(data).saveName;
				$fileDragView.html("<a href='javascript:void(0)' class='cvf_delete_image'><img src='/resources/images/uploadImages/chat/"+saveName+"'/></a>");
				console.log("saveName : " + saveName);
				$chatImage.val(saveName); */
				saveName = JSON.parse(data).saveName;
				$fileDragView.html("<a href='javascript:void(0)' class='cvf_delete_image'><img src='https://zzupzzup.s3.ap-northeast-2.amazonaws.com/chat/"+saveName+"'/></a>");
				console.log("saveName : " + saveName);
				$chatImage.val(saveName);
				
			});
			
			/* 실패 */
			xhr.addEventListener('error', function() {
				
				console.log('Ajax 중 에러 발생 : ' + xhr.status + ' / ' + xhr.statusText);
				
				if(obj.error){
					obj.error(xhr, xhr.status, xhr.statusText);
				}
			});
			
			/* 중단 */
			xhr.addEventListener('abort', function() {
				
				if(obj.abort){
					obj.abort(xhr);
				}
			});
			
			/* 진행 */
			xhr.upload.addEventListener('progress', function() {
				
				if(obj.progress){
					obj.progress(xhr);
				}
			});
			
			/* 요청 시작 */
			xhr.addEventListener('loadstart', function() {
				
				if(obj.loadstart)
					obj.loadstart(xhr);
			});
			
			if(obj.async === false)
				xhr.open(method, url, obj.async);
			else
				xhr.open(method, url, true);
			
			if(obj.contentType)
				xhr.setRequestHeader('Content-Type', obj.contentType);	
				
			xhr.send(data);	
		}
		
		//사진 클릭시 첨부 이미지 삭제
		$("body").on("click", ".file-drag-view a", function(){
			console.log("이미지에 마우스 올렸다");
			$chatImage.val('');
			$(this).remove();
			$fileDragMsg.text("파일을 여기로 드래그 하거나 선택하세요.");
		});

		//==>취소 클릭시 뒤로 감
		$("input[value='취소']").on("click", function() {
			history.back();
		});

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

				<section id="addChatView">
					<div class="container">

						<!-- start:Form -->
						<h3>쩝쩝친구 생성</h3>
						

						<form id="addChatView">
							<input type="hidden" name="chatRestaurant.restaurantNo"
								id="restaurantNo"> <input type="hidden"
								name="chatLeaderId.memberId" id="chatLeaderId"
								value="${member.memberId}">
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="restaurantName">음식점명</label> <input type="text"
										name="restaurantName" id="restaurantName"
										class="ui-autocomplete-input" autocomplete="off"
										placeholder="" required maxlength="50" />
									<p class="find-restaurant-txt"></p>
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-4">
									<label for="restaurantTel">음식점 전화번호</label> <input type="text"
										name="restaurantTel" id="restaurantTel" value=""
										placeholder="" disabled="disabled" />
								</div>

								<div class="col-md-4">
									<label for="streetAddress">음식점 도로명 주소</label> <input
										type="text" name="streetAddress" id="streetAddress" value=""
										placeholder="" disabled="disabled" />
								</div>

								<div class="col-md-4">
									<label for="areaAddress">음식점 지번 주소</label> <input type="text"
										name="areaAddress" id="areaAddress" value="" placeholder=""
										disabled="disabled" />
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="chatTitle">채팅방 제목</label> <input type="text"
										name="chatTitle" id="chatTitle" placeholder="" required
										maxlength="100" />
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatGender">참여가능 성별</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-12">
									<input type="radio" id="male" name="chatGender" value="1"
										checked> <label for="male">남자</label> <input
										type="radio" id="female" name="chatGender" value="2">
									<label for="female">여자</label> <input type="radio"
										id="malefemale" name="chatGender" value="3"> <label
										for="malefemale">성별무관</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatAge">참여가능 연령대</label>
								</div>
								<div class="col-md-12">
									<input type="checkbox" id="chatAge1" name="chatAge" value="1">
									<label for="chatAge1">10대</label> <input type="checkbox"
										id="chatAge2" name="chatAge" value="2"> <label
										for="chatAge2">20대</label> <input type="checkbox"
										id="chatAge3" name="chatAge" value="3"> <label
										for="chatAge3">30대</label> <input type="checkbox"
										id="chatAge4" name="chatAge" value="4"> <label
										for="chatAge4">40대</label> <input type="checkbox"
										id="chatAge5" name="chatAge" value="5"> <label
										for="chatAge5">50대</label> <input type="checkbox"
										id="chatAge6" name="chatAge" value="6"> <label
										for="chatAge6">60대 이상</label> <input type="checkbox"
										id="chatAge7" name="chatAge" value="7"> <label
										for="chatAge7">연령대 무관</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatText">채팅방 소개글</label>
									<textarea name="chatText" id="chatText" placeholder="소개글 입력"
										rows="6"></textarea>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-md-8">
									<label for="">채팅방 대표 이미지</label>
									<div class="file-drag-area">
										<span class="file-drag-btn">파일 선택</span> <span
											class="file-drag-msg">파일을 여기로 드래그 하거나 선택하세요.</span> <input
											class="file-drag-input" type="file" id="fileDragInput" name="fileDragInput" >
											<input type="hidden" id="chatImage" name="chatImage">
									</div>
									<div class="file-drag-view mt-4">
									</div>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<ul class="actions justify-content-center">
										<li><input type="reset" value="취소" class="normal" /></li>
										<li><input type="submit" value="채팅방 등록" class="primary" /></li>
									</ul>
								</div>
							</div>

						</form>
						<!-- end -->

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