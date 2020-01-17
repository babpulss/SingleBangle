<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/resources/css/accountCSS/accountCSS.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/resources/js/accountJS/accountJS.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger {
	cursor: pointer;
}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker {
	cursor: pointer;
}
</style>
</head>
<body>
	<main class="container pt-5">
	<div class="card mb-5">

		<div class="card-header">
			<h2>
				<c:out value="${sessionScope.userName}" />
				(
				<c:out value="${sessionScope.id}" />
				) 님 의가계부
			</h2>
		</div>
		<div class="card-block p-0">
			<form id="addFrm"action="${pageContext.request.contextPath }/accountBook/Account.add"
				method="post">
				<table class="table">
					<thead>
						<tr>
							<th class="border-0 text-uppercase small font-weight-bold">날짜</th>
							<th class="border-0 text-uppercase small font-weight-bold">용도</th>
							<th class="border-0 text-uppercase small font-weight-bold">결제방식</th>
							<th class="border-0 text-uppercase small font-weight-bold">입/출금</th>
							<th class="border-0 text-uppercase small font-weight-bold">금액</th>
							<th class="border-0 text-uppercase small font-weight-bold">비고</th>
							<th class="border-0 text-uppercase small font-weight-bold"
								id="modiBtn" style="display: none">선택</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="datePic"><input type="text" id="datepicker" name="reportingDate"></td>
							<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
								id="detailsSelect" name="details">
									<option selected>선택</option>
									<option value="식비">식비</option>
									<option value="문화 생활비">문화 생활비</option>
									<option value="교통비">교통비</option>
									<option value="관리비">관리비</option>
									<option value="급여">급여</option>
									<option value="저축">저축</option>
									<option value="기타">기타</option>
							</select></td>
							<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
								id="paymentsSelect" name="payments">
									<option selected>선택</option>
									<option value="카드">카드</option>
									<option value="현금">현금</option>
							</select></td>
							<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
								id="specSelect" name="spec">
									<option selected>선택</option>
									<option value="수입">수입</option>
									<option value="지출">지출</option>
							</select></td>

							<td><input type="text" id="price" name="price"
								placeholder="(ex. 10000)"></td>

							<td><input type="text" id="remarks" name="remarks"
								placeholder="비고란"></td>
							<td class="plusBtn"><input type="button" id="addBtn"
								value="적용"></td>
						</tr>
					</tbody>
				</table>
			</form>
			<table
				class="table table-bordered table-sm m-0 table table-condensed table-hover">
				<thead>
					<tr>
						<th>날짜</th>
						<th>수입</th>
						<th>지출</th>
						<th>총 수입/지출 비용</th>
						<th>선택</th>
					</tr>
				</thead>

				<tbody id="monthDataBody">
					<c:forEach items="${list }" var="list">
						<tr class="monthData">
							<td class="formedDate">${list.formedReportingDate}</td>
							<td class="income"><fmt:formatNumber value="${list.income}"
									pattern="###,###,###원" /></td>
							<td class="expense">-<fmt:formatNumber
									value="${list.expense}" pattern="###,###,###원" /></td>
							<td class="total"><fmt:formatNumber
									value="${list.income-list.expense}" pattern="###,###,###원" /></td>
							<td><a
								href="${pageContext.request.contextPath }/accountBook/detailAccount?formedReportingDate=${list.formedReportingDate}"><input
									type="button" name="${list.formedReportingDate}"
									class="detailBtn" value="상세보기"></a> <a><input
									type="button" name="${list.formedReportingDate}"
									class="deleteBtn" value="삭제"></a></td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="card-footer p-0">
			<nav aria-label="...">
				<ul class="pagination justify-content-end mt-3 mr-3">
					<li class="page-item disabled"><span class="page-link">Previous</span>
					</li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item active"><span class="page-link">2<span
							class="sr-only">(current)</span>
					</span></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</nav>
		</div>
	</div>
	</main>
	<script>
		$(function() {
			//input을 datepicker로 선언
			$("#datepicker")
					.datepicker(
							{
								dateFormat : 'yy-mm-dd' //Input Display Format 변경
								,
								showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
								,
								showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
								,
								changeYear : true //콤보박스에서 년 선택 가능
								,
								changeMonth : true //콤보박스에서 월 선택 가능                
								,
								showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
								,
								buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
								,
								buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
								,
								buttonText : "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
								,
								yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
								,
								monthNamesShort : [ '1', '2', '3', '4', '5',
										'6', '7', '8', '9', '10', '11', '12' ] //달력의 월 부분 텍스트
								,
								monthNames : [ '1월', '2월', '3월', '4월', '5월',
										'6월', '7월', '8월', '9월', '10월', '11월',
										'12월' ] //달력의 월 부분 Tooltip 텍스트
								,
								dayNamesMin : [ '일', '월', '화', '수', '목', '금',
										'토' ] //달력의 요일 부분 텍스트
								,
								dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
										'금요일', '토요일' ] //달력의 요일 부분 Tooltip 텍스트
								,
								minDate : "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
								,
								maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)   
								,
								changeMonth : true
								,
								changeDay : true
								,
								changeYear : true
							});

			//초기값을 오늘 날짜로 설정
			$('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
			
		});
