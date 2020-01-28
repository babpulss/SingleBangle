<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/nav.css">
<link rel="stylesheet" href="/css/footer.css">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
.image-upload-wrap {
	margin-top: 20px;
	border: 4px dashed #1FB264;
	position: relative;
}

.image-dropping, .image-upload-wrap:hover {
	background-color: #1FB264;
	border: 4px dashed #ffffff;
}

.file-upload-content {
	text-align: center;
}

.file-upload-input {
	position: absolute;
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	outline: none;
	opacity: 0;
	cursor: pointer;
}

#comments {
	height: 300px;
	overflow: auto;
}

.img{
	width: 1000px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#btnComment").on("click", function() {
			var input =  $("#inputComment").val();
			if(input.length != 0){
				$.ajax({
					url: "/house/houseCommentWriteProc",
					type: "post",
					data:{
						houseSeq: ${houseDTO.seq},
						content: input
					},

				}).done(function(data) {
					var json = JSON.parse(data);
					 $("#inputComment").val("");
					 $("#comments").empty();
					 var commentList = json.commentList;
					 for(var i =0; i<commentList.length; i++){
						$("#comments").prepend(
							"<div class='panel-body'> 									<span> " + commentList[i].writer + "</b> " + commentList[i].wirteDate+" 										<c:if test='" + ${loginInfo.id eq commentList[i].writer } +"'> 										<button type='button' class='btn btn-outline-danger btn-sm' 											onclick='commentDel('"+  commentList[i].seq  +"')'>삭제</button> 										</c:if> 										<br> 										${dto.content} 									</span> 								</div>"
						)
								
					 }
					 $("#comments").prepend("")
				}).fail(function() {
					
				});
			}else{
				alert("댓글을 입력해주세요");
			}
		})
		
		$("#btnUpdate").on("click", function() {
			location.href= "/house/houseUpdate?seq=" + ${houseDTO.seq}
		})
		
		$("#btnLogin").on("click", function() {
			alert("로그인이 필요합니다.");
		})
		
		$("#btnList").on("click", function() {
			location.href="/house/houseMain";
		})
		
		$("#btnDelete").on("click", function() {
			location.href= "/house/houseDelete?seq=" + ${houseDTO.seq}
		})
	})
	
	function commentDel(seq) {
		if(confirm("댓글을 삭제하시겠습니까?")){
			$.ajax({
				url: "/house/houseCommentDel",
				type: "post",
				data:{
					seq: seq
				}
	
			}).done(function(data) {
				console.log(data)
				if(data){
					window.location.reload(true);
				}else{
					alert("실패")
				}
				/*  $("#inputComment").val("");
				 $("#comments").empty();
				 var commentList = json.commentList;
				 for(var i =0; i<commentList.length; i++){
					$("#comments").prepend(
						"<div class='panel-body'> 									<span> 										<b>" + commentList[i].writer + "</b> " + commentList[i].wirteDate+" <br> 										" + commentList[i].content + " 									</span> 								</div>		"	
					)
							
				 }
				 $("#comments").prepend("") */
			}).fail(function() {
				
			});
		}
	}
</script>
</head>

<body>
<jsp:include page="/resources/jsp/nav.jsp" />
	<div id="mainWrapper">
		<form class="container">
			<c:choose>
				<c:when test="${houseDTO ne null && contentList ne null}">
					<div class="card-header">
						<label class="form-control-label">${houseDTO.title}</label>
					</div>
					<div>
						<label>작성자 ${houseDTO.writer }</label>
					</div>
					<c:forEach items="${contentList}" var="contentDTO">
						<div class="contents">
							<div class="title"><h4>${contentDTO.imgTitle}</h4></div>
							<img class="img" src="/files/${contentDTO.sysName}"
								alt="${contentDTO.oriName}">
							<div>${contentDTO.imgContent}</div>
						</div>
						<hr>
					</c:forEach>
					<div class="comment">
						<b>댓글</b>
						<c:choose>
							<c:when test="${loginInfo ne null}">
								<div class="input-group mb-3">
									<input id="inputComment" type="text" class="form-control"
										placeholder="댓글을 입력해주세요.">
									<div class="input-group-append">
										<button class="btn btn-outline-secondary" type="button"
											id="btnComment">등록</button>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="input-group mb-3">
									<input id="inputComment" type="text" class="form-control"
										placeholder="로그인이 필요합니다.">
									<div class="input-group-append">
										<button class="btn btn-outline-secondary" type="button"
											id="btnLogin">등록</button>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						
						<div id="comments" class="panel panel-default">
							<c:if test="${commentList ne null}">
								<c:forEach items="${commentList}" var="dto">
									<div class="panel-body">
										<span> <b>${dto.writer}</b> ${dto.wirteDate}
											<c:if test="${loginInfo.id eq houseDTO.writer}">
											<button type="button" class="btn btn-outline-danger btn-sm"
												onclick="commentDel('${dto.seq}')">삭제</button>
											</c:if>
											<br>
											${dto.content}
										</span>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
					<div id="btnDiv">
						<c:if test="${loginInfo.id eq houseDTO.writer}">
							<button type="button" class="btn btn-warning" id="btnUpdate">수정</button>
							<button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
						</c:if> 
						<button type="button" class="btn btn-secondary" id="btnList">목록</button>
					</div>
				</c:when>
	
			</c:choose>
	
		</form>
	
	
		<hr>
		<!--    <form class="container">
	        <div class="form-group">
	            <label class="form-control-label" for="inputSuccess3">Input with <code>is-valid</code></label>
	            <input type="text" class="form-control is-valid" id="inputSuccess3">
	            <div class="valid-feedback">Success! You've done it.</div>
	        </div>
	    </form>-->
	</div>
	<jsp:include page="/resources/jsp/footer.jsp" />
	
</body>

</html>
