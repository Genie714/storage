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
<title>Group.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style type="text/css">
.separator-line 
{
	border-top: 3px solid #555;
	margin: 30px 0;
	width: 100%;
	height: 0;
}

.transfer-btn[disabled] 
{
	background-color: #ddd;
	color: #aaa;
	cursor: not-allowed;
	opacity: 0.8;
	filter: blur(0.5px);
}

.member-item 
{
	display: grid;
	grid-template-columns: 1fr auto;
	align-items: center;
}

.center-message 
{
    text-align: center;
    color: red;
    font-weight: bold;
    margin-top: 20px;
}

.navbar-brand, .nav > li > a 
{
	font-size: 18px;  
	padding: 15px 18px;  
}

</style>

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
		
		$(".vote").click(function() 
		{
		    var groupId = $(this).data('group-id');
		    var voteId = $(this).data('vote-id');
		    var matchId = $(this).data('match-id');  
		    $(location).attr("href", "managervote.action?group_id=" + groupId + "&vote_id=" + voteId + "&match_id=" + matchId);
		});
		
	});
	
	// 그룹 초대 관련 코드
	function copyToClipboard()
	{
		// 복사할 URL 설정
		var inviteUrl = document.getElementById("inviteUrl").innerText;
		
		var tempTextArea = document.createElement("textarea");
		tempTextArea.value = inviteUrl;
		document.body.appendChild(tempTextArea);
		
        tempTextArea.select();
        document.execCommand("copy");
        
        document.body.removeChild(tempTextArea);
        
        alert("초대 URL이 클립보드에 복사되었습니다!");

	}

	
</script>

