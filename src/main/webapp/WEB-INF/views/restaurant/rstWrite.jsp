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
		
		<title>혼밥 / 혼술 글 작성</title>
		
		<link rel="stylesheet" href="/css/nav.css">
		<link rel="stylesheet" href="/css/footer.css">
        <style>
        	/* 지도에 적용되는 CSS */
        	.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
            .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
            .map_wrap {width:100%;height:500px;}
            #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
            .bg_white {background:#fff;}
            #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
            #menu_wrap .option{text-align: center;}
            #menu_wrap .option p {margin:10px 0;}  
            #menu_wrap .option button {margin-left:5px;}
            #placesList li {list-style: none;}
            #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
            #placesList .item span {display: block;margin-top:4px;}
            #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
            #placesList .item .info{padding:10px 0 10px 55px;}
            #placesList .info .gray {color:#8a8a8a;}
            #placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
            #placesList .info .tel {color:#009900;}
            #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
            #placesList .item .marker_1 {background-position: 0 -10px;}
            #placesList .item .marker_2 {background-position: 0 -56px;}
            #placesList .item .marker_3 {background-position: 0 -102px}
            #placesList .item .marker_4 {background-position: 0 -148px;}
            #placesList .item .marker_5 {background-position: 0 -194px;}
            #placesList .item .marker_6 {background-position: 0 -240px;}
            #placesList .item .marker_7 {background-position: 0 -286px;}
            #placesList .item .marker_8 {background-position: 0 -332px;}
            #placesList .item .marker_9 {background-position: 0 -378px;}
            #placesList .item .marker_10 {background-position: 0 -423px;}
            #placesList .item .marker_11 {background-position: 0 -470px;}
            #placesList .item .marker_12 {background-position: 0 -516px;}
            #placesList .item .marker_13 {background-position: 0 -562px;}
            #placesList .item .marker_14 {background-position: 0 -608px;}
            #placesList .item .marker_15 {background-position: 0 -654px;}
            #pagination {margin:10px auto;text-align: center;}
            #pagination a {display:inline-block;margin-right:10px;}
            #pagination .on {font-weight: bold; cursor: default;color:#777;}
        	
        	
        	        	
        	/* 작성 폼에 적용되는 CSS */
            *{
                box-sizing: border-box;
            }
            body {
				background-color: #f7f7ef;
			}
            
            #frmContainer, #addContainer, #submitContainer{
                width: 500px;
                margin: auto;
            }
            #mapContainer{
            	width: 800px;
            	margin: auto;
            }
            
            #titleArea{
                padding: 0px;
            }
            #title{
                border: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 40px;
                font-size: 18px;
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

            .filesArea{
                text-align: center;
            }
            .filesLabel{
                border: 2px dashed #0085cb;
                border-radius: 5px;
                cursor: pointer;
                color: #0085cb;
                background-color: white;
                width: 100px;
                line-height: 50px;
                margin-bottom: 25px;
            }
            .filesLabel:hover{
                background-color: #cceeff;
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
            .contentsTmp{
                border-top: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 100px;
                overflow-y: scroll;
            }
            .contents{
                width: 100%;
                resize: none;
            }

            #addArea{
                text-align: center;
            }
            #addBtn{
                border: 2px dashed #0085cb;
                border-radius: 5px;
                cursor: pointer;
                color: #0085cb;
                background-color: white;
                width: 200px;
                height: 100px;
                font-size: 30px;
            }
            #addBtn:hover{
                background-color: #cceeff;
            }
            
            #mapBox{
            	border: 1px solid #b2b2b2;
            }
            #mapSearchArea{
            	text-align: center;
            }
            #mapSearchLabel{
            	border: 2px dashed #0085cb;
                border-radius: 5px;
                cursor: pointer;
                color: #0085cb;
                background-color: white;
                width: 200px;
                line-height: 50px;
                margin-bottom: 25px;
            }
            #mapSearchLabel:hover{
            	background-color: #cceeff;
            }
            #searchBtn{
            	/* width: 60px;
            	height: 20px; */
            }
            
            #mapArea{
            	border-top: 1px dashed #b2b2b2;
            	border-bottom: 1px dashed #b2b2b2;
            	margin-bottom: 30px;
            }
            
            #placeArea{
            	padding: 0px;
            }
            #placeLabel{
            	font-size: 12px;
            	margin-bottom: 0px;
            }
            #placeInfoBox{
            	display: none;
            	border-top: 1px solid #dadada;
            	background-color: #f7f7f7;
            	width: 100%;
            }
            #placeInfo{
            	margin: auto;
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
            .placeInput{
            	border: none;
            	background-color: #f7f7f7;
            }
            
            .validCheck {
                font-size: 12px;
            }
            
            #submitArea{
                text-align: center;
            }
            .btns{
                border: none;
                border-radius: 5px;
                cursor: pointer;
                color: white;
                background-color: #0085cb;
            }
            .submitBtns{
            	width: 100px;
                height: 40px;
                font-size: 16px;
            }
            #cancelBtn{
                background-color: #e05252;
            }
        </style>
    </head>
    <body>
    	<c:choose>
            <c:when test="${loginInfo==null}">
                <script>
                    alert("로그인 후 이용하실 수 있습니다.");
                    location.href="${pageContext.request.contextPath}/member/login.mem";
                </script>		
            </c:when>
		</c:choose>
    
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    	
    	<br><br><br>
    	<div id="mainWrapper">
	        <form action="${pageContext.request.contextPath}/restaurant/rstWriteProc.rst" method="post" id="frm" enctype="multipart/form-data" onsubmit="return validCheck()">
	           
	            <div id="frmContainer">
	                <div class="container" id="titleBox">
	                    <div class="row">
	                        <div class="col-12" id="titleArea">
	                            <input type="text" id="title" name="title" placeholder=" 제목" >
	                            <span class="validCheck" id="titleCheck"></span>
	                        </div>
	                    </div>
	                </div>
	                <br>
	
	                <div class="container writeBox">
	                    <br>
	                    <div class="row">
	                        <div class="col-12 filesArea">
	                            <label class="filesLabel">사진 선택</label>
	                            <input type="file" class="files" name="files" hidden>
	                        </div>
	                        <div class="col-12 imgArea">
	                            <img src="" alt="" class="imgs">
	                        </div>
	                        <div class="col-12 contentsArea">
	                            <label class="contentsLabel"><b>사진에 대한 설명을 작성하세요. (생략 가능)</b></label>
	                            <div class="contentsTmp" contenteditable="true"></div>
	                            <span class="validCheck contentsCheck"></span>
	                            <textarea class="contents" name="contents" placeholder=" 내용" hidden></textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div id="addContainer">
	                <div class="container" id="addBox">
	                    <div class="row">
	                        <div class="col-12" id="addArea">
	                            <button type="button" id="addBtn">추가 입력</button>
	                        </div>
	                    </div>
	                </div>
	                <hr>
	            </div>
	            
	            <div id="mapContainer">
	            	<div class="container" id="mapBox">
	                    <br>
	                    <div class="row">
	                    	<div class="col-12" id="mapSearchArea">
	                    		<label for="keyword" id="mapSearchLabel">혼밥 / 혼술집 위치 검색</label>
	                    	</div>
	                        <div class="col-12 map_wrap" id="mapArea">
	                            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	
					            <div id="menu_wrap" class="bg_white">
					                <div class="option">
					                    <div>
											키워드 : <input type="text" id="keyword" size="14" placeholder=" 검색어 입력 "> 
											<button type="button" id="searchBtn">검색하기</button> 
					                    </div>
					                </div>
					                <hr>
					                <ul id="placesList"></ul>
					                <div id="pagination"></div>
					            </div>
	                        </div>
	                        <div class="col-12" id="placeArea">
		                        <label id="placeLabel"><b>혼밥 / 혼술집 위치를 등록하세요. (필수 입력)</b></label>
		                        <div id="placeInfoBox">
			                        <table id="placeInfo">
										<tbody>
			                        		<tr>
			                        			<td class="placeKey">장소명</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="placeName" name="placeName" readonly></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">지번 주소</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="jibunAddr" name="jibunAddr" readonly></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">도로명 주소</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="roadAddr" name="roadAddr" readonly></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">전화번호</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="placePhone" name="placePhone" readonly></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">상세정보</td>
			                        			<td class="placeVal" id="placeUrlTmp"></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">x좌표</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="xPos" name="xPos" readonly></td>
			                        		</tr>
			                        		<tr>
			                        			<td class="placeKey">y좌표</td>
			                        			<td class="placeVal"><input type="text" class="placeInput" id="yPos" name="yPos" readonly></td>
											</tr>
										</tbody>
									</table>
									<input type="text" class="placeInput" id="placeUrl" name="placeUrl" hidden>
								</div>
	                        </div>
	                        <br>
	                    </div>
	                </div>
	                <hr>
	            </div>
	
				<div id="submitContainer">
	                <div class="container" id="submitBox">
	                    <div class="row">
	                        <div class="col-12" id="submitArea">
	                            <input type="submit" class="btns submitBtns" id="submitBtn" value="작성">
	                            <button type="button" class="btns submitBtns" id="cancelBtn">취소</button>
	                        </div>
	                    </div>
	                </div>
				</div>
	        </form>
    	</div>
		<br><br><br>
		
		<jsp:include page="/resources/jsp/footer.jsp" />

        <script>
            // 라벨을 클릭하면 숨겨진 input[type="file"]이 클릭되게 하는 함수
            $("#frmContainer").on("click", ".filesLabel", function(){
                var labelNum = $(".filesLabel").index(this);
                console.log("라벨 번호 : " + labelNum);
                $($(".files")[labelNum]).click();
            })



