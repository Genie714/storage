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
<title>Group.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(document).ready(function()
	{
		
		$(".btn-success").click(function()
		{
			var moment_id = $(this).val();
			var className = $("#" + moment_id).attr("class");
			
			if (className == "MH01")
			{
				$(location).attr("href", "momentoper.action?moment_id=" + $(this).val() + "&group_id=" + $("#group_id").val());
			}
			else if (className == "MH02")
			{
				$(location).attr("href", "momentbuild.action?moment_id=" + $(this).val() + "&group_id=" + $("#group_id").val());
			}
			else if (className == "MH03")
			{
				$(location).attr("href", "momentinfo.action?moment_id=" + $(this).val() + "&group_id=" + $("#group_id").val());
			}
			
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
						모먼트 <span class="sr-only">(current)</span>
					</a>
				</li>
			</ul>
		</div><!-- .collapse .navbar-collapse -->
		
	</div><!-- .container-fluid -->
	
</nav>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<!-- <div class="panel-heading row"> -->
			<div class="panel-heading" style="height: 60px;">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					모먼트 출력
				</span>
				<span class="col-md-9">
					<a href="momentoperform.action?group_id=<%=request.getParameter("group_id") %>" role="button" class="btn btn-success btn-xs" id="btnAdd"
					style="vertical-align: bottom;">모먼트 생성</a>
				</span>
			</div>
			
			<div class="panel-body">
				내가 참여 중인 모먼트 수
				<span class="badge">${myCount }</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<tr class="title">
						<th>모먼트 명</th>
						<th>단계</th>
						<th>일시</th>
						<th>장소</th>
						<th>현재 멤버</th>
						<th>최소 인원</th>
						<th>최대 인원</th>
						<th>계획 마감 일시</th>
						<th>
						</th>
					</tr>
					<c:forEach var="moment" items="${myList }">
					<tr id="${moment.moment_id }" class="${moment.phase_id }">
						<td>${moment.moment_name }</td>
						<td>${moment.phase }</td>
						<td>${moment.date_name }</td>
						<td>${moment.place_name }</td>
						<td>${moment.parti_num }</td>
						<td>${moment.min_participant }</td>
						<td>${moment.max_participant == null ? "미정" : moment.max_participant}</td>
						<td>${moment.plan_end_date }</td>
						<td>
							<button type="button" class="btn btn-success" value="${moment.moment_id }">조회</button>
						</td>
					</tr>
					</c:forEach>
					
					<tr style="height: 10px;">
					</tr>
				</table>
				
			<div class="panel-body">
				전체 모먼트 수
				<span class="badge">${allCount }</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<tr class="title">
						<th>모먼트 명</th>
						<th>단계</th>
						<th>일시</th>
						<th>장소</th>
						<th>현재 멤버</th>
						<th>최소 인원</th>
						<th>최대 인원</th>
						<th>계획 마감 일시</th>
						<th>
							<input type="hidden" id="group_id" value="<%=request.getParameter("group_id") %>">
						</th>
					</tr>
					<c:forEach var="moment" items="${allList }">
					<tr id="${moment.moment_id }" class="${moment.phase_id }">
						<td>${moment.moment_name }</td>
						<td>${moment.phase }</td>
						<td>${moment.date_name }</td>
						<td>${moment.place_name }</td>
						<td>${moment.parti_num }</td>
						<td>${moment.min_participant }</td>
						<td>${moment.max_participant == null ? "미정" : moment.max_participant}</td>
						<td>${moment.plan_end_date }</td>
						<td>
							<button type="button" class="btn btn-success" value="${moment.moment_id }">조회</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		
		</div>
	</div>
</div>

</body>
</html>