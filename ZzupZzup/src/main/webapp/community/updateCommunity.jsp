<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE HTML>

<html>
<head>
<title>게시물 수정하기 | ${community.postTitle}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 지도(위도, 경도)를 사용하기 위해 key 설정 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86fc1389540999ea4a3cdaa2a9ca1cc1&libraries=services"></script>


<script type="text/javascript">

	//이미지 정보를 담을 배열
	var sel_files = [];
	
	//음식점의 위도와 경도를 가져오기 위해 선언
	var geocoder = new daum.maps.services.Geocoder();

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
                
                //주소의 위도와 경도 가져오기
                geocoder.addressSearch(data.address, function(results, status) {
	             	if (status === daum.maps.services.Status.OK) {
	             		var result = results[0];
		            	//console.log(result.y);
		            	//console.log(result.x);
		            	$("input[name='latitude']").val(result.x);
		            	$("input[name='longitude']").val(result.y);
					}	
	            });
                
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
	
	function fncUpdateCommunity() {
		
		/* var memberId = $("input[name='memberId']").val(); */
		var postTitle = $("input[name='postTitle']").val();
		var postText = $("textarea[name='postText']").val();
		var restaurantName = $("input[name='restaurantName']").val();
		var restaurantTel = $("input[name='restaurantTel']").val();
		var streetAddress = $("input[name='streetAddress']").val();
		var areaAddress = $("input[name='areaAddress']").val();
		var restAddress = $("input[name='restAddress']").val();
		var menuType = $("select[name='menuType']").val();
		var mainMenuTitle = $("input[name='mainMenuTitle']").val();
		var mainMenuPrice = $("input[name='mainMenuPrice']").val();
		
		console.log(restaurantName);
		
		
		if(postTitle == null || postTitle.length<1){
			alert("게시물 제목을 입력해주세요");
			return;
		}
		
		/* if(postText == null || postText.length<1){
			alert("게시물 내용을 입력해주세요");
			return;
		} */
	
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
		
		/* if(restAddress == null || restAddress.length<1){
			alert("음식점 상세 주소를 입력해주세요");
			return;
		} */
		
		if(menuType == null || menuType.length<1){
			alert("음식 종류를 선택해주세요");
			return;
		}
		
		if(mainMenuTitle == null || mainMenuTitle.length<1){
			alert("대표메뉴명을 입력해주세요");
			return;
		}
		
		if(mainMenuPrice == null || mainMenuPrice.length<1){
			alert("대표메뉴가격을 입력해주세요");
			return;
		}
		
		
		uploadFiles();
	
	}

//	window.onload = function(){
		
		<c:forEach var="image" items="${community.postImage}" varStatus="status">
		<c:set var="fileName" value="${fn:split(image, '_')}"/>
			sel_files.push( {name : "${fileName[1]}" });
		</c:forEach>
		
		var index = ${fn:length(community.postImage)};
		console.log(index);
		
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(function() {
			// 등록 버튼 실행
			$( "#button1" ).on("click" , function() {
				fncUpdateCommunity();
			});
			
			// 주소 검색 버튼 실행
			$( "#button2" ).on("click" , function() {
				daumPostcode();
			});
			
			// 이전으로 버튼 실행
			$( "#button3" ).on("click" , function() {
				history.go(-1);
			});
		});

