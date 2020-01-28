<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>랜선집들이 게시판</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/nav.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
img {
	height: 150px;
	width: 100%;
}

div [class^="col-"] {
	padding-left: 5px;
	padding-right: 5px;
}

.card {
	transition: 0.5s;
	cursor: pointer;
}

.card-title {
	font-size: 15px;
	transition: 1s;
	cursor: pointer;
}

.card-title i {
	font-size: 15px;
	transition: 1s;
	cursor: pointer;
	color: #ffa710
}

.card-title i:hover {
	transform: scale(1.25) rotate(100deg);
	color: #18d4ca;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 10px 10px 15px rgba(0, 0, 0, 0.3);
}

.card-text {
	height: 80px;
}

.card::before, .card::after {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	transform: scale3d(0, 0, 1);
	transition: transform .3s ease-out 0s;
	background: rgba(255, 255, 255, 0.1);
	content: '';
	pointer-events: none;
}

.card::before {
	transform-origin: left top;
}

.card::after {
	transform-origin: right bottom;
}

.card:hover::before, .card:hover::after, .card:focus::before, .card:focus::after
	{
	transform: scale3d(1, 1, 1);
}
</style>
<script type="text/javascript">
        var curPage = 1; //현재 페이지
		
        $(function() {
            $(window).scroll(function() {
                var total = ${total} //총 페이지
                if(curPage <= total){ //현재 페이지가 전체 페이지와 비교
                	if (Math.ceil($(window).scrollTop()) >= Math.round($(document).height() - $(window).height())) {
                        window.scrollTo(0, $(window).scrollTop() -20); //하단에서 -20 위에로 이동; 
                        curPage++; // 현재 페이지에서 +1 처리.
                    	getContent();
                        //ajax 호출
                    }
                }
                
            	
            }) 
            
            $("#btnWrite").on("click", function() {
				location.href="${pageContext.request.contextPath}/house/houseWriter";
			})
        })

        function getContent() {
            $.ajax({
                url: "/house/getHouseContent",
                type: "post",
                data: {
                    curPage: curPage
                },
                dataType: "JSON",
            }).done(function(data) {
                for (var i = 0; i < data.length; i++) {
                    $("#mark").before
                    (
						"<div class='col-md-3 col-sm-6 mt-5 mr-5' onclick='detailContent( " + data[i].SEQ + ")'>                             <div class='card card-block' >                                 <!-- <h4 class='card-title text-right'><i class='material-icons'>settings</i></h4> -->                                 <img src='/files/" + data[i].SYSNAME + "' alt='${map.ORINAME}'>                                 <h3 class='card-title mt-2 text-center'>                                     <b>" + data[i].TITLE + "</b>                                 </h3>                                 <h6 class='card-subtitle mb-2 text-muted'>작성자 " + data[i].WRITER + " 조회수 " + data[i].VIEWCOUNT + "</h6>                             </div>                         </div>"
                    );
				}
            
                
            }).fail(function(a, b, c) {
                console.log(a);
                console.log(b);
                console.log(c);
            });
        }
        
        function detailContent(seq) {
			location.href = "/house/houseDetail?seq=" + seq;
		}

    </script>
</head>

<body>
	<jsp:include page="/resources/jsp/nav.jsp" />
	<div id="mainWrapper">
		<br>
		<h1 style="text-align:center;">랜선 집들이</h1>
		<br>
		<h4 style="text-align:center;">회원님의 집을 소개해 보세요!</h4>
		<br>
		<p style="text-align:center;"><button type="button" class="btn btn-info" id="btnWrite">작성하기</button></p>
		<div class="container mt-2">
			<!--   <div class="card card-block mb-2">
    <h4 class="card-title">Card 1</h4>
    <p class="card-text">Welcom to bootstrap card styles</p>
    <a href="#" class="btn btn-primary">Submit</a>
  </div>   -->
			<div class="row ml-5">
				<c:choose>
					<c:when test="${list ne null}">
						<c:forEach items="${list}" var="map">
							<div class="col-md-3 col-sm-6 mt-5  mr-5"
								onclick="detailContent(${map.SEQ})">
								<div class="card card-block">
									<!-- <h4 class="card-title text-right"><i class="material-icons">settings</i></h4> -->
									<img src="/files/${map.SYSNAME}" alt="${map.ORINAME}">
									<h3 class="card-title mt-2 text-center">
										<b>${map.TITLE}</b>
									</h3>
									<h6 class="card-subtitle mb-2 text-muted">작성자
										${map.WRITER} 조회수 ${map.VIEWCOUNT}</h6>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<h4 class="card-title">없음</h4>
					</c:otherwise>
				</c:choose>
				<div id="mark"></div>

			</div>
		</div>
	</div>
	<jsp:include page="/resources/jsp/footer.jsp" />
	
</body>

</html>
