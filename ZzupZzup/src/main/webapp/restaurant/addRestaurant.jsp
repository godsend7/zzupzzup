<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>음식점 등록 정보 확인</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

  .img{
    width: auto;
    border-radius: 10px;
    cursor: pointer;
    transition: 0.3s;
  }
  /* 이미지 클릭 시, 밝기 조절 */
  .img:hover {opacity: 0.8;}

  .modal {
    display: none; /* 모달창 숨겨 놓기 */
    position: fixed; 
    z-index: 1; /* 모달창을 제일 앞에 두기 */
    padding-top: 100px;
    left: 0; top: 0;
    width: 100%; height: 100%;
    overflow: auto; /* 스크롤 허용 auto */
    cursor: pointer; /* 마우스 손가락모양 */
    background-color: rgba(0, 0, 0, 0.8);
  }
  /* 모달창 이미지 */
  .modal_content {
    margin: auto;
    display: block;
    width: 50%; height: auto;
    max-width: 1000px;
    border-radius: 10px;
    animation-name: zoom;
    animation-duration: 0.8s;
  }
  /* 모달창 애니메이션 추가 */
  @keyframes zoom {
    from {transform: scale(0)}
    to {transform: scale(1)}
  }
  /* 닫기 버튼 꾸미기 */
  .imgClose {
    position: absolute;
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
  }
  .imgClose:hover, .imgClose:focus{
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
  }

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	/* window.onload = function() { */
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#button" ).on("click" , function() {
				self.location = "../main.jsp";
			});
		
		});
		
		// MODAL IMAGE
		$(function() {
			
			const modal = document.querySelector(".modal");
			//const img = document.querySelector(".img");
			const modal_img = document.querySelector(".modal_content");
			const span = document.querySelector(".imgClose");
			
			const $img = $(".img");
			$img.on("click" , function(){
				let img_src = $(this).attr("src");
				modalDisplay("block");
				  modal_img.src = img_src;
			});

			/* img.addEventListener('click', ()=>{
				console.log('img');
			  modalDisplay("block");
			  modal_img.src = img.src;
			}); */
			span.addEventListener('click', ()=>{
			  modalDisplay("none");
			});
			modal.addEventListener('click', ()=>{
			  modalDisplay("none");
			});
			
			function modalDisplay(text){
			  modal.style.display = text;
			}
			
		});
		
