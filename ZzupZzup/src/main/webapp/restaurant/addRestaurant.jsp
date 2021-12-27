<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">등록 요청한 음식점 정보 내역입니다.</h3>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.restaurantName}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 도로명주소</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.streetAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 지번주소</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.areaAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식점 상세주소</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.restAddress}</div>
		</div><hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
			<div class="col-xs-8 col-md-4">${restaurant.menuType}</div>
		</div><hr/>
		
	</div>
	
<jsp:include page="/layout/sidebar.jsp" />
    