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
<title>ComplaintInsertForm.jsp </title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$("#sumitBtn").click(function()
		{	
			// 신고자 폼에 담기
			var user_id = '<%=session.getAttribute("user_id")  %>';
			
			var inputComplainter = document.createElement("input");
			inputComplainter.type = "hidden";
			inputComplainter.name = "complainter_user_id";
			inputComplainter.value = user_id;
			
			$("#complaintForm").append(inputComplainter);
		
			// 신고당하는 사람 추후 작업
			
			if ($("#contents").val() == "")
			{
				alert("내용을 입력해야합니다.");
				return;
			}
			
			$("#complaintForm").submit();
			
		});
	});
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





</body>
</html>