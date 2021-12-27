<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">나만의 작고 소중한 맛집 게시판의 게시물입니다.</h3>
	    </div>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
			<div class="col-xs-8 col-md-4">${community.postTitle}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
			<div class="col-xs-8 col-md-4">${community.postText}</div>
		</div><hr/>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
			<div class="col-xs-8 col-md-4">${community.restaurantName}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${community.restaurantTel}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 도로명주소</strong></div>
			<div class="col-xs-8 col-md-4">${community.streetAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 지번주소</strong></div>
			<div class="col-xs-8 col-md-4">${community.areaAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 상세주소</strong></div>
			<div class="col-xs-8 col-md-4">${community.restAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
			<div class="col-xs-8 col-md-4">${community.menuType}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 메인메뉴 이름</strong></div>
			<div class="col-xs-8 col-md-4">${community.mainMenuTitle}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 메인메뉴 가격</strong></div>
			<div class="col-xs-8 col-md-4">${community.mainMenuPrice}</div>
		</div><hr/>
		
	</div>
	
<jsp:include page="/layout/sidebar.jsp" />
    