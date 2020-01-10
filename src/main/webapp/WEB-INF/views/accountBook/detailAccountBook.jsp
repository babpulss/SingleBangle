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
<link rel="stylesheet"
	href="/resources/css/accountCSS/detailAccountCSS.css" />
<script src="/resources/js/accountJS/accountJS.js"></script>
</head>
<body>


	<div class="container">
		<div class="invoice row">
			<div class="col-12">
				<div class="card">
					<div class="card-body p-0">
						<div class="row p-5">
							<div class="col-md-6">
								<h1><c:out value="${month }"/>월 수입/지출 정보</h1>
							</div>

							<div class="col-md-6 text-right">
								<button id="printInvoice" class="btn btn-info">
									<i class="fa fa-print"></i> Print
								</button>
								<button class="btn btn-info">
									<i class="fa fa-file-pdf-o"></i> Export as PDF
								</button>
							</div>
						</div>

						<hr class="my-1">

						<div class="row pb-5 p-5">
							<div class="col-md-6">
								<p class="font-weight-bold mb-4"></p>
								<p class="mb-1"></p>

								<!--                             <p class="mb-1">6781 45P</p> -->
							</div>

							<div class="col-md-6 text-right">
								<p class="font-weight-bold mb-4">Payment Details</p>
								<p class="mb-1">
									<span class="text-muted">카드 : </span> 4,065,000원
								</p>
								<p class="mb-1">
									<span class="text-muted">현금 : </span> 235,000원
								</p>
								<p class="mb-1">
									<span class="text-muted">이름 : </span> 김필동
								</p>
							</div>
						</div>

						<div class="row p-5">
							<div class="col-md-12">
								<table class="table">
									<thead>
										<tr>
											<th class="border-0 text-uppercase small font-weight-bold">날짜</th>
											<th class="border-0 text-uppercase small font-weight-bold">용도</th>
											<th class="border-0 text-uppercase small font-weight-bold">결제방식</th>
											<th class="border-0 text-uppercase small font-weight-bold">입/출금</th>
											<th class="border-0 text-uppercase small font-weight-bold">금액</th>
											<th class="border-0 text-uppercase small font-weight-bold">비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list }" var="list">
											<tr>
												<td>${list.reportingDate }</td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="inlineFormCustomSelect">
														<option selected>${list.details}</option>
														<option value="1">식비</option>
														<option value="2">문화 생활비</option>
														<option value="3">교통비</option>
														<option value="4">관리비</option>
														<option value="5">급여</option>
														<option value="6">저축</option>
														<option value="7">기타</option>
												</select></td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="inlineFormCustomSelect">
														<option selected>${list.payments }</option>
														<option value="1">카드</option>
														<option value="2">현금</option>
												</select></td>
												<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0"
													id="inlineFormCustomSelect">
														<option selected>${list.spec }</option>
														<option value="1">수입</option>
														<option value="2">지출</option>
												</select></td>
												<c:choose>

													<c:when test="${list.income != 0 }">
														<td style="color: dodgerblue"><fmt:formatNumber
																value="${list.income}" pattern="###,###원" /></td>
													</c:when>
													<c:otherwise>
														<td style="color: red"><fmt:formatNumber
																value="${list.expense}" pattern="###,###원" /></td>
													</c:otherwise>
												</c:choose>
												<td>${list.remarks}</td>
											</tr>
											<!-- 										<td>2019-12-02</td> -->
											<!-- 										<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 											id="inlineFormCustomSelect"> -->
											<!-- 												<option selected>관리비</option> -->
											<!-- 												<option value="1">식비</option> -->
											<!-- 												<option value="2">문화 생활비</option> -->
											<!-- 												<option value="3">교통비</option> -->
											<!-- 												<option value="4">관리비</option> -->
											<!-- 												<option value="5">급여</option> -->
											<!-- 												<option value="6">저축</option> -->
											<!-- 												<option value="7">기타</option> -->
											<!-- 										</select></td> -->
											<!-- 										<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 											id="inlineFormCustomSelect"> -->
											<!-- 												<option selected>카드</option> -->
											<!-- 												<option value="1">카드</option> -->
											<!-- 												<option value="2">현금</option> -->
											<!-- 										</select></td> -->
											<!-- 										<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 											id="inlineFormCustomSelect"> -->
											<!-- 												<option selected>지출</option> -->
											<!-- 												<option value="1">수입</option> -->
											<!-- 												<option value="2">지출</option> -->
											<!-- 										</select></td> -->
											<!-- 										<td style="color: red">800,000원</td> -->
											<!-- 										<td>아파트 관리 / 차량 할부</td> -->
											<!-- 										</tr> -->
											<!-- 										<tr> -->
											<!-- 											<td>2019-12-15</td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>문화 생활비</option> -->
											<!-- 													<option value="1">식비</option> -->
											<!-- 													<option value="2">문화 생활비</option> -->
											<!-- 													<option value="3">교통비</option> -->
											<!-- 													<option value="4">관리비</option> -->
											<!-- 													<option value="5">급여</option> -->
											<!-- 													<option value="6">저축</option> -->
											<!-- 													<option value="7">기타</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>현금</option> -->
											<!-- 													<option value="1">카드</option> -->
											<!-- 													<option value="2">현금</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>지출</option> -->
											<!-- 													<option value="1">수입</option> -->
											<!-- 													<option value="2">지출</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td style="color: red">235,000원</td> -->
											<!-- 											<td>데이트(공연)</td> -->
											<!-- 										</tr> -->
											<!-- 										<tr> -->
											<!-- 											<td>2019-12-22</td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>기타</option> -->
											<!-- 													<option value="1">식비</option> -->
											<!-- 													<option value="2">문화 생활비</option> -->
											<!-- 													<option value="3">교통비</option> -->
											<!-- 													<option value="4">관리비</option> -->
											<!-- 													<option value="5">급여</option> -->
											<!-- 													<option value="6">저축</option> -->
											<!-- 													<option value="7">기타</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>카드</option> -->
											<!-- 													<option value="1">현금</option> -->
											<!-- 													<option value="2">카드</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td><select class="custom-select mb-2 mr-sm-2 mb-sm-0" -->
											<!-- 												id="inlineFormCustomSelect"> -->
											<!-- 													<option selected>지출</option> -->
											<!-- 													<option value="1">수입</option> -->
											<!-- 													<option value="2">지출</option> -->
											<!-- 											</select></td> -->
											<!-- 											<td style="color: red">3,265,000원</td> -->
											<!-- 											<td>쇼핑</td> -->
											<!-- 										</tr> -->
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						<div class="d-flex flex-row-reverse bg-dark text-white p-4">
							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 수입/지출비용</div>
								<div class="h2 font-weight-light"><fmt:formatNumber
																value="${incomeSUM-expenseSUM}" pattern="###,###원" /></div>
							</div>

							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 수입 비용</div>
								<div class="h2 font-weight-light" style="color: dodgerblue"><fmt:formatNumber
																value="${incomeSUM}" pattern="###,###원" /></div>
							</div>

							<div class="py-3 px-5 text-right">
								<div class="mb-2">총 지출 비용</div>
								<div class="h2 font-weight-light" style="color: red">-<fmt:formatNumber
																value="${expenseSUM}" pattern="###,###원" /></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="text-light mt-5 mb-5 text-center small">
			by : <a class="text-light" target=""
				href="${pageContext.request.contextPath}/">Single Bangle</a>
		</div>

	</div>
</body>
</html>