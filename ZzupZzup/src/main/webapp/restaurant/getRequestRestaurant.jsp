<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>심사하기 | ${restaurant.restaurantName}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	window.onload = function() {
		$(function() {
			
			// '이전으로' 버튼
			$("#backoff").on("click", function() {
				history.go(-1);
			});
			
			// '심사하기' 버튼
			$("#judgement").on("click", function() {
				$("#execution").dialog({
					resizable: false,
				    height: "auto",
				    width: 400,
				    modal: true,
				    buttons: {
				    	"거절" : function() {
				    		alert("해당 요청이 거절되었습니다.");
				    		//self.location = "/restaurant/judgeRestaurant/3";
				    		$("input[name='judgeStatus']").val("3");
				    		$("#restaurant").attr("method", "POST").attr("action", "/restaurant/judgeRestaurant").submit();
				    	},
				    	
				    	"승인" : function() {
				    		alert("해당 요청이 승인되었습니다.");
				    		//self.location = "/restaurant/judgeRestaurant/2";
				    		$("input[name='judgeStatus']").val("2");
				    		$("#restaurant").attr("method", "POST").attr("action", "/restaurant/judgeRestaurant").submit();
				    	}
				    }
				});
			});
		});
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
						
						<form id="restaurant">
						
							<div class="page-header">
						       <h2 class=" text-danger">심사 대기중인 음식점 정보입니다.</h2>
						    </div><hr>
						    
						    <input type="hidden" name="restaurantNo" value="${restaurant.restaurantNo}" />
						    <input type="hidden" name="judgeStatus" value="${restaurant.judgeStatus}" />
						    
						    <div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.restaurantName}</div>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점 주소</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.streetAddress}</div><br>
								<div class="col-xs-8 col-md-4">${restaurant.areaAddress}</div><br>
								<div class="col-xs-8 col-md-4">${restaurant.restAddress}</div><br>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.returnMenuType}</div>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점 메뉴</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.restaurantMenus}</div>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점 운영시간</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.restaurantTimes}</div>
							</div><br>
							
							<div class="row">
						  		<div class="col-xs-4 col-md-2"><strong>음식점 사진</strong></div>
								<div class="col-xs-8 col-md-4">${restaurant.restaurantImage}</div>
							</div><hr>
						
						</form><br>
						
						<div class="text-center">
							<button type="button" class="btn btn-outline-warning btn-sm" id="backoff">
				            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply-all" viewBox="0 0 16 16">
				  			<path d="M8.098 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L8.8 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L4.114 8.254a.502.502 0 0 0-.042-.028.147.147 0 0 1 0-.252.497.497 0 0 0 .042-.028l3.984-2.933zM9.3 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
				  			<path d="M5.232 4.293a.5.5 0 0 0-.7-.106L.54 7.127a1.147 1.147 0 0 0 0 1.946l3.994 2.94a.5.5 0 1 0 .593-.805L1.114 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.5.5 0 0 0 .042-.028l4.012-2.954a.5.5 0 0 0 .106-.699z"/>
							</svg> 이전으로</button> &nbsp;
							
							<button type="button" class="btn btn-outline-danger btn-sm" id="judgement">
	                		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
	  						<path d="M1 0 0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.356 3.356a1 1 0 0 0 1.414 0l1.586-1.586a1 1 0 0 0 0-1.414l-3.356-3.356a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0zm9.646 10.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708zM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11z"/>
							</svg> 심사하기</button>
						</div><br>
						
						<div id="execution" title="음식점 심사하기" style="display:none;">
							<p><!-- <span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span> -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-triangle-fill" viewBox="0 0 16 16">
  							<path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
							</svg><strong>&nbsp; 해당 음식점을 심사해주세요.</strong></p>
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