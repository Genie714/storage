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
<title>GroupList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="panel title">
	<h1>GroupList 페이지</h1>
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
					<a href="grouplist.action">
						그룹 관리 <span class="sr-only">(current)</span>
					</a>
				</li>
				<li>
					<a href="groupcreationform.action">
						그룹 생성 
					</a>
				</li>
				<li>
					<a href="groupcreationList.action">
						가개설 그룹 리스트 
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
					그룹 리스트 
				</span>
			</div>
			
			<div class="panel-body">
				전체 그룹 수
				<span class="badge">${count }</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<tr class="trTitle">
						<th>그룹ID</th>
						<th>그룹명</th>
						<th>소개글</th>
						<th>아이콘</th>
						<th>개설 일자</th>
						<th>그룹원 수</th>
						<th>그룹 홈</th>
						<th>가입</th>
						<th>관리</th>
					</tr>
					 
					 <c:forEach var="group" items="${list }">
					 <tr>
					 	<td>${group.id }</td>
					 	<td>${group.name }</td>
					 	<td>${group.introduction }</td>
					 	<td>${group.root }</td>
					 	<td>${group.open_date }</td>
					 	<td>${group.count }</td>
					 	
					 	<td>
							<a href="group.action?group_id=${group.id }" role="button" class="btn btn-success">그룹 홈</a>
					 	</td>
					 	<td>
							<a href="groupsignupquestionform.action?group_id=${group.id }" role="button" class="btn btn-success">가입</a>
					 	</td>
					 	<td>
							<a href="groupdelete.action?group_id=${group.id }" role="button" class="btn btn-danger">삭제</a>
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

























