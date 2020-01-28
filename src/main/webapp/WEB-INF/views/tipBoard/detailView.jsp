<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/css/footer.css">
 <style>

        html, body { margin: 0px; padding: 0px;}
        * {
            box-sizing: border-box; 
 	        font-family: 'BMHANNAAir'; 
       }
        #board {
            margin: 65px 110px 0 110px;
        }
        #bHeader {
            background-color: #0085cb;
            border-radius: 10px 10px 0 0;
        }
        .bRow {
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }
        .bRow * {
            line-height: 50px;
            text-align: center;
        }
        .bRow>span:first-child {
            flex-basis: 10%;
        }
        .bRow>span:nth-child(2) {
            flex-basis: 50%;
        }
        .bRow>span:nth-child(3) {
            flex-basis: 10%;
            text-align: left;
        }
        .bRow a {
            text-decoration: none;
        }
        .bRow>span:nth-child(4) {
            flex-basis: 20%;
        }
        .bRow>span:last-child {
            flex-basis: 10%;
        }
        .bRow:last-child {
            border-radius: 0 0 10px 10px;
            background-color: #e05252;
        }
        #btns {
            margin: 20px 110px 0 110px;
            display: flex;
            justify-content: space-between;
        }
        #btns>button:first-child, #btns>div>button {
            border: none;
            width: 50px;
            height: 30px;
            border-radius: 10px;
        }
        #btns>div>input {
            width: 300px;
            height: 30px;
            border-radius: 10px;
            border: 1px solid gray;
        }
        #btns>button:last-child {
            border: none;
            width: 80px;
            height: 30px;
            border-radius: 10px;
        }
        @media ( max-width: 600px ) {
            #board {
                margin: 65px 0 0 0;
            }
            #bHeader {
                border-radius: 0;
            }
            .bRow>span:first-child {
                display: none;
            }
            #btns {
                margin: 20px 0 0 0;
            }
        }
        .pageNavi{
        	text-decoration: none;
        }
        .pageNavi:hover {
        	color: pink;
        }
        .titleList:hover{
        	color: #de8c98;
        }
        #line5 {
            min-height: 500px;
        }
        .index{
            background-color: #b3cee2;
        }
        #tipBtns button, #reportBtn{
            background-color: #7f93b4;
            border: none;
            color: white;
            width: 100px;
            font-size: 15px;
            border-radius: 10px;
            margin: 5px;
        }
        #tipContents{
        width: 800px;
        margin: 0px;
        }
        #tipContents div{
        box-sizing:border-box;
        margin:0px;
        }
        #wrapper{
        	width:830px;
        	margin: auto;
        }
        #line5{
        	background-color: #e6eff5;
        	padding: 10px;
        }
        .pageNavi:hover{
         cursor: pointer;
        }
        #wrapper>div{
        	width:800px;
        }
        #cmtOk{
        width: 110px;
        height: 74px;
       	background-color: #f0f7f7;
       	border: 1px solid gray;
       	shadow: none;
        }
        .replyUpdate:hover, .replyDelete:hover, .reUpdate:hover, .reCancel:hover{
        	cursor: pointer;
        	color: black;
        	text-decoration: none;
        }
        .replyDelete{
        text-decoration: none;
        color: black;
        }
     	.cmtContents{
     	border-bottom: 1px solid #cccccc;
     	}
    </style>
<script>
$(function(){
	//****동적바인딩****//
	$(document).on("click",".replyUpdate",function(){
// replyUpdate : 수정 / reUpdate : (수정)확인 / reDelete : 삭제 / reCancel : (수정)취소
		var oriContents = $(this).parent().siblings(".cmtContents").html();
		$(this).parent().siblings(".cmtContents").attr("contenteditable","true");
		$(this).parent().siblings(".cmtContents").attr("style","background-color: #f5f3ed");
		$(this).attr("hidden","true");
		$(this).siblings(".replyDelete").attr("hidden","true");
		$(this).siblings(".reUpdate").attr("hidden",false);
		$(this).siblings(".reCancel").attr("hidden",false);
		
			var seq = ($(this).attr("seq"));
		
		$(".reUpdate").on("click",function(){
			var contents = $(this).parent().siblings(".cmtContents").html();
			console.log(seq + " : " + contents);
			
			$("#updateContents").html(contents);
			$("#updateSeq").val(seq);
			$("#updateForm").submit();
		})
		
		$(".reCancel").on("click",function(){
			$(this).parent().siblings(".cmtContents").attr("contenteditable","false");
			$(this).parent().siblings(".cmtContents").attr("style","background-color:none");
			$(this).parent().siblings(".cmtContents").html(oriContents);
			$(this).siblings(".replyUpdate").attr("hidden",false);
			$(this).siblings(".replyDelete").attr("hidden",false);
			$(this).attr("hidden",true);
			$(this).siblings(".reUpdate").attr("hidden",true);
		})
	})
	getCommentList(); 
});
</script>

