<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ComplaintList.jsp</title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>

</head>
<body>


<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading" id="title">
				신고사항입력
			</div>
			<div class="panel-body">
				<form id="complaintForm" role="form" action="complaintinsert.action" method="post">
					<div class="form-group">
						<label for="reason_id">
							신고사유
						</label>
						<select name="reason_id" id="reason_id" class="form-control">
							 <c:forEach var="item" items="${reasonList }">
							 <option value="${item.id }">${item.contents }</option>
							 </c:forEach>
						</select>
					</div>
		
					<div class="form-group">
						<label for="contents">
							신고내용 
						</label>
						<textarea name="contents" id="contents" cols="30" rows="10" class="form-control"></textarea>
					</div>
					
					<button id="sumitBtn" type="button" class="btn btn-success btn-sm">SUBMIT</button>
				</form>
			</div>
		</div>
	</div>
</div>

<div>
	<!-- 콘텐츠 영역 -->
	<div id="container">			
		<table id="complaintList" class="table">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주민번호</th>
				<th>생년월일</th>
				<th>양/음력</th>
				<th>전화번호</th>
				<th>지역</th>
				<th>부서</th>
				<th>직위</th>
				<th>기본급</th>
				<th>수당</th>
				<th>급여</th>
				<th>등급</th>
				
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="item" items="${complaintList}">
			<tr>
				<td>${item.employeeId }</td>
				<td>${item.name}</td>
				<td>${item.ssn1}-*******</td>
				<td>${item.birthday}</td>
				<td>${item.lunarName}</td>
				<td>${item.telephone }</td>
				<td>${item.regionName }</td>
				<td>${item.departmentName }</td>
				<td>${item.positionName}</td>
				
				<%-- <td>${item.basicPay}</td> --%>
				<td>
					<fmt:formatNumber value="${item.basicPay}" groupingUsed="true"></fmt:formatNumber>
				</td>
				
				<td>
					<fmt:formatNumber value="${item.extraPay}" groupingUsed="true"></fmt:formatNumber>
				</td>
				
				<td>
					<fmt:formatNumber value="${item.pay}" groupingUsed="true"></fmt:formatNumber>
				</td>
				<td>${item.grade==0 ? "관리자" : "일반사원"}</td>
				
				<td><button type="button" class="btn updateBtn btn-primary"
					value="${item.employeeId }" style="width: 100%;">수정</button></td>
				<td><button type="button" class="btn deleteBtn btn-primary"
					value="${item.employeeId }" style="width: 100%;">삭제</button></td>
			</tr>
			</c:forEach>
		
		</table>
		
		
	</div>
</div>




</body>
</html>