// 		$(".detailBtn")
// 				.on(
// 						"click",
// 						function() {
// 							var report = $(this).attr("name");
// 							console.log(report);
// 							location.href = "${pageContext.request.contextPath}/accountBook/detailAccount?formedReportingDate="
// 									+ report;
// 						});
		$("#addBtn").on("click", function() {
				$("#addFrm").submit();
			// 						var reportingDates = $("#datepicker").val();
			// 						var detail = $("#detailsSelect").val();
			// 						var payment = $("#paymentsSelect").val();
			// 						var specs = $("#specSelect").val();
			// 						var prices = $("#price").val();
			// 						var remark = $("#remarks").val();

			// 						$.ajax({
			// 							url : "/Account.add",
			// 							dataType : "json",
			// 							type : "post",
			// 							data : {
			// 								reportingDate : reportingDates,
			// 								details : detail,
			// 								payments : payment,
			// 								spec : specs,
			// 								price : prices,
			// 								remarks : remark
			// 							}
			// 						}).done(function(resp) {
			// 							$(".monthData").remove();
			// 							$.each(resp, function(i,list){
			// 								console.log(i);
			// 							$("#monthDataBody").append("<tr class=\"monthData"+i+"\"></tr>");
			// 							$(".monthData"+i).append("<td class=\"formedDate"+i+"\">"+list.formedReportingDate+"</td>");
			// 							var incomePrice = addComma(list.income);

			// 							$(".monthData"+i).append("<td class=\"'income'"+i+" style='color:dodgerblue'\">"+incomePrice+"</td>");
			// 							addComma(list.expense);
			// 							$(".monthData"+i).append("<td class=\"'expense'"+i+" style='color:red'\">"+list.expense+"</td>");
			// 							$(".monthData"+i).append("<td class=\"'total"+i+"'>"+list.income-list.expense+"</td>");
			// 							$(".monthData"+i).append("<td><input type='button' class='detailBtn' name="+list.formedReportingDate+" value='상세보기'>"
			// 							+"<input type='button' class='deleteBtn' name="+list.formedReportingDate+" value='삭제'></td>");
			// 							$(".formedDate").html(list.formedReportingDate);
			// 							$(".income").html(list.income);
			// 							$(".expense").html(list.expense);
			// 							$(".total").html(list.income-list.expense);					
			// 							})
			// 							console.log(resp);
			// 						}).fail(function() {
			// 							console.log("fail");
			// 						});

		});
		function addComma(num) {
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			return num.toString().replace(regexp, ',');
		}
	</script>
</body>
</html>