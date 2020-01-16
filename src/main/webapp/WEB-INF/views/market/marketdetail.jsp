<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

</head>
<body>
	<div class="wrapper" style="width: 800px; border:1px solid black; margin: auto;">
		<div id="contentBox">
		<div>${dto.writer } ${dto.place }</div>
		<div>${dto.title } ${dto.category }</div>
		<div>${dto.price }원</div>
		<div>
		<c:choose>
			<c:when test="${dto.writer == id && dto.done == 'N'}">
				<button type="button" id="done_${dto.seq }" onclick="updateDone('${dto.seq}')">판매완료</button>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${dto.done == 'Y' }">
				< < 판 매 완 료 > >
			</c:when>
		</c:choose>
		</div>
		<div>${dto.content }</div>
		<c:choose>
			<c:when test="${dto.writer == id}">
				<div><button id="update">수정하기</button><button id="delete">삭제하기</button></div>
			</c:when>
			<c:otherwise>
				<div><button id="msg">쪽지보내기</button><button id="report">신고하기</button></div>
			</c:otherwise>
		</c:choose>
		<div><button id="back">돌아가기</button></div>
		</div>
		<div>댓글</div>
		<div class="replybox">
			<c:choose>
				<c:when test="${list.size() == 0 }">
					<div>댓글이 없습니다.</div>
				</c:when>
				<c:otherwise>
						<c:forEach items="${list }" var="list">
<%-- 						<form action="${pageContext.request.contextPath }/marketReply/delete.do?seq=${list.seq}&boardSeq=${list.boardSeq}" method="post"> --%>
								<div class="outputRe">
								<div style="width:20%; float:left;">${list.writer }</div>
								<div id="reText_${list.seq }" contenteditable="false" style="width:50%; float:left;">${list.recontent }</div>
								<input type="hidden" id="reTextProc_"+${list.seq }>
								<c:choose>
									<c:when test="${list.writer == id }">
										<button type="button" id="updateRe_${list.seq }" onclick="updateRe('${list.seq}')">수정하기</button>
										<input type="hidden" id="boardSeqRe_${list.seq }" value="${list.boardSeq }">
										<button id="deleteRe_${list.seq }" type="button" onclick="deleteRe('${list.seq}')">삭제하기</button>
										<button type="button" id="updateDone_${list.seq }" style="display:none" onclick="updateDone('${list.seq}')">수정완료</button>
									</c:when>
								</c:choose>
								</div>
<!-- 								</form> -->
						</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<input type="text" id="recontent" name="recontent"><button id="reconfirm">확인</button>
		</div>
	</div>
	
	<script>
	
// 	$("#done").on("click", function(){
// 		location.href="${pageContext.request.contextPath}/market/updateDone.do?seq=${dto.seq}"
// 	});
	
	var updateDone = function(seq){
		var updateDone = "#updateDone_"+seq;
		var doneYes = "#doneYes_"+seq;
		$(updateDone).css("display","none");
		$.ajax({
			url: "${pageContext.request.contextPath}/market/updateDone.do?seq="+seq,
			type: "post",
			data: {
				seq : seq
			},
			success: function(data){
				alert("판매완료상태로 전환되었습니다. 판매완료 처리 된 상품은 다시 판매중으로 돌릴 수 없습니다.");
				window.location.reload();
			}
		}).fail(function(data){
			console.log(data);
		})
	};
	
	var deleteRe = function(seq){
		var boardSeq= $("#boardSeqRe_"+seq).val();
		console.log(boardSeq);
		$.ajax({
			url: "${pageContext.request.contextPath }/marketReply/delete.do?seq="+seq+"&boardSeq="+boardSeq,
			type: "post",
			data: {
				seq : seq,
				boardSeq : boardSeq
			},
			dataType: "json",
			success: function(data){
				$(".replybox").empty();
				
				for(var i = 0; i <data.length; i++){
					console.log(data[i].writer + i);
					
					$(".replybox").append("<div style='width:20%; float:left'>"+
					data[i].writer + "</div><div style='width:50%; float:left'>"+data[i].recontent+"</div>")
				}
				$("#recontent").val("");
				alert("댓글이 삭제되었습니다.");
			}
			
		})
	};
	
		function updateRe(seq){
				var updateRe = "#updateRe_"+seq;
				var updateOk = "#updateDone_"+seq;
				var reText = "#reText_"+seq;
				var deleteRe = "#deleteRe_"+seq;
				
				$(updateRe).css("display","none");
				$(updateOk).css("display","inline");
				$(deleteRe).css("display","none");
				$(reText).attr("contenteditable","true");
			}
		
		function updateDone(seq){
			var updateRe = "#updateRe_"+seq;
			var deleteRe = "#deleteRe_"+seq;
			var updateOk = "#updateDone_"+seq;
			
			var recontent = $("#reText_"+seq).text();
			console.log(recontent);
			$.ajax({
				url: "${pageContext.request.contextPath}/marketReply/update.do?seq="+seq,
				type: "post",
				data: {
					recontent : recontent
				},
				dataType: "json",
				success: function(data){
					alert("댓글이 수정되었습니다.");
					$(updateRe).css("display","block");
					$(deleteRe).css("display","block");
					$(updateOk).css("display","inline");
				}
			})
			
		}

		$("#back").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/boardList.do";
		})
		
		$("#delete").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/delete.do?seq=${dto.seq}";
		})
	
		$("#update").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/update.do?seq=${dto.seq}";
		})
		
		$("#msg").on("click",function(){
			var url = "${pageContext.request.contextPath }/msg/writeMsg.do?receiver=${dto.writer }";
			window.open(url, "메세지", "width=500px, height=500px, location=no, status=no, scrollbars=no");
		})
		
		$("#report").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/report.do?url=${realUrl}";
		})
		
		$("#reconfirm").on("click", function(){
			var recontent = $("#recontent").val();
			var seq = ${dto.seq};
			if(recontent == ""){
				alert("댓글을 입력하세요.");
				return;
			}else{
				$.ajax({
					type: "post",
					url: "../marketReply/insert.do?seq="+seq,
					data: {
						recontent : recontent
					},
					dataType: "json",
					success: function(data){
						$(".replybox").empty();
						console.log(data.length);
						
						for(var i = 0; i <data.length; i++){
							console.log(data[i].writer + i);
							
							$(".replybox").append("<div style='width:20%; float:left'>"+
							data[i].writer + "</div><div style='width:50%; float:left'>"+data[i].recontent+"</div>")
						}
						$("#recontent").val("");
						alert("댓글이 등록되었습니다.");
					},
					error: function(data){
						alert("댓글작성에 실패했습니다.");
					}
				})
			}
		})
	</script>
</body>
</html>