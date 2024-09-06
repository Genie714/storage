<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MemberInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<script type="text/javascript" src="<%=cp %>/js/jquery-ui.js"></script>

<script type="text/javascript">

	$(document).ready(function()
	{
		$("#nullError").css("display", "none");
		
		$("#birth_date").datepicker(
		{
			dateFormat : "yy-mm-dd"
			, changeYear : true
			, changeMonth : true
			, maxDate : 0
		});
		
		$("#my_id").change(function()
		{
			$("#idError1").css("display", "none");
			$("#idError2").css("display", "none");
			$("#idError3").css("display", "none");
			
			var my_id = $("#my_id").val();
			
			var params = "my_id=" + my_id;
			$.ajax(
			{
				type : "POST"
				, url : "memberidcount.action"
				, data : params
				, dataType : "xml"					//-- check
				, success : function(id)
				{
					
					$(id).find("lists").each(function()
					{
						var lists = $(this);
						var countId = lists.find("count").text();
						
						if (countId != "" && parseInt(countId) > 0)
						{
							$("#idError1").css("display", "inline");
							$("#my_id").focus();
							return;
						}
					});

				}
				, error : function(e)
				{
					alert(e.responseText);
				}
				
			});
			
			if (my_id.length < 6)
			{
				$("#idError2").css("display", "inline");
				$("#my_id").focus();
				return;
			}
			
			let checkNum = /[0-9]/;
			let checkEng = /[a-zA-Z]/;
			let checkSpc = /[~!@#$%^&*()_+|<>?:{}]/;
			let checkKor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			
			var flagSpc = checkSpc.test(my_id);
			var flagKor = checkKor.test(my_id);
			
			if (flagSpc || flagKor)
			{
				$("#idError3").css("display", "inline");
				$("#my_id").focus();
				return;
			}
		});
		
		$("#pw").change(function()
		{
			$("#pwError1").css("display", "none");
			$("#pwError2").css("display", "none");
			$("#pwError3").css("display", "none");
			
			var pw = $("#pw").val();
			
			if (pw.length < 8)
			{
				$("#pwError1").css("display", "inline");
				$("#pw").focus();
				return;
			}
			
			let checkNum = /[0-9]/;
			let checkEng = /[a-zA-Z]/;
			let checkSpc = /[~!@#$%^&*()_+|<>?:{}]/;
			let checkKor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			
			var flagNum = checkNum.test(pw);
			var flagEng = checkEng.test(pw);
			
			if (!flagNum || !flagEng)
			{
				$("#pwError2").css("display", "inline");
				$("pw").focus();
				return;
			}
		});
		
		
		$("#user_name").change(function()
		{
			$("#nameError1").css("display", "none");
			$("#nameError2").css("display", "none");
			
			var user_name = $("#user_name").val();
			
			if (user_name.length < 2)
			{
				$("#nameError1").css("display", "inline");
				$("#my_id").focus();
				return;
			}
			
			var params = "user_name=" + user_name;		
			$.ajax(
			{
				type : "POST"
				, url : "membernamecount.action"
				, data : params
				, dataType : "xml"					
				, success : function(name)
				{
					
					$(name).find("lists").each(function()
					{
						var lists = $(this);
						var count = lists.find("count").text();
						
						if (parseInt(count) > 0)
						{
							$("#nameError2").css("display", "inline");
							$("#user_name").focus();
							return;
						}
					});

				}
				, error : function(e)
				{
					alert(e.responseText);
				}
				
			});
		});
			
		
		$("#answer").change(function()
		{
			$("#answerError").css("display", "none");
			
			if ($("#answer").val().length < 2)
			{
				$("#answerError").css("display", "inline");
				$("#answer").focus();
				return;
			}
			
		});
		
		$(".btn-success").click(function()
		{
			var flag = true;
			
			if ($("#my_id").val() == "" || $("#pw").val() == "" || $("#user_name").val() == ""
			   || $("#answer").val() == "" || $("#birth_date").val() == "")
			{
				$("#nullError").css("display", "inline");
				flag = false;
			}
			
			if ($("#idError1").css("display") == "inline" || $("#idError2").css("display") == "inline" || $("#idError3").css("display") == "inline"
			   || $("#pwError1").css("display") == "inline" || $("#pwError2").css("display") == "inline" 
			   || $("#nameError1").css("display") == "inline" || $("#nameError1").css("display") == "inline"
			   || $("#answerError").css("display") == "inline" || $("#birthDateError").css("display") == "inline")
			{
				flag = false;
			}
			
			if (flag)
			{
				$("#myForm").submit();
			}
			
		});
		
	});
		
		

</script>

</head>
<body>

<div class="panel title">
	<h1>회원가입</h1>
</div>

<!-- 메인 메뉴 영역 -->
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Home</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="#">
						어플리케이션 <span class="sr-only">(current)</span>
					</a>
				</li>
			</ul>
		</div><!-- .collapse .navbar-collapse -->
		
	</div><!-- .container-fluid -->
</nav>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<div class="panel-heading" style="height: 60px;">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					회원 정보 입력
				</span>
			</div>
			
			<div class="panel-body">
				<form action="memberinsert.action" method="post" id="myForm">
					<table class="table">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										아이디
									</span>
									<input type="text" id="my_id" name="my_id" class="form-control"
									placeholder="아이디" maxlength="12" required="required">
									<span class="input-group-addon">6 ~ 12자 / 영어, 숫자 사용 가능</span>
								</div>
							</td>
						</tr>
						<tr>
							<td style="display: none;"id="idError1" class="error">
								<span style="font-size: small; color: red;">※ 이미 존재하는 아이디입니다.</span>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="idError2" class="error">
								<span style="font-size: small; color: red;">※ 6자 이상 입력해야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="idError3" class="error">
								<span style="font-size: small; color: red;">※ 사용 불가능한 문자입니다.</span>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										비밀번호
									</span>
									<input type="password" id="pw" name="pw" class="form-control"
									placeholder="비밀번호" maxlength="16" required="required">
									<span class="input-group-addon">8 ~ 16자 / 영어, 숫자 필수(특수문자 사용 가능) </span>
								</div>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="pwError1" class="error">
								<span style="font-size: small; color: red;">※ 8자 이상 입력해야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="pwError2" class="error">
								<span style="font-size: small; color: red;">※ 영어, 숫자가 포함되어야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										닉네임
									</span>
									<input type="text" id="user_name" name="user_name" class="form-control"
									placeholder="닉네임" maxlength="30" required="required">
									<span class="input-group-addon">2 ~ 30자 / 중복 불가</span>
								</div>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="nameError1" class="error">
								<span style="font-size: small; color: red;">※ 2자 이상 입력해야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="nameError2" class="error">
								<span style="font-size: small; color: red;">※ 이미 존재하는 닉네임입니다.</span>
							</td>
						</tr>
						<tr style="height: 10px;">
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										생년월일
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" id="birth_date" name="birth_date" placeholder="생년월일" required="required">
							</td>
						</tr>
						<tr style="height: 10px;">
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										성별
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" id="male" name="gender_id" value="GD01" checked="checked" class="gender">
								<label for="male" style="font-size: 14px;">남성</label>
								<input type="radio" id="female" name="gender_id" value="GD02" class="gender">
								<label for="female" style="font-size: 14px;">여성</label>
							</td>							
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										비밀번호 찾기 질문 / 답변
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<select id="find_id" name="find_id">
									<c:forEach var="find" items="${findList }">
										<option value="${find.find_id }">
											${find.question }
										</option>
									</c:forEach>
								</select>
								<input type="text" id="answer" name="answer" class="form-control"
									placeholder="답변" maxlength="100" required="required">
							</td>
						</tr>
						<tr>
							<td style="display: none;" id="answerError" class="error">
								<span style="font-size: small; color: red;">※ 2자 이상 입력해야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;">
								<button type="button" class="btn btn-success">등록</button>
								<button type="reset" class="btn btn-default">취소</button>
								<br>
								
								<span id="nullError" style="font-size: small; color: red; display: none;">
									필수입력 사항을 모두 입력해야 합니다.
								</span>
							</td>
							<td></td>
						</tr>
					</table>
				</form>
			</div>
		
		</div>
	</div>
</div>




</body>
</html>