//	}
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
		
			<form action="">
			
				<div class="page-header">
			       <h3 class=" text-info">등록 요청한 음식점 정보 내역입니다.</h3>
			    </div><hr>
			    
			    <div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantName} &nbsp;
						<c:if test="${restaurant.parkable}">
							<span class="badge badge-light">주차가능</span>
						</c:if>
					</div>
				</div><br>
				
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>대표자명</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.member.memberName}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
				</div><br>
				
				<div class="row">
					<div class="col-md-2"><strong>음식점 주소</strong></div>
					<div class="col-md-3"><span class="badge badge-secondary">도로명주소</span> ${restaurant.streetAddress}</div>
					<div class="col-md-3"><span class="badge badge-secondary">지번주소</span> ${restaurant.areaAddress}</div>
					<c:if test="${!empty restaurant.restAddress}">
						<div class="col-md-4"><span class="badge badge-secondary">상세주소</span> ${restaurant.restAddress}</div>
					</c:if>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.returnMenuType}</div>
				</div><br>
				
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>음식점 메뉴</strong></div>
					<div class="col-xs-8 col-md-4">
					<c:set var="i" value="0"/>
					<c:forEach var="menus" items="${restaurant.restaurantMenus}">
						<div>
						${menus.menuTitle} &nbsp; ${menus.menuPrice}원 &nbsp;
						<c:if test="${menus.mainMenuStatus}">
							<span class="badge badge-success">메인메뉴</span>
						</c:if>
						</div>
					</c:forEach>
					</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 운영시간</strong></div>
					<div class="col-xs-2 col-md-10">
					
						<!-- ************* 월요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'true'}">
								월요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'false'}">
								월요일 | ${restaurant.restaurantTimes[0].restaurantOpen} ~ ${restaurant.restaurantTimes[0].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[0].restaurantBreak}">
											
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[0].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[0].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[0].restaurantLastOrder}">
											
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[0].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[0].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 화요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'true'}">
								화요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'false'}">
								화요일 | ${restaurant.restaurantTimes[1].restaurantOpen} ~ ${restaurant.restaurantTimes[1].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[1].restaurantBreak}">
											
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[1].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[1].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[1].restaurantLastOrder}">
											
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[1].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[1].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 수요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'true'}">
								수요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'false'}">
								수요일 | ${restaurant.restaurantTimes[2].restaurantOpen} ~ ${restaurant.restaurantTimes[2].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[2].restaurantBreak}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[2].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[2].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[2].restaurantLastOrder}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[2].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[2].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 목요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'true'}">
								목요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'false'}">
								목요일 | ${restaurant.restaurantTimes[3].restaurantOpen} ~ ${restaurant.restaurantTimes[3].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[3].restaurantBreak}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[3].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[3].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[3].restaurantLastOrder}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[3].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[3].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 금요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'true'}">
								금요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'false'}">
								금요일 | ${restaurant.restaurantTimes[4].restaurantOpen} ~ ${restaurant.restaurantTimes[4].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[4].restaurantBreak}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[4].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[4].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[4].restaurantLastOrder}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[4].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[4].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 토요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'true'}">
								토요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'false'}">
								토요일 | ${restaurant.restaurantTimes[5].restaurantOpen} ~ ${restaurant.restaurantTimes[5].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[5].restaurantBreak}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[5].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[5].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[5].restaurantLastOrder}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[5].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[5].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
								
						<!-- ************* 일요일 ************* -->
						<div class="col" style="padding-left: 0px;">
							<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'true'}">
								일요일 휴무
							</c:if>
							<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'false'}">
								일요일 | ${restaurant.restaurantTimes[6].restaurantOpen} ~ ${restaurant.restaurantTimes[6].restaurantClose}
								<c:if test="${empty restaurant.restaurantTimes[6].restaurantBreak}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[6].restaurantBreak}">
									, break at ${restaurant.restaurantTimes[6].restaurantBreak}
								</c:if>
								<c:if test="${empty restaurant.restaurantTimes[6].restaurantLastOrder}">
									
								</c:if>
								<c:if test="${!empty restaurant.restaurantTimes[6].restaurantLastOrder}">
									, LastOrder Time is ${restaurant.restaurantTimes[6].restaurantLastOrder}
								</c:if>
							</c:if>
						</div>
					
					</div>
				</div><br><br>
				
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>사업자 등록증</strong></div>
					<div class="col-xs-8 col-md-4">
						<%-- <img class="img" src="/resources/images/uploadImages/owner/${restaurant.ownerImage}" width="100px" height="150px" 
						style="border: 1px solid pink; border-radius: 0.5em;" /> --%>
						<img class="img" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/restaurant/${restaurant.ownerImage}" width="100px" height="150px" 
						style="border: 1px solid pink; border-radius: 0.5em;" />
						<div class="modal">
						  <span class="imgClose">&times;</span>
						  <img class="modal_content" id="originalImg">
						</div>
					</div>
				</div><br><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 사진</strong></div>
					<div class="col-xs-8 col-md-10 row" style="border: 1px solid pink; border-radius: 0.5em; padding-left: 0;">
						<c:set var="i" value="0" />
						<c:forEach var="imgs" items="${restaurant.restaurantImage}">
							<div style="padding-top: 20px; padding-bottom: 20px; height: 140px;">
								<%-- <img class="img" id="img" src="/resources/images/uploadImages/${imgs}" width="100px" height="100px" style="padding-left: 0;"/> --%>
								<img class="img" id="img" src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/restaurant/${imgs}" width="100px" height="100px" style="padding-left: 0;"/>
							</div><br>
						</c:forEach>
						<div class="modal">
						  <span class="imgClose">&times;</span>
						  <img class="modal_content" id="originalImg">
						</div>
					</div>
				</div>
				
				<%-- <div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 사진</strong></div>
					<div class="col-xs-8 col-md-4">
						<c:set var="i" value="0" />
						<c:forEach var="imgs" items="${restaurant.restaurantImage}">
							<img alt="/resources/images/uploadImages/${imgs}" src="음식점이미지">
						</c:forEach>
					</div>
				</div> --%>
				
			</form><hr>
			
			<div class="text-center">
				<button type="button" class="btn btn-outline-danger btn-sm" id="button">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
  				<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
				</svg> 메인으로</button>
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
    