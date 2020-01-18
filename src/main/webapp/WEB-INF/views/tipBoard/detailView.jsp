<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<style>
*{
box-sizing:border-box;
}

div{
border: 1px solid black;
}
#container{
width:800px;
}

</style>
</head>
<body>
<!-- 이제 여기서 ${detailView} 내용 꺼내기! -->
<div id="container">
	<div id="tipBoardView">
	<div class="row">
		<div class="col-3">[${detailView.category}]</div>
		<div class="col-9">${detailView.title }</div>
	</div>
	<div class="row">
		<div class="col-3">${detailView.writeDate }</div>
		<div class="col-3">${detailView.writer}</div>
		<div class="col-3"></div>
		<div class="col-3">조회수: ${detailView.viewCount }</div>
	</div>
	<div class="row">
		<div class="col-8"></div>
		<div class="col-2">스크랩 수: <span id="scrapCount">${detailView.scrapCount }</span></div>
		<div class="col-2">좋아요 수: <span id="likeCount">${detailView.likeCount}</span></div>
	</div>
	<div class="row">
		<div class="col-12" style="height:800px">${detailView.contents }</div>
	</div>
	<div class="row">
		<div class="col-4">
<!-- 		로그인하지 않으면 스크랩 버튼이 안 보임!! -->
		<c:choose>
			<c:when test="${loginInfo == null}"></c:when>
			<c:otherwise>
				<button type="button" id="btnScrap">스크랩</button>
<!-- 	ajax를 이 위치에서 쓰는 이유는?ㅜ.ㅜ			 -->
				<script>
				$("#btnScrap").on("click",function(){
					var scrapSeq = ${detailView.seq};
					var scrapCategory = ${detailView.category};
					var scrapId = "${loginInfo.id}";
					var scrapTitle = "${detailView.title}";
					
					console.log(scrapSeq +" : "+ scrapCategory +" : "+ scrapId + " : " + scrapTitle);
					
					$.ajax({
						url:"tipScrap.bo",
						data: {seq:scrapSeq, category:scrapCategory, id:scrapId, title:scrapTitle},
						dataType: "json",
						type:"post"
					}).done(function(data){
						$("#scrapCount").html(data.scrapCount);
						if(data.scrapCheckResult != 0){
							alert("이미 스크랩된 게시글입니다.");
						}else if(data.scrapCheckResult == 0){
							alert("스크랩 성공! 마이페이지에서 확인하세요!");
						}
					}).fail(function(data){
						alert("비동기 실패ㅠ");
					})
				})
				</script>
			</c:otherwise>
		</c:choose>
		</div>
		
		<div class="col-4">
<!-- 		로그인하지 않으면 좋아요 버튼이 안 보임!!!!  -->
		<c:choose>
		<c:when test="${loginInfo == null}"></c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${likeCheck == 1}">
					<button type="button" id="btnLike" style="border:0px;outline:0px;background-color:transparent;">
					<img id="heartImage" src="/img/tipBoard/coloredHeart.png" style="width:20px;height:20px;"></button>
				</c:when>
				<c:otherwise><button type="button" id="btnLike" style="border:0px;outline:0px;background-color:transparent;">
					<img id="heartImage" src="/img/tipBoard/heart.png" style="width:20px;height:20px;"></button>
				</c:otherwise>
			</c:choose>
			
			<script>
			//게시글 들어가서 좋아요 버튼 누름
			$("#btnLike").on("click",function(){
				//게시글의 seq와 접속한 id 값을 뽑아냄
				var likeSeq = ${detailView.seq};
				var likeId = "${loginInfo.id}";
				console.log("Session ID: "+likeId);
					$.ajax({
						url:"like.bo",
						type:"post",
						data: { seq: likeSeq,
							id: likeId },
						dataType:"json"
					}).done(function(data){
						$("#likeCount").html(data.likeCount);
						if(data.likeCheckResult == 0){
							$("#heartImage").attr('src','/img/tipBoard/coloredHeart.png');
//		 					alert(data.id+"가 "+data.seq+"번 글을 좋아합니다.");
						}else{
							$("#heartImage").attr('src','/img/tipBoard/heart.png');
//		 					alert(data.id+"가 "+data.seq+"번 글의 좋아요를 취소 합니다.");
						}
					}).fail(function(data){
						alert("비동기 실패ㅜ.ㅜ");
					})
			});
			</script>
		</c:otherwise>
	</c:choose>
		</div>
		<div class="col-4"><a id="kakao-link-btn" href="javascript:;">
<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png"/>
</a></div>
	</div>
	<c:choose>
	<c:when test="${loginInfo.id == detailView.writer}">
	<div class="row">
		<div class="col-8"></div>
		<div class="col-2"><button id="updateTip">글 수정</button></div>
		<div class="col-2"><button id="deleteTip">글 삭제</button></div>
	</div>
	</c:when>
	<c:otherwise></c:otherwise>
	</c:choose>
	<div class="row">
	<div class="col-10"><button id="goBoardList">목록으로</button></div>
	<div class="col-2">
	<c:choose>
		<c:when test="${loginInfo.adminCheck == 'Y'}"><button id="black">블랙리스트</button></c:when>
		<c:otherwise><button id="report">신고하기</button></c:otherwise>
	</c:choose>
	</div>
	</div>
	</div>
	</div>
<!-- 	script 겹쳐서 이미지 불러오는 데 에러생김! 그래서 아래로 내려주고, image 먼저 로딩되고 bootstrap 실행되도록 함! -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<script>	
	$("#goBoardList").on("click",function(){
		location.href = "${pageContext.request.contextPath}/board/boardList.bo";
	});
	
	$("#updateTip").on("click",function(){
		//내가 보고있는 게시글 화면의 seq값을 가지고 수정하는 controller로 이동!
		location.href = "${pageContext.request.contextPath}/board/updatePage.bo?seq=${detailView.seq}";
	});
	
	$("#deleteTip").on("click",function(){
		location.href = "${pageContext.request.contextPath}/board/deleteTip.bo?seq=${detailView.seq}";
	});
	
//  스크랩 기능은 ajax로 바꿀거라서 성공하면 이거 필요 없음!	
// 	여기서 seq값을 가지고 가야 controller에서 이 seq값을 가지고 boardTB의 값을 가져올 수 있음!
//	$("#btnScrap").on("click",function(){
//		location.href = "${pageContext.request.contextPath}/board/tipScrap.bo?seq=${detailView.seq}";
//	})
	
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
	
</body>
</html>