<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE HTML>

<html>
<head>
<title>Review 수정하기</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/review.css" />
 
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	.reviewShowStatus {
		display: none;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	var scopeClean = ${review.scopeClean};
	var scopeTaste = ${review.scopeTaste};
	var scopeKind = ${review.scopeKind};
	
	//hashTag id 초기화
	var hashTagCount = ${fn:length(review.hashTag)};
	//해시태그 리스트 초기화
	var hashtag_list = [];
	
	//이미지 정보를 담을 배열
 	var sel_files = [];
	
	function fncUpdateReview() {
		console.log("fncUpdateReview");
		//alert("선택하지 않은 평점이 존재합니다!");
		if(scopeClean != 0) {
			$("#scopeClean").val(scopeClean);
		}
		
		if(scopeTaste != 0) {
			$("#scopeTaste").val(scopeTaste);
		}
		
		if(scopeKind != 0) {
			$("#scopeKind").val(scopeKind);
		}
		
		if(scopeClean == 0 || scopeTaste == 0 || scopeKind == 0) {
			alert("선택하지 않은 평점이 존재합니다!");
			return;
		}
		
		if ($("#reviewShowStatus").is(':checked')) {
			$("#reviewShowStatus").val("true")
		} else {
			$("#reviewShowStatus").val("false")
		}
		
		uploadFiles();
		
		//$("#review").attr("method", "POST").attr("action" , "/review/updateReview").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
	} 
	
	
	
	window.onload = function() {
		<c:forEach var="image" items="${review.reviewImage}" varStatus="status">
		<c:set var="fileName" value="${fn:split(image, '_')}"/>
			sel_files.push( {name : "${fileName[1]}" });
		</c:forEach>
	
		//console.log(sel_files);
		
		for (var i = 0; i < $("#hashTagBox").children().length; i++) {
			hashtag_list.push(parseInt($("#hashTagBox").children("span:eq("+(i)+")").find("input").attr("value")));
		}
		console.log(hashtag_list);
		
		for (var i = 0; i < ${review.scopeClean}; i++) {
	  		$(".starClean").eq(i).addClass("on");
		}
		
		for (var i = 0; i < ${review.scopeTaste}; i++) {
	  		$(".starTaste").eq(i).addClass("on");
		}
		
		for (var i = 0; i < ${review.scopeKind}; i++) {
	  		$(".starKind").eq(i).addClass("on");
		}
		
		if (${member.memberRole != 'admin'}) {
			$(".starClean").on('click',function(){
				var idx = $(this).index();
				scopeClean = idx+1;
				/* console.log(scopeClean); */
		  		$(".starClean").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starClean").eq(i).addClass("on");
		   		}
			});
			
			$(".starTaste").on('click',function(){
				var idx = $(this).index();
				scopeTaste = idx+1;
				/* console.log(scopeTaste); */
		  		$(".starTaste").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starTaste").eq(i).addClass("on");
		   		}
			});
			
			$(".starKind").on('click',function(){
				var idx = $(this).index();
				scopeKind = idx+1;
				/* console.log(scopeKind); */
		  		$(".starKind").removeClass("on");
		  		for(var i=0; i<=idx; i++){
		        	$(".starKind").eq(i).addClass("on");
		   		}
			});
			
			$("#hashTagBox").on("click", "span", function(e) {
				e.stopPropagation();
				
				$(this).remove();
				
				var no = $(this).children().val();
				console.log(no);
			 	for (var i = 0; i < hashtag_list.length; i++) {
					if (hashtag_list[i] == no) {
						hashtag_list.splice(i, 1);
						break;
					}
				} 
				
				if ($("#hashTagBox").children().length == 0) {
					hashTagCount = 0;
				}
			});
		}
		
			
		$("#hashTagAuto").autocomplete({
			source: function(request, response) {
		 		$.ajax({
		 			url:"/review/json/listHashTag",
	    	  		method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : {
						"keyWord" : $("#hashTagAuto").val()
					},
					success : function(data, status) {
						
						var array = Array.prototype.slice.call(data);
						var hashArry = [];
						
						for (var i = 0; i < hashtag_list.length; i++) {
							for (let hashTag of array) {
								var check = false;
								
								if (hashtag_list[i] == hashTag.hashTagNo) {
									hashArry.push(hashTag);
									break;
								}
							}
						}
						
						//중복된 해시태그 제외 출력 (차집합)
						let difference = array.filter(x => !hashArry.includes(x));
						
						//console.log(difference);
						
						response(
							$.map(difference, function(item) {
                                return {
                                	value: item.hashTag,
                                    label: item.hashTag,
                                    id: item.hashTagNo
                                }
                            })
						);//response 
					}
	      		});
	 		},
	 		select : function(event, ui) {
	 			$("#hashTagBox").append("<span class='badge badge-pill badge-secondary hashTag' id='hashtag" 
	 									+ hashTagCount + "'>" + ui.item.label + " x <input type='hidden' name='hashTag[" 
	 										+ hashTagCount + "].hashTagNo' value='" + ui.item.id + "'></span>");
				hashTagCount++;
				
				hashtag_list.push(ui.item.id);
				
				$("#hashTagAuto").val('');
				
				return false;
	 		}
		});
		
		$("#updateBtn").on("click", function() {
			/* console.log("button"); */
			fncUpdateReview();
		});
		
		$("#cancelBtn").on("click", function() {
			window.history.back();
		});
	}
	
	$(function() {
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
			url : "/review/json/addDragFile",
			processData : false,
			contentType : false,
			method: 'POST',
			data: formData,
			success:function(data){
				console.log(data);
				
			 	$.each(data, function(index, item) {
			 		var imageUpload = "<input type='hidden' name='reviewImage[" + index + "]' value='"+ item + "'>";
			 		$(".imageUploadBox").append(imageUpload);
			 		//console.log(item);
			 	});
				
			 	$("#review").attr("method", "POST").attr("action" , "/review/updateReview").attr("enctype", "multipart/form-data").attr("accept-charset","UTF-8").submit();
		    },
		    error:function(e){
				console.log("실패");
		    }
		});
	}
	
	$(function() {
		//특정 이미지 삭제
		if (${member.memberRole != "admin"}) {
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

				<section id="updateReviewView">
					<div class="container">
					
						<!-- start:Form -->
						<h2>Review 수정</h2>
						<br>
						<form id="review">
							<div class="row gtr-uniform">
							
								<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo}">
							
								<div class="col-12">
							 		<br>
									<label for="reviewStar">음식점 평가</label>
								</div>
							 
							 	<div class="col-md-4 star-box">
							 		<label for="scopeClean" class="starLabel">청결해요</label>
									<div class="star-in">
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
										<span class="star starClean"></span>
									</div>
									<input type="hidden" id="scopeClean" name="scopeClean" />
							 	</div>
							 	
								<div class="col-md-4 star-box">
									<label for="scopeTaste" class="starLabel">맛있어요</label>
									<div class="star-in">
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
										<span class="star starTaste"></span>
									</div>
									<input type="hidden" id="scopeTaste" name="scopeTaste" />
								</div>
								
								<div class="col-md-4 star-box">
									<label for="scopeKind" class="starLabel">친절해요</label>
									<div class="star-in">
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
										<span class="star starKind"></span>
									</div>
									<input type="hidden" id="scopeKind" name="scopeKind" />
								</div>
								
								<c:choose>
									<c:when test="${member.memberRole eq 'admin'}">
										<div class="col-12">
										<br>
											<label for="fileDragInput">리뷰 이미지</label>
											<div class="file-drag-view">
												<c:forEach var="image" items="${review.reviewImage}">
													<a class='cvf_delete_image' id='img_id_${status.index}'>
														<%-- <img src="/resources/images/uploadImages/review/${image}"> --%>
														<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/${image}">
													</a>
												</c:forEach>
											</div>
										</div>
										
										<br>
										
										<!-- Break -->
										<div class="col-12">
										<br>
											<label for="reviewDetail">어떤 점이 좋았나요?</label>
											<p>${review.reviewDetail}</p>
										</div>
										
										<!-- Break -->
										<div class="col-12">
										<br>
											<label for="hashTag">해시태그</label>
											<div class="box" id="hashTagBox">
												<c:forEach var="hashtag" items="${review.hashTag}">
													<span class='badge badge-pill badge-secondary hashTag'>${hashtag.hashTag}</span>
												</c:forEach>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-12">
										<br>
											<label for="fileDragInput">리뷰 이미지</label>
											<div class="file-drag-area">
												<span class="file-drag-btn">파일 선택</span> 
												<span class="file-drag-msg">파일을 여기로 드래그 하거나 선택하세요.</span> 
												<input class="file-drag-input" type="file" id="fileDragInput" name="fileDragInput" multiple="multiple">
											</div>
											<div class="file-drag-view mt-4">
												<c:forEach var="image" items="${review.reviewImage}" varStatus="status">
													<c:set var="fileName" value="${fn:split(image, '_')}"/>
													<a class='cvf_delete_image' id='img_id_${status.index}'>
														<%-- <img src="/resources/images/uploadImages/review/${image}" data-file='${fileName[1]}' class='selProductFile' title='click to remove'> --%>
														<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/${image}" data-file='${fileName[1]}' class='selProductFile' title='click to remove'>
														<input type='hidden' name='reviewImage[${status.index}]' value='${image}'>
													</a>
												</c:forEach>
											</div>
											<div class="imageUploadBox">
											</div>
										</div>
										<!-- Break -->
										<div class="col-12">
										<br>
											<label for="reviewDetail">어떤 점이 좋았나요?</label>
											<textarea name="reviewDetail" id="reviewDetail" placeholder="100자 이내로 입력해주세요." maxlength='100' rows="2">${review.reviewDetail}</textarea>
										</div>
										
										<!-- Break -->
										<div class="col-12">
										<br>
											<label for="hashTag">해시태그</label>
											<input id="hashTagAuto" type="text" placeholder="#을 입력하여 해시태그를 등록해보세요."><br>
											
											<div class="box" id="hashTagBox">
											<c:set var="i" value="0" />
											<c:forEach var="hashtag" items="${review.hashTag}">
												<span class='badge badge-pill badge-secondary hashTag' id='hashtag${i}'>${hashtag.hashTag} x 
													<input type='hidden' name='hashTag[${i}].hashTagNo' value='${hashtag.hashTagNo}'>
												</span>
												<c:set var="i" value="${ i+1 }" />
											</c:forEach>
											</div>
											<!-- <input id="hashTagAppend" type="button" value="X"> -->
											<!-- <textarea name="review.hashTag" id="review.hashTag" placeholder="#을 입력하여 해시태그를 선택해주세요." rows="2"></textarea> -->
										</div>
									</c:otherwise>
								</c:choose>
								
								<!-- Break -->
								<div class="col-12${member.memberRole eq 'admin' ? '' : ' reviewShowStatus'}">
								<br>
									<input type="checkbox" id="reviewShowStatus" name="reviewShowStatus" ${review.reviewShowStatus ? 'checked' : ''}> 
									<label for="reviewShowStatus">리뷰 노출 여부</label>
								</div>
								
					 	   		<!-- Break -->
								<div class="col-12">
									<ul class="actions justify-content-center">
										<li><input type="button" value="취소" class="normal" id="cancelBtn" /></li>
										<li><input type="button" value="수정" class="primary" id="updateBtn" /></li>
									</ul>
								</div>
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