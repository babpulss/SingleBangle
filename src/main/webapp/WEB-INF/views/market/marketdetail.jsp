<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>re마켓</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
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
            flex-basis: 20%;
        }
        .bRow>span:nth-child(3) {
            flex-basis: 50%;
            text-align: left;
        }
        .bRow a {
            text-decoration: none;
        }
        .bRow>span:nth-child(4) {
            flex-basis: 10%;
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
            width: 100px;
            height: 30px;
            border-radius: 10px;
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
</style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
 <div id="board" style="width: 800px; position: relative; top: 65px; margin: auto;">
        <div id="bHeader" class="bRow" style="font-size: 20px; font-weight: bold;">
            <span style="margin: auto;">${dto.title }</span>
        </div>
		<div id="contentBox">
		<div style="border-bottom: 1px solid #c4c4c4;">
		<div style="font-weight: bold; font-size: 18px;"><br>상품정보</div>
		<div> ${dto.category }</div>
		<div>${dto.price }원<br></div><br>
		</div>
		<div style="border-bottom: 1px solid #c4c4c4;">
		<div style="font-weight: bold; font-size: 18px;"><br>판매자정보</div>
		<div>${dto.writer }</div>
		<div>${dto.place }</div>
		<div>
		<c:choose>
			<c:when test="${dto.gender == 'F' }">
				여성
			</c:when>
			<c:otherwise>
				남성
			</c:otherwise>
		</c:choose>
		</div><br>
		</div><br>
		<c:choose>
			<c:when test="${dto.writer == loginInfo.id && dto.done == 'N'}">
				<div>
				<button type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;" id="updateSellDone_${dto.seq }" onclick="updateSellDone('${dto.seq}')">판매완료</button></div>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${dto.done == 'Y' }">
				<div style="text-align: center; font-size: 25px;"> < < 판 매 완 료 > > </div>
			</c:when>
		</c:choose>
		<br>
		<div>${dto.content }</div>
		<br>
		<c:choose>
			<c:when test="${dto.writer == loginInfo.id }">
				<div><button id="update" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">수정하기</button>
				<button id="delete" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">삭제하기</button>
				<button id="back" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">돌아가기</button></div>
			</c:when>
			<c:when test="${loginInfo != null && dto.writer != loginInfo.id}">
				<div><button id="msg" type="button" style="border: none; width: 65px; height: 30px; border-radius: 10px;">쪽지보내기</button>
				<button id="report" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">신고하기</button>
				<button id="back" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">돌아가기</button>
				<c:choose>
					<c:when test="${loginInfo.adminCheck == 'Y' }">
					<button id="delete" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">삭제하기</button></div>
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
		<br>
		</div>
		<br>
		<div style="text-align: center; font-size: 20px; border-bottom: 1px solid #c4c4c4">댓글<br></div><br>
		<div class="replybox" style="margin: auto;">
			<c:choose>
				<c:when test="${list.size() == 0 }">
					<br><div style="text-align: center;">댓글이 없습니다.</div><br>
				</c:when>
				<c:otherwise>
						<c:forEach items="${renavilist }" var="list">
								<div class="outputRe">
								<div style="width:20%; float:left; font-weight: bold;">${list.writer }</div>
								<div class="reText_${list.seq }" contenteditable="false" style="width:50%; float:left;">${list.recontent }</div>
								<input type="hidden" id="reTextProc_${list.seq }">
								<c:choose>
									<c:when test="${list.writer == loginInfo.id }">
									<div style="float:left; width: 30%; text-align: center;">
										<button style="border: none; width: 50px; height: 25px; border-radius: 10px;" type="button" class="updateRe_${list.seq }" onclick="updateRe('${list.seq}')">수정</button>
										<input type="hidden" class="boardSeqRe_${list.seq }" value="${list.boardSeq }">
										<button class="deleteRe_${list.seq }" style="border: none; width: 50px; height: 25px; border-radius: 10px;" type="button" onclick="deleteRe('${list.seq}')">삭제</button>
										<button type="button" style="border: none; display:none; width: 50px; height: 25px; border-radius: 10px;" class="updateDone_${list.seq }" onclick="updateDone('${list.seq}')">완료</button>
									</div>
								</c:when>
								<c:otherwise>
									<div style="float:left; width: 30%;">&nbsp</div>
								</c:otherwise>
								</c:choose>
								</div>
						</c:forEach>
				</c:otherwise>
			</c:choose>
		<div style="text-align: center">${navi }</div>
			<c:choose>
				<c:when test="${loginInfo != null }">
					<br>
					<div style="width: 100%; text-align: center;">
					<textarea style="resize: none; vertical-align: middle; width: 85%; height: 50px;" id="recontent" name="recontent"></textarea>
					<button type="button" id="reconfirm" style="border: none; width: 50px; height: 30px; border-radius: 10px;">확인</button>
					</div>
					<br>
				</c:when>
				<c:otherwise>
					<br>
					<div style="width: 800px; text-align: center;">
					로그인 후 댓글 입력이 가능합니다.
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		</div>
	<jsp:include page="/resources/jsp/footer.jsp" />
	<script>
	
	var updateSellDone = function(seq){
		if(confirm("판매완료상태로 전환합니다. \n 판매완료 처리 된 상품은 다시 판매중으로 돌릴 수 없습니다.") == true){
			var updateSellDone = "#updateSellDone_"+seq;
			var doneYes = "#doneYes_"+seq;
			$(updateSellDone).css("display","none");
			$.ajax({
				url: "${pageContext.request.contextPath}/market/updateSellDone.do?seq="+seq,
				type: "post",
				data: {
					seq : seq
				},
				success: function(data){
					window.location.reload();
				}
			}).fail(function(data){
				console.log(data);
			})
		}else{
			return false;
		}
		
	};
	
	var deleteRe = function(seq){
		var boardSeq= $(".boardSeqRe_"+seq).val();
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
				window.location.reload();
			}
			
		})
	};
	
		function updateRe(seq){
				var updateRe = ".updateRe_"+seq;
				var updateOk = ".updateDone_"+seq;
				var reText = ".reText_"+seq;
				var deleteRe = ".deleteRe_"+seq;
				
				$(updateRe).css("display","none");
				$(updateOk).css("display","inline");
				$(deleteRe).css("display","none");
				$(reText).attr("contenteditable","true");
			}
		
		function updateDone(seq){
			var updateRe = ".updateRe_"+seq;
			var deleteRe = ".deleteRe_"+seq;
			var updateOk = ".updateDone_"+seq;
			
			var recontent = $(".reText_"+seq).text();
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
					window.location.reload();
				}
			})
			
		}

		$("#back").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/boardList.do";
		})
		
		$("#delete").on("click",function(){
			alert("글이 성공적으로 삭제되었습니다.");
			location.href="${pageContext.request.contextPath}/market/delete.do?seq=${dto.seq}";

		})
	
		$("#update").on("click",function(){
			location.href="${pageContext.request.contextPath}/market/update.do?seq=${dto.seq}";
		})
		
		$("#msg").on("click",function(){
			var url = "${pageContext.request.contextPath }/msg/writeMsg.do?receiver=${dto.writer }";
			window.open(url, "메세지", "width=450px, height=500px, location=no, status=no, scrollbars=no");
		})
		
		$("#report").on("click",function(){
			var url = "${pageContext.request.contextPath}/market/report.do?url=${realUrl}&seq=${dto.seq}";
			window.open(url, "신고하기", "width=500px, height=400px, location=no, status=no, scrollbars=no");
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
						window.location.reload();
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