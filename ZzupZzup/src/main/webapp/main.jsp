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
<script type="text/javascript" src="./resources/js/MarkerOverlappingRecognizer.js"></script>
<link rel="stylesheet" href="/resources/css/map.css"/>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.iw_inner_p ^ {
	border-radius: 1em;
}
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
	//marker 겹침 처리
	var recognizer;
	
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
	
	//map 초기화
	function initMap() {
		map = new naver.maps.Map('content', {
			zoom: 13,
		    center: new naver.maps.LatLng(nowLatitude, nowLongitude)
		});
	}
	
	//marker, infowindow 초기화
	function resetMap() {
		for (var i = 0, len = markers.length; i < len; i++) {
			markers[i].setMap(null);
			infowindows[i].setMap(null);
		}
		
		markers = [];
		infowindows = [];
	}
	
	window.onload = function() {
		console.log("오");
		//현재 위치 받아오기
		thisLocation();
		
		//초기화 진행 function
		initMap();
	}
	
	$(function() {
		
		loadGyeonggidoMap();
		loadRestaurantMap();
		
		//$( ".filterBox" ).draggable();
		
		/////////////// switch toggle check 여부 start ///////////////
		$(".reservationCheck").on("change",function() {
			$("#searchKeyword").val('');
			arrayLayout = new Array();
			if($(this).prop("checked") == true){
				reCheck = true;
				
				loadRestaurantMap();
			} else {
				reCheck = false;
				
				loadGyeonggidoMap();
				loadRestaurantMap();
			}
			iconChange();
		});
		
		$(".parkableCheck").on("change",function() {
			$("#searchKeyword").val('');
			arrayLayout = new Array();
			if($(this).prop("checked") == true){
				parkCheck = true;
				loadRestaurantMap();
			} else {
				parkCheck = false;
				loadGyeonggidoMap();
				loadRestaurantMap();
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
			//console.log("modal 닫힘");
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
						
						//console.log(data);
						
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
	 				startLocation.push({"title":"출발지"});
	 				startLocation.push(ui.item.id);
					//startLocation = ui.item.id;
					//startLocation.push({title:"출발지"});
					//console.log(startLocation);
				} else if (thisInput == "goalInput"){
					goalLocation.push({"title":"목적지"});
					goalLocation.push(ui.item.id);
					//goalLocation = ui.item.id;
					//console.log(goalLocation);
				}
	 			
	 			//console.log(ui.item.id);
	 			
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
				startLat: startLocation[1].latitude,
				startLong: startLocation[1].longitude,
				goalLat: goalLocation[1].latitude,
				goalLong: goalLocation[1].longitude
			}), 
			success : function(data, status) {
				//alert(JSON.stringify(data.route.bbox));
				//console.log(JSON.stringify(data.route.trafast[0].path));
				//getDirec();
				
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
				//alert(request);
				//alert(error);
				alert("잘못된 요청입니다. 다시 시도해주세요.");
			}
		});
	}
	
	//길찾기 실행
	function getDirec() {
		resetMap();
		
		//modal 종료
		$("#directionModal").modal("hide");
		
		//button 변경
		$("#direction").addClass("direc-hide");
		$("#none-direction").removeClass("direc-hide");
		
		map.setZoom(13);
		map.setCenter(new naver.maps.LatLng(startLocation[1].latitude, startLocation[1].longitude));
		
		var polyline = new naver.maps.Polyline({
			path: polylinePath,
	        strokeColor: '#d16767',
	        strokeOpacity: 0.8,
	        strokeWeight: 6,
	        zIndex: 88,
	        clickable: true,
	        map: map
		});
		/* 
		var startMarker = new naver.maps.Marker({
		    position: polylinePath[0], //마크 표시할 위치 배열의 시작 위치
		    map: map,
		    icon: {
	   			url:"/resources/images/main/map_marker.png"
	   		}
		});
		
		var goalMarker = new naver.maps.Marker({
		    position: polylinePath[polylinePath.length-1], //마크 표시할 위치 배열의 마지막 위치
		    map: map,
		    icon: {
	   			url:"/resources/images/main/map_marker.png"
	   		}
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
		goalInfowindow.open(map, goalMarker); */
		
		viewCustomOverlay(startLocation);
		viewCustomOverlay(goalLocation);
		
		dirCheck = true;
		iconChange();
		
		//경로 안내 출력
		getPathInfo();
	}
	
	function viewCustomOverlay(locationArray) {
		//console.log(locationArray);
		
		// 4. 사용자 정의 오버레이
		var CustomOverlay = function(options) {
		    // 마커 이미지 크기이다. draw 메서드에서 마커 위치를 잡을 때 사용한다.
		    this._imgSize = new naver.maps.Size(22, 30);
		    
		    // 오버레이에서 필요한 엘리먼트를 준비한다.
		    this._prepareDOM();

		    this.setPosition(options.position);
		  
		    // 지도와 오버레이를 연결한다.
		    this.setMap(options.map || null);
		};

		CustomOverlay.prototype = new naver.maps.OverlayView();
		CustomOverlay.prototype.constructor = CustomOverlay;

		CustomOverlay.prototype.setPosition = function(position) {
		    this._position = position;
		  
		    // Setter 메서드를 이용해 좌표가 변경되면 오버레이 엘리먼트 위치를 다시 잡을 수 있도록 draw 메서드를 호출한다.
		    this.draw();
		};

		CustomOverlay.prototype.getPosition = function() {
		    return this._position;
		};

		CustomOverlay.prototype.onAdd = function() {
		    // 오버레이가 위치할 페인을 결정한다. 이 예제에서는 정보 창을 올리는 floatPane을 사용한다.
		    var paneName = 'floatPane',
		        floatPane = this.getPanes()[paneName];
		  
		    // 오버레이 엘리먼트를 페인에 추가한다.
		    this._element.appendTo(floatPane);
		    // 이벤트 리스너를 등록한다.
		    this._bindEvent();
		};

		CustomOverlay.prototype.draw = function() {
		    if (!this.getMap()) {
		        return;
		    }

		    var projection = this.getProjection(), // 오버레이 엘리먼트의 위치를 잡기 위해 프로젝션을 가져온다.
		        position = this.getPosition(), // 오버레이 위치를 가져온다(위/경도).
		        pixelPosition = projection.fromCoordToOffset(position); // 평면 좌표를 화면 좌표로 변환한다.
		  
		    // 화면좌표를 그대로 사용하면 마커 이미지 기준 (0, 0)이 위치한다.
		    // 마커의 가운데 아래쪽 뽀족한 부분을 위치로 사용하려면 그만큼 엘리먼트를 움직여야 한다.
		    this._element.css('left', pixelPosition.x - (this._imgSize.width / 2));
		    this._element.css('top', pixelPosition.y - this._imgSize.height);
		};

		CustomOverlay.prototype.onRemove = function() {
		    // 등록된 이벤트를 해제한다.
		    this._unbindEvent();
		    // 추가된 엘리먼트를 제거한다.
		    this._element.remove();
		};
		

		CustomOverlay.prototype._onClick = function() {
		    this._iw.show();
		    this._mk.removeClass("none-info");
		    this._mk.addClass("info");
		}; 

		CustomOverlay.prototype._onClear = function() {
		    this._iw.hide();
		    this._mk.removeClass("info");
		    this._mk.addClass("none-info");
		};

		CustomOverlay.prototype._bindEvent = function() {
		    this._element
		        .on('click', '.none-info', this._onClick.bind(this))
		        .on('click', '.info', this._onClear.bind(this))
		};

		CustomOverlay.prototype._unbindEvent = function() {
		    this._element.off();
		};

		CustomOverlay.prototype._prepareDOM = function() {
		    var markerContent = [
		        '<div style="position:absolute;">',
		            '<div class="infowindow" style="position:absolute;width:240px;height:110px;top:-140px;left:-110px;background-color:white;z-index:1;border:1px solid black;margin:0;padding:10px; border-radius:1em;">',
		                '<div style="font-size:13px; color:#f56a6a;">['+ locationArray[0].title +']</div>',
		                '<div style="font-size:13px;"><b>'+locationArray[1].restaurantName+'</b> <br>'+locationArray[1].streetAddress+'<br>'+locationArray[1].restaurantTel+'</div>',
		                '<div style="margin: 0px; padding: 0px; width: 0px; height: 0px; position: absolute; border-width: 24px 10px 0px; border-style: solid; border-color: rgb(51, 51, 51) transparent; border-image: initial; pointer-events: none; box-sizing: content-box !important; transform-origin: right bottom 0px; transform: skewX(0deg); bottom: -25px; left: 110px;"></div>',
		                '<div style="margin: 0px; padding: 0px; width: 0px; height: 0px; position: absolute; border-width: 24px 10px 0px; border-style: solid; border-color: rgb(255, 255, 255) transparent; border-image: initial; pointer-events: none; box-sizing: content-box !important; transform-origin: right bottom 0px; transform: skewX(0deg); bottom: -22px; left: 110px;"></div>',
		            '</div>',
		            '<div class="pin_s" style="cursor: pointer; width: 22px; height: 30px;">',
	                '<img class="info" src="/resources/images/main/map_marker.png" alt="" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; width: 22px; height: 30px; left: 0px; top: 0px;">',
	            	'</div>',
	       		'</div>'
		    ].join('');
	
		    this._element = $(markerContent);
		    this._iw = this._element.find('.infowindow');
		    this._mk = this._element.find("img"); 
		    //this._tooltip = this._element.find('.pins_s_tooltip');
		};
	
		var overlay = new CustomOverlay({
		    map: map,
		    position: new naver.maps.LatLng(locationArray[1].latitude, locationArray[1].longitude)
		});
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
			right: "50px",
			position: "relative"
		});
		
		$(".speech-path").children("p").css({
		    fontSize: "0.9em"
		});
	}
	
	//주소 비교를 위한 변경 function()
	function addrChange(arrayAddr) {
		var addr = "";
		for (var i = 0; i < arrayAddr.length; i++) {
   	  		if (i != 0) {
   	  			addr += arrayAddr[i];
			}
	 	}
		
		return addr;
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
				//console.log("gyeonggidoMap");
				$.each(data, function(index, item){
					arrayLayout.push(
						{restaurantName:item.RESTRT_NM, mainMenu:item.REPRSNT_FOOD_NM, latitude:item.REFINE_WGS84_LAT, longitude:item.REFINE_WGS84_LOGT,
						 streetADDR:item.REFINE_ROADNM_ADDR, areaADDR:item.REFINE_LOTNO_ADDR, restaurantTel:item.TASTFDPLC_TELNO}
					)
				});
				
				/////////////// openApi 음식점 정보가 restaurant DB에 존재한다면 중복 제거 작업 //////////////
	            var checkArray = new Array();
	            
	            let apiCheck = false;
	            for(let i = 0; i < arrayLayout.length; i++) {
	            	const checkName = arrayLayout[i].restaurantName;
	              	var checkAddr = arrayLayout[i].streetADDR.split(" ");
	              	
	              	const addr1 = addrChange(checkAddr);
	              
	              	for(let j = i+1; j < arrayLayout.length; j++) {
	                	// console.log(arrayLayout[j]);
	                	var arrayStreet = arrayLayout[j].streetADDR.split(" ");
	                	
	                	const addr2 = addrChange(arrayStreet);
		           	  	
		                if(checkName === arrayLayout[j].restaurantName && addr1 === addr2) {
		                    if (typeof arrayLayout[j].restaurantNo == "undefined") {
			                    console.log("동일한 애 openApi " + arrayLayout[j]);
			                    //console.log(arrayLayout[j]);
			                    checkArray.push(arrayLayout[j]);
			                    apiCheck = true;
			                    break;
		                  	}
		                }
		            }
	              
		            if(apiCheck)  {
						break;
		            }
	            }
	            
	            //중복된 음식점 제외 출력 (차집합)
	            arrayLayout = arrayLayout.filter(x => !checkArray.includes(x));
	            //console.log("하단 최종");
	            //console.log(arrayLayout);
	               
	            ///////////////////////////////////////////////////////////////////////////////
			
				viewMap();
	
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
		$.ajax({
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
 					 console.log("restaurantMap");
 					$.each(data, function(index, item){ 
 						//console.log(item.location);
 						
 						if (item.postNo == 0 && item.judgeStatus != 2) {
							console.log("openAPI를 통해 등록된 심사중인 음식점");
						} else {
							arrayLayout.push(
								{restaurantNo:item.restaurantNo, restaurantName:item.restaurantName, menuType:item.returnMenuType, mainMenu:item.restaurantMenus.menuTitle, 
								latitude:item.latitude, longitude:item.longitude, streetADDR:item.streetAddress, areaADDR:item.areaAddress, restaurantTel:item.restaurantTel, 
						 		parkable:item.parkable, reservationStatus:item.reservationStatus, judgeStatus:item.judgeStatus, requestDate:item.requestDate, postNo:item.postNo}
	 						); 
						}
 					});
 					
 					/////////////// postNo가 동일하면 중복 제거 작업 //////////////
					var checkArray = new Array();
					
					let postNoCheck = false;
					for(let i = 0; i < arrayLayout.length; i++) {
					  const check = arrayLayout[i].postNo;
					  
					  for(let j = i+1; j < arrayLayout.length; j++) {
					  	if(check === arrayLayout[j].postNo) {
					  		if (arrayLayout[j].judgeStatus != 2 && arrayLayout[j].requestDate != null) {
								//console.log("동일한 애 아직심사중 " + arrayLayout[j].restaurantNo);
								//console.log(arrayLayout[j]);
								checkArray.push(arrayLayout[j]);
								postNoCheck = true;
						      	break;
							}
					    }
					  }
					  
					  if(postNoCheck)  {
					    break;
					  }
					}
 					//중복된 음식점 제외 출력 (차집합)
 					arrayLayout = arrayLayout.filter(x => !checkArray.includes(x));
 					//console.log("하단 최종");
 					//console.log(arrayLayout);
 					
 					////////////////////////////////////////////////////////
 					
 					viewMap();
			
 				},
	 			error:function(request,status,error){
			       //console.log("실패");
			       alert("정보를 불러올 수 없습니다. 다시 시도해주세요.");
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
	
	function viewMap() {
		//marker, infowindow 초기화 진행
		resetMap();
		
		if((reCheck || parkCheck) || $("#searchKeyword").val() != "") {
			if (Array.isArray(arrayLayout) && arrayLayout.length === 0) {
				return;
			}
			
			mapZoom = 12;
			
			if (Array.isArray(arrayLayout) && arrayLayout.length === 1) {
				mapZoom = 15;
			}
			
			nowLatitude = arrayLayout[arrayLayout.length-1].latitude;
			nowLongitude = arrayLayout[arrayLayout.length-1].longitude;
		}
	    
	    map.setCenter(new naver.maps.LatLng(nowLatitude, nowLongitude));
	    map.setZoom(mapZoom);
		
		//겹침 처리
		recognizer = new MarkerOverlappingRecognizer({
	        highlightRect: false,
	        tolerance: 5
	    });
		
		recognizer.setMap(map);
		
		//동서남북 위치
		bounds = map.getBounds(),
	    	southWest = bounds.getSW(),
	    	northEast = bounds.getNE(),
	    	lngSpan = northEast.lng() - southWest.lng(),
	   		latSpan = northEast.lat() - southWest.lat();
		
		
		//filter 조건에 따른 map 표시
		for (var i=0; i<arrayLayout.length; i++) {
			
			
			/* if ((!(arrayLayout[i].judgeStatus == 1 || arrayLayout[i].judgeStatus == 3) || typeof arrayLayout[i].judgeStatus == "undefined")
					&& (arrayLayout[i].requestDate == null || typeof arrayLayout[i].requestDate == "undefined")) { */
				
				//console.log(arrayLayout[i]);
				if(reCheck && parkCheck) {
					if ((arrayLayout[i].reservationStatus && arrayLayout[i].judgeStatus == 2) && arrayLayout[i].parkable) {
						selectMap(i);
					}
				} else if (reCheck) {
					if (arrayLayout[i].reservationStatus && arrayLayout[i].judgeStatus == 2) {
						selectMap(i);
					}
				} else if (parkCheck) {
					if (arrayLayout[i].parkable) {
						selectMap(i);
					}
				} else {
					selectMap(i);
				}
			//}
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
					$(".iw_inner").parent("div").attr("class", "iw_inner_p");
					$(".iw_inner_p").parent("div").css("border-radius","1em");
				}
			}
		}
		
		//겹쳐진 marker 처리하는 function
		function highlightMarker(marker) {
	    	marker.setZIndex(1000);
	    }

	    function unhighlightMarker(marker) {
	        marker.setZIndex(100);
	    }
		
		for (var i=0, ii=markers.length; i<ii; i++) {
			//marker 겹침 이벤트 생성
			markers[i].addListener('mouseover', function(e) {
           		highlightMarker(e.overlay);
        	});
			
	        markers[i].addListener('mouseout', function(e) {
	            unhighlightMarker(e.overlay);
	        });
	        
			naver.maps.Event.addListener(markers[i], "click", getClickHandler(i));
			
			recognizer.add(markers[i]);
		}
		
		naver.maps.Event.addListener(map, 'idle', function() {
		    updateMarkers(map, markers);
		});
		
		var overlapCoverMarker = null;
		
		naver.maps.Event.addListener(recognizer, 'overlap', function(list) {
	        if (overlapCoverMarker) {
	            unhighlightMarker(overlapCoverMarker);
	        }

	        overlapCoverMarker = list[0].marker;

	        naver.maps.Event.once(overlapCoverMarker, 'mouseout', function() {
	            highlightMarker(overlapCoverMarker);
	        });
	    });

	    naver.maps.Event.addListener(recognizer, 'clickItem', function(e) {
	        recognizer.hide();

	        if (overlapCoverMarker) {
	            unhighlightMarker(overlapCoverMarker);

	            overlapCoverMarker = null;
	        }
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
	        position: new naver.maps.LatLng(arrayLayout[i].latitude, arrayLayout[i].longitude),
	   		zIndex: 100,
	   		icon: {
	   			url:"/resources/images/main/map_marker.png"
	   		}
		});
		
		var menuType = "";
		var mainMenu = "";
		var reservationStatus = "";
		if (arrayLayout[i].menuType != null) {
			menuType = "("+arrayLayout[i].menuType+")";	
		}
		
		if (arrayLayout[i].mainMenu != null) {
			mainMenu = "<br> 대표메뉴 : " + arrayLayout[i].mainMenu;
		}
		
		if (arrayLayout[i].reservationStatus != null) {
			if (arrayLayout[i].reservationStatus) {
				reservationStatus = '<span class="badge badge-info">예약 및 결제 가능</span>';
			} else {
				reservationStatus = '<span class="badge badge-danger">예약 및 결제 불가능</span>';
			}
		}
		
		var contentString = "";
		
		contentString = '<div class="iw_inner" style="padding:10px; width:250px;"><div style="width:230px;"><b>' + arrayLayout[i].restaurantName + menuType + '</b> </div>' +
						'<div style="font-size:0.9em; width:230px;">'+ mainMenu +
						'<br>'+ arrayLayout[i].streetADDR +
						/* '<br>'+ arrayLayout[i].areaADDR + */
						'<br>'+ arrayLayout[i].restaurantTel;
						
						 
		if (arrayLayout[i].judgeStatus == 2) {
			contentString += '<br><div>'+ reservationStatus + '<a href="/restaurant/getRestaurant?restaurantNo=' + arrayLayout[i].restaurantNo + '" class="button primary small" style="float:right;">상세보기</a> </div></div></div>';
		}	
						 
		//클릭 했을 때 띄어줄 정보 HTML
		var infowindow = new naver.maps.InfoWindow({
		    content: contentString,
		    maxWidth: 300,
		    borderColor: "#f56a6a",
		    borderWidth: 3
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