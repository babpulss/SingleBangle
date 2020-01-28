<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
              integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
              crossorigin="anonymous">

        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" 
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" 
                crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" 
                crossorigin="anonymous"></script>

        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea7c69cd1bf56d37c0df13609580d2bd&libraries=services"></script>

        <title>혼밥 / 혼술 - ${dto.title}</title>
        
        <link rel="stylesheet" href="/css/nav.css">
        <link rel="stylesheet" href="/css/footer.css">
        <style>
            *{
                box-sizing: border-box;
            }
            #frmContainer, #btnContainer{
                width: 500px;
                margin: auto;
            }
            #mapContainer{
                width: 500px;
                margin: auto;
            }

            #titleArea{
                border-bottom: 1px solid #dadada;
                font-size: 18px;
                padding: 0px;
            }
            #writerArea{
                font-size: 12px;
                padding: 0px;
            }
            #dateArea{
                text-align: right;
                font-size: 12px;
                padding: 0px;
            }

            .writeBox{
                border: 1px solid #b2b2b2;
                margin-bottom: 40px;
            }

            .removeArea{
                text-align: right;
                padding: 0px;
            }
            .removeBtn{
                border: none;
                cursor: pointer;
                color: #e05252;
                background-color: white;
                line-height: 20px;
                font-size: 30px;
            }

            .imgArea{
                border-top: 1px dashed #b2b2b2;
                border-bottom: 1px dashed #b2b2b2;
                height: 405px;
                line-height: 400px;
                text-align: center;
                padding: 0px;
                margin-bottom: 30px;
            }
            .imgs{
                max-width: 400px;
                max-height: 400px;
            }

            .contentsArea{
                padding: 0px;
            }
            .contentsLabel{
                font-size: 12px;
                margin-bottom: 0px;
            }
            .contents{
                border: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 100px;
                overflow-y: auto;
            }

            #mapBox{
                border: 1px solid #b2b2b2;
            }
            #mapLocationArea{
                text-align: center;
            }
            #mapLocationLabel{
                background-color: white;
                line-height: 50px;
                margin-bottom: 20px;
            }

            #mapArea{
                border-top: 1px dashed #b2b2b2;
                border-bottom: 1px dashed #b2b2b2;
                height: 400px;
                margin-bottom: 30px;
                padding: 0px;
            }

            #placeArea{
                padding: 0px;
            }
            #placeLabel{
                font-size: 12px;
                margin-bottom: 0px;
            }
            #placeInfoBox{
                border-top: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
            }
            #placeInfo{
                /* margin: auto; */
            }
            .placeKey{
                width: 120px;
                height: 40px;
                background-color: #e0e0e0;
                margin-bottom: 5px;
                padding-right: 10px;
                text-align: right;
            }
            .placeVal{
                min-width: 360px;
                padding-left: 10px;
            }

            #btnArea{
                text-align: center;
            }
            .btns{
                border: none;
                border-radius: 5px;
                cursor: pointer;
                color: white;
                background-color: #0085cb;
                width: 100px;
                height: 40px;
                font-size: 16px;
            }
            #backBtn{
                /* background-color: #e05252; */
            }
            #deleteBtn{
            	background-color: #e05252;
            }
        </style>
    </head>
    <body>
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    	
        <br><br><br>
		<div id="mainWrapper">
	        <div id="frmContainer">
	            <div class="container" id="titleBox">
	                <div class="row">
	                    <div class="col-12" id="titleArea">
	                        <b>${dto.title}</b>
	                    </div>
	                    <div class="col-9" id="writerArea">
	                        <b>${dto.writer}</b>
	                    </div>
	                    <div class="col-3" id="dateArea">
	                        <b>${dto.getFormedDate2()}</b>
	                    </div>
	                </div>
	            </div>
	            <br>
	
	            <c:choose>
	                <c:when test="${filesList.size() > 0}">
	                    <c:forEach items="${filesList}" var="fileDto">
	                        <div class="container writeBox">
	                            <br>
	                            <div class="row">
	                                <div class="col-12 imgArea">
	                                    <img src="/files/${fileDto.sysName}" alt="" class="imgs">
	                                </div>
	                                <div class="col-12 contentsArea">
	                                    <label class="contentsLabel"><b>사진 설명</b></label>
	                                    <div class="contents">${fileDto.contents}</div>
	                                </div>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </c:when>
	            </c:choose>
	        </div>
	
	        <div id="mapContainer">
	            <div class="container" id="mapBox">
	                <br>
	                <div class="row">
	                    <div class="col-12" id="mapLocationArea">
	                        <label id="mapLocationLabel"><h3><<위치 정보>></h3></label>
	                    </div>
	                    <div class="col-12 map_wrap" id="mapArea">
	                        <div id="map" style="width:100%;height:100%;overflow:hidden;"></div>
	                    </div>
	                    <div class="col-12" id="placeArea">
	                        <label id="placeLabel"><b>혼밥 / 혼술집 상세정보</b></label>
	                        <div id="placeInfoBox">
	                            <table id="placeInfo">
	                                <tbody>
	                                    <tr>
	                                        <td class="placeKey">장소명</td>
	                                        <td class="placeVal">${dto.placeName}</td>
	                                    </tr>
	                                    <tr>
	                                        <td class="placeKey">지번 주소</td>
	                                        <td class="placeVal">${dto.jibunAddr}</td>
	                                    </tr>
	                                    <tr>
	                                        <td class="placeKey">도로명 주소</td>
	                                        <td class="placeVal">${dto.roadAddr}</td>
	                                    </tr>
	                                    <tr>
	                                        <td class="placeKey">전화번호</td>
	                                        <td class="placeVal">${dto.placePhone}</td>
	                                    </tr>
	                                    <tr>
	                                        <td class="placeKey">상세정보</td>
	                                        <td class="placeVal" id="placeUrl"><a href="${dto.placeUrl}" target="_blank">식당 상세정보</a></td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                    <br>
	                </div>
	            </div>
	            <hr>
	        </div>
	
	        <div id="btnContainer">
	            <div class="container" id="btnBox">
	                <div class="row">
	                    <div class="col-12" id="btnArea">
	                        <button type="button" class="btns" id="backBtn">돌아가기</button>
	                        
	                        <c:choose>
					            <c:when test="${loginInfo.adminCheck=='Y'}">
			                        <button type="button" class="btns" id="approvalBtn">승인</button>
			                        <button type="button" class="btns" id="deleteBtn">삭제</button>
			                        
			                        <script>
			                        	$("#approvalBtn").on("click", function(){
			                        		var approvalConfirm = confirm("해당 글을 승인하시겠습니까?");
			                        		
			                        		if(approvalConfirm == true){
			                        			location.href="${pageContext.request.contextPath}/restaurant/rstApproval.rst?seq=${dto.seq}";
			                        		}
			                        	})
			                        	
			                        	$("#deleteBtn").on("click", function(){
			                        		var deleteConfirm = confirm("해당 글을 삭제하시겠습니까?");
			                        		
			                        		if(deleteConfirm == true){
			                        			location.href="${pageContext.request.contextPath}/restaurant/rstDelete.rst?seq=${dto.seq}";
			                        		}
			                        	})
			                        </script>
					            </c:when>
					        </c:choose>
					        
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
        <br><br><br>
        
        <jsp:include page="/resources/jsp/footer.jsp" />

        <script>
            console.log("사진 개수 : " + ${filesList.size()});    

            $("#backBtn").on("click", function(){
            	history.back();
            })



            var x = Number(${dto.xPos});
            var y = Number(${dto.yPos});
            console.log(x);
            console.log(y);

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

            // 지도 생성
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 마커가 표시될 위치
            var markerPosition  = new kakao.maps.LatLng(y, x); 
            
         	// 마커 이미지의 주소
            var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
         	
         	// 마커 이미지의 크기
         	var imageSize = new kakao.maps.Size(24, 35);
         	
         	// 마커 이미지 생성
         	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

            // 마커 생성
            var marker = new kakao.maps.Marker({
                position: markerPosition,
                image: markerImage
            });

            // 마커가 지도 위에 표시되도록 설정
            marker.setMap(map);

            // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성
            var iwContent = '<div style="width:200px; padding:5px;">${dto.placeName}</div>';

            // 인포윈도우를 생성
            var infowindow = new kakao.maps.InfoWindow({
                content : iwContent
            });

            // 마커에 마우스오버 이벤트를 등록
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시
                infowindow.open(map, marker);
            });

            // 마커에 마우스아웃 이벤트를 등록
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거
                infowindow.close();
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