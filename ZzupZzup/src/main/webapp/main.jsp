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
		cursor: move;
		width: 20%;
		height: 17%;
		right: 20px;
		top: 250px;
		padding: 1.0em;
	}
	
	.filterBox p {
		font-size: 1.0em;
	}
	
	.thisLocation {
		z-index: 99;
		position: absolute;
		top: 90%; left: 50%;
		width:120px; height: 35px;
		margin-left:-65px;
		line-height: 33px;
		border-radius: 20em;
	}
	
	.btn-outline-primary {
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
	/* .mainMap {
		position: relative;
	} */
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">	
	var arrayLayout = new Array();
	
	var nowLatitude = "37.5703942";
	var newLongitude = "126.9832113";
	//현재위치로 이동
	//naver.maps.Event.once(map, '')
	
	//지도 정보를 담을 객체 선언
	let markers = new Array();
	let infowindows = new Array();
	
	//화면에 보여줄 map 객체 선언
	var map;
	//화면에 보여줄 지도의 기본 크기 설정
	var mapZoom = 15; 
	
	//화면 위치(s,n,w,e) 넣을 객체 선언
	var bounds;
	
	//map search condition
	var reCheck = false;
	var parkCheck = false;
	
	$(function() {
		
		loadRestaurantMap();
		loadGyeonggidoMap();
		
		
		$( ".filterBox" ).draggable();
		
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
		});
		
		
		document.getElementById("mapSearch").addEventListener("keydown", function(evant) {
			//console.log("keydown");
			if (evant.keyCode === 13) {
				evant.preventDefault();
				document.getElementById("searchButton").click();
			}
		});
		
		$(".thisLocation").on("click", function() {
			thisLocation();
		});
	});
	
	function loadGyeonggidoMap() {
		//console.log("뭐야 실행된거임?");
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
			newLongitude = arrayLayout[0].longitude;
		} else if(!reCheck && !parkCheck) {
			mapZoom = 15;
			nowLatitude = arrayLayout[0].latitude;
			newLongitude = arrayLayout[0].longitude;
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
			newLongitude = arrayLayout[0].longitude;
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
			newLongitude = arrayLayout[0].longitude;
		}
		
		map = new naver.maps.Map('content', {
	        center: new naver.maps.LatLng(nowLatitude, newLongitude),  //지도 시작 좌표
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
		
		/* if (arrayLayout[i].restaurantNo != null) {
			contentString = '<div style="padding:10px; width:280px;"><b>' + arrayLayout[i].restaurantName + menuType + ' <a href="/restaurant/getRestaurant?restaurantNo=' + arrayLayout[i].restaurantNo + '" class="button primary small" style="float:right; margin-right:20px;">찜</a>';
		} else {
			contentString = '<div style="padding:10px; width:280px;"><b>' + arrayLayout[i].restaurantName + menuType;
		}  */
	
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
			newLongitude = crd.longitude;
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
					
						<div class="filterBox ui-widget-content">
							<!-- <nav class="top_nav" style="background: #f56a6a;">
								<div style="height: 20px;"></div>
							</nav> -->
							<!-- <p><input type="checkbox" checked data-toggle="toggle" data-size="xs"> 예약 가능 여부 </p> -->
							<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="reservationCheck"> 예약 가능한 가게만 보기 </p>
							<p><input type="checkbox" data-toggle="toggle" data-size="xs" data-onstyle="outline-primary" class="parkableCheck"> 주차 가능한 가게만 보기 </p>
						</div>
					
						<div>
							<span class="badge badge-primary thisLocation">현 위치로 이동 &nbsp&nbsp&nbsp&nbsp<svg 
								xmlns="http://www.w3.org/2000/svg" width="16" height="16" style="margin-bottom: 3px;" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
  								<path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"/>
  								<path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"/>
								</svg>
							</span>
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
	