</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
<br><br><br><br>
<!-- 이제 여기서 ${detailView} 내용 꺼내기! -->
   <div id="wrapper">
        <div id="tipContents">
            <div class="row" id="line1">
                <div class="col-2 index">카테고리</div>
                <div class="col-4">
                    <c:choose>
                        <c:when test="${detailView.category == 1}">요리</c:when>
                        <c:when test="${detailView.category == 2}">청소</c:when>
                        <c:when test="${detailView.category == 3}">건강</c:when>
                        <c:when test="${detailView.category == 4}">동식물</c:when>
                        <c:otherwise>기타</c:otherwise>
                    </c:choose>
                </div>
                <div class="col-2 index">조회수</div>
                <div class="col-4">${detailView.viewCount}</div>
            </div>
            <div class="row" id="line2">
                <div class="col-2 index">작성자</div>
                <div class="col-4">${detailView.writer}</div>
                <div class="col-2 index">작성일</div>
                <div class="col-4">${detailView.formedDate}</div>
            </div>
            <div class="row" id="line3">
                <div class="col-6"></div>
                <div class="col-2 index">스크랩 수</div>
                <div class="col-1" id="scrapCount">${detailView.scrapCount}</div>
                <div class="col-2 index">좋아요 수</div>
                <div class="col-1" id="likeCount">${detailView.likeCount}</div>
            </div>
            <div class="row" id="line4">
                <div class="col-2 index">제목</div>
                <div class="col-10">${detailView.title}</div>
            </div>
            <br>
            <div class="row" id="line5">
                ${detailView.contents}
            </div>
            <br>
        </div> 
		<form action="replyUpdate.bo" method="post" id="updateForm">
			<textarea style="display:none" id="updateContents" name="contents"></textarea>
			<input type="hidden" id="updateSeq" name="seq">
		</form>
        <div id="tipIcon">
            <div class="row">
                <div class="col-9"></div>

                <div class="col-1" id="likeBtn">
                    <!-- 		로그인하지 않으면 좋아요 버튼이 안 보임!!!!  -->
                    <c:choose>
                        <c:when test="${loginInfo == null}"></c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${likeCheck == 1}">
                                    <button type="button" id="btnLike" style="border: 0px; outline: 0px; background-color: transparent;">
                                    <img id="heartImage" src="/img/tipBoard/coloredHeart.png" style="width: 30px; height: 30px;">
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" id="btnLike" style="border: 0px; outline: 0px; background-color: transparent;">
                                        <img id="heartImage" src="/img/tipBoard/heart.png" style="width: 30px; height: 30px;">
                                    </button>
                                </c:otherwise>
                            </c:choose>
                            <script>
                                //게시글 들어가서 좋아요 버튼 누름
                                $("#btnLike").on("click", function() {
                                    //게시글의 seq와 접속한 id 값을 뽑아냄
                                    var likeSeq = ${detailView.seq};
                                    var likeId = "${loginInfo.id}";
                                    console.log("Session ID: " + likeId);
                                    $.ajax({
                                        url: "like.bo",
                                        type: "post",
                                        data: {
                                            seq: likeSeq,
                                            id: likeId
                                        },
                                        dataType: "json"
                                    }).done(function(data) {
                                        $("#likeCount").html(data.likeCount);
                                        if (data.likeCheckResult == 0) {
                                            $("#heartImage").attr('src', '/img/tipBoard/coloredHeart.png');
                                            //		 					alert(data.id+"가 "+data.seq+"번 글을 좋아합니다.");
                                        } else {
                                            $("#heartImage").attr('src', '/img/tipBoard/heart.png');
                                            //		 					alert(data.id+"가 "+data.seq+"번 글의 좋아요를 취소 합니다.");
                                        }
                                    }).fail(function(data) {
                                        alert("비동기 실패ㅜ.ㅜ");
                                    })
                                });

                            </script>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                                <div class="col-1" id="scrapBtn">
                    <!-- 		로그인하지 않으면 스크랩 버튼이 안 보임!! -->
                    <c:choose>
                        <c:when test="${loginInfo == null}"></c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${scrapCheck == 0}">
                                    <button type="button" id="btnScrap" style="border: 0px; outline: 0px; background-color: transparent;">
                                        <img id="scrapImage" src="/img/tipBoard/bookMark.png" style="width: 30px; height: 30px;">
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" id="btnScrap" style="border: 0px; outline: 0px; background-color: transparent;">
                                        <img id="scrapImage" src="/img/tipBoard/coloredBookMark.png" style="width: 30px; height: 30px;">
                                    </button>
                                </c:otherwise>
                            </c:choose>
                            <!-- 	ajax를 이 위치에서 쓰는 이유는?ㅜ.ㅜ			 -->
                            <script>
                                $("#btnScrap").on("click", function() {
                                    var scrapSeq = ${detailView.seq};
                                    var scrapCategory = ${detailView.category};
                                    var scrapId = "${loginInfo.id}";
                                    var scrapTitle = "${detailView.title}";

                                    console.log(scrapSeq + " : " + scrapCategory + " : " + scrapId + " : " + scrapTitle);

                                    $.ajax({
                                        url: "tipScrap.bo",
                                        data: {
                                            seq: scrapSeq,
                                            category: scrapCategory,
                                            id: scrapId,
                                            title: scrapTitle
                                        },
                                        dataType: "json",
                                        type: "post"
                                    }).done(function(data) {
                                        $("#scrapCount").html(data.scrapCount);
                                        if (data.scrapCheckResult != 0) {
                                            alert("이미 스크랩된 게시글입니다.");
                                        } else if (data.scrapCheckResult == 0) {
                                            $("#scrapImage").attr('src', '/img/tipBoard/coloredBookMark.png');
                                            alert("스크랩 성공! 마이페이지에서 확인하세요!");
                                        }
                                    }).fail(function(data) {
                                        alert("비동기 실패ㅠ");
                                    })
                                })

                            </script>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="col-1" id="kakaoBtn">
                    <a id="kakao-link-btn" href="javascript:;"> <img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png" />
                    </a>
                </div>
            </div>
        </div>
           <div id="tipBtns">
            <!-- 글 수정/삭제 row는 작성자와 접속자가 같아야 나타남! -->
            <c:choose>
                <c:when test="${loginInfo.id == detailView.writer}">
                    <div class="row" id="contentsEdit">
                        <div class="col-8"></div>
                        <div class="col-2">
                            <button id="updateTip">글 수정</button>
                        </div>
                        <div class="col-2">
                            <button id="deleteTip">글 삭제</button>
                        </div>
                    </div>
                </c:when>
                <c:when test="${loginInfo.adminCheck == 'Y'}">
                 <div class="row" id="contentsEdit">
                        <div class="col-10"></div>
                        <div class="col-2">
                            <button id="deleteTip">글 삭제</button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
            <div class="row" id="publicBtn">
                <div class="col-10">
                    <button id="goBoardList">목록으로</button>
                </div>
                <div class="col-2">
                    <c:choose>
                        <c:when test="${loginInfo == null}"></c:when>
                        <c:otherwise>
                            <input id="reportBtn" type="button" value="신고하기" onclick="window.open('../board/reportPage.bo?url=${pageContext.request.contextPath}/board/detailView.bo?seq=${detailView.seq}&writer=${detailView.writer}&title=${detailView.title}','신고하기','width=450px, height=450px')">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div id="replyBox">
            <form id="cmtForm" name="cmtForm" method="post">
                <br>
                <div class="row">
                    <div class="col-10">
                        <textarea style="width: 800px" rows="3" cols="30" id="cmtWrite" placeholder=" 댓글은 로그인 후 이용가능합니다."></textarea>
                    </div>
                    <div class="col-2">
                        <button id="cmtOk" type="button" onclick="fn_Cmt()">등록</button>
                    </div>
                </div>

                <div class="row">
                    <div col-12>
                        <span><strong>Comments</strong></span> [<span id="cmtCount">0</span>]
                        <br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div id="cmtListForm"></div>
                    </div>
                </div>
                <input type="hidden" id="seqB" name="seqB" value="${detailView.seq }">
            </form>
            <div id="paging" style="text-align:center;"></div>
        </div>
    </div>
	<!-- 	script 겹쳐서 이미지 불러오는 데 에러생김! 그래서 아래로 내려주고, image 먼저 로딩되고 bootstrap 실행되도록 함! -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<script>	