//            var selectedFile;  // 선택된 파일 정보를 알기 위한 변수???
            $("#frmContainer").on("change", ".files", handleImg);

            // input[type="file"]에 선택된 사진을 미리 볼 수 있게 해주는 함수
            function handleImg(e){
                var filesNum = $(".files").index(this);
                console.log("폼 번호 : " + filesNum);

                var files = e.target.files;
                var filesArr = Array.prototype.slice.call(files);

                filesArr.forEach(function(f){
                    if(!f.type.match("image.*")){
                        alert("이미지 확장자만 가능합니다.");
                        return;
                    }

//                    selectedFile = f;
//                    console.log("선택된 파일 정보 : " + selectedFile);

                    var reader = new FileReader();
                    reader.onload = function(e){
                        $($(".imgs")[filesNum]).attr("src", e.target.result);
                    }
                    reader.readAsDataURL(f);
                })
            }



            // 업로드하는 사진의 크기를 조정해주는 함수
            /* $("img").each(function(){
                $(this).on("load", function(){
                    var imgWidth = this.naturalWidth;
                    var imgHeight = this.naturalHeight;
                    console.log("사진의 가로 길이 : " + imgWidth);
                    console.log("사진의 세로 길이 : " + imgHeight);
                    console.log("");

                    $(this).css("width", "");
                    $(this).css("height", "");

                    if(imgWidth < 400 && imgHeight < 400){
                        return;
                    }
                    else{
                        if(imgWidth > imgHeight){
                            $(this).css("width", "400px");
                        }
                        else{
                            $(this).css("height", "400px");
                        }
                    }
                })
            }) */


            
            // 동적으로 입력 양식을 추가해주는 함수
            $("#addBtn").on("click", function(){
                $("#frmContainer").append('<div class="container writeBox">' +
                                                '<div class="row">' + 
                                                    '<div class="col-12 removeArea">' +
                                                        '<button type="button" class="removeBtn">x</button>' +
                                                    '</div>' +
                                                '</div>' +
                                                '<div class="row">' +
                                                    '<div class="col-12 filesArea">' +
                                                        '<label class="filesLabel">사진 선택</label>' +
                                                        '<input type="file" class="files" name="files" hidden>' +
                                                    '</div>' +
                                                    '<div class="col-12 imgArea">' +
                                                        '<img src="" alt="" class="imgs">' +
                                                    '</div>' +
                                                    '<div class="col-12 contentsArea">' +
                                                        '<label class="contentsLabel"><b>사진에 대한 설명을 작성하세요. (생략 가능)</b></label>' +
                                                        '<div class="contentsTmp" contenteditable="true"></div>' +
                                                        '<span class="validCheck contentsCheck"></span>' +
                                                        '<textarea class="contents" name="contents" placeholder=" 내용" hidden></textarea>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>');

                // 업로드하는 사진의 크기를 조정해주는 함수
                // 동적 요소에 포함된 사진에도 적용시키기 위해 append 해주는 함수 내부에 한번 더 정의함
                /* $("img").each(function(){
                    $(this).on("load", function(){
                        var imgWidth = this.naturalWidth;
                        var imgHeight = this.naturalHeight;
                        console.log("사진의 가로 길이 : " + imgWidth);
                        console.log("사진의 세로 길이 : " + imgHeight);
                        console.log("");

                        $(this).css("width", "");
                        $(this).css("height", "");

                        if(imgWidth < 400 && imgHeight < 400){
                            return;
                        }
                        else{
                            if(imgWidth > imgHeight){
                                $(this).css("width", "400px");
                            }
                            else{
                                $(this).css("height", "400px");
                            }
                        }
                    })
                }) */
            })
            
            
            
            // 추가된 폼을 삭제하는 함수
            $("#frmContainer").on("click", ".removeBtn", function(){
                $(this).closest(".writeBox").remove();
            })
            
            
            
            // 제목 길이 유효성 검사 변수
            var validTitle = 0;
            
            // 제목 길이 유효성 검사
            $("#title").on("input", function(){
            	var title = $("#title").val();
            	var titleRegex = /^[\w\W]{0,50}$/;
            	var titleResult = titleRegex.exec(title);
            	
            	if(titleResult != null){
            		$("#titleCheck").html("");
            		validTitle = 1;
            	}
            	else{
            		$("#titleCheck").html("50글자 이내로 작성해야 합니다.").css("color", "red");
            		validTitle = 0;
            	}
            })
            
            // 내용 길이 유효성 검사
            $("#frmContainer").on("input", ".contentsTmp", function(){
            	var contentsNum = $(".contentsTmp").index(this);
            	console.log("내용 번호 : " + contentsNum);
            	
            	var contents = $(this).html();
            	var contentsRegex = /^[\w\W]{0,1000}$/;
            	var contentsResult = contentsRegex.exec(contents);
            	
            	if(contentsResult != null){
            		$($(".contentsCheck")[contentsNum]).html("");
            	}
            	else{
            		$($(".contentsCheck")[contentsNum]).html("1000글자 이내로 작성해야 합니다.").css("color", "red");
            	}
            })
            
            
            
            // 제목, 사진, 주소를 등록했는지 검사하는 함수
            function validCheck(){
            	
            	// 유효성 변수 확인
                console.log("제목 검사 : " + validTitle);
                console.log("");
            	
                var title = $("#title").val();
            	var boxLength = $(".writeBox").length;
            	var place = $("#placeName").val();
                
                if(title == ""){
                	alert("제목을 입력하세요.");
                	$("#title").focus();
                	return false;
                }
                
                for(var i = 0; i < boxLength; i++){
                    if($($(".imgs")[i]).attr("src") == ""){
                        alert("입력하지 않은 사진란이 있습니다.");
                        $(".filesArea")[i].scrollIntoView();
                        return false;
                    }
                }
                
                if(place == ""){
                	alert("주소를 등록하세요.");
                	$("#keyword").focus();
                	return false;
                }
                
                if(validTitle != 1){
                    alert("제목의 글자 수를 확인해주세요.");
                    $("#title").focus();
                    return false;
                }
                
                for(var i = 0; i < boxLength; i++){
                	if($($(".contentsTmp")[i]).html().length > 1000){
                		alert("내용의 글자 수를 확인해주세요.");
                		$(".contentsTmp")[i].scrollIntoView();
                		return false;
                	}
                }
                
                for(var i = 0; i < boxLength; i++){
                    $($(".contents")[i]).val($($(".contentsTmp")[i]).html());
                    if($($(".contentsTmp")[i]).html() == ""){
                    	$($(".contents")[i]).val(" ");
                    }
                }
                
                return confirm("글을 작성하시겠습니까?");
            }
            
            $("#cancelBtn").on("click", function(){
                var cancelConfirm = confirm("글 작성을 취소하시겠습니까?");
                
                if(cancelConfirm == true){
                	location.href="${pageContext.request.contextPath}/restaurant/rstListY.rst";
                }
            })
            
            
            
            //////////////////////////////////////////////////
            //////////////////////////////////////////////////
            // 지도 관련 JS
            
            
            
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.568101, 126.983053), // 지도의 중심좌표
                    level: 4 // 지도의 확대 레벨
                };  

            // 지도 생성
            var map = new kakao.maps.Map(mapContainer, mapOption); 

            // 장소 검색 객체 생성
            var ps = new kakao.maps.services.Places();

            // 마커를 담을 배열
            var markers = [];

            // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우 생성
            var infowindow = new kakao.maps.InfoWindow({zIndex:1});
            
         	// '검색하기' 버튼을 클릭하면 검색 요청 함수 실행
            $("#searchBtn").on("click", searchPlaces);

            // 키워드 검색을 요청하는 함수
            function searchPlaces() {
            	$("#placeInfoBox").css("display", "none");
            	$("#placeName").val("");
            	$("#jibunAddr").val("");
            	$("#roadAddr").val("");
            	$("#placePhone").val("");
            	$("#placeUrl").val("");
            	$("#placeUrlTmp").html("");
            	$("#xPos").val("");
            	$("#yPos").val("");
            	
                var keyword = document.getElementById('keyword').value;

                if (!keyword.replace(/^\s+|\s+$/g, '')) {
                    alert('키워드를 입력해주세요!');
                    return false;
                }

                // 장소검색 객체를 통해 키워드로 장소검색을 요청
                ps.keywordSearch(keyword, placesSearchCB); 
            }

            // 장소검색이 완료됐을 때 호출되는 콜백함수
            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면  검색 목록과 마커를 표출
                    displayPlaces(data);

                    // 페이지 번호를 표출
                    displayPagination(pagination);

                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                    alert('검색 결과가 존재하지 않습니다.');
                    return;

                } else if (status === kakao.maps.services.Status.ERROR) {

                    alert('검색 결과 중 오류가 발생했습니다.');
                    return;

                }
            }

            // 검색 결과 목록과 마커를 표출하는 함수
            function displayPlaces(places) {

                var listEl = document.getElementById('placesList'), 
                    menuEl = document.getElementById('menu_wrap'),
                    fragment = document.createDocumentFragment(), 
                    bounds = new kakao.maps.LatLngBounds(), 
                    listStr = '';

                // 검색 결과 목록에 추가된 항목들을 제거
                removeAllChildNods(listEl);

                // 지도에 표시되고 있는 마커를 제거
                removeMarker();

                for ( var i=0; i<places.length; i++ ) {

                    // 마커를 생성하고 지도에 표시
                    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                        marker = addMarker(placePosition, i), 
                        itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가
                    bounds.extend(placePosition);

                    // 마커와 검색결과 항목에 
                    // mouseover 했을 때 해당 장소에 인포윈도우에 장소명을 표시, 
                    // mouseout 했을 때 인포윈도우를 닫음, 
                    // click 했을 때 상세정보를 출력
                    (function(marker, place) {
                        kakao.maps.event.addListener(marker, 'mouseover', function() {
                            displayInfowindow(marker, place);
                        });

                        kakao.maps.event.addListener(marker, 'mouseout', function() {
                            infowindow.close();
                        });

                        kakao.maps.event.addListener(marker, 'click', function(){
                            printInfowindow(marker, place);
                        })
                        
                        itemEl.onmouseover = function () {
                            displayInfowindow(marker, place);
                        };

                        itemEl.onmouseout = function () {
                            infowindow.close();
                        };
                        
                        itemEl.onclick = function () {
                            printInfowindow(marker, place);
                        }
                    })(marker, places[i]);

                    fragment.appendChild(itemEl);
                }

                // 검색결과 항목들을 검색결과 목록 Elemnet에 추가
                listEl.appendChild(fragment);
                menuEl.scrollTop = 0;

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정
                map.setBounds(bounds);
            }

            // 검색결과 항목을 Element로 반환하는 함수
            function getListItem(index, places) {

                var el = document.createElement('li'),
                    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                    '<div class="info"><h5>' + places.place_name + '</h5>';

                if (places.road_address_name) {
                    itemStr += '<span class="road gray">' + places.road_address_name + '</span>' +
                        '<span class="jibun gray">' +  places.address_name  + '</span>';
                } else {
                    itemStr += '<span>' +  places.address_name  + '</span>'; 
                }

                itemStr += '<span class="tel">' + places.phone  + '</span></div>';           

                el.innerHTML = itemStr;
                el.className = 'item';

                return el;
            }

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수
            function addMarker(position, idx, title) {
                var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 사용
                    imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                    imgOptions =  {
                        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage 
                    });

                marker.setMap(map); // 지도 위에 마커를 표출
                markers.push(marker);  // 배열에 생성된 마커를 추가

                return marker;
            }

            // 지도 위에 표시되고 있는 마커를 모두 제거
            function removeMarker() {
                for ( var i = 0; i < markers.length; i++ ) {
                    markers[i].setMap(null);
                }   
                markers = [];
            }

            // 검색결과 목록 하단에 페이지번호를 표시는 함수
            function displayPagination(pagination) {
                var paginationEl = document.getElementById('pagination'),
                    fragment = document.createDocumentFragment(),
                    i; 

                // 기존에 추가된 페이지번호를 삭제
                while (paginationEl.hasChildNodes()) {
                    paginationEl.removeChild (paginationEl.lastChild);
                }

                for (i=1; i<=pagination.last; i++) {
                    var el = document.createElement('a');
                    el.href = "#";
                    el.innerHTML = i;

                    if (i===pagination.current) {
                        el.className = 'on';
                    } else {
                        el.onclick = (function(i) {
                            return function() {
                                pagination.gotoPage(i);
                            }
                        })(i);
                    }

                    fragment.appendChild(el);
                }
                paginationEl.appendChild(fragment);
            }

            // 검색결과 목록 또는 마커에 마우스를 올렸을 때 인포윈도우에 장소명을 표시
            function displayInfowindow(marker, place) {
                var content = '<div style="padding:5px;z-index:1;">' + place.place_name + '</div>';

                infowindow.setContent(content);
                infowindow.open(map, marker);
            }

            // 검색결과 목록의 자식 Element를 제거하는 함수
            function removeAllChildNods(el) {   
                while (el.hasChildNodes()) {
                    el.removeChild (el.lastChild);
                }
            }
            
         	// 검색결과 목록 또는 마커를 클릭했을 때 정보를 출력
            function printInfowindow(marker, place) {
                console.log(place);
                
                $("#placeInfoBox").css("display", "block");
                $("#placeName").val(place.place_name);
                $("#jibunAddr").val(place.address_name);
                $("#roadAddr").val(place.road_address_name);
                $("#placePhone").val(place.phone);
                $("#placeUrl").val(place.place_url);
                $("#placeUrlTmp").html("<a href='" + place.place_url + "' target='_blank'>식당 상세정보</a>");
                $("#xPos").val(place.x);
                $("#yPos").val(place.y);
            }
            
         	
         	
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