</head>
<body>
	
	<div class="panel title">
		<h1>모먼트</h1>
	</div>


	<!-- 메인 메뉴 영역 -->
	<nav class="navbar navbar-default">
		<div class="container-fluid"
			style="display: flex; align-items: center; justify-content: flex-start;">

			<!-- Home 및 모멘트 메뉴를 감싸는 영역 -->
			<div style="display: flex; align-items: center; flex: 0 0 auto;">
				<!-- Home 및 모멘트 메뉴 -->
				<div class="navbar-header">
					<a class="navbar-brand" href="#">Home</a>
				</div>
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active"><a href="group.action">모먼트</a></li>
					</ul>
				</div>
			</div>

			<!-- 매니저 최소 인원이 충족되지 못하면 경고 메시지와 버튼 표시 -->
			<c:choose>
			
				<%-- 그룹 멤버가 5명 미만일 때 경고 메시지 표시 --%>
				<c:when test="${memberTotalCount < 5}">
					<div style="display: flex; align-items: center; justify-content: center; flex-grow: 1;">
						<%-- 중앙에 정렬 --%>
						<div class="center-message" style="color: red; font-weight: bold; margin-left: -150px; margin-bottom: 10px; font-size: 18px;">
							<%-- 경고 메시지 --%>
							그룹 멤버를 초대하여 인원을 충족하세요!
						</div>
					</div>
				</c:when>
				
				<c:when
					test="${memberTotalCount >= 5 && memberTotalCount <= 20 && managerCount < 1
	                            || memberTotalCount >= 21 && memberTotalCount <= 40 && managerCount < 2 
	                            || memberTotalCount >= 41 && memberTotalCount <= 60 && managerCount < 3 
	                            || memberTotalCount >= 61 && memberTotalCount <= 80 && managerCount < 4 
	                            || memberTotalCount >= 81 && memberTotalCount <= 100 && managerCount < 5}">
					<div style="display: flex; align-items: center; justify-content: center; flex-grow: 1;">
						<%-- 중앙에 정렬 --%>
						<div class="center-message" style="color: red; font-weight: bold; margin-left: -150px; margin-bottom: 10px; font-size: 18px;">
							<%-- 경고 메시지 --%>
							매니저 최소 인원 수가 부족합니다. 투표로 매니저를 선발해주세요.
						</div>
						<button type="button" class="vote" 
								data-group-id="${group_id}" 
            					data-vote-id="${vote_id}" 
            					data-match-id="${member_id}"
								style="margin-left: 10px; margin-top: 3px; background-color: red; color: white;">투표하기
						</button>
					</div>
				</c:when>
				
			</c:choose>

		</div>
	</nav>


	<!-- 상단 레이아웃 -->
	<div class="container">
		<div class="row">
		
			<!-- 공지사항 -->
			<div class="col-md-8" style="max-width: 900px;">
				<div class="panel panel-default text-center">
					<div class="panel-heading">공지사항</div>
					<div class="panel-body">
						<div id="notice">
							<!-- 공지사항 내용 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 그룹 멤버 리스트 -->
			<div class="col-md-4" style="max-width: 450px;">
				<div class="panel panel-default">
					<div class="panel-heading">그룹 멤버 리스트</div>
					<div class="panel-body">
						<div id="groupMemberList">
						
							<!-- 매니저 리스트 -->
							<div class="manager-list">
								<div class="manager-items">
									<c:forEach var="mrList" items="${managerList}">
										<div style="display: flex;">
											<p class="member-name" style="margin: 0; margin-right: 5px;">${mrList.name}</p>
											<!-- 왕관 아이콘 추가 -->
											<i>(i태그 아이콘)</i>
										</div>
									</c:forEach>
								</div>
							</div>

							<!-- 구분선 -->
							<div class="separator-line"></div>

							<!-- 그룹원 리스트 -->
							<div class="general-member-list">
								<div class="general-member-items">
									<c:forEach var="gmList" items="${generalMemberList}">
										<div class="member-item">
											<p class="member-name">${gmList.name}</p>
											<!-- match_id와 비교하여 버튼 활성화 -->
											<c:choose>
												<c:when test="${gmId == mrList.match_id}">
													<!-- 접속자 match_id와 매니저의 match_id가 일치하면 버튼 활성화 -->
													<button class="transfer-btn">매니저 양도</button>
												</c:when>
												<c:otherwise>
													<!-- 일치하지 않으면 버튼 비활성화 -->
													<button class="transfer-btn" disabled>매니저 양도</button>
												</c:otherwise>
											</c:choose>
										</div>
									</c:forEach>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		
		</div>
	</div>
	
	
	<div class="container">
		<div class="row moment-panel">
		
			<!-- 그룹 모먼트 일정 달력 -->
			<div class="col-md-8">
				<div class="panel panel-default text-center" style="height: 100%;">
					<div class="panel-heading">그룹 모먼트 일정 달력</div>
					<div class="panel-body" style="height: 100%;">
						<div id="calendar" style="height: 100%;">
							<!-- 달력 위젯 -->
						</div>
					</div>
				</div>
			</div>
		
			<!-- 매니저 인원 수 -->
			<div class="col-md-4">
				<div class="panel panel-default text-center" style="min-height: 100px;">
					<div class="panel-heading">매니저 인원 수</div>
					<div class="panel-body text-center">
						<div id="managerInfo">
							<p>
								매니저 최소 인원:
								<c:choose>
									<c:when test="${memberTotalCount >= 5 && memberTotalCount <= 20}">
	                                	1명
	                           		</c:when>
									<c:when test="${memberTotalCount >= 21 && memberTotalCount <= 40}">
	                                	2명
	                            	</c:when>
									<c:when test="${memberTotalCount >= 41 && memberTotalCount <= 60}">
	                                	3명
	                            	</c:when>
									<c:when test="${memberTotalCount >= 61 && memberTotalCount <= 80}">
	                                	4명
	                            	</c:when>
									<c:when test="${memberTotalCount >= 81 && memberTotalCount <= 100}">
	                                	5명
	                            	</c:when>
									<c:otherwise>
	                               		매니저 없음 
									</c:otherwise>
								</c:choose>
							</p>
							<p>매니저 현재 인원: ${managerCount}명</p>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>


	<div class="container">
		<div class="row">
		
			<!-- 모먼트 검색창 -->
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">모먼트 검색</div>
					<div class="panel-body">
						<div id="momentSearch">
							<input type="text" placeholder="모먼트 검색..." class="form-control"  style="margin-bottom: 10px;">
							<div style="display: flex; justify-content: flex-end;">
								<button type="button" class="btn btn-primary mt-2">검색</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	
	<div class="container">
		<div class="row">
			<!-- 참가인원이 가장 많았던 모먼트 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">참가인원이 가장 많았던 모먼트</div>
					<div class="panel-body">
						<div id="mostParticipantsMoment">
							<!-- 모먼트 데이터 표시 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 가장 최근에 진행됐던 모먼트 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">가장 최근에 진행됐던 모먼트</div>
					<div class="panel-body">
						<div id="recentMoment">
							<!-- 최근 모먼트 정보 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 가장 가까운 일시에 진행될 모먼트 (남은 날짜 보여주기) -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">가장 가까운 일시에 진행될 모먼트</div>
					<div class="panel-body">
						<div id="closestMoment">
							<!-- 가까운 모먼트 정보 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 최근에 생성된 모먼트들(일주일) -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">최근에 생성된 모먼트들(일주일)</div>
					<div class="panel-body">
						<div id="recentMoments">
							<!-- 최근에 생성된 모먼트 정보 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<!-- 갤러리 사진 랜덤 뿌려주기 -->
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">갤러리</div>
					<div class="panel-body">
						<div id="gallery">
							<!-- 랜덤 사진 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 총 경비 -->
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">총 경비</div>
					<div class="panel-body">
						<div id="totalExpenses">
							<!-- 경비 정보 -->
						</div>
					</div>
				</div>
			</div>

			<!-- 장소 모음 -->
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">장소 모음</div>
					<div class="panel-body">
						<div id="places">
							<!-- 장소 목록 -->
						</div>
					</div>
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
						모먼트 출력 
					</span> 
					<span class="col-md-9"> 
						<a href="momentoperform.action?group_id=<%=request.getParameter("group_id") %>" role="button" class="btn btn-success btn-xs" id="btnAdd" 
						style="vertical-align: bottom;">모먼트 생성</a>
					</span>
				</div>

				<!-- 초대 URL을 표시할 요소 -->
				<div id="inviteUrl" style="display: none;">
					http://localhost:8090/FinalApp02/groupinvite.action?typeId=GT02&matchId=${gmId}
				</div>
				<button onclick="copyToClipboard()" role="button" class="btn btn-success btn-xs">초대(URL)</button>

				<div class="panel-body">
					내가 참여 중인 모먼트 수 <span class="badge">${myCount }</span>
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
							<th></th>
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
				</div>
				<div class="panel-body">
					전체 모먼트 수 <span class="badge">${allCount }</span>
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
							<th><input type="hidden" id="group_id"
								value="<%=request.getParameter("group_id") %>"></th>
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


	<!-- 건의사항 및 그룹 신고 섹션 (가로로 나란히) -->
	<div class="container">
		<div class="row">
			<!-- 건의사항 작성 버튼 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">건의사항 작성</div>
					<div class="panel-body">
						<button type="button" class="btn btn-warning">건의사항 작성</button>
					</div>
				</div>
			</div>

			<!-- 건의사항 조회 버튼 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">건의사항 조회</div>
					<div class="panel-body">
						<button type="button" class="btn btn-warning">건의사항 조회</button>
					</div>
				</div>
			</div>

			<!-- 그룹 신고 버튼 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">그룹 신고</div>
					<div class="panel-body">
						<button type="button" class="btn btn-danger">그룹 신고</button>
					</div>
				</div>
			</div>

			<!-- 그룹 신청서 입력/수정 -->
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">그룹 신청서</div>
					<div class="panel-body">
						<div id="applicationForm">
							<!-- 신청서 입력/수정 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>