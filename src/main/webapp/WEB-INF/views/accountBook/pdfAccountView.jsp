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
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="/resources/css/accountCSS/detailAccountCSS.css" />
<script src="/resources/js/accountJS/accountJS.js"></script>
</head>
<body>
	<form id="pdf" action="${pageContext.request.contextPath }/accountBook/accountPDF"
		method="post">
		<input type="hidden" class="pdfValue btn btn-info" id="pdfValue"
			name="pdfValue" value="" />
	</form>
	<div class="container">
		<div class="invoice row">
			<div class="col-12">
				<div class="card">
					<div class="card-body p-0">
						<div class="row p-5" style="border-bottom: 1px solid gray">
							<div class="col-md-6" >
								<h1 class="h1" style="font-size: 18pt">
									<c:out value="${formedDate }" /></h1>
									수입/지출 정보
								
							</div>

							<div class="col-md-6 text-right">
								<button id="printInvoice" class="btn btn-info">
									<i class="fa fa-print"></i> Print
								</button>
								<button type="button" class="pdfBtn btn btn-info"
									value="PDF DownLoad">PDF DownLoad</button>


							</div>
						</div>
<!-- 						<hr class="my-1" /> -->
						<div class="row pb-5 p-5" style="padding-bottom: 20px">
							<div class="col-md-6">
								<p class="font-weight-bold mb-4"></p>
								<p class="mb-1"></p>

							</div>

							<div class="col-md-6 text-right" style="text-align: right">
								<p class="font-weight-bold mb-4" style="font-weight: bold;">Payment Details</p>
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
												<td>${list.details}</td>
												<td>${list.payments }</td>
												<td>${list.spec }</td>
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

										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>

						<div class="d-flex flex-row-reverse bg-dark text-white p-4" style="background-color: #424242; padding-top:20px; padding-bottom:20px;">
							<div class="py-3 px-5 text-right" style="float:left; width:35%; padding-left: 40px;">
								<div class="mb-2" style="color:white;">총 수입 비용</div>
								
								<div class="h2 font-weight-light" style="color: dodgerblue">
									<fmt:formatNumber value="${in}" pattern="###,###원" />
								</div>
							</div>

							<div class="py-3 px-5 text-right" style="width:35%; float:left;  padding-left:30px;">
								<div class="mb-2" style="color:white;">총 지출 비용</div>
								<div class="h2 font-weight-light" style="color: red">
									-
									<fmt:formatNumber value="${out}" pattern="###,###원" />
								</div>
							</div>

							
							<div class="py-3 px-5 text-right" style="float:right; width:80%; padding-left:20px;">
								<div class="mb-2" style="color:white;">총 수입/지출비용</div>
								<div class="h2 font-weight-light"style="color:white;">
									<fmt:formatNumber value="${in-out}" pattern="###,###원" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="text-light mt-5 mb-5 text-center small" style="text-align: center">
			by : <a class="text-light" target=""
				href="#">Single Bangle</a>
		</div>
	</div>
	<script>
	$(".pdfBtn").on("click", function() {
		$("#pdfValue").val($(".container").html());
		console.log($("#pdfValue").val());
		$("#pdf").submit();
	});
	</script>
</body>
</html>