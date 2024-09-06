<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%
	Calendar cal = Calendar.getInstance();

	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	int date = cal.get(Calendar.DATE);

    ArrayList<Integer> yearArr = new ArrayList<Integer>();
    for (int i = 0; i < 3; i++)
    	yearArr.add(i, year + i);
    
	ArrayList<Integer> monthArr = new ArrayList<Integer>();
    for (int i = 0; i < 12; i++)
    	monthArr.add(i, i + 1);
    
    ArrayList<String> timeArr = new ArrayList<String>();
    for (int i = 0; i < 24; i++)
    {
    	if (i < 10)
    	{
    		timeArr.add(i,  String.format("0%s:00:00", i));
    	}
    	else
    		timeArr.add(i,  String.format("%s:00:00", i));
    }
    	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MomentOperForm.jsp</title>
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
			$("#error").css("display", "none");
			$("#date_edit").css("display", "none");
			$("#place_edit").css("display", "none");
			var startYear = $("year").val();
			var today = new Date();
			var todayYear = today.getFullYear();
			var todayMonth = today.getMonth() + 1;
			var todayDate = today.getDate();
			
			var index = 0;
			for(var y = startYear; y <= todayYear; y++)
			{
				document.getElementById("year").options[index] = new Option(y, y);
				index++;
			}
			
			index = 0;
			
			for(var m= 1 ; m <= 12; m++){
				document.getElementById("month").options[index] = new Option(m, m);
				index++;
			}
			
			lastday();
			
			$("#year").val(todayYear).attr("selected", "selected");
			$("#month").val(todayMonth).attr("selected", "selected");
			$("#day").val(-1).attr("selected", "selected");
			$("#time").val(-1).attr("selected", "selected");
			
			var oldDay = $("#day").val();
			
			$("#year").change(function()
			{
				if (($("#year").val() == todayYear + 2 && $("#month").val() > todayMonth)
					|| ($("#year").val() == todayYear + 2 && $("#month").val() == todayMonth && $("#day").val() > todayDate)
					|| ($("#day").val() != -1 && $("#year").val() == todayYear && $("#month").val() == todayMonth && $("#day").val() <= todayDate + 2)
					|| ($("#day").val() != -1 && $("#year").val() == todayYear && $("#month").val() < todayMonth))
				{
					alert("오늘로부터 3일 뒤 ~ 2년 이내의 날짜만 입력 가능합니다.");
					$("#year").val(todayYear).attr("selected", "selected");
					$("#month").val(todayMonth).attr("selected", "selected");
					$("#day").val(oldDay).attr("selected", "selected");
					$("#time").val(-1).attr("selected", "selected");
				}
			});
			
			$("#month").change(function()
			{
				if (($("#year").val() == todayYear + 2 && $("#month").val() > todayMonth)
					|| ($("#year").val() == todayYear && $("#month").val() < todayMonth))
				{
					alert("오늘로부터 3일 뒤 ~ 2년 이내의 날짜만 입력 가능합니다.");
					$("#year").val(todayYear).attr("selected", "selected");
					$("#month").val(todayMonth).attr("selected", "selected");
					$("#day").val(oldDay).attr("selected", "selected");
					$("#time").val(-1).attr("selected", "selected");
				}
			});
			
			$("#day").change(function()
			{
				if (($("#day").val() != -1 && $("#year").val() == todayYear + 2 && $("#month").val() == todayMonth && $("#day").val() > todayDate)
					|| ($("#day").val() != -1 && $("#year").val() == todayYear && $("#month").val() == todayMonth && $("#day").val() <= todayDate + 2))
				{
					alert("오늘로부터 3일 뒤 ~ 2년 이내의 날짜만 입력 가능합니다.");
					$("#year").val(todayYear).attr("selected", "selected");
					$("#month").val(todayMonth).attr("selected", "selected");
					$("#day").val(oldDay).attr("selected", "selected");
					$("#time").val(-1).attr("selected", "selected");
				}
			});
			
			
			$(".dateSubmit").click(function()
					{
						// 테스트
						//alert("확인");
						
						var params = "year=" + $("#year").val() + "&month=" + $("#month").val()
							+ "&day=" + $("#day").val() + "&time=" + $("#time").val();
						
						$.ajax(
						{
							type : "POST"
							, url : "momentdateinsert.action"
							, data : params
							, dataType : "xml"					//-- check
							, success : function(date)
							{
								
								$(date).find("lists").each(function()
								{
									var lists = $(this);
									var date_id = lists.find("date_id").text();
									var year = lists.find("year").text();
									var month = lists.find("month").text();
									var day = lists.find("day").text();
									var time = lists.find("time").text();
									
									$("#date_id").val(date_id);
									$("#year").val(year).attr("selected", "selected");
									$("#month").val(month).attr("selected", "selected");
									$("#day").val(day).attr("selected", "selected");
									$("#time").val(time).attr("selected", "selected");
									
									$("#date_submit").attr("disabled", true);
									$("#date_edit").css("display", "inline");
								});

								
							}
							, error : function(e)
							{
								alert(e.responseText);
							}
							
						});
				});
			
			
			$("#date_edit").click(function()
			{
				$("#date_submit").attr("disabled", false);
				$("#date_edit").css("display", "none");
				$("#date_id").val("");
			});
			
			/*
			$(".placeSelect").click(function()
			{
				 
				var n = "";
				if ($(this).val() == 1)
				{
					n = "";
				}
				
				
				$("#placeTr").html("<td><input type='text' id='place' name='place' class='form-control' placeholder='장소' required='required'></td>" + $("#placeTr").html());
			});
			*/
			
			$(".placeSubmit").click(function()
			{
				// 테스트
				//alert($("#place").val());
				
				var params = "place_name=" + $("#place_name").val() + "&detail_id=" + $(".placeSelect").val();			
				$.ajax(
				{
					type : "POST"
					, url : "momentplaceinsert.action"
					, data : params
					, dataType : "xml"					//-- check
					, success : function(place)
					{
						
						$(place).find("lists").each(function()
						{
							var lists = $(this);
							var place_id = lists.find("place_id").text();
							var place_name = lists.find("place_name").text();
							
							$("#place_id").val(place_id);
							$("#place_name").val(place_name);
							
							$("#place_name").attr("readonly", true);
							$("#place_submit").attr("disabled", true);
							$("#place_edit").css("display", "inline");
							
						});

					}
					, error : function(e)
					{
						alert(e.responseText);
					}
					
				});
			});
			
			$("#place_edit").click(function()
			{
				$("#place_name").attr("readonly", false);
				$("#place_submit").attr("disabled", false);
				$("#place_edit").css("display", "none");
				$("#place_id").val("");
				
			});
			
			
			$(".btn-success").click(function()
			{
				if ($("#moment_name").val() == "" || $("#min_participant").val() == "")
				{
					$("#error").css("display", "inline");
					return false;
				}
				
				if (parseInt($("#min_participant").val()) < 2)
				{
					alert("최소 인원은 2명 이상이어야 합니다.");
					$("#min_participant").focus();
					return false;
				}
				
				if ($("#max_participant").val() != "" && parseInt($("#max_participant").val()) > parseInt($("#countMember").val()))
				{
					alert("최대 인원은 그룹원 수보다 많을 수 없습니다.");
					$("#max_participant").focus();
					return false;
				}
				
				if ($("#max_participant").val() != "" && parseInt($("#min_participant").val()) > parseInt($("#max_participant").val()))
				{
					alert("최소 인원은 최대 인원보다 많을 수 없습니다.");
					$("#min_participant").focus();
					return false;
				}
				
				
				if ($("#date_id").val() == "")
				{
					alert("추가 버튼을 눌러 일시를 추가해주세요.");
					$("#year").focus();
					return false;
				}
				
				if ($("#place_id").val() == "")
				{
					alert("추가 버튼을 눌러 장소를 추가해주세요.");
					$("#place").focus();
					return false;
				}
				
			});
			
			$(".btn-default").click(function()
			{
				$(location).attr("href", "group.action?group_id=" + $("#group_id").val());
			});

			
		});
		
		
		function lastday()
		{ 
			var year = document.getElementById("year").value;
			var month = document.getElementById("month").value;
			var day = new Date(new Date(year,month,1) - 86400000).getDate();
			
			var today = new Date();
			var todayDate = today.getDate();
			
		    /* = new Date(new Date(Year,Month,0)).getDate(); */
		    
		    document.getElementById("day").innerHTML = "";
		    
			var dayindexLen = document.getElementById("day").length;
			if (day > dayindexLen)
			{
				document.getElementById("day").innerHTML += "<option value='" + -1 + "' selected='selected'>" + "선택 없음" + "</option>";
				for (var i = (dayindexLen + 1); i <= day; i++)
				{
					document.getElementById("day").innerHTML += "<option value=' " + i + "'>" + i + "</option>";
				}
			}
			else if (day < dayindexLen)
			{
				for (var i=dayindexLen; i >= day; i--)
				{
					document.getElementById("day").options[i] = null;
				}
			}
		}
		
		

