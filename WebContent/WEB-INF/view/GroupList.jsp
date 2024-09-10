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

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function()
	{
		$("#searchGroupName").click(function()
		{
			//alert("test");
			$("#nameErr").css("display", "none");
			$("#noneErr").css("display", "none");
			if ($("#name").val() == "")
			{
				$("#nameErr").css("display", "inline");
				return;
			}
			
			
			var params = "name=" + $("#name").val();
			
			$.ajax(
			{
				type: "POST"
				, url : "groupnamecount.action"
				, data : params
				, dataType : "xml"
				, success : function(count)
				{
					var isGroupExist = false;
					
					$(count).find("lists").each(function()
					{
						var lists = $(this);
						var count = lists.find("count").text();
						
						if (parseInt(count) == 0)
						{
							$("#noneErr").css("display", "inline");
							isGroupExist = false;
							return false;
							
						}
						else
						{
							isGroupExist = true;
							
						}
						
					});
					
				
			
				if (isGroupExist == true)
				{
					$("#searchForm").submit();
				}
			}
				, error : function(e)
				{
					alert(e.responseText);	
				}
				
				
			});
			
			
			
			
		});
		
	});


</script>
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

<!-- 그룹 기본 정책 -->
<div class="alert alert-info" role="alert" style="margin: 20px;">
    <strong>그룹 기본 정책:</strong> 불건전한 목적성 그룹을 주의해주세요.
</div>

<!-- 검색창 추가 -->
<div class="container" style="margin-bottom: 20px;">
	<div class="row">
		<div class="col-md-6">
			<form class="form-inline" action="searchgroup.action" method="get" id="searchForm">
				<div class="form-group">
					<label for="searchKeyword">그룹 검색: </label>
					<input type="text" class="form-control" id="name" name="keyword" placeholder="그룹명을 입력하세요">
				</div>
				<button type="button" class="btn btn-default" id="searchGroupName">검색</button>
				<span class="errMsg" id="nameErr" style="display: none; color: red;">검색어가 없습니다.</span>
				<span class="errMsg" id="noneErr" style="display: none; color: red;">해당 그룹이 존재하지 않습니다.</span>
			</form>
		</div>
	</div>
</div>

<div class="container">
	<!-- 인포 모먼트 수가 많은 그룹 (활성화된 그룹) -->
	<div class="panel panel-warning">
		<div class="panel-heading text-left">
			<span style="font-size: 17pt; font-weight: bold;">활성화된 그룹 (인포 모먼트 수가 많은 그룹)</span>
		</div>
		
		<div class="panel-body">
			<table class="table table-hover table-striped">
				<tr class="trTitle">
					<th>그룹ID</th>
					<th>그룹명</th>
					<th>소개글</th>
					<th>아이콘</th>
					<th>개설 일자</th>
					<th>인포 모먼트 수</th>
					<th>그룹 홈</th>
				</tr>
				
				
				<tr>
					<td>${activeGroup.id }</td>
					<td>${activeGroup.name }</td>
					<td>${activeGroup.introduction }</td>
					<td>${activeGroup.root }</td>
					<td>${activeGroup.open_date }</td>
					<td>${activeCount }</td>
					<td>
						<a href="group.action?group_id=${activeGroup.id }" role="button" class="btn btn-success">그룹 홈</a>
					</td>
				</tr>
				
			</table>
		</div>
	</div>

	<!-- 최근 생성된 그룹 -->
	<div class="panel panel-info">
		<div class="panel-heading text-left">
			<span style="font-size: 17pt; font-weight: bold;">최근 생성된 그룹</span>
		</div>
		
		<div class="panel-body">
			<table class="table table-hover table-striped">
				<tr class="trTitle">
					<th>그룹ID</th>
					<th>그룹명</th>
					<th>소개글</th>
					<th>아이콘</th>
					<th>개설 일자</th>
					<th>그룹 홈</th>
				</tr>
				
				<c:forEach var="recentGroup" items="${recentList }">
				<tr>
					<td>${recentGroup.id }</td>
					<td>${recentGroup.name }</td>
					<td>${recentGroup.introduction }</td>
					<td>${recentGroup.root }</td>
					<td>${recentGroup.open_date }</td>
					<td>
						<a href="group.action?group_id=${recentGroup.id }" role="button" class="btn btn-success">그룹 홈</a>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<!-- 그룹원이 많은 그룹 -->
	<div class="panel panel-primary">
		<div class="panel-heading text-left">
			<span style="font-size: 17pt; font-weight: bold;">그룹원이 많은 그룹</span>
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
				</tr>
				
				
				<tr>
					<td>${largeGroup.id }</td>
					<td>${largeGroup.name }</td>
					<td>${largeGroup.introduction }</td>
					<td>${largeGroup.root }</td>
					<td>${largeGroup.open_date }</td>
					<td>${largeCount}</td>
					<td>
						<a href="group.action?group_id=${largeGroup.id }" role="button" class="btn btn-success">그룹 홈</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="container">
	<!-- 그룹 리스트 -->
	<div class="panel-group">
		<div class="panel panel-default">
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
					 	<td>${group.memberCount }</td>
					 	<td>
							<a href="group.action?group_id=${group.id }" role="button" class="btn btn-success">그룹 홈</a>
					 	</td>
					 	<td>
						    <c:set var="isFound" value="false" />
						    <c:forEach var="findGroup" items="${findGroup }">
						        <c:if test="${findGroup.group_id == group.id}">
						            <c:set var="isFound" value="true" />
						        </c:if>
						    </c:forEach>
						    
						    <c:choose>
						        <c:when test="${isFound}">
						            <a href="groupsignupquestionform.action?group_id=${group.id }" role="button" class="btn btn-success" disabled="disabled">가입</a>
						        </c:when>
						        <c:otherwise>
						            <a href="groupsignupquestionform.action?group_id=${group.id }" role="button" class="btn btn-success">가입</a>
						        </c:otherwise>
						    </c:choose>
						</td>
					 	<td>
							<a href="complaintinsert.action?group_id=${group.id }" role="button" class="btn btn-danger">신고</a>
					 	</td>
					 </tr>
					 </c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
		
			<!-- <div class="panel-heading row"> -->
			<div class="panel-heading" style="height: 60px;">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					가개설 그룹 리스트 
				</span>
			</div>
			
			<div class="panel-body">
				전체 가개설 그룹 수
				<span class="badge">${creationCount }</span>
			</div>
			
			<div class="panel-body">
				<table class="table table-hover table-striped">
					<tr class="trTitle">
						<th>가개설 그룹ID</th>
						<th>개설자</th>
						<th>그룹명</th>
						<th>소개글</th>
						<th>아이콘</th>
						<th>가개설 일자</th>
						<th>개설 마감 일자</th>
						<th>초기 그룹원 수</th>
					</tr>
					 
					 <c:forEach var="group" items="${creationList }">
					 	<c:if test="${group.count == '1' or group.count == '2' or group.count == '3' or group.count == '4' or group.end_date > sysdate}">
						 <tr>
						 	<td>${group.id }</td>
						 	<td>${group.user_id }</td>
						 	<td>${group.name }</td>
						 	<td>${group.introduction }</td>
						 	<td>${group.root }</td>
						 	<td>${group.creation_date }</td>
						 	<td>${group.end_date }</td>
						 	<td>${group.count }</td>
						 </tr>
					 	</c:if>
					 </c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>	
	