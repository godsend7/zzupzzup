<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<script defer type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7gzdb36t5o"></script>
	
	<script>
		window.onload = function() {
			
			$(function() {
				initMap();
			});
			
			function initMap() {
				var arrayLayout = new Array();
				arrayLayout.push(
					{location:'강남', lat:'37.4959854', lng:'127.066401'}
				
				)
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
			
			
			/* 
			$(function() {
				$.ajax(
					{
						url : "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt?KEY=0584ed7e427d4676a15a4bf7f91b1597&Type=json&pIndex=1&pSize=10",
	    				type : "GET",
	    				dataType : "json",
	    				success : function(data, status) {
	    					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
	    					console.log(JSON.stringify(data));
	    					//alert(status);
							//alert("data : \n"+data);
	    				},
	    				error:function(request,status,error){
	 				       console.log("실패");
	 				    }
					}
				)
						
			}); */
		}
	</script>
	
	<div class="content" id="content" style="width: 100%; height:70vh;"></div>
	
	 <jsp:include page="/layout/sidebar.jsp" />