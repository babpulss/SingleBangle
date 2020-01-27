<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/resources/js/accountJS/accountJS.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/css/nav.css" />
<script
	src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" />
<link rel="stylesheet"
	href="/resources/css/accountCSS/detailAccountCSS.css" />
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
	<div class="container">
		<div class="invoice row-fluid">
			<div class="col-12">
				<div class="card">
					<div class="card-body p-0">
						<div class="row p-5">
							<div class="col-md-8">
								<h1>
									<c:out value="${formedDate }" />
									수입/지출 정보
								</h1>
							</div>

							<div class="col-md-4 text-right">
								<button type="button" id="printInvoice" class="btn btn-info"
									style="margin-right: 7px;">Excel</button>
								<form id="pdf"
									action="${pageContext.request.contextPath }/accountBook/accountPDF"
									method="post" style="float: right;">
									<input type="hidden" class="pdfValue btn btn-info"
										name="pdfValue" value="">
									<button type="button" class="pdfBtn btn btn-info"
										value="PDF View">PDF View</button>
								</form>

							</div>
						</div>

						<hr class="my-1" />

						<div class="row pb-5 p-5">
							<div class="col-md-6">
								<p class="font-weight-bold mb-4"></p>
								<p class="mb-1"></p>

								<!--                             <p class="mb-1">6781 45P</p> -->
							</div>

							<div class="col-md-6 text-right">
								<p class="font-weight-bold mb-4">Payment Details(지출)</p>
								<p class="mb-1">
									<span class="text-muted">카드 : </span>
									<fmt:formatNumber value="${cardSum}" pattern="###,###원" />
								</p>
								<p class="mb-1">
									<span class="text-muted">현금 : </span>
									<fmt:formatNumber value="${cashSum}" pattern="###,###원" />
								</p>
								<p class="mb-1">
									<span class="text-muted">이름 : </span>
									<c:out value="${name }" />
								</p>
							</div>
						</div>

						<div class="row p-5">
							<div class="col-md-12">
								<table id="detailTable"
									class="table table-condensed table-hover">
									<thead>
										<tr>

											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 5%">No</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="display:none"></th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 23%">날짜</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 12%">용도</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 12%">결제방식</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 12%">입/출금</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 15%">금액</th>
											<th class="border-0 text-uppercase small font-weight-bold"
												style="width: 12%">비고</th>
											<th id="selecBtn"
												class="border-0 text-uppercase small font-weight-bold	">선택</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list }" var="list" varStatus="status">
											<tr>

												<td>${status.count }</td>
												<td style="display: none"><input type="hidden"
													id="seqs" name="seqs" value="${list.seq }"></td>
												<td><input type="text" id="${list.seq }"
													name="reportingDates" value="${list.reportingDate }"
													class="datepicker col-10"
													placeholder="${list.reportingDate }" autocomplete="off"></td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="detailsSelects" name="details">
														<option selected>${list.details}</option>
														<option value="식비">식비</option>
														<option value="문화 생활비">문화 생활비</option>
														<option value="교통비">교통비</option>
														<option value="관리비">관리비</option>
														<option value="급여">급여</option>
														<option value="저축">저축</option>
														<option value="기타">기타</option>
												</select></td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="paymentsSelects" name="payments">
														<option selected>${list.payments }</option>
														<option value="카드">카드</option>
														<option value="현금">현금</option>
												</select></td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="specSelects" name="spec">
														<option selected>${list.spec }</option>
														<option value="수입">수입</option>
														<option value="지출">지출</option>
												</select></td>
												<c:choose>

													<c:when test="${list.income != 0 }">
														<td style="color: dodgerblue"><input type="text"
															style="width: 80%; color: dodgerblue;" class="incomes"
															id="incomes" name="income"
															value="<fmt:formatNumber value="${list.income}" pattern="###,###" />"
															placeholder="<fmt:formatNumber value="${list.income}" pattern="###,###" />"
															onkeyup="inputNumberFormat(this)">원</td>
													</c:when>
													<c:otherwise>
														<td style="color: red"><input type="text"
															style="width: 80%; color: red;" class="expenses"
															id="expenses" name="expense"
															value="<fmt:formatNumber value="${list.expense}" pattern="###,###" />"
															placeholder="<fmt:formatNumber value="${list.expense}" pattern="###,###" />"
															onkeyup="inputNumberFormat(this)">원</td>
													</c:otherwise>
												</c:choose>
												<td><input type="text" class="remark" id="remark"
													name="remark" value="${list.remarks}"
													style="border: 1px solid white;"></td>
												<td><input type="button"
													class="modifyBtn btn btn-light" disabled="disabled"
													value="수정" name="${list.seq }"> <input
													type="button" class="deleteBtn btn btn-danger" value="삭제"></td>

											</tr>

										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>

						<div class="d-flex flex-row-reverse bg-dark text-white p-4">
							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 수입/지출비용</div>
								<div class="h2 font-weight-light">
									<fmt:formatNumber value="${in-out}" pattern="###,###원" />
								</div>
							</div>

							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 지출 비용</div>
								<div class="h2 font-weight-light" style="color: red">
									-
									<fmt:formatNumber value="${out}" pattern="###,###원" />
								</div>
							</div>

							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 수입 비용</div>
								<div class="h2 font-weight-light" style="color: dodgerblue">
									<fmt:formatNumber value="${in}" pattern="###,###원" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<form id="modiFrm"
			action="${pageContext.request.contextPath }/accountBook/modifyAccount"
			method="post">
			<input type="hidden" id="seq" name="seq"> <input
				type="hidden" id="reportingDate" name="reportingDate"> <input
				type="hidden" id="details" name="details"> <input
				type="hidden" id="payments" name="payments"> <input
				type="hidden" id="spec" name="spec"> <input type="hidden"
				id="income" name="income"> <input type="hidden" id="expense"
				name="expense"> <input type="hidden" id="remarks"
				name="remarks">
		</form>
		<div class="text-light mt-5 mb-5 text-center small">
			by : <a class="text-light" target="" href="#">Single Bangle</a>
		</div>
	</div>

	<script>
		function inputNumberFormat(obj) {
			obj.value = comma(uncomma(obj.value));
		}
		function comma(str) {
			str = String(str);
			return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}
		function uncomma(str) {
			str = String(str);
			return str.replace(/[^\d]+/g, '');
		}
		$(".modifyBtn").on(
				"click",
				function() {
					var seqs = $(this).parent().parent().children().children(
							"#seqs").val();
					var reportingDates = $(this).closest("tr").children()
							.next().next().children("input").val();

					var detail = $(this).parent().parent().children().children(
							"#detailsSelects").val();
					var payment = $(this).parent().parent().children()
							.children("#paymentsSelects").val();
					var specs = $(this).parent().parent().children().children(
							"#specSelects").val();
					var income = $(this).parent().parent().children().children("#incomes").val();
					var expense = $(this).parent().parent().children().children("#expenses").val();
					if ($(this).parent().parent().children().children(
							"#expenses").val() != 0) {
						expense = $(this).parent().parent().children().children(
								"#expenses").val();
						income = 0;
					} else if ($(this).parent().parent().children().children(
							"#incomes").val() != 0) {
						income = $(this).parent().parent().children()
								.children("#incomes").val();
						expense = 0;
					} 
					var incomes = uncomma(income);
					var expenses = uncomma(expense);
					var remark = $(this).parent().parent().children().children(
							"#remark").val();

					console.log(seqs + " : " + reportingDates + " : " + detail
							+ " : " + payment + " : " + specs + " : " + incomes
							+ " : " + expenses + " : " + remark);
					$("#seq").val(seqs);
					$("#reportingDate").val(reportingDates);
					$("#details").val(detail);
					$("#payments").val(payment);
					$("#spec").val(specs);
					$("#income").val(incomes);
					$("#expense").val(expenses);
					$("#remarks").val(remark);
					$("#modiFrm").submit();
					console.log($("#seq").val() + $("#reportingDate").val()
							+ $("#details").val() + $("#payments").val()
							+ $("#spec").val() + $("#income").val()
							+ $("#expense").val() + $("#remarks").val());

				});
		$(".deleteBtn")
				.click(
						function() {
							$("#selectFrm")
									.attr("action",
											"${pageContext.request.contextPath}/accountBook/deleteAccountBySeq");
							$("#selectFrm").submit();
						});

		$(".custom-select").on(
				"change",
				function() {
					$(this).parent().parent().children().children(".modifyBtn")
							.attr("class", "modifyBtn btn btn-info")

					$(this).parent().parent().children().children(".modifyBtn")
							.removeAttr("disabled");

				});
		$(".datepicker").on(
				"change",
				function() {
					$(this).parent().parent().children().children(".modifyBtn")
							.attr("class", "modifyBtn btn btn-info")
					$(this).parent().parent().children().children(".modifyBtn")
							.removeAttr("disabled");

				});
		$(".remark").on(
				"keyup",
				function() {
					$(this).parent().parent().children().children(".modifyBtn")
							.attr("class", "modifyBtn btn btn-info")
					$(this).parent().parent().children().children(".modifyBtn")
							.removeAttr("disabled");

				});
		$(".incomes").on(
				"input",
				function() {
					$(this).parent().parent().children().children(".modifyBtn")
							.attr("class", "modifyBtn btn btn-info")
					$(this).parent().parent().children().children(".modifyBtn")
							.removeAttr("disabled");
				});
		$(".expenses").on(
				"input",
				function() {
					$(this).parent().parent().children().children(".modifyBtn")
							.attr("class", "modifyBtn btn btn-info")
					$(this).parent().parent().children().children(".modifyBtn")
							.removeAttr("disabled");
				});
		$(".pdfBtn")
				.on(
						"click",
						function() {
							location.href = "${pageContext.request.contextPath}/accountBook/ListViewForPDF";
						});
		
		$("#printInvoice").on("click",function(){
			location.href="${pageContext.request.contextPath}/accountBook/excelDownload";
		});

		$(function() {
			//input을 datepicker로 선언
			$('.datepicker')
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
								showAnim : "slide",
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
								minDate : "-10M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
								,
								maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
							});

		});
		$(function() {
			$("#detailTable").DataTable({

			});
		});
	</script>
</body>
</html>