</script>

</head>
<body>

<div class="panel title">
	<h1>모먼트 생성</h1>
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
		
			<div class="panel-heading" style="height: 60px;">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					모먼트 데이터 입력
				</span>
			</div>
			
			<div class="panel-body">
				<form action="momentinsert.action?group_id=<%=request.getParameter("group_id") %>" method="post" id="myForm">
					<table class="table">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										모먼트명 <sup style="color: red;">※</sup>
									</span>
									<input type="text" id="moment_name" name="moment_name" class="form-control"
									placeholder="모먼트명" maxlength="30" required="required">
									<span class="input-group-addon">30자 이내</span>
								</div>
							</td>
							<td></td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										년도 <sup style="color: red;">※</sup>
									</span>
									<select id="year" name="year" class="form-control" onchange="lastday()" required="required">
										<!--  
										<option value="1">2024</option>
										<option value="2">2025</option>
										<option value="3">2026</option>
										 -->
										<%
										for (int i : yearArr)
										{
										%>
										<option value="<%=i %>">
										<%=i %>
										</option>
										<%
										}
										%>
									</select>
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										월 <sup style="color: red;">※</sup>
									</span>
									<select id="month" name="month" class="form-control" onchange="lastday()" required="required"> 
										<%
										for (int i : monthArr)
										{
											if (i == month)
											{
										%>
										<option value="<%=i %>" selected="selected">
										<%=i %>
										</option>
										<%
											}
											else
											{
										%>
										<option value="<%=i %>">
										<%=i %>
										</option>
										<%
											}
										}
										%>
									</select>
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										일
									</span>
									<select id="day" name="day" class="form-control"> 
									</select>
									<span class="input-group-addon" id="basic-addon3" style="width: 100px;">
										시간
									</span>
									<select id="time" name="time" class="form-control">
										<option value="-1" selected="selected">선택 없음</option>
										<%
										for (String i : timeArr)
										{
										%>
										<option value="<%=i %>">
										<%=i %>
										</option>
										<%
										}
										%>
									</select>
								</div>
							</td>
							<td>
								<input type="hidden" id="date_id" name="date_id">
								<button type="button" class="dateSubmit" id="date_submit">추가</button>
								<button type="button" class="dateEdit" id="date_edit" style="display: none;">수정</button>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										장소 <sup style="color: red;">※</sup>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" id="abstractPlace" name="place" value="1" checked="checked" class="placeSelect">
								<label for="abstractPlace" style="font-size: 14px;">대충 등록!</label>
								<input type="radio" id="fullPlace" name="place" value="2" class="placeSelect">
								<label for="fullPlace" style="font-size: 14px;">자세히 등록!</label>
							</td>
						</tr>
						<tr id="placeTr">
							<td><input type="text" id="place_name" name="place_name" class="form-control"
								 placeholder="장소" required="required"></td>
							<td>
								<button type="button" class="placeSubmit" id="place_submit">추가</button>
								<button type="button" class="placeEdit" id="place_edit" style="display: none;">수정</button>
							</td>
							<td><input type="hidden" id="place_id" name="place_id"></td>
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										최소 인원 <sup style="color: red;">※</sup>
									</span>
									<input type="text" id="min_participant" name="min_participant" class="form-control"
									placeholder="ex) 2" maxlength="30" required="required">
									<span class="input-group-addon">최소 2명</span>
								</div>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										최대 인원
									</span>
									<input type="text" id="max_participant" name="max_participant" class="form-control"
									placeholder="ex) 5" maxlength="30">
									<span class="input-group-addon">최대 ${countMember }명</span>
								</div>
							</td>
							<td>
							<input type="hidden" value="${countMember }" id="countMember">
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2" style="width: 100px;">
										참고사항
									</span>
									<textarea id="note" name="note" class="form-control" cols="30" rows="10"
									placeholder="ex) 노트북 챙겨와!" maxlength="200"></textarea>
									<span class="input-group-addon">200자 이내</span>
								</div>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<span style="font-size: small;">※은 필수입력 사항입니다.</span>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td style="text-align: center;">
								<button type="submit" class="btn btn-success">등록</button>
								<button type="reset" class="btn btn-default">취소</button>
								<br>
								
								<span style="font-size: small; color: red; display: none;" id="error">
									필수입력 사항을 모두 입력해야 합니다.
								</span>
							</td>
							<td>
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