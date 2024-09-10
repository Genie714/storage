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
<title>MomentInfo.jsp</title>
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
					if ($("#planEndMoment").val() != null && $("#planEndMoment").val() != "" && parseInt($("#planEndMoment").val()) < 1
						&& ($("#endMoment").val() == null || $("#endMoment").val() == ""))
					{
						alert("이미 계획기간이 끝난 모먼트에 참여할 수 없습니다.");
						return;
					}
					else if ($("#endMoment").val() != null && $("#endMoment").val() != "" && parseInt($("#endMoment").val()) < 1)
					{
						if (confirm("모먼트에 실제로 참석하지 않았는데 어플리케이션 상에서 참여를 신청할 경우 패널티를 받을 수 있습니다. 그래도 해당 모먼트에 참여하시겠습니까?"))
						{
							$("#myForm").submit();
						}
					}
					else
					{
						if (confirm("해당 모먼트에 참여하시겠습니까?"))
						{
							$("#myForm").submit();
						}
					}
				}
				else
				{
					if ($("#planEndMoment").val() != null && $("#planEndMoment").val() != "" && parseInt($("#planEndMoment").val()) < 1)
					{
						alert("이미 계획기간이 끝난 모먼트의 참여를 취소할 수 없습니다.");
						return;
					}
					else if (confirm("해당 모먼트의 참여를 취소하시겠습니까?"))
					{
						location.href = "momentcancel.action?moment_id=" + $("#moment_id").val() + "&group_id=" + $("#group_id").val();
					}
				}
			});
			
			$("#gallery").click(function()
			{
				$(location).attr("href", "gallery.action?group_id=" + $("#group_id").val() + "&moment_id=" + $("#moment_id").val());
			});
			
			
			$(".btn-default").click(function()
			{
				$(location).attr("href", "group.action?group_id=" + $("#group_id").val());
			});
			
			if ($("#endMoment").val() != null && $("#endMoment").val() != "")
			{
				$("#endThing").css("display", "inline");
				
				if ($(".btn-success").val() > 0)
				{
					$("#adjustment").css("display", "inline");
				}
			}

			
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
					모먼트 인포 조회
				<p></p>
				<p style="font-size: small; color: blue;">▷ ${momentList.parti_num }명이 ${endMoment <= 0 ? '참여한' : '참여 중인'} 모먼트입니다.<br>
				<b style="font-size: small; color: purple;">&nbsp&nbsp&nbsp 인포 마감 : ${momentList.plan_end_date}</b>
				</p>
				<div>
					<table>
						<tr style="height: 10px;">
						</tr>
					</table>
				</div>
				<div>
					<h4 style="font-weight: bold;">현재 참여 중인 멤버</h4>
					<c:forEach var="parti" items="${partiList }">
						<p style="font-size: small; color: navy;"> ☆ ${parti.participant_name }</p>
					</c:forEach>
				</div>
				<input type="hidden" id="parti_num" value="${momentList.parti_num }">
				</span>
			</div>
			
			<div style="${countDate > 0  && countJoin < 1 ? 'display: inline;' : 'display: none;' }">
				<span style="color: red; font-weight: bold;">해당 모먼트의 일시에 이미 일정이 존재합니다.<br>
				신중하게 참여를 결정해주세요.</span>
			</div>
			
			<div class="panel-body">
				<form action="momentjoin.action?group_id=<%=request.getParameter("group_id") %>" method="post" id="myForm">
					<table class="table">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px; font-weight: bold;">
										모먼트명
									</span>
									<input type="text" id="moment_name" name="moment_name" class="form-control" readonly="readonly"
									value="${momentList.moment_name }" style="width: 1000px;">
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
									value="${momentList.date_name }" style="width: 1000px;">
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
									value="${momentList.place_name }" style="width: 1000px;">
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
									value="${momentList.min_participant }" style="width: 1000px;">
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
									value="${momentList.max_participant }" style="width: 1000px;">
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
									${momentList.note }
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
								<input type="hidden" id="moment_id" name="moment_id" value="${momentList.moment_id }">
								<input type="hidden" id="phase" name="phase"value="${momentList.phase }">
								<input type="hidden" id="group_id" value="<%=request.getParameter("group_id") %>">
								<input type="hidden" id="endMoment" value="${endMoment }">
								<input type="hidden" id="planEndMoment" value="${planEndMoment }">
							</td>
						</tr>
						
						<tr id="endThing" style="display: none;">
							<td>
								<button type="button" id="adjustment" class="btn btn-info" style="display: none;">정산 import할 자리</button>
								<button type="button" id="gallery" class="btn btn-info">갤러리</button>
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