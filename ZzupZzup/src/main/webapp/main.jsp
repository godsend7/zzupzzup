<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP</title>

<jsp:include page="/layout/toolbar.jsp" />

<!-- naver Map OpenAPI -->
<script defer type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7gzdb36t5o"></script>
<link href="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/css/bootstrap4-toggle.min.css" rel="stylesheet">  
<script src="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/js/bootstrap4-toggle.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	.restaurantCheck {
		display: none;
	}
	
	.filterBox {
		z-index: 99;
		position: fixed;
		cursor: grab;
		width: 20%;
		height: 17%;
		right: 20px;
		top: 250px;
		padding: 1.0em;
	}
	
	.filterBox:active {
		cursor: grabbing;
	}
	
	.filterBox p {
		font-size: 1.0em;
	}
	
	.thisLocation {
		z-index: 99;
		position: absolute;
		top: 90%; left: 50%;
		width:220px; height: 35px;
		margin-left: -110px;
		text-align: center;
	}
	
	.thisLocation:hover span {
		background-color: #d16767;
		cursor: pointer;
	}
	
	.thisLocation span {
		font-size: 1.0em;
		border-radius: 20em;
		line-height: 33px;
		padding-left: 13px;
		padding-right: 13px;
	}
	
/* 	.btn-outline-primary {
		color: #f56a6a;
		border-color: #f56a6a;
	}
	
	.btn-outline-primary:hover{
		color: #f56a6a;
		border-color: #f56a6a;
		background-color: f56a6a;
	}
	
	.toggle.btn-outline-primary .toggle-handle {
		background-color: #f56a6a;
		border-color: #f56a6a;
	}
	
	.toggle.btn-outline-primary .toggle-handle:hover{
		color: #f56a6a;
		border-color: #f56a6a;
		background-color: f56a6a;
	}
	
	.toggle-on:hover{
		background-color: #ffffff;
	}
	
	.toggle-on:mouseup{
		background-color: #ffffff;
	} */
	
	/* input[type=checkbox]{
		height: 0;
		width: 0;
		visibility: hidden;
	}
	
	label {
		cursor: pointer;
		text-indent: -9999px;
		width: 200px;
		height: 100px;
		background: grey;
		display: block;
		border-radius: 100px;
		position: relative;
	}
	
	label:before {
		display: none;
		visibility: hidden;
	}
	
	label:after {
		content: '';
		position: absolute;
		top: 5px;
		left: 5px;
		width: 90px;
		height: 90px;
		background: #fff;
		border-radius: 90px;
		transition: 0.3s;
	}
	
	input:checked + label {
		background: #bada55;
	}
	
	input:checked + label:after {
		left: calc(100% - 5px);
		transform: translateX(-100%);
	}
	
	label:active:after {
		width: 130px;
	} */
	.toggle-off {
		left:48%;
	}
	
	/* 필터 적용 버튼 css */
	.filter-group {
		z-index: 99;
		position: absolute;
		right: 20px;
		bottom: 40px; 
		text-align: right;
		width: 200px;
	}
	
	.filter-group .filter-button {
		background-color: #ffc824;
		border-color: #000000;
		border-radius: 15em;
		width: 60px;
		height: 60px;
		text-align: center;
		display: inline-block;
	}
	
	.filter-group .filter-button .none {
		display: none;
	}
	
	.filter-group .filter-button i {
		font-size: 35px;
		margin-top: 12px;
	}
	
	.filter-group .speech-bubble {
	/*   border: 1px solid gray; */
	  border-radius: 10px;
	  width: auto;
	  height: auto;
	  display: flex;
	  flex-direction: column;
	  position: relative;
	  justify-content: center;
	  align-items: flex-start;
	  overflow-wrap: break-word;
	  box-shadow: 0px 9px 76px -10px rgba(0,0,0,0.51);
	  margin-bottom: 25px;
	  padding: 15px;
	}
	
	.filter-group .speech-bubble p {
	  z-index: 10;
	  text-align: left;
	}
	
	.filter-group .speech-bubble::before {
	 /*  background-color: #fff;
	  display: block;
	  position: absolute;
	  bottom: -6px;
	  //left: 50px; 
	  width: 20px;
	  height: 20px;
	  content: '';
	  //border-right: 1px solid gray; 
	  //border-bottom: 1px solid gray; 
	  transform: rotate(28deg) skewY(35deg);*/
	  
	  	content: '';
		position: absolute;
		bottom: 0;
		left: 65%;
		width: 0;
		height: 0;
		border: 20px solid transparent;
		border-top-color: #ffffff;
		border-bottom: 0;
		border-right: 0;
		margin-left: -10px;
		margin-bottom: -20px;
	}

	.filter-group .speech-bubble::after {
	  background-color: #fff;
	  display: block;
	  position: absolute;
	  bottom: 0;
	  left: 0;
	  top: 0;
	  right: 0;
	  margin: auto;
	  border-radius: inherit;
	  width: inherit;
	  height: inherit;
	  content: '';
	  z-index: 1;
	}
	
	.filter-group .speech-bubble.none{
		display: none;
	}
	
	/* .filter-group .speech-path {
		overflow: auto;
		width: 300px;
		height: 400px;
		background-color: white;
		text-align: left;
		padding: 15px;
		margin-bottom: 25px;
		right: 100px;
		position: relative;
	}
	
	.filter-group .speech-path  p {
		font-size: 0.9em;
	} */
	
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">	
	var arrayLayout = new Array();
	
	//default 지도 위치
	var nowLatitude = "37.5703942";
	var nowLongitude = "126.9832113";
	
	//지도 정보를 담을 객체 선언
	let markers = new Array();
	let infowindows = new Array();
	
	//화면에 보여줄 map 객체 선언
	var map;
	//화면에 보여줄 지도의 기본 크기 설정
	var mapZoom = 15; 
	
	//화면 위치(s,n,w,e) 넣을 객체 선언 
	//=> 지도를 움직일 때 이동한 위치 근처만 마커 표시 
	var bounds;
	
	//map search condition
	var reCheck = false;
	var parkCheck = false;
	var dirCheck = false;
	
	//길찾기 시 화면에 경로 표시
	var polylinePath = new Array();
	var pathInfo = new Array();
	//길찾기 시작 정보
	var startLocation = new Array();
	//길찾기 도착 정보
	var goalLocation = new Array();
	
	
	//filter icon 변경 envet
	function iconChange() {
		$(".filter-button").children("i").removeClass("none");
		$(".filter-button").children("i").addClass("none");
		
		if (dirCheck) {
			$(".fa-map-marked-alt").removeClass("none");
		} else if (reCheck && parkCheck) {
			$(".fa-tasks").removeClass("none");
		} else if (reCheck) {
			$(".fa-calendar-check").removeClass("none");
		} else if (parkCheck) {
			$(".fa-car").removeClass("none");
		} else if (!(reCheck && parkCheck)) {
			$(".fa-list").removeClass("none");
		}
	}
	
	
	$(function() {
		
		loadRestaurantMap();
		loadGyeonggidoMap();
		
		//$( ".filterBox" ).draggable();
		
		/////////////// switch toggle check 여부 start ///////////////
		$(".reservationCheck").on("change",function() {
			$("#searchKeyword").val('');
			if($(this).prop("checked") == true){
				reCheck = true;
				
				loadRestaurantMap();
			} else {
				reCheck = false;
				
				loadRestaurantMap();
				loadGyeonggidoMap();
			}
			iconChange();
		});
		
		$(".parkableCheck").on("change",function() {
			$("#searchKeyword").val('');
			if($(this).prop("checked") == true){
				parkCheck = true;
				loadRestaurantMap();
			} else {
				parkCheck = false;
				loadRestaurantMap();
				loadGyeonggidoMap();
			}
			iconChange();
		});
		
		$(".directionCheck").on("change",function() {
			$("#searchKeyword").val('');
			if($(this).prop("checked") == true){
				
				$('#directionModal').modal({
				    backdrop: 'static',
				    keyboard: false,
				    show: true
				});
			}
			iconChange();
		});
		/////////////// switch toggle check 여부 end ///////////////
		
		//검색 시 enter event
		document.getElementById("mapSearch").addEventListener("keydown", function(evant) {
			//console.log("keydown");
			if (evant.keyCode === 13) {
				evant.preventDefault();
				document.getElementById("searchButton").click();
			}
		});
		
		//현재 위치로 이동 event
		$(".thisLocation").on("click", function() {
			thisLocation();
			map.setCenter(new naver.maps.LatLng(nowLatitude, nowLongitude));
			map.setZoom(15);
		});
		
		//길찾기 modal 검색 event
		$("#searchDirec").on("click", function() {
			loadDirections();
		});
		
		//filter function start
		$(".filter-button").on("click", function() {
			if ($(".fa-map-marked-alt").hasClass("none") === true) {
				if($(".speech-bubble").hasClass("none") === true) { 
					// class가 존재함 
					$(".speech-bubble").removeClass("none");
				} else { 
					// class가 존재하지않음 
					$(".speech-bubble").addClass("none");
				}
			} else {
				if (confirm("길찾기를 종료하시겠습니까?")) {
					location.reload();
				}
			}
		});
		
		//길찾기 종료
		$("#none-direction").on("click", function() {
			location.reload();
		});
		
		//////////////////////// modal show or hide event start //////////////////////////
		//길찾기 modal 실행될 때 현재위치 가져오기
		$("#directionModal").on("shown.bs.modal", function() { 
			$(".direction-control").autocomplete("option", "appendTo", "#directionModal");
			
			$.ajax ({
				url:"/map/json/thisReverseGeoCoding",
    	  		method : "POST",
				dataType : "json",
				contentType: 'application/json',
				data : JSON.stringify ({
					thisLat : nowLatitude,
					thisLong : nowLongitude 
				}),
				success : function(data, status) {
					
					console.log(data.status.code);
					if (data.status.code == 0) {
						console.log(data.results[0].region);
						
						//$("#startInput").val(data);
					}
				}
			});
		});
		
		//길찾기 modal 종료 시 switch toggle off
		$("#directionModal").on("hide.bs.modal", function() { 
			console.log("modal 닫힘");
			$(".directionCheck").prop("checked", false);
			$(".directionCheck").parent("div").attr("class", "toggle btn btn-xs btn-light off");
		});
		
		////////////////////////modal show or hide event end //////////////////////////
		
		
		//restaurant Direction autoComplete
		$("#startInput, #goalInput").autocomplete({
			source: function(request, response) {
		 		$.ajax({
		 			url:"/map/json/listRestaurantName",
	    	  		method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : {
						"keyWord" : request.term
					},
					success : function(data, status) {
						
						console.log(data);
						
						//label : 화면에 보여지는 텍스트 
						//value : 실제 text태그에 들어갈 값
						response(
							$.map(data, function(item) {
                                return {
                                	value: item.restaurantName + " (" +item.streetAddress + ")",
                                    label: item.restaurantName + " (" +item.streetAddress + ")",
                                    id : item
                                }
                            })
						);//response 
					}
	      		});
	 		},
	 		select : function(event, ui) {
	 			var thisInput = $(this).attr("id");
	 			
	 			if (thisInput == "startInput") {
					startLocation = ui.item.id;
					//console.log(startLocation.restaurantName);
				} else if (thisInput == "goalInput"){
					goalLocation = ui.item.id;
					//console.log(goalLocation);
				}
	 			
	 			console.log(ui.item.id);
	 			
				//return false;
	 		} ,
	 		focus : function (event, ui) {
	 			
	 			return false;
	 			//event.preventDefault();
	 		}
		});
	});
	
	//길찾기 ajax
	function loadDirections() {
		$.ajax({
			url : "/map/json/getDirections",
			type : "POST",
			dataType : "json",
			contentType: 'application/json',
			data : JSON.stringify ({
				startLat: startLocation.latitude,
				startLong: startLocation.longitude,
				goalLat: goalLocation.latitude,
				goalLong: goalLocation.longitude
			}), 
			success : function(data, status) {
				//alert(JSON.stringify(data.route.bbox));
				//console.log(JSON.stringify(data.route.trafast[0].path));
				
				/* pathInfo.push(
					{ instructions:"유턴", distance:258, duration:41461}
				);
				
				pathInfo.push(
					{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
				);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				pathInfo.push(
						{ instructions:"황산교차로에서 '서울' 방면으로 좌회전", distance:656, duration:108054}
					);
				getDirec(); */
				if (data.code == 0) {
					$.each (data.route.trafast[0].path, function(index, item){ 
						polylinePath.push(new naver.maps.LatLng(item[1], item[0]));
					});
					
					//instructions :: 경로 설명
					//distance :: 해당 경로까지의 거리 meters (전 경로에서부터의)
					//duration :: 해당 경로까지 걸리는 시간 milisecond(1/1000초) (전 경로에서부터의)
					$.each (data.route.trafast[0].guide, function(index, item){
						pathInfo.push(
							{ instructions:item.instructions, distance:item.distance, duration:item.duration }
						);
					});
					
					getDirec();
				} else if (data.code == 1) {
					alert("출발지와 도착지가 동일합니다.");
				} else if (data.code == 2) {
					alert("출발지 또는 도착지가 도로 주변이 아닙니다.");
				} else if (data.code == 3) {
					alert("자동차 길찾기 안내를 제공하지 않는 경로입니다.");
				} else if (data.code == 5) {
					alert("요청하신 길찾기의 거리가 너무 깁니다!");
				}				
			},
			error : function(request, status, error) {
				alert(request);
				alert(error);
			}
		});
	}
	
	//길찾기 실행
	function getDirec() {
		
		//modal 종료
		$("#directionModal").modal("hide");
		
		//button 변경
		$("#direction").addClass("direc-hide");
		$("#none-direction").removeClass("direc-hide");
		
		map = new naver.maps.Map('content', {
			zoom: 13,
		    center: new naver.maps.LatLng(startLocation.latitude, startLocation.longitude)
		});
		
		var polyline = new naver.maps.Polyline({
			path: polylinePath,
	        strokeColor: '#d16767',
	        strokeOpacity: 0.8,
	        strokeWeight: 6,
	        zIndex: 88,
	        clickable: true,
	        map: map
		});
		
		var startMarker = new naver.maps.Marker({
		    position: polylinePath[0], //마크 표시할 위치 배열의 시작 위치
		    map: map
		});
		
		var goalMarker = new naver.maps.Marker({
		    position: polylinePath[polylinePath.length-1], //마크 표시할 위치 배열의 마지막 위치
		    map: map
		});
		
		//클릭 했을 때 띄어줄 정보 HTML
		var startInfowindow = new naver.maps.InfoWindow({
		    content: '<div style="padding:10px; width:280px;"><b>출발지<br>'+startLocation.restaurantName +'<br>'+startLocation.streetAddress,
		    maxWidth: 300,
		    borderColor: "#f56a6a",
		    borderWidth: 5
		});
		
		var goalInfowindow = new naver.maps.InfoWindow({
		    content: '<div style="padding:10px; width:280px;"><b>목적지<br>'+goalLocation.restaurantName +'<br>'+goalLocation.streetAddress,
		    maxWidth: 300,
		    borderColor: "#f56a6a",
		    borderWidth: 5
		});
		
		//정보창 출력
		startInfowindow.open(map, startMarker);
		goalInfowindow.open(map, goalMarker);
		
		dirCheck = true;
		iconChange();
		
		//경로 안내 출력
		getPathInfo();
	}
	
	//길찾기 경로 안내 출력
	function getPathInfo() {
		
		$(".speech-bubble").addClass('none');
		console.log(pathInfo);
		
		for (var i = 0; i < pathInfo.length; i++) {
			const hour = String(Math.floor((pathInfo[i].duration/ (1000 * 60 *60 )) % 24 )).padStart(2, "0"); // 시
	        const minutes = String(Math.floor((pathInfo[i].duration  / (1000 * 60 )) % 60 )).padStart(2, "0"); // 분
	        const second = String(Math.floor((pathInfo[i].duration / 1000 ) % 60)).padStart(2, "0"); // 초
			
			var pInfo = "<p>" + pathInfo[i].distance + "m 앞, " + pathInfo[i].instructions + "<br>(약 ";
			
			if (hour != "00") {
				pInfo += hour +"시간 ";
			}
			if (minutes != "00") {
				pInfo += minutes +"분 ";
			}
			pInfo += second + "초 소요) </p>";
			
			$(".speech-path").append(pInfo);
		}
		$(".speech-path").css({
			overflow:"auto",
			width:"250px",
			height:"400px",
			backgroundColor:"white",
			textAlign: "left",
			padding: "15px",
			marginBottom: "25px",
			right: "100px",
			position: "relative"
		});
		
		$(".speech-path").children("p").css({
		    fontSize: "0.9em"
		});
	}
	
	//경기도 맛집 api 화면에 표시
	function loadGyeonggidoMap() {
		$.ajax({
					url : "/map/json/gyeonggidoRestAPI",
	   				type : "POST",
	   				dataType : "json",
	   				contentType: 'application/json',
	   				data : JSON.stringify({
	   					searchCondition : $("#searchCondition").val(),
	   					searchKeyword : $("#searchKeyword").val()
	   				}),
	   				success : function(data, status) {
	   					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
	   					//console.log(JSON.stringify(data));
	   					//alert(status);
						//alert("data : \n"+data);
						
	   					//var obj = JSON.parse(data);
	   					//console.log(data.PlaceThatDoATasteyFoodSt[1].row);
	   					//console.log(JSON.parse(data));
	   					$.each(data, function(index, item){ 
	   						//console.log(item.RESTRT_NM);
	   						arrayLayout.push(
	   							{restaurantName:item.RESTRT_NM, mainMenu:item.REPRSNT_FOOD_NM, latitude:item.REFINE_WGS84_LAT, longitude:item.REFINE_WGS84_LOGT,
	   							 streetADDR:item.REFINE_ROADNM_ADDR, areaADDR:item.REFINE_LOTNO_ADDR, restaurantTel:item.TASTFDPLC_TELNO}
	   							/* item */
	   						)
	   					});
   					
   					initMap();
					
   				},
   				error:function(request,status,error){
					console.log("실패");
					console.log(request);
					console.log(error);
				}
		});
	}
	
	//DB에 등록된 음식점 화면에 표시
	function loadRestaurantMap() {
		$.ajax(
			{
				url : "/map/json/listRestaurant",
				type : "POST",
   				dataType : "json",
   				contentType: 'application/json',
   				data : JSON.stringify({
   					searchCondition : $("#searchCondition").val(),
   					searchKeyword : $("#searchKeyword").val()
   				}),
   				success : function(data, status) {
   					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
   					//console.log(JSON.stringify(data));
   					//alert(status);
					//alert("data : \n"+data);
					
   					//var obj = JSON.parse(data);
   					
   					$.each(data, function(index, item){ 
   						//console.log(item.location);
   						arrayLayout.push(
							{restaurantNo:item.restaurantNo, restaurantName:item.restaurantName, menuType:item.returnMenuType, mainMenu:item.restaurantMenus.menuTitle, 
							 latitude:item.latitude, longitude:item.longitude, streetADDR:item.streetAddress, areaADDR:item.areaAddress, restaurantTel:item.restaurantTel, 
							 parkable:item.parkable, reservationStatus:item.reservationStatus}
   						); 
   					});
   					
   					initMap();
					
   				},
   				error:function(request,status,error){
				       console.log("실패");
				    }
			}
		)
	}
	
	//음식점명 or 음식점 주소 검색
	function searchMap() {
		arrayLayout = new Array();
		
		loadGyeonggidoMap();
		loadRestaurantMap();
	}
	
	
	function initMap() {
		
		markers = new Array();
		infowindows = new Array();
		
		/* if(reCheck || parkCheck) {
			mapZoom = 10;
			nowLatitude = arrayLayout[0].latitude;
			nowLongitude = arrayLayout[0].longitude;
		} else if(!reCheck && !parkCheck) {
			mapZoom = 15;
			nowLatitude = arrayLayout[0].latitude;
			nowLongitude = arrayLayout[0].longitude;
		} 
		
		if ($("#searchKeyword").val() != "") {
			if (Array.isArray(arrayLayout) && arrayLayout.length === 0) {
				return;
			}
			
			reCheck = false;
			parkCheck = false;
			mapZoom = 10;
			if (Array.isArray(arrayLayout) && arrayLayout.length === 1) {
				mapZoom = 15;
			}
			
			nowLatitude = arrayLayout[0].latitude;
			nowLongitude = arrayLayout[0].longitude;
		} */
		
		
		//map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
	    //map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
		
		
		
		if((reCheck || parkCheck) || $("#searchKeyword").val() != "") {
			if (Array.isArray(arrayLayout) && arrayLayout.length === 0) {
				return;
			}
			
			mapZoom = 12;
			
			if (Array.isArray(arrayLayout) && arrayLayout.length === 1) {
				mapZoom = 15;
			}
			
			nowLatitude = arrayLayout[0].latitude;
			nowLongitude = arrayLayout[0].longitude;
		}
		
		map = new naver.maps.Map('content', {
	        center: new naver.maps.LatLng(nowLatitude, nowLongitude),  //지도 시작 좌표
	        zoom: mapZoom
	    });
		
		//동서남북 위치
		bounds = map.getBounds(),
	    	southWest = bounds.getSW(),
	    	northEast = bounds.getNE(),
	    	lngSpan = northEast.lng() - southWest.lng(),
	   		latSpan = northEast.lat() - southWest.lat();
		
		
		//filter 조건에 따른 map 표시
		for (var i=0; i<arrayLayout.length; i++) {
			if(reCheck && parkCheck) {
				if (arrayLayout[i].reservationStatus && arrayLayout[i].parkable) {
					selectMap(i);
				}
			} else if (reCheck) {
				if (arrayLayout[i].reservationStatus) {
					selectMap(i);
				}
			} else if (parkCheck) {
				if (arrayLayout[i].parkable) {
					selectMap(i);
				}
			} else {
				selectMap(i);
			}
		}
		
		function getClickHandler(seq) {
			//마커를 클릭하는 부분
			return function(e) {
				var marker = markers[seq], //클릭한 마커의 시퀀스를 찾는다
					infowindow = infowindows[seq]; //클릭한 마커의 시퀀스를 찾는다.
				
				if (infowindow.getMap()) {
					infowindow.close();
				} else {
					infowindow.open(map, marker);
				}
			}
		}
		
		for (var i=0, ii=markers.length; i<ii; i++) {
			//console.log(markers[i], getClickHandler(i));
			naver.maps.Event.addListener(markers[i], "click", getClickHandler(i));
		}
		
		naver.maps.Event.addListener(map, 'idle', function() {
		    updateMarkers(map, markers);
		});
	}
	
	function selectMap(i){
		
		var position = new naver.maps.LatLng(
		        southWest.lat() + latSpan * Math.random(),
		        southWest.lng() + lngSpan * Math.random());
		
		var marker = new naver.maps.Marker({
	        map: map,
	        position: position,
	        title: arrayLayout[i].restaurantName, //지역구 이름 => 음식점 이름과 같음
	        position: new naver.maps.LatLng(arrayLayout[i].latitude, arrayLayout[i].longitude)
	    });
		
		var menuType = "";
		var mainMenu = "";
		var reservationStatus = "";
		if (arrayLayout[i].menuType != null) {
			menuType = "("+arrayLayout[i].menuType+")";	
		}
		
		if (arrayLayout[i].mainMenu != null) {
			mainMenu = arrayLayout[i].mainMenu;
		}
		
		if (arrayLayout[i].reservationStatus != null) {
			if (arrayLayout[i].reservationStatus) {
				reservationStatus = '<span class="badge badge-info">예약 및 결제 가능</span>';
			} else {
				reservationStatus = '<span class="badge badge-danger">예약 및 결제 불가능</span>';
			}
		}
		
		var contentString = "";
		
		contentString = '<div style="padding:10px; width:280px;"><b>' + arrayLayout[i].restaurantName + menuType +
						'<br>'+ mainMenu +
						'<br>'+ arrayLayout[i].streetADDR +
						/* '<br>'+ arrayLayout[i].areaADDR + */
						'<br>'+ arrayLayout[i].restaurantTel;
						
						 
		if (arrayLayout[i].restaurantNo != null) {
			contentString += '<br><div>'+ reservationStatus + '<a href="/restaurant/getRestaurant?restaurantNo=' + arrayLayout[i].restaurantNo + '" class="button primary small" style="float:right; margin-right:20px;">상세보기</a> </div></div>';
		}	
						 
		//클릭 했을 때 띄어줄 정보 HTML
		var infowindow = new naver.maps.InfoWindow({
		    content: contentString,
		    maxWidth: 300,
		    borderColor: "#f56a6a",
		    borderWidth: 5
		});
	
		markers.push(marker); //생성한 마커를 배열에 담기
		infowindows.push(infowindow); //생성한 정보창을 배열에 담기
	}
	
	//위치에 따른 마커 hide, show
	function updateMarkers(map, markers) {

	    var mapBounds = map.getBounds();
	    var marker, position;

	    for (var i = 0; i < markers.length; i++) {

	        marker = markers[i]
	        position = marker.getPosition();

	        if (mapBounds.hasLatLng(position)) {
	            showMarker(map, marker);
	        } else {
	            hideMarker(map, marker);
	        }
	    }
	}
	
	//marker show
	function showMarker(map, marker) {

	    if (marker.getMap()) return;
	    marker.setMap(map);
	}

	//marker hide
	function hideMarker(map, marker) {

	    if (!marker.getMap()) return;
	    marker.setMap(null);
	}
	
	
	window.onload = function() {
		//현재 위치 받아오기
		thisLocation();
	}
	
	function thisLocation() {
		var options = {
			enableHighAccuracy: true,
			timeout: 5000,
			maximumAge: 0
		};
		
		function success(pos) {
			var crd = pos.coords;
			
			nowLatitude = crd.latitude;
			nowLongitude = crd.longitude;
			//console.log(crd);
			//console.log(pos);
		}
		
		function error(err) {
			console.warn("error :: " + err);
		}
		
		// geolocation 을 지원한다면 위치를 요청 
		if(navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(success, error, options);
		} else {
			alert("위치 정보 사용이 불가능한 웹입니다.");
		}
	}
	
