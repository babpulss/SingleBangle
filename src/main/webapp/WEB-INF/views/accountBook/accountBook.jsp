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
<link rel="stylesheet" href="/resources/css/accountCSS/accountCSS.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/resources/js/accountJS/accountJS.js"></script>
</head>
<body>
	<main class="container pt-5">
	<div class="card mb-5">

		<div class="card-header">
			<h2>
				<c:out value="${sessionScope.userName}" />
				(
				<c:out value="${sessionScope.id}" />
				) 의가계부
			</h2>
		</div>
		<div class="card-block p-0">
			<table class="table table-bordered table-sm m-0 table table-condensed table-hover">
				<thead>
					<tr>
						<th>날짜</th>
						<th>수입</th>
						<th>지출</th>
						<th>총 수입/지출 비용</th>
						<th>선택</th>
					</tr>
				</thead>
				<c:forEach items="${list }" var="list">
					<tbody>
						<tr>
							<td class="formedDate">${list.formedReportingDate}</td>
							<td class="income"><fmt:formatNumber value="${list.income}"
									pattern="###,###,###원" /></td>
							<td class="expense"><fmt:formatNumber value="${list.expense}"
									pattern="###,###,###원" /></td>
							<td><fmt:formatNumber value="${list.income-list.expense}"
									pattern="###,###,###원" /></td>
							<td><input type="button" name="${list.formedReportingDate}"class="detailBtn" value="상세보기">
								<input type="button" name="${list.formedReportingDate}" class="deleteBtn" value="삭제"></td>
						</tr>

					</tbody>
				</c:forEach>
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
	<!--         <table class="table table-bordered table-definition mb-5"> -->
	<!--             <thead class="table-warning "> --> <!--                 <tr> -->
	<!--                     <th></th> --> <!--                     <th>Name</th> -->
	<!--                     <th>Registration Date</th> --> <!--                     <th>E-mail address</th> -->
	<!--                     <th>Premium Plan</th> --> <!--                 </tr> -->
	<!--             </thead> --> <!--             <tbody> --> <!--                 <tr> -->
	<!--                     <td> --> <!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td>jhlilk22@yahoo.com</td> --> <!--                     <td>No</td> -->
	<!--                 </tr> --> <!--                 <tr> --> <!--                     <td> -->
	<!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td>jhlilk22@yahoo.com</td> --> <!--                     <td>No</td> -->
	<!--                 </tr> --> <!--                 <tr> --> <!--                     <td> -->
	<!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td>jhlilk22@yahoo.com</td> --> <!--                     <td>No</td> -->
	<!--                 </tr> --> <!--             </tbody> --> <!--             <tfoot> -->
	<!--                 <tr> --> <!--                     <th></th> --> <!--                     <th colspan="4"> -->
	<!--                         <button class="btn btn-primary float-right">Add User</button> -->
	<!--                         <button class="btn btn-default">Approve</button> -->
	<!--                         <button class="btn btn-default">Approve All</button> -->
	<!--                     </th> --> <!--                 </tr> --> <!--             </tfoot> -->
	<!--         </table> --> <!--         <table class="table  table-sm"> -->
	<!--             <thead class="table-info"> --> <!--                 <tr> -->
	<!--                     <th></th> --> <!--                     <th>Name</th> -->
	<!--                     <th>Registration Date</th> --> <!--                     <th>E-mail address</th> -->
	<!--                     <th>Premium Plan</th> --> <!--                 </tr> -->
	<!--             </thead> --> <!--             <tbody> --> <!--                 <tr> -->
	<!--                     <td> --> <!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td>jhlilk22@yahoo.com</td> --> <!--                     <td>No</td> -->
	<!--                 </tr> --> <!--                 <tr> --> <!--                     <td> -->
	<!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td class="table-danger">jhlilk22@yahoo.com</td> -->
	<!--                     <td>No</td> --> <!--                 </tr> -->
	<!--                 <tr> --> <!--                     <td> --> <!--                         <label class="custom-control custom-checkbox"> -->
	<!--                             <input type="checkbox" class="custom-control-input"> -->
	<!--                             <span class="custom-control-indicator"></span> -->
	<!--                         </label> --> <!--                     </td> -->
	<!--                     <td>John Lilki</td> --> <!--                     <td>September 14, 2013</td> -->
	<!--                     <td>jhlilk22@yahoo.com</td> --> <!--                     <td>No</td> -->
	<!--                 </tr> --> <!--             </tbody> --> <!--         </table> -->
	</main>
	<script>
		$(".detailBtn").on("click",function(){
			var report = $(this).attr("name");
			console.log(report);
			location.href="${pageContext.request.contextPath}/detailAccount?formedReportingDate="+report;						
		});
	</script>
</body>
</html>