// 	currentPage 찾는법은~?
	$("#goBoardList").on("click",function(){
		location.href = "${pageContext.request.contextPath}/board/boardList.bo"
	});
	
	$("#updateTip").on("click",function(){
		//내가 보고있는 게시글 화면의 seq값을 가지고 수정하는 controller로 이동!
		location.href = "${pageContext.request.contextPath}/board/updatePage.bo?seq=${detailView.seq}";
	});
	
	$("#deleteTip").on("click",function(){
		location.href = "${pageContext.request.contextPath}/board/deleteTip.bo?seq=${detailView.seq}";
	});
	
	function fn_Cmt(){
		var seqB = ${detailView.seq};
		var cmtWrite = $("#cmtWrite").val();
		var writer = '${loginInfo.id}';
		console.log(cmtWrite);
		if(writer == ""){
			alert("로그인 후 이용하실 수 있습니다.");
			$("#cmtWrite").val("");
			location.href="${pageContext.request.contextPath}/member/login.mem";
		}else{
		if(cmtWrite == ""){
			alert("댓글을 입력해주세요.");
			return false;
		}else{
		$.ajax({
			type: "post",
			url: "addComment.bo",
			data: {contents:cmtWrite, rootSeq:seqB, writer:writer},
			dataType: "json"
		}).done(function(data){
			if(data.cmtResult == 1){
				alert("댓글이 성공적으로 입력되었습니다.");
				
				getCommentList();
				$("#cmtWrite").val("");
			}else{
				alert("댓글이 입력되지 않았습니다.")
			}
		}).fail(function(data){
			alert("비동기 실패ㅠ");
		})
		}
	}
	}

	function getCommentList(page){
// 		var rootSeq = ${detailView.seq};
// 		var writer = "${detailView.writer}";
		var id = "${loginInfo.id}";
		
		$.ajax({
			type:"post",
			url:"cmtList.bo",
			data:{
				rootSeq: ${detailView.seq},
				currentPage: page
				},
			dataType: "json"
		}).done(function(data){
			console.log(data);
			console.log(data.cmtList);
			console.log(data.getNavi);
			$("#cmtListForm").empty();
			$("#cmtCount").html(data.cmtCount);
			$("#paging").html(data.getNavi)
			var data = JSON.parse(data.cmtList);
			
// 			$.each(cmtList, function(i ,j) {
// 				console.log(j.seq);
// 				console.log(j.contents);
// 			});
			
			for(var i = 0; i <data.length; i++){
				console.log(data[i].contents);
							
				if(data[i].writer != id){
					$("#cmtListForm").append("<div class='row cmtList'><div class='col-2'>"+data[i].writer+"</div><div class='col-6 cmtContents'>"+data[i].contents
					+"</div><div class='col-2'>"+data[i].formedDate+"</div><div class='col-2'></div></div>");			
				}else{
					$("#cmtListForm").append("<div class='row cmtList'><div class='col-2'>"+data[i].writer+"</div><div class='col-6 cmtContents'>"+data[i].contents
							+"</div><div class='col-2'>"+data[i].formedDate
							+"</div><div class='col-2'><a class='replyUpdate' seq="+data[i].seq+">수정</a> <a class='replyDelete' href='${pageContext.request.contextPath}/board/replyDelete.bo?seq=" 
							+ data[i].seq + "&contents="+data[i].contents+"'>삭제</a> <a class='reUpdate' seq=" + data[i].seq + " hidden>확인</a> <a class='reCancel' seq="+data[i].seq+" hidden>취소</a></div>");
					}
			}
		}).fail(function(data){
			alert("비동기 실패ㅠ")
		})
	}
	
	$("#paging").on("click", ".pageNavi", function() {
		var pageNum = $(this).html();
		$("#cmtListForm").html("");
		getCommentList(pageNum);
	});
	
	
	//<![CDATA[
    // // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('3f73de4f79f44e9f4e1baff5d7daf350');
    // // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
    Kakao.Link.createDefaultButton({
      container: '#kakao-link-btn',
      objectType: 'feed',
      content: {
        title: '[리빙포인트][${detailView.category}] ${detailView.title}',
        description: '#꿀팁 #혼족 #리빙포인트 #생활의_지혜 #싱글방글',
        imageUrl: 'https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2013/png/iconmonstr-light-bulb-17.png&r=66&g=100&b=194',

        link: {
          mobileWebUrl: 'http://192.168.160.75/board/detailView.bo?seq=${detailView.seq}',
          webUrl: 'http://192.168.160.75/board/detailView.bo?seq=${detailView.seq}'
        }
      },
      social: {
        likeCount: ${detailView.likeCount},
        commentCount: 45,
        sharedCount: 845
      },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
            mobileWebUrl: 'http://192.168.160.75/board/detailView.bo?seq=${detailView.seq}',
            webUrl: 'http://192.168.160.75/board/detailView.bo?seq=${detailView.seq}'
          }
        }
      ]
    });
  //]]>
  
	</script>
	<jsp:include page="/resources/jsp/footer.jsp"></jsp:include>
</body>
</html>