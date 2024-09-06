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
<title>GroupCreationFormjsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="panel title">
	<h1>그룹생성신청폼</h1>
</div>

<!-- 메인 메뉴 영역 -->
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Home</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li>
					<a href="grouplist.action">
						그룹 관리 
					</a>
				</li>
				<li class="active">
					<a href="groupcreationform.action">
						그룹 생성 <span class="sr-only">(current)</span>
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
			<div class="panel-heading" style="height: 60px;">
				<span style="font-size: 17px; font-weight: bold;" class="col-md-3">
					그룹 데이터 입력
				</span>
				<span class="col-md-9">
					<a href="grouplist.action" role="button" class="btn btn-success btn-xs" id="btnAdd"
					style="vertical-align: bottom;">그룹 리스트 출력</a>
				</span>
			</div>
			
			<div class="panel-body">
				<form action="groupcreationinsert.action" method="post" id="myForm">
					<table class="table table-striped">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon1">
										그룹 번호 
									</span>
									<input type="text" id="id" name="id" class="form-control"
									placeholder="groupId" maxlength="30" required="required" readonly="readonly" value="${nextGCId }">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						 
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										생성자 ID <sup style="color: red;">※</sup>
									</span>
									<input type="text" id="user_id" name="user_id" class="form-control"
									placeholder="US00" maxlength="30" required="required">
								</div>
							</td>
						</tr>
						
						
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										그룹명 <sup style="color: red;">※</sup>
									</span>
									<input type="text" id="name" name="name" class="form-control"
									placeholder="ex) SIST" maxlength="30" required="required">
									<span class="input-group-addon">1 ~ 30 이내</span>
								</div>
							</td>
						</tr>
						
						
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										소개글 <sup style="color: red;">※</sup>
									</span>
									<input type="text" id="introduction" name="introduction" class="form-control"
									placeholder="ex) 안녕하세요" maxlength="40">
									<span class="input-group-addon">1 ~ 30 이내</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										그룹 아이콘  
									</span>
									<input type="text" id="root" name="root" class="form-control"
									placeholder="파일 첨부" maxlength="40">
									<span class="input-group-addon"><button type="button" >파일</button></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<span style="font-size: small;">(※)는 필수입력 사항입니다.</span>
							</td>
						</tr>
						
						<tr>
							<td style="text-align: center;">
								<button type="submit" class="btn btn-success">등록</button>
								<button type="reset" class="btn btn-default">취소</button>
								<br>
								
								
								<span style="font-size: small; color: red; display: none;">
									필수 입력 사항을 모두 입력해야 합니다.
								</span>
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























