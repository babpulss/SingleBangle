<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea7c69cd1bf56d37c0df13609580d2bd&libraries=services"></script>
        <title>혼밥/혼술</title>

        <link rel="stylesheet" href="/css/nav.css">
        <style>
        	*{
				box-sizing: border-box;
			}
			body {
				background-color: #f5f5f5;
			}
        	
        	#writeBox{
        		margin: auto;
        		text-align: center;
        		min-width: 700px;
        	}
        	#writeBtn{
        		border: none;
            	border-radius: 5px;
            	width: 80px;
            	height: 40px;
            	font-size: 16px;
            	cursor: pointer;
            	color: white;
            	background-color: #0085cb;
        	}
        	
			#placeInfoBox{
            	display: none;
            	width: 80%;
            	margin: auto;
            }
            #placeInfo{
            	margin: auto;
            }
            
            .placeKey{
            	width: 120px;
            	height: 40px;
            	background-color: #e0e0e0;
            	padding-right: 10px;
            	text-align: right;
            }
            .placeVal{
            	min-width: 400px;
            	padding-left: 10px;
            }
            #placeTitle a{
            	color: #0085cb;
            	text-decoration: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/resources/jsp/nav.jsp"/>

        <br><br><br>
        <div id="mainWrapper">
			<div id="writeBox">
				<button type="button" id="writeBtn">글쓰기</button>
			</div>
			
            <br><hr><br>
            <div id="map" style="width:80%; min-width:700px; height:700px; margin:auto"></div>
            <br><hr><br>

            <div id="placeInfoBox">
                <table id="placeInfo">
                    <tbody>
                        <tr>
                            <td class="placeKey">제목</td>
                            <td class="placeVal" id="placeTitle"></td>
                        </tr>
                        <tr>
                            <td class="placeKey">작성자</td>
                            <td class="placeVal" id="writer"></td>
                        </tr>
                        <tr>
                            <td class="placeKey">작성일</td>
                            <td class="placeVal" id="writeDate"></td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
        <br><br><br>

		<script>
			$("#writeBtn").on("click", function(){
	    		location.href="${pageContext.request.contextPath}/restaurant/rstWrite.rst";
	    	})
			
	    	
	    	
			var container = document.getElementById('map');  // 지도를 담을 영역의 DOM 레퍼런스
	        var options = {
	            center: new kakao.maps.LatLng(37.568101, 126.983053),  // 지도의 중심좌표
	            level: 4
	        };
	
	        var map = new kakao.maps.Map(container, options);  // 지도 생성 및 객체 리턴
	        var markers = [];  // 지도에 표시된 마커 객체를 가지고 있을 배열
	        
	        // 마커를 생성하는 함수
	        function addMarker(position, placeData) {
                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: position
                });

                // 마커에 표시할 인포윈도우를 생성
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<span class="infoContent" style="width: 200px;">' + placeData.title + '</span>'  // 인포 윈도우에 표시할 내용
                });

                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));  // 마커에 마우스를 올리면 게시글 제목 띄우기
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));  // 마커에서 마우스가 벗어나면 게시글 제목 사라짐
				kakao.maps.event.addListener(marker, 'click', printPlaceInfo(placeData));  // 마커를 클릭하면 게시글 정보가 출력됨
                
                // 마커가 지도 위에 표시되도록 설정
                marker.setMap(map);

                // 생성된 마커를 배열에 추가
                markers.push(marker);
            }
	        
	     	// 인포 윈도우를 표시하는 클로저를 만드는 함수
            function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }

            // 인포 윈도우를 닫는 클로저를 만드는 함수
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }
            
            // 화면에 게시글 상세정보를 띄우는 클로저를 만드는 함수
            function printPlaceInfo(placeData) {
            	return function(){
            		$("#placeTitle").html("<a href='${pageContext.request.contextPath}/restaurant/rstDetail.rst?seq=" + placeData.seq + "'>" + placeData.title + "</a>");
            		$("#writer").html(placeData.writer);
            		$("#writeDate").html(placeData.formedDate1);
            		
            		$("#placeInfoBox").css("display", "block");
            		$("#writeDate")[0].scrollIntoView();
            	};
            }
	        
	        var placeJson = ${jsonResult};  // 서버로부터 보내진 json 형태의 게시글 목록
	        console.log(placeJson);
	        
	        for(var i = 0; i < placeJson.length; i++){
	        	var lat = Number(placeJson[i].yPos);  // 위도는 y좌표
	        	var lng = Number(placeJson[i].xPos);  // 경도는 x좌표
	        	var placeData = placeJson[i];
	        	
	        	addMarker(new kakao.maps.LatLng(lat, lng), placeData);  // 지도 위에 마커 표시
	        }
	        
	        var geocoder = new kakao.maps.services.Geocoder();  // 주소-좌표간 변환 서비스 객체
	        var userAddr = "${loginInfo.address1}";  // 사용자 정보에 등록되어 있는 주소
	        console.log(userAddr);
	        
	        // 주소에 해당하는 좌표값을 요청
            geocoder.addressSearch(userAddr, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    map.setCenter(coords);
                } else{
                    alert("로그인하셔야 근처 혼밥/혼술집을 보실 수 있습니다.")
                }
            }); 
	        
	     	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도 타입 컨트롤을 지도에 표시
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	        
		</script>
    </body>
</html>