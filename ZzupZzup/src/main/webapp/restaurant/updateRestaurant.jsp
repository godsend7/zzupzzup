<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE HTML>

<html>
<head>
<title>음식점 수정하기 | ${restaurant.restaurantName}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 지도(위도, 경도)를 사용하기 위해 key 설정 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86fc1389540999ea4a3cdaa2a9ca1cc1&libraries=services"></script>

<link href="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/css/bootstrap4-toggle.min.css" rel="stylesheet">  
<script src="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/js/bootstrap4-toggle.min.js"></script>

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
	            //console.log(data.address);
	            
	            //주소의 위도와 경도 가져오기
	            geocoder.addressSearch(data.address, function(results, status) {
	             	if (status === daum.maps.services.Status.OK) {
	             		var result = results[0];
		            	//console.log(result.y);
		            	//console.log(result.x);
		            	$("input[name='latitude']").val(result.y);
		            	$("input[name='longitude']").val(result.x);
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

	function fncUpdateRestaurant(){
		
		var restaurantName = $("input[name='restaurantName']").val();
		var restaurantTel = $("input[name='restaurantTel']").val();
		var streetAddress = $("input[name='streetAddress']").val();
		var areaAddress = $("input[name='areaAddress']").val();
		var restAddress = $("input[name='restAddress']").val();
		var menuType = $("select[name='menuType']").val();
		var menuTitle = $("input[name='restaurantMenus[0].menuTitle']").val();
		var menuPrice = $("input[name='restaurantMenus[0].menuPrice']").val();
		var ownerImage = $("input[id='ownerImage']").val();
		/* var restaurantImage = $("input[name='restaurantImage[0].restaurantImage']").val(); */
		
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
		
		/* if(restAddress == null || restAddress.length<1){
			alert("음식점 상세 주소를 입력해주세요");
			return;
		} */
		
		if(menuType == null || menuType.length<1){
			alert("음식 종류를 선택해주세요");
			return;
		}
		
		if(menuTitle == null || menuTitle.length<1){
			alert("메뉴명은 최소 한가지 입력해 주셔야 합니다.");
			return;
		}
		
		if(menuPrice == null || menuPrice.length<1){
			alert("메뉴가격은 최소 한가지 입력해 주셔야 합니다.");
			return;
		}
		
		/* if(ownerImage == null || ownerImage.length<1){
			alert("사업자 등록증 이미지는 필수로 첨부해주셔야 합니다.");
			return;
		} */
		
		uploadFiles();
		
	} // fncUpdateRestaurant() FINISH
	
//	window.onload = function(){
		<c:forEach var="image" items="${restaurant.restaurantImage}" varStatus="status">
		<c:set var="fileName" value="${fn:split(image, '_')}"/>
			sel_files.push( {name : "${fileName[1]}" });
		</c:forEach>
		
		var index = ${fn:length(restaurant.restaurantMenus)};
		console.log(index);
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(function() {
			// 정보 수정 버튼 실행
			$( "#dataUpdate" ).on("click" , function() {
				fncUpdateRestaurant();
			});
			
			// 등록 재요청 버튼 실행
			$( "#redemand" ).on("click" , function() {
				fncUpdateRestaurant();
				/* alert('등록 심사 재요청이 완료되었습니다.\n심사 결과는 마이페이지에서 확인 가능합니다.');
				$("#updateRestaurant").attr("method" , "POST").attr("action" , "/restaurant/updateRestaurant?restaurantNo=${restaurant.restaurantNo}").attr("enctype", "multipart/form-data").submit(); */
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
		
		$(function() {
			$( "#plus" ).on("click" , function() {
				index++;
				var menu = /* '<div><br><input type="text" name="txt" value="test[' + index + ']">'
						+ '<input type="button" class="btnRemove" value="Remove"><br></div>'; */
						
						'<div class="row menuBox"> <div class="col-md-4">'
						+ '<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[' + index + '].menuTitle" placeholder="음식점 메뉴이름">'
						+ '</div>'
						+ '<div class="col-md-4">'
						+ '<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[' + index + '].menuPrice" placeholder="음식점 메뉴가격">'
						+ '</div>'
						+ '<div class="col-md-4">'
						+ '<input type="checkbox" id="mainMenuStatus' + index + '" name="restaurantMenus[' + index + '].mainMenuStatus" value="1">'
						+ '<label for="mainMenuStatus' + index + '">메인메뉴</label>'
						+ '<span class="badge badge-primary remove">X</span>'
						+ '</div></div>'
						
				$("#inputMenu").parent().append (menu);
				
			});
			
			/* $('.savedMenus').on('click', function () { 
                $(this).remove ();
            }); */
			$('body').on('click', '.remove', function () { 
                $(this).prev().remove ();
                $(this).next ().remove ();
                console.log($(this));
                
                $(this).parents(".menuBox").remove ();
         	});
			
		});
		
		$(function() {
			// SHOW BUTTON OPERATION
			$("#showButton").on("click", function() {
				$("#workingForms").fadeIn();
			});
			
			// HIDE BUTTON OPERATION
			$("#hideButton").on("click", function() {
				$("#workingForms").fadeOut();
			});
		});
//	} // window.onload FINISH
	
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
			url : "/restaurant/json/addDragFile",
			processData : false,
			contentType : false,
			method: 'POST',
			data: formData,
			success:function(data){
				console.log(data);
				
			 	$.each(data, function(index, item) {
			 		var imageUpload = "<input type='hidden' name='restaurantImage[" + index + "]' value='"+ item + "'>";
			 		$(".imageUploadBox").append(imageUpload);
			 		//console.log(item);
			 	});
				
			 	alert("음식점 등록 정보가 수정되었습니다.");
				
				$("#updateRestaurant").attr("method" , "POST").attr("action" , "/restaurant/updateRestaurant?restaurantNo=${restaurant.restaurantNo}").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
			 	
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
		
		$('#ownerImage').on('change', function(e) {
			let fileName = $(this).val().split('\\').pop();
			$("input[name=file]").val(fileName);
		});
			
		
	});
	
	//changed image preview function
	function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
		
        reader.onload = function (e) {
                $("#ownerImage").attr("src", e.target.result);
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
						
						<h2>음식점 등록하기</h2><hr>
	
						<form class="form-horizontal" id="updateRestaurant">
						
						<input type="hidden" name="member.memberId" value="${member.memberId}">
						<input type="hidden" name="member.memberName" value="${member.memberName}">
						<c:if test="${restaurant.judgeStatus == 3}">
							<input type="hidden" name="judgeStatus" value="1">
						</c:if>
						<c:if test="${restaurant.judgeStatus == 2}">
							<input type="hidden" name="judgeStatus" value="2">
						</c:if>
						
						
						<div class="form-group">
							<label for="restaurantName" class="col-sm-offset-1 col-sm-3 control-label">음식점명</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="restaurantName" name="restaurantName" value="${restaurant.restaurantName}" readonly="readonly">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-4">
								<label for="ownerImage">사업자 등록증 이미지</label>
								<img id="${restaurant.ownerImage}" src="/resources/images/uploadImages/owner/${restaurant.ownerImage}" width="100"/>
								<p>등록된 이미지 파일 : ${restaurant.ownerImage}</p>
								<input type="file" name="file" id="ownerImage" value="${restaurant.ownerImage}">
							</div>
						</div><br>
							
						<div class="form-group">
							<label for="restaurantTel" class="col-sm-offset-1 col-sm-3 control-label">음식점 전화번호</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="restaurantTel" name="restaurantTel" placeholder="음식점 전화번호" value="${restaurant.restaurantTel}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="streetAddress" class="col-sm-offset-1 col-sm-3 control-label">음식점 주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="streetAddress" name="streetAddress" placeholder="음식점 도로명주소" value="${restaurant.streetAddress}" readonly="readonly">
								<input type="text" class="form-control" id="areaAddress" name="areaAddress" placeholder="음식점 지번주소" value="${restaurant.areaAddress}" readonly="readonly">
								<input type="text" class="form-control" id="restAddress" name="restAddress" placeholder="음식점 상세주소" value="${restaurant.restAddress}" readonly="readonly">
								<button type="button" class="normal btn-sm" id="button2" style="height: 35px;">
									<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	  								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
								</svg> 주소찾기</button>
							</div>
						</div><br>
						
						<input type="hidden" name="latitude" value="${restaurant.latitude}">
						<input type="hidden" name="longitude" value="${restaurant.longitude}">
						
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
								<option value="1" ${!empty restaurant.menuType && restaurant.menuType == "1" ? "selected" : ""}>한식</option>
								<option value="2" ${!empty restaurant.menuType && restaurant.menuType == "2" ? "selected" : ""}>중식</option>
								<option value="3" ${!empty restaurant.menuType && restaurant.menuType == "3" ? "selected" : ""}>일식</option>
								<option value="4" ${!empty restaurant.menuType && restaurant.menuType == "4" ? "selected" : ""}>양식</option>
								<option value="5" ${!empty restaurant.menuType && restaurant.menuType == "5" ? "selected" : ""}>카페</option>
							</select>
							<div class="invalid-feedback">
								Please select a menu type
							</div>
						</div><br>
						
						
						
						<div class="col-md-12">
							<label for="inputMenu">음식점 메뉴 &nbsp;
								<span class="badge badge-success" id="plus">추가하기</span>
							</label>
							<%-- <div class="row" id="menuBox">
								<div class="col-md-4">
									<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[0].menuTitle" placeholder="음식점 메뉴이름" value="${restaurant.restaurantMenus[0].menuTitle}">
								</div>
								<div class="col-md-4">
									<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[0].menuPrice" placeholder="음식점 메뉴가격" value="${restaurant.restaurantMenus[0].menuPrice}">
								</div>
								<div class="col-md-4">	
									<!-- <input type="text" class="form-control" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" placeholder="대표메뉴 여부"> -->
									<input type="checkbox" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" value="1" 
									${!empty restaurant.restaurantMenus[0].mainMenuStatus && restaurant.restaurantMenus[0].mainMenuStatus ? "checked" : ""}>
									<label for="mainMenuStatus">메인메뉴</label>
								</div>
							</div> --%>
							<c:set var="i" value="1"/>
							<c:forEach var="menus" items="${restaurant.restaurantMenus}" varStatus="status" >
								<div class="row menuBox" id="inputMenu">
									<div class="col-md-4">
										<input type="text" class="form-control" id="menuTitle" name="restaurantMenus[${status.index}].menuTitle" placeholder="음식점 메뉴이름" value="${menus.menuTitle}">
									</div>
									<div class="col-md-4">
										<input type="text" class="form-control" id="menuPrice" name="restaurantMenus[${status.index}].menuPrice" placeholder="음식점 메뉴가격" value="${menus.menuPrice}">
									</div>
									<div class="col-md-4">	
										<!-- <input type="text" class="form-control" id="mainMenuStatus" name="restaurantMenus[0].mainMenuStatus" placeholder="대표메뉴 여부"> -->
										<input type="checkbox" id="mainMenuStatus" name="restaurantMenus[${status.index}].mainMenuStatus" value="1" ${!empty menus.mainMenuStatus && menus.mainMenuStatus ? "checked" : ""}>
										<label for="mainMenuStatus">메인메뉴</label>
										<c:if test="${status.index != 0}"><span class="badge badge-primary remove">X</span></c:if>
									</div>
								</div>
							</c:forEach>
						</div><br>
						
						<div class="col-sm-8 restaurant-info">
							<label for="working">음식점 운영정보 &nbsp;
								<span class="badge badge-info" id="showButton">보기</span>
								<span class="badge badge-danger" id="hideButton">숨기기</span>
							</label>
							
							<div id="workingForms" style="display: none;"><br>
							
							<div id="toggleButton">주차가능여부 &nbsp;&nbsp;
								<input type="checkbox" name="parkable" id="parkable" data-toggle="toggle" data-size="sm" value="true" 
								${!empty restaurant.parkable && restaurant.parkable ? "checked" : ""}>
							</div><br>
							
							<!-- ######################### 월요일 ######################### -->
							<div id="working1">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday" name="restaurantTimes[0].restaurantDay" value="1" onclick="return(false);" checked> <label for="monday">월</label>
									<input type="radio" id="tuesday" name="restaurantTimes[0].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday">화</label>
									<input type="radio" id="wednesday" name="restaurantTimes[0].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday">수</label>
									<input type="radio" id="thursday" name="restaurantTimes[0].restaurantDay" value="4" onclick="return(false);"> <label for="thursday">목</label>
									<input type="radio" id="friday" name="restaurantTimes[0].restaurantDay" value="5" onclick="return(false);"> <label for="friday">금</label>
									<input type="radio" id="saturday" name="restaurantTimes[0].restaurantDay" value="6" onclick="return(false);"> <label for="saturday">토</label>
									<input type="radio" id="sunday" name="restaurantTimes[0].restaurantDay" value="7" onclick="return(false);"> <label for="sunday">일</label>
							    	<input type="checkbox" id="dayoff" name="restaurantTimes[0].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[0].restaurantDayOff && restaurant.restaurantTimes[0].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time"></label>
								    	<input type="time" id="time" name="restaurantTimes[0].restaurantOpen" value="${restaurant.restaurantTimes[0].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time"></label>
								    	<input type="time" id="time" name="restaurantTimes[0].restaurantClose" value="${restaurant.restaurantTimes[0].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time"></label>
								    	<input type="time" id="time" name="restaurantTimes[0].restaurantBreak" value="${restaurant.restaurantTimes[0].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time"></label>
								    	<input type="time" id="time" name="restaurantTimes[0].restaurantLastOrder" value="${restaurant.restaurantTimes[0].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 화요일 ######################### -->
							<div id="working2">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday1" name="restaurantTimes[1].restaurantDay" value="1" onclick="return(false);"> <label for="monday1">월</label>
									<input type="radio" id="tuesday1" name="restaurantTimes[1].restaurantDay" value="2" onclick="return(false);" checked> <label for="tuesday1">화</label>
									<input type="radio" id="wednesday1" name="restaurantTimes[1].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday1">수</label>
									<input type="radio" id="thursday1" name="restaurantTimes[1].restaurantDay" value="4" onclick="return(false);"> <label for="thursday1">목</label>
									<input type="radio" id="friday1" name="restaurantTimes[1].restaurantDay" value="5" onclick="return(false);"> <label for="friday1">금</label>
									<input type="radio" id="saturday1" name="restaurantTimes[1].restaurantDay" value="6" onclick="return(false);"> <label for="saturday1">토</label>
									<input type="radio" id="sunday1" name="restaurantTimes[1].restaurantDay" value="7" onclick="return(false);"> <label for="sunday1">일</label>
							    	<input type="checkbox" id="dayoff1" name="restaurantTimes[1].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[1].restaurantDayOff && restaurant.restaurantTimes[1].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff1">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time1"></label>
								    	<input type="time" id="time1" name="restaurantTimes[1].restaurantOpen" value="${restaurant.restaurantTimes[1].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time1"></label>
								    	<input type="time" id="time1" name="restaurantTimes[1].restaurantClose" value="${restaurant.restaurantTimes[1].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time1"></label>
								    	<input type="time" id="time1" name="restaurantTimes[1].restaurantBreak" value="${restaurant.restaurantTimes[1].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time1"></label>
								    	<input type="time" id="time1" name="restaurantTimes[1].restaurantLastOrder" value="${restaurant.restaurantTimes[1].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 수요일 ######################### -->
							<div id="working3">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday2" name="restaurantTimes[2].restaurantDay" value="1" onclick="return(false);"> <label for="monday2">월</label>
									<input type="radio" id="tuesday2" name="restaurantTimes[2].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday2">화</label>
									<input type="radio" id="wednesday2" name="restaurantTimes[2].restaurantDay" value="3" onclick="return(false);" checked> <label for="wednesday2">수</label>
									<input type="radio" id="thursday2" name="restaurantTimes[2].restaurantDay" value="4" onclick="return(false);"> <label for="thursday2">목</label>
									<input type="radio" id="friday2" name="restaurantTimes[2].restaurantDay" value="5" onclick="return(false);"> <label for="friday2">금</label>
									<input type="radio" id="saturday2" name="restaurantTimes[2].restaurantDay" value="6" onclick="return(false);"> <label for="saturday2">토</label>
									<input type="radio" id="sunday2" name="restaurantTimes[2].restaurantDay" value="7" onclick="return(false);"> <label for="sunday2">일</label>
							    	<input type="checkbox" id="dayoff2" name="restaurantTimes[2].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[2].restaurantDayOff && restaurant.restaurantTimes[2].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff2">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time2"></label>
								    	<input type="time" id="time2" name="restaurantTimes[2].restaurantOpen" value="${restaurant.restaurantTimes[2].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time2"></label>
								    	<input type="time" id="time2" name="restaurantTimes[2].restaurantClose" value="${restaurant.restaurantTimes[2].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time2"></label>
								    	<input type="time" id="time2" name="restaurantTimes[2].restaurantBreak" value="${restaurant.restaurantTimes[2].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time2"></label>
								    	<input type="time" id="time2" name="restaurantTimes[2].restaurantLastOrder" value="${restaurant.restaurantTimes[2].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 목요일 ######################### -->
							<div id="working4">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday3" name="restaurantTimes[3].restaurantDay" value="1" onclick="return(false);"> <label for="monday3">월</label>
									<input type="radio" id="tuesday3" name="restaurantTimes[3].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday3">화</label>
									<input type="radio" id="wednesday3" name="restaurantTimes[3].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday3">수</label>
									<input type="radio" id="thursday3" name="restaurantTimes[3].restaurantDay" value="4" onclick="return(false);" checked> <label for="thursday3">목</label>
									<input type="radio" id="friday3" name="restaurantTimes[3].restaurantDay" value="5" onclick="return(false);"> <label for="friday3">금</label>
									<input type="radio" id="saturday3" name="restaurantTimes[3].restaurantDay" value="6" onclick="return(false);"> <label for="saturday3">토</label>
									<input type="radio" id="sunday3" name="restaurantTimes[3].restaurantDay" value="7" onclick="return(false);"> <label for="sunday3">일</label>
							    	<input type="checkbox" id="dayoff3" name="restaurantTimes[3].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[3].restaurantDayOff && restaurant.restaurantTimes[3].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff3">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time3"></label>
								    	<input type="time" id="time3" name="restaurantTimes[3].restaurantOpen" value="${restaurant.restaurantTimes[3].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time3"></label>
								    	<input type="time" id="time3" name="restaurantTimes[3].restaurantClose" value="${restaurant.restaurantTimes[3].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time3"></label>
								    	<input type="time" id="time3" name="restaurantTimes[3].restaurantBreak" value="${restaurant.restaurantTimes[3].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time3"></label>
								    	<input type="time" id="time3" name="restaurantTimes[3].restaurantLastOrder" value="${restaurant.restaurantTimes[3].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 금요일 ######################### -->
							<div id="working5">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday4" name="restaurantTimes[4].restaurantDay" value="1" onclick="return(false);"> <label for="monday4">월</label>
									<input type="radio" id="tuesday4" name="restaurantTimes[4].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday4">화</label>
									<input type="radio" id="wednesday4" name="restaurantTimes[4].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday4">수</label>
									<input type="radio" id="thursday4" name="restaurantTimes[4].restaurantDay" value="4" onclick="return(false);"> <label for="thursday4">목</label>
									<input type="radio" id="friday4" name="restaurantTimes[4].restaurantDay" value="5" onclick="return(false);" checked> <label for="friday4">금</label>
									<input type="radio" id="saturday4" name="restaurantTimes[4].restaurantDay" value="6" onclick="return(false);"> <label for="saturday4">토</label>
									<input type="radio" id="sunday4" name="restaurantTimes[4].restaurantDay" value="7" onclick="return(false);"> <label for="sunday4">일</label>
							    	<input type="checkbox" id="dayoff4" name="restaurantTimes[4].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[4].restaurantDayOff && restaurant.restaurantTimes[4].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff4">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time4"></label>
								    	<input type="time" id="time4" name="restaurantTimes[4].restaurantOpen" value="${restaurant.restaurantTimes[4].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time4"></label>
								    	<input type="time" id="time4" name="restaurantTimes[4].restaurantClose" value="${restaurant.restaurantTimes[4].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time4"></label>
								    	<input type="time" id="time4" name="restaurantTimes[4].restaurantBreak" value="${restaurant.restaurantTimes[4].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time4"></label>
								    	<input type="time" id="time4" name="restaurantTimes[4].restaurantLastOrder" value="${restaurant.restaurantTimes[4].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 토요일 ######################### -->
							<div id="working6">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday5" name="restaurantTimes[5].restaurantDay" value="1" onclick="return(false);"> <label for="monday5">월</label>
									<input type="radio" id="tuesday5" name="restaurantTimes[5].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday5">화</label>
									<input type="radio" id="wednesday5" name="restaurantTimes[5].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday5">수</label>
									<input type="radio" id="thursday5" name="restaurantTimes[5].restaurantDay" value="4" onclick="return(false);"> <label for="thursday5">목</label>
									<input type="radio" id="friday5" name="restaurantTimes[5].restaurantDay" value="5" onclick="return(false);"> <label for="friday5">금</label>
									<input type="radio" id="saturday5" name="restaurantTimes[5].restaurantDay" value="6" onclick="return(false);" checked> <label for="saturday5">토</label>
									<input type="radio" id="sunday5" name="restaurantTimes[5].restaurantDay" value="7" onclick="return(false);"> <label for="sunday5">일</label>
							    	<input type="checkbox" id="dayoff5" name="restaurantTimes[5].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[5].restaurantDayOff && restaurant.restaurantTimes[5].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff5">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time5"></label>
								    	<input type="time" id="time5" name="restaurantTimes[5].restaurantOpen" value="${restaurant.restaurantTimes[5].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time5"></label>
								    	<input type="time" id="time5" name="restaurantTimes[5].restaurantClose" value="${restaurant.restaurantTimes[5].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time5"></label>
								    	<input type="time" id="time5" name="restaurantTimes[5].restaurantBreak" value="${restaurant.restaurantTimes[5].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time5"></label>
								    	<input type="time" id="time5" name="restaurantTimes[5].restaurantLastOrder" value="${restaurant.restaurantTimes[5].restaurantLastOrder}">
								    </div>
								</div>
							</div><br><br>
							
							<!-- ######################### 일요일 ######################### -->
							<div id="working7">
								<div>음식점 운영요일 &nbsp;
									<input type="radio" id="monday6" name="restaurantTimes[6].restaurantDay" value="1" onclick="return(false);"> <label for="monday6">월</label>
									<input type="radio" id="tuesday6" name="restaurantTimes[6].restaurantDay" value="2" onclick="return(false);"> <label for="tuesday6">화</label>
									<input type="radio" id="wednesday6" name="restaurantTimes[6].restaurantDay" value="3" onclick="return(false);"> <label for="wednesday6">수</label>
									<input type="radio" id="thursday6" name="restaurantTimes[6].restaurantDay" value="4" onclick="return(false);"> <label for="thursday6">목</label>
									<input type="radio" id="friday6" name="restaurantTimes[6].restaurantDay" value="5" onclick="return(false);"> <label for="friday6">금</label>
									<input type="radio" id="saturday6" name="restaurantTimes[6].restaurantDay" value="6" onclick="return(false);"> <label for="saturday6">토</label>
									<input type="radio" id="sunday6" name="restaurantTimes[6].restaurantDay" value="7" onclick="return(false);" checked> <label for="sunday6">일</label>
							    	<input type="checkbox" id="dayoff6" name="restaurantTimes[6].restaurantDayOff" value="1" 
							    	${!empty restaurant.restaurantTimes[6].restaurantDayOff && restaurant.restaurantTimes[6].restaurantDayOff ? "checked" : ""}>
							    	<label for="dayoff6">휴무일</label>
							    </div>
							    
							    <div class="row">
								    <div class="col">오픈시간
								    	<label for="time6"></label>
								    	<input type="time" id="time6" name="restaurantTimes[6].restaurantOpen" value="${restaurant.restaurantTimes[6].restaurantOpen}">
								    </div>
								    <div class="col">마감시간
								    	<label for="time6"></label>
								    	<input type="time" id="time6" name="restaurantTimes[6].restaurantClose" value="${restaurant.restaurantTimes[6].restaurantClose}">
								    </div>
								    <div class="col">브레이크타임
								    	<label for="time6"></label>
								    	<input type="time" id="time6" name="restaurantTimes[6].restaurantBreak" value="${restaurant.restaurantTimes[6].restaurantBreak}">
								    </div>
								    <div class="col">라스트오더
								    	<label for="time6"></label>
								    	<input type="time" id="time6" name="restaurantTimes[6].restaurantLastOrder" value="${restaurant.restaurantTimes[6].restaurantLastOrder}">
								    </div>
								</div>
							</div>
							
							</div>
							
						</div><br>
						
						<%-- <div class="col-sm-4">
							<label for="restaurantImage">음식점 이미지</label>
							<input type="file" id="file" name="file" multiple="multiple" value="${restaurant.restaurantImage}">
							
							<!-- <input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
							<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진">
							<input type="text" class="form-control" id="restaurantImage" name="restaurantImage[0].restaurantImage" placeholder="음식점 사진"> -->
						</div><br><br> --%>
						
						<div class="col-md-12">
							<label for="fileDragInput">음식점 이미지</label>
							<div class="file-drag-area">
								<span class="file-drag-btn">파일 선택</span>
								<span class="file-drag-msg">파일을 여기로 드래그 하거나 선택하세요.</span>
								<%-- <input type="hidden" name="restaurantImage"  value="${restaurant.restaurantImage}"> --%>
								<input class="file-drag-input" type="file" id="fileDragInput" name="fileDragInput" multiple="multiple">
									
							</div>
							<div class="file-drag-view mt-4">
								<c:forEach var="image" items="${restaurant.restaurantImage}" varStatus="status">
									<c:set var="fileName" value="${fn:split(image, '_')}"/>
									<a class='cvf_delete_image' id='img_id_${status.index}'>
										<img src="/resources/images/uploadImages/${image}" data-file='${fileName[1]}' class='selProductFile' title='click to remove'>
										<input type='hidden' name='restaurantImage[${status.index}]' value='${image}'>
									</a>
								</c:forEach></div>
							<div class="imageUploadBox"></div>
						</div><br><br>
						
						<div class="col-sm-12">
							<label for="restaurantText">음식점 소개글</label>
							<textarea id="restaurantText" name="restaurantText" placeholder="음식점 소개글" rows="3" style="resize: none; height: 10em;">${restaurant.restaurantText}</textarea>
						</div><br><br>
						
						<div class="col-md-12"><strong>예약 및 결제 서비스</strong> &nbsp;&nbsp;
							<input type="checkbox" name="reservationStatus" id="reservationStatus" checked data-toggle="toggle" data-size="sm" data-onstyle="success" value="true" 
							${!empty restaurant.reservationStatus && restaurant.reservationStatus ? "checked" : ""}>	
						</div><br><hr>
							
						</form>
						
						<div class="text-center">
							
							<button type="button" class="btn btn-outline-warning btn-sm" id="button3">
				                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply-all" viewBox="0 0 16 16">
				  				<path d="M8.098 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L8.8 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L4.114 8.254a.502.502 0 0 0-.042-.028.147.147 0 0 1 0-.252.497.497 0 0 0 .042-.028l3.984-2.933zM9.3 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
				  				<path d="M5.232 4.293a.5.5 0 0 0-.7-.106L.54 7.127a1.147 1.147 0 0 0 0 1.946l3.994 2.94a.5.5 0 1 0 .593-.805L1.114 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.5.5 0 0 0 .042-.028l4.012-2.954a.5.5 0 0 0 .106-.699z"/>
								</svg> 이전으로
							</button> &nbsp;
							
							<c:if test="${restaurant.judgeStatus == '3'}">
								<button type="button" class="btn btn-outline-primary btn-sm" id="redemand">
					                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-repeat" viewBox="0 0 16 16">
	  								<path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
	  								<path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3zM3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9H3.1z"/>
									</svg> 재등록하기
								</button> &nbsp;	
							</c:if>
							
							<c:if test="${restaurant.judgeStatus == '2'}">
								<button type="button" class="btn btn-outline-danger btn-sm" id="dataUpdate">
					                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
					  					<path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
					  					<path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
					  				</svg> 수정하기
					  			</button>
							</c:if>
							
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