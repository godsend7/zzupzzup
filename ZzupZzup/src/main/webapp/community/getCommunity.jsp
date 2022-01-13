<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>${community.restaurantName}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

.checked {
 	fill : pink;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	// 좋아요 기능
	$(function() {
		$(".postLike").on("click", function() {
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			if ($(this).hasClass("checked") === true) {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/community/json/deleteLike/"+$(this).closest("div").find("input[name='postNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						//console.log(data.likeCount);
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','postLike');
					}
				});	
			} else {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/community/json/addLike/"+$(this).closest("div").find("input[name='postNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						//console.log(data);
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','postLike checked');
					}
				});
			}
		});
	});

	window.onload = function(){
		// carousel prev & next
		$("#car_prev").click(function(){
			$("#carouselExampleFade").carousel("prev");
		});
		
		$("#car_next").click(function(){
			$("#carouselExampleFade").carousel("next");
		});
	}
	
	$(function() {
		$("#goToBack").on("click", function() {
			self.location = "/community/listCommunity"
			//history.go(-1);
		});
		
		$("#deleteButton").on("click", function() {
			if(confirm("해당 게시물을 삭제하시겠습니까?")) {
				self.location = "/community/deleteCommunity?postNo=${community.postNo}"
			}
			/* $("#restaurant").attr("method", "POST").attr("action","/community/deleteCommunity").submit(); */
		});
		
		$("#modifyButton").on("click", function() {
			self.location = "/community/updateCommunity?postNo=${community.postNo}"
		});
		
		$("#promoteButton").on("click", function() {
			console.log("click")
			if(confirm("해당 게시물을 정식 맛집으로 승격하시겠습니까?")) {
				$("#getCommunity").attr("method" , "POST").attr("action" , "/community/officialCommunity?postNo=${community.postNo}").submit();
				//self.location = "/community/officialCommunity?postNo=${community.postNo}"
			}
		});
		
		// 신고하기 Modal
		$(".reportModal").on("click", function() {
			$("#reportModal").modal("show");
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
				
				<section id="">
				
				<form id="getCommunity">
				
					<input type="hidden" class="form-control" id="community.postNo" name="community.postNo" value="${community.postNo}">
					
					<div class="container">
					
						<c:if test="${!empty community.receiptImage}">
							<span class="badge badge-success" id="receiptImage" data-toggle="modal" data-target="#receiptModal">영수증 첨부된 게시물</span>
						</c:if>
						
						<!-- Modal -->
						<div class="modal fade" id="receiptModal" tabindex="-1" aria-labelledby="receiptModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="receiptModalLabel">첨부된 영수증 이미지</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <img src="/resources/images/uploadImages/receipt/${community.receiptImage}" width="100%" />
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-link btn-sm" data-dismiss="modal">&nbsp;확&nbsp;인&nbsp;</button>
						        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
						      </div>
						    </div>
						  </div>
						</div>
						
						<div class="row">
							<div class="col-md-8">
								<h2 class="text-info">${community.postTitle} &nbsp;
								<small style="color:gray;" class="getOtherUserModal" data-toggle='modal' data-target='#getOtherUserModal' data-id="${community.member.memberId}">by. ${community.member.nickname}</small>
								</h2>
							</div>
							<div class="col-md-4" style="text-align:right; padding-right: 20px;">
								<span class="likeCount">${community.likeCount}</span> &nbsp;
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-heart-fill postLike <c:forEach var="like" items="${listLike}">${(community.postNo == like.postNo && !empty member && member.memberId == like.memberId )? ' checked' : ''}</c:forEach>" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>
								<input type="hidden" name="postNo" value="${community.postNo}">&nbsp;&nbsp;&nbsp;
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="Crimson" class="bi bi-flag-fill reportModal" data-toggle='modal' data-target='#reportModal' viewBox="0 0 16 16" data-id="[4,${community.postNo}]">
								  <path d="M14.778.085A.5.5 0 0 1 15 .5V8a.5.5 0 0 1-.314.464L14.5 8l.186.464-.003.001-.006.003-.023.009a12.435 12.435 0 0 1-.397.15c-.264.095-.631.223-1.047.35-.816.252-1.879.523-2.71.523-.847 0-1.548-.28-2.158-.525l-.028-.01C7.68 8.71 7.14 8.5 6.5 8.5c-.7 0-1.638.23-2.437.477A19.626 19.626 0 0 0 3 9.342V15.5a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 1 0v.282c.226-.079.496-.17.79-.26C4.606.272 5.67 0 6.5 0c.84 0 1.524.277 2.121.519l.043.018C9.286.788 9.828 1 10.5 1c.7 0 1.638-.23 2.437-.477a19.587 19.587 0 0 0 1.349-.476l.019-.007.004-.002h.001"/>
								</svg>
							</div>
					    </div><hr style="margin-top: 10px;">
					    
					    <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
						  <div class="carousel-inner">
						  	<c:if test="${!empty community.postImage}">
							  	<c:forEach var="image" items="${community.postImage}" varStatus="status">
							  		<c:choose>
							  			<c:when test="${status.index == 0}">
							  				<div class="carousel-item active">
							  					<img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100">
							  				</div>
							  			</c:when>
							  			<c:otherwise>
							  				<div class="carousel-item">
							  					<img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100">
							  				</div>
							  			</c:otherwise>
							  		</c:choose>
							  			<%-- <img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100"> --%>	
							  	</c:forEach>
							  </c:if>	
							  <c:if test="${empty community.postImage}">
							  	<div class="carousel-item active">
							  		<img src="/resources/images/uploadImages/default.jpg" height="600" class="d-block w-100">
							  	</div>
							  </c:if>	
						  </div>
						  <button class="carousel-control-prev btn-outline-link" type="button" id="car_prev" data-target="#carouselExampleFade" data-slide="prev"
						  style="border: none; outline: none; box-shadow: none; height: 600px; background-color:transparent;">
						    <span class="carousel-control-prev-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
						    <span class="sr-only">Previous</span>
						  </button>
						  <button class="carousel-control-next btn-outline-link" type="button" id="car_next" data-target="#carouselExampleFade" data-slide="next"
						  style="border: none; outline: none; box-shadow: none; height: 600px; background-color:transparent;">
						    <span class="carousel-control-next-icon" aria-hidden="true" style="width: 50px; height: 50px;"></span>
						    <span class="sr-only">Next</span>
						  </button>
						</div><br><br>
						
						<div class="row">
					  		<div class="col-xs-4 col-md-2"><strong>
					  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-text" viewBox="0 0 16 16">
							  <path d="M5 4a.5.5 0 0 0 0 1h6a.5.5 0 0 0 0-1H5zm-.5 2.5A.5.5 0 0 1 5 6h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5zM5 8a.5.5 0 0 0 0 1h6a.5.5 0 0 0 0-1H5zm0 2a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1H5z"/>
							  <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2zm10-1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1z"/>
							</svg> 게시물 설명</strong></div>
							<div class="col-xs-8 col-md-9">${community.postText}</div>
						</div><br><hr/>
					    
					    <div class="row">
					  		<div class="col-xs-4 col-md-2"><strong>
					  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-credit-card-2-front" viewBox="0 0 16 16">
							  <path d="M14 3a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h12zM2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2z"/>
							  <path d="M2 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z"/>
							</svg> 음식점명</strong></div>
							<div class="col-xs-8 col-md-4">${community.restaurantName}</div>
						</div><br>
						
						<div class="row">
					  		<div class="col-xs-4 col-md-2"><strong>
					  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16">
	  						<path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
							</svg> 음식점 전화번호</strong></div>
							<div class="col-xs-8 col-md-4">${community.restaurantTel}</div>
						</div><br>
						
						<div class="row col-xs-4">
			  				<div class="col-md-2">
			  					<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt" viewBox="0 0 16 16">
	  							<path d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94zM8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10z"/>
	 							<path d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
								</svg> 위치</strong></div>
							<div class="col-md-3"><span class="badge badge-secondary">도로명주소</span> ${community.streetAddress}</div>
							<div class="col-md-3"><span class="badge badge-secondary">지번주소</span> ${community.areaAddress}</div>
							<c:if test="${empty community.restAddress}">
								
							</c:if>
							<c:if test="${!empty community.restAddress}">
								<div class="col-md-3"><span class="badge badge-secondary">상세주소</span> ${community.restAddress}</div>
							</c:if>
						</div><br>
						
						<div class="row">
							<div class="col-xs-4 col-md-2"><strong>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-funnel" viewBox="0 0 16 16">
	  						<path d="M1.5 1.5A.5.5 0 0 1 2 1h12a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.128.334L10 8.692V13.5a.5.5 0 0 1-.342.474l-3 1A.5.5 0 0 1 6 14.5V8.692L1.628 3.834A.5.5 0 0 1 1.5 3.5v-2zm1 .5v1.308l4.372 4.858A.5.5 0 0 1 7 8.5v5.306l2-.666V8.5a.5.5 0 0 1 .128-.334L13.5 3.308V2h-11z"/>
							</svg> 음식 종류</strong></div>
							<div class="col-xs-8 col-md-4">${community.returnMenuType}</div>
						</div><br>
						
						<div class="row">
							<div class="col-xs-4 col-md-2"><strong>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
							  <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
							</svg> 이 곳의 대표메뉴</strong></div>
							<div class="col-xs-8 col-md-4">${community.mainMenuTitle} &nbsp; ${community.mainMenuPrice}원</div>
						</div><hr>
						
						<%-- <div class="row">
					  		<div class="col-xs-4 col-md-2"><strong>음식점 메인메뉴 가격</strong></div>
							<div class="col-xs-8 col-md-4">${community.mainMenuPrice}</div>
						</div><hr> --%>
						
						<div class="text-center">
						<c:if test="${member.memberRole == 'admin'}">
							<button type="button" class="btn btn-success btn-sm" id="promoteButton">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shift-fill" viewBox="0 0 16 16">
							<path d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
							</svg> 정식맛집</button>
						</c:if>
						<c:if test="${member.memberRole == 'admin' || community.member.memberId == member.memberId}">
							<button type="button" class="btn btn-link btn-sm" id="deleteButton">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
	  						<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
	  						<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
							</svg> 삭제하기</button>
							<button type="button" class="btn btn-primary btn-sm" id="modifyButton">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bug" viewBox="0 0 16 16">
	  						<path d="M4.355.522a.5.5 0 0 1 .623.333l.291.956A4.979 4.979 0 0 1 8 1c1.007 0 1.946.298 2.731.811l.29-.956a.5.5 0 1 1 .957.29l-.41 1.352A4.985 4.985 0 0 1 13 6h.5a.5.5 0 0 0 .5-.5V5a.5.5 0 0 1 1 0v.5A1.5 1.5 0 0 1 13.5 7H13v1h1.5a.5.5 0 0 1 0 1H13v1h.5a1.5 1.5 0 0 1 1.5 1.5v.5a.5.5 0 1 1-1 0v-.5a.5.5 0 0 0-.5-.5H13a5 5 0 0 1-10 0h-.5a.5.5 0 0 0-.5.5v.5a.5.5 0 1 1-1 0v-.5A1.5 1.5 0 0 1 2.5 10H3V9H1.5a.5.5 0 0 1 0-1H3V7h-.5A1.5 1.5 0 0 1 1 5.5V5a.5.5 0 0 1 1 0v.5a.5.5 0 0 0 .5.5H3c0-1.364.547-2.601 1.432-3.503l-.41-1.352a.5.5 0 0 1 .333-.623zM4 7v4a4 4 0 0 0 3.5 3.97V7H4zm4.5 0v7.97A4 4 0 0 0 12 11V7H8.5zM12 6a3.989 3.989 0 0 0-1.334-2.982A3.983 3.983 0 0 0 8 2a3.983 3.983 0 0 0-2.667 1.018A3.989 3.989 0 0 0 4 6h8z"/>
							</svg> 수정하기</button>
						</c:if>
							<button type="button" class="btn btn-warning btn-sm" id="goToBack">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
	  						<path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
	  						<path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
							</svg> 목록으로</button>
						</div>
						
					</div>
				
				</form>
	
				</section>
			</div>
		</div>
		<!-- E:Main -->
		
		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
		
		<!-- Report -->
		<ul class='icons'>
			<jsp:include page='/report/addReportView.jsp'/>
		</ul>
		
		<!-- User Profile -->
		<jsp:include page='/member/modal-archive.jsp'/>
		
	</div>
	<!-- E:Wrapper -->
</body>
</html>
