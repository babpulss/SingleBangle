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
        <title>병원 목록</title>
        
        <link rel="stylesheet" href="/css/nav.css">
        <style>
        	*{
				box-sizing: border-box;
			}
			body {
				background-color: #f5f5f5;
			}
        
        	#searchBox{
        		margin: auto;
        		text-align: center;
        		min-width: 700px;
        	}        
            .addrSelect{
            	border: 1px solid #dadada;
            	width: 140px;
                height: 40px;
                font-size: 16px;
            }
            #searchHosp{
            	border: none;
            	border-radius: 5px;
            	width: 80px;
            	height: 40px;
            	font-size: 16px;
            	cursor: pointer;
            	color: white;
            	background-color: #0085cb;
            }
            
            #hospInfoBox{
            	display: none;
            	width: 80%;
            	margin: auto;
            }
            #hospInfo{
            	margin: auto;
            }
            
            .hospKey{
            	width: 120px;
            	height: 40px;
            	background-color: #e0e0e0;
            	padding-right: 10px;
            	text-align: right;
            }
            .hospVal{
            	min-width: 400px;
            	padding-left: 10px;
            }
            #hospUrl a{
            	color: #0085cb;
            	text-decoration: none;
            }
        </style>
    </head>
    <body>
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    
    	<br><br><br>
    	<div id="mainWrapper">
			<div id="searchBox">
		        <select class="addrSelect" id="sidoCd" name="sidoCd">
		            <option value="0">시/도 선택</option>
		            <option value="110000">서울</option>
		            <option value="210000">부산</option>
		            <option value="220000">인천</option>
		            <option value="230000">대구</option>
		            <option value="240000">광주</option>
		            <option value="250000">대전</option>
		            <option value="260000">울산</option>
		            <option value="310000">경기</option>
		            <option value="320000">강원</option>
		            <option value="330000">충북</option>
		            <option value="340000">충남</option>
		            <option value="350000">전북</option>
		            <option value="360000">전남</option>
		            <option value="370000">경북</option>
		            <option value="380000">경남</option>
		            <option value="390000">제주</option>
		            <option value="410000">세종</option>
		        </select>
		
		        <select class="addrSelect" id="sgguCd" name="sgguCd">
		            <option value="0">시/군/구 선택</option>
		        </select>
		
		        <select class="addrSelect" id="emdongNm" name="emdongNm">
		            <option value="0">읍/면/동 선택</option>
		        </select>
		
		        <select class="addrSelect" id="hospType" name="hospType">
		            <option value="0">병원 종류 선택</option>
		            <option value="치과">치과</option>
		            <option value="안과">안과</option>
		            <option value="이비인후과">이비인후과</option>
		            <option value="내과">내과</option>
		            <option value="외과">외과</option>
		            <option value="신경과">신경과</option>
		            <option value="신경외과">신경외과</option>
		            <option value="정형외과">정형외과</option>
		            <option value="피부과">피부과</option>
		            <option value="성형외과">성형외과</option>
		            <option value="산부인과">산부인과</option>
		            <option value="비뇨기과">비뇨기과</option>
		        </select>
		
		        <button type="button" id="searchHosp">검색</button>
	        </div>
	        
			<br><hr><br>
	        <div id="map" style="width:80%; min-width:700px; height:700px; margin:auto"></div>
	        <br><hr><br>
	        
	        <div id="hospInfoBox">
	            <table id="hospInfo">
	            	<tbody>
		                <tr>
		                    <td class="hospKey">병원명</td>
		                    <td class="hospVal" id="hospName"></td>
		                </tr>
		                <tr>
		                    <td class="hospKey">주소</td>
		                    <td class="hospVal" id="hospAddr"></td>
		                </tr>
		                <tr>
		                    <td class="hospKey">전화번호</td>
		                    <td class="hospVal" id="hospTel"></td>
		                </tr>
		                <tr>
		                    <td class="hospKey">홈페이지</td>
		                    <td class="hospVal" id="hospUrl"></td>
		                </tr>
	                </tbody>
	            </table>
	        </div>
		</div>
		<br><br><br>
		
        <script>
            //////////////////////////////////////////////////

            var container = document.getElementById('map');  // 지도를 담을 영역의 DOM 레퍼런스
            var options = {
                center: new kakao.maps.LatLng(37.568101, 126.983053),  // 지도의 중심좌표
                level: 4
            };

            var map = new kakao.maps.Map(container, options);  // 지도 생성 및 객체 리턴
            var markers = [];  // 지도에 표시된 마커 객체를 가지고 있을 배열



            // 지도 중심좌표 이동시키기
            function setCenter(a, b){
                // 이동할 위도&경도 위치를 생성
                var moveLatLon = new kakao.maps.LatLng(a, b);

                // 지도 중심을 이동시킴
                map.setCenter(moveLatLon);
            }



            // 마커를 생성하는 함수
            function addMarker(position, hospData) {
                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: position
                });

                // 마커에 표시할 인포윈도우를 생성
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<span class="infoContent" style="width: 200px;">' + hospData.hospName + '</span>'  // 인포 윈도우에 표시할 내용
                });

                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));  // 마커에 마우스를 올리면 병원 이름 띄우기
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));  // 마커에서 마우스가 벗어나면 병원 이름 사라짐
				kakao.maps.event.addListener(marker, 'click', printHospInfo(hospData));  // 마커를 클릭하면 병원 정보가 출력됨
                
                // 마커가 지도 위에 표시되도록 설정
                marker.setMap(map);

                // 생성된 마커를 배열에 추가
                markers.push(marker);
            }



            // 배열에 추가된 마커를 지도에서 삭제하는 함수
            function removeMarkers() {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers = [];  // 새로운 검색 결과를 담기 위해 마커 배열 초기화
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
            
            // 화면에 병원 상세정보를 띄우는 클로저를 만드는 함수
            function printHospInfo(hospData) {
            	return function(){
            		$("#hospName").html(hospData.hospName);
            		$("#hospAddr").html(hospData.addr);
            		$("#hospTel").html(hospData.telNo);
            		if(hospData.url != ""){
	            		$("#hospUrl").html('<a href=' + hospData.url + ' target="_blank">' + hospData.url + '</a>');
            		}
            		else{
            			$("#hospUrl").html("웹 사이트를 제공하지 않는 병원입니다.");
            		}
            		
            		$("#hospInfoBox").css("display", "block");
            		$("#hospUrl")[0].scrollIntoView();
            	};
            }
            
            
            
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도 타입 컨트롤을 지도에 표시
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			
			
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
            
			
            //////////////////////////////////////////////////

            
            // 시도 코드 입력으로 시군구 코드 가져오기
            $("#sidoCd").on("change", function(){
                var sidoCd = $("#sidoCd").val();
                console.log("시도 코드 : " + sidoCd);

                $("#sgguCd").empty();
                if(sidoCd == "0"){
                	$("#sgguCd").append("<option value='0'>시/군/구 선택</option>");
                }
                else{
	                $("#sgguCd").append("<option value='0'>불러오는 중...</option>");
                }
                $("#emdongNm").empty();
                $("#emdongNm").append("<option value='0'>읍/면/동 선택</option>");

                if(sidoCd != "0"){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/hosp/getSgguCd.hp",
                        type:"post",
                        data:{
                            sidoCd:sidoCd
                        },
                        dataType:"json"
                    }).done(function(data){
                    	
                    	$("#sgguCd").empty();
                        $("#sgguCd").append("<option value='0'>시/군/구 선택</option>");

                        // 시군구 오름차순으로 정렬
                        data.sort(function(a, b){
                            return a.addrCdNm < b.addrCdNm ? -1 : a.addrCdNm > b.addrCdNm ? 1 : 0;
                        });

                        for(var i = 0; i < data.length; i++){
                            var option = "<option value='" + data[i].addrCd + "'>" + data[i].addrCdNm + "</option>";
                            $("#sgguCd").append(option);
                        }
                    }).fail(function(a, b, c){
                        console.log(a);
                        console.log(b);
                        console.log(c);
                    })
                }
            })

            // 시군구 코드 입력으로 읍면동 가져오기
            $("#sgguCd").on("change", function(){
                var sgguCd = $("#sgguCd").val();
                console.log("시군구 코드 : " + sgguCd);

                $("#emdongNm").empty();
                if(sgguCd == "0"){
                	$("#emdongNm").append("<option value='0'>읍/면/동 선택</option>");
                }
                else{
	                $("#emdongNm").append("<option value='0'>불러오는 중...</option>");
                }

                if(sgguCd != "0"){
                    var sidoCdNm=$("#sidoCd option:selected").text();
                    var sgguCdNm=$("#sgguCd option:selected").text();
                    console.log(sidoCdNm + " : " + sgguCdNm);

                    $.ajax({
                        url:"${pageContext.request.contextPath}/hosp/getEmdongNm.hp",
                        type:"post",
                        data:{
                            sidoCdNm:sidoCdNm,
                            sgguCdNm:sgguCdNm
                        },
                        dataType:"json"
                    }).done(function(data){

                    	$("#emdongNm").empty();
                        $("#emdongNm").append("<option value='0'>읍/면/동 선택</option>");
                    	
                        // 읍면동 오름차순으로 정렬
                        data.sort(function(a, b){
                            return a.addrCdNm < b.addrCdNm ? -1 : a.addrCdNm > b.addrCdNm ? 1 : 0;
                        });

                        for(var i = 0; i < data.length; i++){
                            var option = "<option value='" + data[i].addrCdNm + "'>" + data[i].addrCdNm + "</option>";
                            $("#emdongNm").append(option);
                        }
                    }).fail(function(a, b, c){
                        console.log(a);
                        console.log(b);
                        console.log(c);
                    })
                }
            })

            $("#emdongNm").on("change", function(){
                var emdongNm = $("#emdongNm").val();
                console.log("읍면동 명 : " + emdongNm);
            })

            // 시도 코드, 시군구 코드, 읍면동, 병원 종류로 병원 목록 검색하기
            $("#searchHosp").on("click", function(){
            	$("#hospInfoBox").css("display", "none");
            	
                var sidoCd = $("#sidoCd").val();
                if($("#sidoCd").val() == "0"){
                    sidoCd = "";
                }

                var sgguCd = $("#sgguCd").val();
                if($("#sgguCd").val() == "0"){
                    sgguCd = "";
                }

                var emdongNm = $("#emdongNm").val();
                if($("#emdongNm").val() == "0"){
                    emdongNm = "";
                }

                var yadmNm = $("#hospType").val();
                if($("#hospType").val() == "0"){
                    yadmNm = "";
                }

                console.log(sidoCd + " : " + sgguCd + " : " + emdongNm + " : " + yadmNm);

                $.ajax({
                    url:"${pageContext.request.contextPath}/hosp/getHosp.hp",
                    type:"post",
                    data:{
                        sidoCd:sidoCd,
                        sgguCd:sgguCd,
                        emdongNm:emdongNm,
                        yadmNm:yadmNm
                    },
                    dataType:"json"
                }).done(function(data){
                    console.log(data);  // 서버로부터 받은 병원 목록 출력해주기
                    removeMarkers();  // 새로운 검색 결과를 다시 표시하기 위해 지도에 표시되어있는 마커 제거하기

                    // 병원 상세정보 창 비우기
                    $("#hospName").html("");
            		$("#hospAddr").html("");
            		$("#hospTel").html("");
            		$("#hospUrl").html("");
                    
                    if(data.length > 0){
                        for(var i = 0; i < data.length; i++){
                            var lat = Number(data[i].yPos);  // 위도는 y좌표
                            var lng = Number(data[i].xPos);  // 경도는 x좌표
                            var hospData = data[i];
                            
                            addMarker(new kakao.maps.LatLng(lat, lng), hospData);  // 지도 위에 마커 표시
                        }

                        var centerLat = Number(data[0].yPos);
                        var centerLng = Number(data[0].xPos);

                        setCenter(centerLat, centerLng);  // 검색된 병원 목록 중 첫 번째 병원으로 중심좌표 이동
                        map.setLevel(6);  // 지도의 확대 수준 설정
                    }
                    else{
                        alert("검색 조건에 해당하는 병원이 없습니다.");
                    }
                }).fail(function(a, b, c){
                    console.log(a);
                    console.log(b);
                    console.log(c);
                })
            })
        </script>
    </body>
</html>