</script>

</head>

<body class="is-preload">
	<!-- S:Wrapper -->
	<div id="wrapper">
		<!-- S:Main -->
		<div id="main" class="index">
			<div class="inner">
				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />

				<section id="map">
					<div class="content mainMap" id="content" style="width: 100%; height:100vh;">
					
						<!-- <div class="filterBox ui-widget-content">
							<nav class="top_nav" style="background: #f56a6a;">
								<div style="height: 20px;"></div>
							</nav>
							<p><input type="checkbox" checked data-toggle="toggle" data-size="xs"> 예약 가능 여부 </p>
							<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="reservationCheck"> 예약 가능한 가게만 보기 </p>
							<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="parkableCheck"> 주차 가능한 가게만 보기 </p>
						</div> -->
					
						<div class="thisLocation">
							<span class="badge badge-primary">현 위치로 이동 &nbsp;&nbsp;&nbsp;<i class="fas fa-location-arrow"></i>
							</span>
						</div>
						
						<div class="filter-group">
							<div class="speech-bubble">
								<!-- <span>contents</span> -->
								<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="reservationCheck"> 예약 가능 음식점</p>
								<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="parkableCheck"> 주차 가능 음식점 </p>
								<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="directionCheck" id="direction" data-toggle="modal" data-target="#directionModal" data-backdrop="static"> 길찾기 </p>
							</div>
							<div class="speech-path">
							</div>
							<div class="filter-button">
								<i class="fas fa-list"></i>
								<i class="fas fa-map-marked-alt none"></i>
								<i class="fas fa-calendar-check none"></i>
								<i class="fas fa-car none"></i>
								<i class="fas fa-filter none"></i>
								<i class="fas fa-tasks none"></i>
							</div>
							<!-- <a type="button" class="button info large" id="direction" data-toggle="modal" data-target="#directionModal" data-backdrop="static">길찾기</a>
							<a type="button" class="button info large direc-hide" id="none-direction">길찾기 종료</a> -->
							<!-- <img alt="길찾기" src="/resources/images/main/pngegg.png" class="directions-filter none"/> -->
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
	
	<div class="modal fade" id="directionModal" tabindex="-1" role="dialog" aria-labelledby="directionModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="directionModalLabel">길 찾기 검색</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div><p>길 안내를 원하는 음식점 이름을 입력해주세요.</p></div>
	          <div class="form-group">
	            <label for="start" class="col-form-label">출발지</label>
	            <input type="text" class="direction-control" id="startInput">
	          </div>
	          <div class="form-group">
	            <label for="goal" class="col-form-label">도착지</label>
	            <input type="text" class="direction-control" id="goalInput">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <input type="button" value="취소" class="normal" data-dismiss="modal" />
			<input type="button" value="검색" class="primary" id="searchDirec" />
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>