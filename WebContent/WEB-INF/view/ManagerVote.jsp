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
<title>ManagerVote.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
body 
{
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    text-align: center;
}

.container 
{
    margin-top: 20px;
}

.title 
{
    font-size: 36px;
    font-weight: bold; 
    margin: 0;
}

.list-container 
{
    margin: 20px auto;
    width: 80%; 
}

.list-title 
{
    font-size: 24px; 
    font-weight: bold; 
    margin-bottom: 10px;
}

.list-table 
{
    width: 100%; 
    border-collapse: collapse;
    margin: 0 auto; 
}

.list-table td 
{
    padding: 10px;
    border: 1px solid #ddd; 
}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	/* 
	$(document).ready(function()
	{
		$(".voteFin").click(function()
		{
			if (confirm("투표를 완료하시겠습니까?"))
			{
				$(location).attr("href", "managervotefin.action?group_id=" + $(this).val());
			}
			
		}); 
		
	}); 
	*/
	
</script>
</head>
<body>

<div class="container">
    <h1 class="title">매니저 임명 투표</h1>
</div>

<form role="form" action="managervotefin.action" method="post">
	
	<input type="text" name="groupId" value="${group_id}" />
	
    <div class="list-container">
        <h2 class="list-title">매니저 임명 후보리스트</h2>
        <table class="list-table">
            <c:forEach var="candi" items="${candidates}">
                <tr>
                    <td>
                        <input type="radio" name="candidateMatchId" value="${candi.match_id}"/> ${candi.name}
                    </td>		
                </tr>
            </c:forEach>
        </table>
    </div>
    <button type="submit" class="voteFin">투표완료</button>
</form>

</body>
</html>