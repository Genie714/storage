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
<style type="text/css">
	*
	{
		margin: 0;
		padding: 0;
	}
	
	#images
	{
		width: 650px;
		margin: 0 auto;
		overflow: hidden;
		padding-top: 10px;
	}
	
	div > article
	{
		float: left;
		margin-left: 10px;
		margin-bottom: 10px;
	}
	
	img
	{
		display: block;
		width: 350px;
		height: 250px;
	}
	

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

	function galleryLink(gallery_id)
	{
		location.href = "gallerypage.action?gallery_id=?" + gallery_id;
	}

</script>

</head>
<body>

<div class="panel title">
	<h1>갤러리</h1>
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
						갤러리 <span class="sr-only">(current)</span>
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
					갤러리
				</span>
				<span class="col-md-9">
					<a href="galleryform.action?moment_id=<%=request.getParameter("moment_id") %>
					&group_id=<%=request.getParameter("group_id") %>" role="button" class="btn btn-success btn-xs" id="btnAdd"
					style="vertical-align: bottom;">게시글 업로드</a>
				</span>
			</div>
			
			<div class="panel-body">
				전체 게시글 수
				<span class="badge">${galleryCount }</span>
			</div>
		     
		    <div class="panel-body">
		    	<div class="images">
		    	<c:choose>
					<c:when test="${galleryList != '[]' }">
						<c:forEach var="article" items="${galleryList }">
							<article><img onclick="galleryLink('${article.gallery_id}')" src="${article.root }" class="img"></article>
						</c:forEach>
					</c:when>
					
					<c:when test="${galleryList == '[]' }">
				    	<div style="text-align: center;">
				    		<span style="font-weight: bold; font-size: x-large;">아직 게시글이 없습니다.</span>
				    	</div>
				    </c:when>
	        	</c:choose>
		    	</div>	
		    </div>
		    
		    
		</div>
	</div>
</div>

</body>
</html>