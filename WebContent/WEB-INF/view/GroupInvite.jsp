<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GroupInvite.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

</head>
<body>
   <%
        // URL 파라미터에서 matchId와 gtId 추출
        String matchId = request.getParameter("matchId");
        String typeId = request.getParameter("typeId");
        
        if (matchId == null | typeId == null) 
        {
            out.println("정상적인 초대 URL이 아닙니다.");
            return;
        }
    %>

<h1>초대 응답 페이지</h1>
    
    <p>그룹 초대 요청이 들어왔습니다. 수락 / 거절 버튼 중 하나를 눌러주세요.</p>

    <div class="button-container">
        <%
            if ("GJ01".equals(typeId)) 
            {
        %>
                <a href="grouppreinvitewhetherinsert.action?matchId=<%=matchId%>&typeId=<%=typeId%>&response=SW01" class="button accept">수락</a>
                <a href="grouppreinvitewhetherinsert.action?matchId=<%=matchId%>&typeId=<%=typeId%>&response=SW02" class="button decline">거절</a>
        <%
            } else if("GJ02".equals(typeId)) 
            {
        %>
               <a href="groupinvitewhetherinsert.action?matchId=<%=matchId%>&typeId=<%=typeId%>&response=SW01" class="button accept">수락</a>
                <a href="groupinvitewhetherinsert.action?matchId=<%=matchId%>&typeId=<%=typeId%>&response=SW02" class="button decline">거절</a>
        <%
            }
         %>
    </div>

</body>
</html>