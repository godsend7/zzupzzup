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

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	.restaurantCheck {
		display: none;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">	
	var arrayLayout = new Array();
	
	var nowLatitude = "37.5703942";
	var newLongitude = "126.9832113";
	//현재위치로 이동
	//naver.maps.Event.once(map, '')
	
	$(function() {
		loadGyeonggidoMap();
		loadRestaurantMap();
	});
	
	function loadGyeonggidoMap(searchCondition) {
		/* $.ajax(
			{
				url : "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt?KEY=0584ed7e427d4676a15a4bf7f91b1597&Type=json&pIndex=1&pSize=1000",
   				type : "GET",
   				dataType : "json",
   				success : function(data, status) {
   					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
   					//console.log(JSON.stringify(data));
   					//alert(status);
					//alert("data : \n"+data);
					
   					//var obj = JSON.parse(data);
   					//console.log(data.PlaceThatDoATasteyFoodSt[1].row);
   					
   					$.each(data.PlaceThatDoATasteyFoodSt[1].row, function(index, item){ 
   						arrayLayout.push(
   							{restaurantName:item.RESTRT_NM, mainMenu:item.REPRSNT_FOOD_NM, latitude:item.REFINE_WGS84_LAT, longitude:item.REFINE_WGS84_LOGT,
   							 streetADDR:item.REFINE_ROADNM_ADDR, areaADDR:item.REFINE_LOTNO_ADDR, restaurantTel:item.TASTFDPLC_TELNO}
   							/* item */
   					/*	);
   					});
   					
   					initMap();
					
   				},
   				error:function(request,status,error){
				       console.log("실패");
				    }
			}
		) */
		console.log("뭐야 실행된거임?");
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
	   					
	   				console.log(arrayLayout);
   					
   					initMap();
					
   				},
   				error:function(request,status,error){
					console.log("실패");
					console.log(request);
					console.log(error);
				}
		});
	}
	
	function loadRestaurantMap(searchCondition) {
		
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
							 latitude:item.latitude, longitude:item.longitude, streetADDR:item.streetAddress, areaADDR:item.areaAddress, restaurantTel:item.restaurantTel, reservationStatus:item.reservationStatus}
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
		/* var arrayLayout = new Array();
		arrayLayout.push(
			{location:'강남', lat:'37.4959854', lng:'127.066401'},
			{location:'건대입구역', lat: '37.539922', lng: '127.070609'},
            {location:'어린이대공원역', lat: '37.547263', lng: '127.074181'}
		); */
		
		let markers = new Array();
		let infowindows = new Array();
		
		
		
		var map = new naver.maps.Map('content', {
	        center: new naver.maps.LatLng(nowLatitude, newLongitude),  //지도 시작 좌표, 현재위치로 변경
	        zoom: 10
	    });
		
		for (var i=0; i<arrayLayout.length; i++) {
			var marker = new naver.maps.Marker({
		        map: map,
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
	}
	
	window.onload = function() {
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

		<script>
			console.log("main 실행");
		</script>

		<!-- S:Main -->
		<div id="main" class="index">
			<div class="inner">
				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />

				<section id="map">
					<div class="content" id="content" style="width: 100%; height:100vh;"></div>
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
	