//	}
	
	/* *************** 이미지 업로드 *************** */
	$(function(){
		//==> drag 파일 업로드
		let $fileDragArea = $(".file-drag-area");
		let $fileDragBtn = $(".file-drag-btn");
		let $fileDragInput = $(".file-drag-input");
		let $fileDragMsg = $(".file-drag-msg");
		let $fileDragView = $(".file-drag-view");
		let $image = $("#file");
		
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
			console.log("파일업로드 실행");
			
			//이미지 정보들을 초기화
			sel_files = []; 
			$(".file-drag-view").empty();
			
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			console.log("이것은 : " + filesArr);
			
			var index = 0;
			filesArr.forEach(function(f) {
				
				console.dir(f);
				
				//유효성 체크
				if(!isValid(f)){
					return;
				}
				
				sel_files.push(f);
				
				var reader = new FileReader();
				reader.onload = function(e) {
					
					var html = "<a href='#' class = 'cvf_delete_image' id='img_id_"+index+"'><img src=\""+ e.target.result
							+ "\" data-file='" + f.name + "' class='selProductFile' title='click to remove'></a>";
					
					$(".file-drag-view").append(html);
					index++;
				}
				
				reader.readAsDataURL(f);
			});
			
			//특정 이미지 삭제
			$('body').on('click', 'a.cvf_delete_image', function(e) {
				e.preventDefault();
				$(this).remove();
				
                var file = $(this).children().attr("data-file");

				for (var i = 0; i < sel_files.length; i++) {
					if (sel_files[i].name == file) {
						sel_files.splice(i, 1);
						break;
					}
				}
				
				console.log(sel_files);
			});
		});
	
		function isValid(data){
			
			//파일인지 유효성 검사
			if(!data.type.indexOf('file') < 0){
				alert("파일이 아닙니다.");
				return false;
			}
			
			//이미지인지 유효성 검사
			if(data.type.indexOf('image') < 0){
				alert('이미지 파일만 업로드 가능합니다.');
				return false;
			}
			
			//파일의 사이즈는 10MB 미만
			if(data.size >= 1024 * 1024 * 10){
				alert('10MB 이상인 파일은 업로드할 수 없습니다.');
				return false;
			}
			
			return true;
		}
		
		//==>취소 클릭시 뒤로 감
		$("input[value='취소']").on("click", function() {
			history.back();
		});
	});
	
	function fileUploadAction() { 
		console.log("fileUploadAction");
		$fileDragInput.trigger('click');
	}
	
	function uploadFiles() {
		var formData = new FormData();
		for (var i = 0; i < sel_files.length; i++) {
			console.log(sel_files[i]);
			formData.append("uploadFile", sel_files[i]);
		}
	
		$.ajax({
			url : "/community/json/addDragFile",
			processData : false,
			contentType : false,
			method: 'POST',
			data: formData,
			success:function(data){
				console.log(data);
				
			 	$.each(data, function(index, item) {
			 		var imageUpload = "<input type='hidden' name='postImage[" + index + "]' value='"+ item + "'>";
			 		$(".imageUploadBox").append(imageUpload);
			 		//console.log(item);
			 	});
				
				
			 	$("#updateCommunity").attr("method" , "POST").attr("action" , "/community/updateCommunity?postNo=${community.postNo}").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
			 	
		    },
		    
		    error:function(e){
				console.log("이미지 업로드 실패");
		    }
		});
	}
	/* *************** 이미지 업로드 *************** */
	
	$(function() {
		//특정 이미지 삭제
		$('body').on('click', 'a.cvf_delete_image', function(e) {
			console.log("이미지 삭제");
			e.preventDefault();
			$(this).remove();
			
            var file = $(this).children().attr("data-file");
			console.log(file);
			for (var i = 0; i < sel_files.length; i++) {
				if (sel_files[i].name == file) {
					sel_files.splice(i, 1);
					break;
				}
			}
			
			console.log(sel_files);
		});
		
		//changed image preview
		$("#fileInput").on("change", function(){
			readURL(this);
       	});
		
		$('#receiptImage').on('change', function(e) {
			let fileName = $(this).val().split('\\').pop();
			$("input[name=file]").val(fileName);
		});
		
	});
	
	//changed image preview function
	function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
		
        reader.onload = function (e) {
                $("#receiptImage").attr("src", e.target.result);
            }

		reader.readAsDataURL(input.files[0]);
		console.log(input.files[0].name);
		
        }
    }
	
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
						
							<form class="form-horizontal" id="updateCommunity">
							
								<input type="hidden" class="form-control" id="member.memberId" name="member.memberId" value="${member.memberId}">
								<input type="hidden" class="form-control" id="member.nickname" name="member.nickname" value="${member.nickname}">
								
								<div class="form-group">
									<label for="postTitle" class="col-sm-offset-1 col-sm-3 control-label">게시물 제목</label>
									<div class="col-sm-12">
										<input type="text" class="form-control" id="postTitle" name="postTitle" value="${community.postTitle}">
									</div>
								</div><br>
								
								<div class="form-group">
									<label for="postText" class="col-sm-offset-1 col-sm-3 control-label">게시물 소개글</label>
									<div class="col-sm-12">
										<!-- <label for="textarea">게시물 소개글</label> -->
										<textarea id="postText" name="postText" rows="3" style="resize: none; height: 50em;">${community.postText}</textarea>
										<!-- <input type="text" class="form-control" id="postText" name="postText" placeholder="게시물 소개글"> -->
									</div>
								</div><br>
								
								<div class="col-md-12">
									<label for="fileDragInput">게시물 이미지</label>
									<div class="file-drag-area">
										<span class="file-drag-btn">파일 선택</span>
										<span class="file-drag-msg">파일을 여기로 드래그 하거나 선택하세요.</span> 
										<input class="file-drag-input" type="file" id="fileDragInput" name="fileDragInput" multiple="multiple">	
									</div>
									<div class="file-drag-view mt-4">
										<c:forEach var="image" items="${community.postImage}" varStatus="status">
											<c:set var="fileName" value="${fn:split(image, '_')}"/>
											<a class='cvf_delete_image' id='img_id_${status.index}'>
												<img src="/resources/images/uploadImages/${image}" data-file='${fileName[1]}' class='selProductFile' title='click to remove'>
												<input type='hidden' name='postImage[${status.index}]' value='${image}'>
											</a>
										</c:forEach></div>
									<div class="imageUploadBox"></div>
								</div><br><hr>
								
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
										<button type="button" class="normal btn-sm" id="button2" style="height: 35px;">
											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
								  			<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
										</svg> 주소찾기</button>
									</div>
								</div><br>
								
								<input type="hidden" name="latitude" value="${community.latitude}">
								<input type="hidden" name="longitude" value="${community.longitude}">
								
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
								
								<div class="col-md-12">
									<label for="mainMenu">이 집의 대표메뉴</label>
									<div class="row" id="mainMenu">
										<div class="col-md-4">
											<input type="text" class="form-control" id="mainMenuTitle" name="mainMenuTitle" placeholder="메뉴 이름" value="${community.mainMenuTitle}">
										</div>
										<div class="col-md-4">
											<input type="text" class="form-control" id="mainMenuPrice" name="mainMenuPrice" placeholder="메뉴 가격" value="${community.mainMenuPrice}">
										</div>
									</div>
								</div><br>
								
								<div class="form-group">
									<div class="col-sm-4">
										<label for="receiptImage">영수증 이미지</label>
										<img id="${community.receiptImage}" src="/resources/images/uploadImages/receipt/${community.receiptImage}" width="100"/>
										<%-- <input type="hidden" name="receiptImage"  value="${community.receiptImage}"> --%>
										<p>등록된 이미지 파일 : ${community.receiptImage}</p>
										<input type="file" name="file" id="receiptImage" value="${community.receiptImage}">
									</div>
								</div><br><hr>
								
								<div class="text-center">
									<button type="button" class="btn btn-outline-warning btn-sm" id="button3">
						                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply-all" viewBox="0 0 16 16">
						  				<path d="M8.098 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L8.8 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L4.114 8.254a.502.502 0 0 0-.042-.028.147.147 0 0 1 0-.252.497.497 0 0 0 .042-.028l3.984-2.933zM9.3 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
						  				<path d="M5.232 4.293a.5.5 0 0 0-.7-.106L.54 7.127a1.147 1.147 0 0 0 0 1.946l3.994 2.94a.5.5 0 1 0 .593-.805L1.114 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.5.5 0 0 0 .042-.028l4.012-2.954a.5.5 0 0 0 .106-.699z"/>
										</svg> 이전으로
									</button> &nbsp;
									<button type="button" class="btn btn-outline-danger btn-sm" id="button1">
						                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
						  					<path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
						  					<path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
						  				</svg> 수정하기
					  				</button>
								</div>
							
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