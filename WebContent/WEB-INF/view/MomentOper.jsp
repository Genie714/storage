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
<title>MomentOper.jsp</title>
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
			$(".btn-success").click(function()
			{
				if (parseInt($("#max_participant").val()) <= parseInt($("#parti_num").val()))
				{
					alert("이미 최대인원이 채워졌습니다. 참여가 불가능합니다.");
					return;
				}
				
				if ($(this).val() < 1)
				{
					if (confirm("해당 모먼트에 참여하시겠습니까?"))
					{
						$("#myForm").submit();
					}
				}
				else
				{
					if (confirm("해당 모먼트의 참여를 취소하시겠습니까?"))
					{
						location.href = "momentopercancel.action?moment_id=" + $("#moment_id").val() + "&group_id=" + $("#group_id").val();
					}
				}
			});
			
			$(".btn-default").click(function()
			{
				$(location).attr("href", "group.action?group_id=" + $("#group_id").val());
			});

			
		});

</script>

</head>
<body>

<div class="panel title">
	<h1>모먼트</h1>
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
					<a href="group.action">
						모먼트<span class="sr-only">(current)</span>
					</a>
				</li>
			</ul>
		</div><!-- .collapse .navbar-collapse -->
		
	</div><!-- .container-fluid -->
</nav>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<div class="panel-heading" style="height: 100px;">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					모먼트 오퍼 조회
				<p></p>
				<p style="font-size: small; color: blue;">▷ 현재 ${dto.parti_num }명이 참여 중인 모먼트입니다.<br>
				<b style="font-size: small; color: purple;">&nbsp&nbsp&nbsp 오퍼 마감 : ${dto.plan_end_date}</b>
				</p>
				<input type="hidden" id="parti_num" value="${dto.parti_num }">
				</span>
			</div>
			
			<div style="${countDate > 0  && countJoin < 1 ? 'display: inline;' : 'display: none;' }">
				<span style="color: red; font-weight: bold;">해당 모먼트의 일시에 이미 일정이 존재합니다.<br>
				신중하게 참여를 결정해주세요.</span>
			</div>
			
			<div class="panel-body">
				<form action="momentoperjoin.action?group_id=<%=request.getParameter("group_id") %>" method="post" id="myForm">
					<table class="table">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										모먼트명
									</span>
									<input type="text" id="moment_name" name="moment_name" class="form-control" readonly="readonly"
									value="${dto.moment_name }" style="width: 1000px;">
								</div>
							</td>
						</tr>
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										일시
									</span>
									<input type="text" id="date_name" name="date_name" class="form-control" readonly="readonly"
									value="${dto.date_name }" style="width: 1000px;">
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										장소
									</span>
									<input type="text" id="place_name" name="place_name" class="form-control" readonly="readonly"
									value="${dto.place_name }" style="width: 1000px;">
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										최소 인원
									</span>
									<input type="text" id="min_participant" name="min_participant" class="form-control" readonly="readonly"
									value="${dto.min_participant }" style="width: 1000px;">
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										최대 인원
									</span>
									<input type="text" id="max_participant" name="max_participant" class="form-control" readonly="readonly"
									value="${dto.max_participant }" style="width: 1000px;">
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										참고사항
									</span>
									<textarea rows="10" cols="200" id="note" name="note" class="form-control"
									 readonly="readonly" style="text-align: left;">
									${dto.note }
									</textarea>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td style="text-align: center;">
								<button type="button" class="btn btn-success" value="${countJoin }">
								${countJoin > 0 ? "참여 취소" : "참여" }</button>
								<button type="button" class="btn btn-default">목록으로</button>
								<input type="hidden" id="moment_id" name="moment_id" value="${dto.moment_id }">
								<input type="hidden" id="phase" name="phase" class="form-control" value="${dto.phase }">
								<input type="hidden" id="group_id" value="<%=request.getParameter("group_id") %>">
							</td>
						</tr>
					</table>
				</form>
			</div>
		
		</div>
	</div>
</div>




</body>
</html>