<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String user_id = (String)session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" constent="width=device-width, initial-scale=1">
<title>Test</title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
<div>
<%=user_id %>

<c:if test="<%=user_id ==null %>">
<button type="button" id="loginBtn" onclick="location.href='loginform.action'">로그인</button>
</c:if>
<c:if test="<%=user_id !=null %>">
<button type="button" id="logoutBtn" onclick="location.href='logout.action'">로그아웃</button>
</c:if>
<c:import url="ComplaintButton.jsp"></c:import>
</div>
</body>
</html>