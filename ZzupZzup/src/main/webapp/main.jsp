<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<script defer type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7gzdb36t5o"></script>
	
	<script>
		window.onload = function() {
			
			var arrayLayout = new Array();
			
			
			$(function() {
				$.ajax(
					{
						url : "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt?KEY=0584ed7e427d4676a15a4bf7f91b1597&Type=json&pIndex=1&pSize=10",
	    				type : "GET",
	    				dataType : "json",
	    				success : function(data, status) {
	    					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
	    					//console.log(JSON.stringify(data));
	    					//alert(status);
							//alert("data : \n"+data);
							
	    					//var obj = JSON.parse(data);
	    					console.log(data.PlaceThatDoATasteyFoodSt[1].row);
	    					
	    					$.each(data.PlaceThatDoATasteyFoodSt[1].row, function(index, item){ 
	    						//console.log(item.SIGUN_NM);
	    						arrayLayout.push(
	    							item
	    						);
	    					});
	    					
	    					initMap();
							
	    				},
	    				error:function(request,status,error){
	 				       console.log("실패");
	 				    }
					}
				)
						
			});
			
			
			/* $(function() {
				initMap();
			}); */
			
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
			        center: new naver.maps.LatLng(37.5666805, 126.9784147), //지도 시작 좌표, 현재위치로 변경
			        zoom: 15
			    });
				
				for (var i=0; i<arrayLayout.length; i++) {
					var marker = new naver.maps.Marker({
				        map: map,
				        title: arrayLayout[i].RESTRT_NM, //지역구 이름 => 음식점 이름과 같음
				        position: new naver.maps.LatLng(arrayLayout[i].REFINE_WGS84_LAT, arrayLayout[i].REFINE_WGS84_LOGT)
				    });
					
					var contentString = '<div><b>' + arrayLayout[i].RESTRT_NM + 
										'<br>'+ arrayLayout[i].REPRSNT_FOOD_NM +
										'<br>'+ arrayLayout[i].SIGUN_NM +
										'<br>'+ arrayLayout[i].REFINE_WGS84_LAT +
										'<br>'+ arrayLayout[i].REFINE_WGS84_LOGT +
										'<br>'+ arrayLayout[i].REFINE_LOTNO_ADDR +
										'<br>'+ arrayLayout[i].REFINE_ROADNM_ADDR +
										'<br>'+ arrayLayout[i].TASTFDPLC_TELNO + 
										'</div>';
					
					//클릭 했을 때 띄어줄 정보 HTML
					var infowindow = new naver.maps.InfoWindow({
					    content: contentString,
					    maxWidth: 200,
					    backgroundColor: "#eee",
					    borderColor: "#f56a6a",
					    borderWidth: 5,
					    /* anchorSize: new naver.maps.Size(30, 30), */
					    /* anchorSkew: true, */
					   /*  anchorColor: "#eee", */
					    /* pixelOffset: new naver.maps.Point(20, -20) */
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
			
			
			
			/* var HOME_PATH = window.HOME_PATH || '.';
			console.log(HOME_PATH);
			var cityhall = new naver.maps.LatLng(37.5666805, 126.9784147),
			    map = new naver.maps.Map('content', {
			        center: cityhall,
			        zoom: 15
			    }),
			    marker = new naver.maps.Marker({
			        map: map,
			        position: cityhall
			    });

			var contentString = [
			        '<div class="iw_inner">',
			        '   <h3>서울특별시청</h3>',
			        '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br />',
			        '       02-120 | 공공,사회기관 &gt; 특별,광역시청<br />',
			        '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
			        '   </p>',
			        '</div>'
			    ].join('');

			var infowindow = new naver.maps.InfoWindow({
			    content: contentString,
			    maxWidth: 200,
			    backgroundColor: "#eee",
			    borderColor: "#2db400",
			    borderWidth: 5,
			    anchorSize: new naver.maps.Size(30, 30),
			    anchorSkew: true,
			    anchorColor: "#eee",
			    pixelOffset: new naver.maps.Point(20, -20)
			});

			naver.maps.Event.addListener(marker, "click", function(e) {
			    if (infowindow.getMap()) {
			        infowindow.close();
			    } else {
			        infowindow.open(map, marker);
			    }
			}); */
		}
	</script>
	
	<div class="content" id="content" style="width: 100%; height:70vh;"></div>
	
	 <jsp:include page="/layout/sidebar.jsp" />