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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

	
	$(document).ready(function()
	{
		$("#submitBtn").click(function()
		{
			//확인
			//alert("gd");

			$("#error").css("diplay", "none");

			if ($("#my_id").val() == "" || $("#pw").val() == "")
			{
				$("#error").html("항목을 모두 입력해야 합니다.").css("display", "inline");
				return;
			}

			$("#loginForm").submit();
		});
	});
</script>
</head>
<body>


<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading" id="title">
				로그인
			</div>
			<div class="panel-body">
				<form id="loginForm" role="form" action="login.action" method="post">
					<div class="form-group">
						<label for="my_id">
							아이디 
						</label>
						<input type="text" name="my_id" id="my_id" class="form-control" 
						placeholder="아이디를 입력하세요"/>
					</div>
		
					<div class="form-group">
						<label for="pw">
							패스워드
						</label>
						<input type="text" name="pw" id="pw" class="form-control" 
						placeholder="비밀번호를 입력하세요"/>
					</div>
					<div class="form-group">
						<label>
							관리자
							<input type="checkbox" name="admin" id="admin" value="0" class="form-control" />
						</label>
					</div>
					<button type="button" id="submitBtn" class="btn btn-default btn-sm"
					style="width: 100%;">Login</button>
					
					<div class="form-group">
						<a href="">회원가입</a>
						<a href="">아이디찾기</a>						
						<a href="">비밀번호찾기</a>						
					</div>
					
					<span id="error" style="color: red; display: none;" ></span>
				</form>
			</div>
		</div>
	</div>
</div>





</body>
</html>