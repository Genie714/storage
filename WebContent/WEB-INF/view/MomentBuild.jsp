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
<title>MomentBuild.jsp</title>
<style type="text/css">
	#surveyFrom table, th, td
	{
		border: 1px solid gray;
		border-collapse: collapse;
		
	}
	#sv_date_name
	{
    z-index: 999;
	}
</style>

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
			
			if ($("#countJoin").val() < 1)
			{
				$(".btn-info").css("display", "none");
			}
			
			if ($("#moment_name_survey_id").val() > 0)
			{
				$("#cr_moment_name").css("display", "none");
				result = createMoment_nameSurvey();
				document.getElementById("result_moment_name").innerHTML = result;
				
				if ($("#moment_name_response_id").val() != "" && $("#moment_name_response_id").val() > 0)
				{
					$("#sm_moment_name").attr("disabled", "disabled");
					$("#sm_moment_name").text("제출 완료");
					
					if ($("#moment_name_response").val() == "")
						$("#sv_moment_name").val("의견 없음");
					else
						$("#sv_moment_name").val($("#moment_name_response").val());
					
					if ($("#moment_name_others").val() == "")
						$("#sv_moment_name_others").val("의견 없음");
					else
						$("#sv_moment_name_others").val($("#moment_name_others").val());
					
					$("#sv_moment_name").attr("readonly", "readonly");
					$("#sv_moment_name_others").attr("readonly", "readonly");
				}
			}
			
			if ($("#date_name_survey_id").val() > 0)
			{
				$("#cr_date_name").css("display", "none");
				result = createDate_nameSurvey();
				document.getElementById("result_date_name").innerHTML = result;
				
				$("#sv_date_name").datepicker(
						{
							dateFormat : "yy-mm-dd"
							, changeYear : true
							, changeMonth : true
							, minDate : +3
							, maxDate : +730
				});
				
				$("#sv_impossible_date").datepicker(
						{
							dateFormat : "yy-mm-dd"
							, changeYear : true
							, changeMonth : true
							, minDate : +3
							, maxDate : +730
				});
				
				if ($("#date_name_response_id").val() > 0)
				{
					$("#sm_date_name").attr("disabled", "disabled");
					$("#sm_date_name").text("제출 완료");
					
					if ($("#date_name_response").val() == "")
						$("#sv_date_name").val("의견 없음");
					else
						$("#sv_date_name").val($("#date_name_response").val());
					
					if ($("#date_name_others").val() == "")
						$("#sv_date_name_others").val("의견 없음");
					else
						$("#sv_date_name_others").val($("#date_name_others").val());
						
					if ($("#date_name_impossible_date").val() == "")
						$("#sv_impossible_date").val("의견 없음");
					else
						$("#sv_impossible_date").val($("#date_name_impossible_date").val().replace("00:00:00", ""));
					
					$("#sv_time").css("display", "none");
					
					$("#sv_date_name").attr("readonly", "readonly");
					$("#sv_date_name_others").attr("readonly", "readonly");
					$("#sv_impossible_date").attr("readonly", "readonly");
				}
			}
			
			
			if ($("#place_name_survey_id").val() > 0)
			{
				$("#cr_place_name").css("display", "none");
				result = createPlace_nameSurvey();
				document.getElementById("result_place_name").innerHTML = result;
				
				if ($("#place_name_response_id").val() > 0)
				{
					$("#sm_place_name").attr("disabled", "disabled");
					$("#sm_place_name").text("제출 완료");
					
					if ($("#place_name_response").val() == "")
						$("#sv_place_name").val("의견 없음");
					else
						$("#sv_place_name").val($("#place_name_response").val());
					
					if ($("#place_name_others").val() == "")
						$("#sv_place_name_others").val("의견 없음");
					else
						$("#sv_place_name_others").val($("#place_name_others").val());
					
					$("#sv_place_name").attr("readonly", "readonly");
					$("#sv_place_name_others").attr("readonly", "readonly");
				}
			}
			
			if ($("#min_participant_survey_id").val() > 0)
			{
				$("#cr_min_participant").css("display", "none");
				result = createMin_participantSurvey();
				document.getElementById("result_min_participant").innerHTML = result;
				
				if ($("#min_participant_response_id").val() > 0)
				{
					$("#sm_min_participant").attr("disabled", "disabled");
					$("#sm_min_participant").text("제출 완료");
					
					if ($("#smin_participant_response").val() == "")
						$("#sv_min_participant").val("의견 없음");
					else
						$("#sv_min_participant").val($("#min_participant_response").val());
					
					if ($("#min_participant_others").val() == "")
						$("#sv_min_participant_others").val("의견 없음");
					else
						$("#sv_min_participant_others").val($("#min_participant_others").val());
					
					$("#sv_min_participant").attr("readonly", "readonly");
					$("#sv_min_participant_others").attr("readonly", "readonly");
				}
			}
			
			if ($("#max_participant_survey_id").val() > 0)
			{
				$("#cr_max_participant").css("display", "none");
				result = createMax_participantSurvey();
				document.getElementById("result_max_participant").innerHTML = result;
				
				if ($("#max_participant_response_id").val() > 0)
				{
					$("#sm_max_participant").attr("disabled", "disabled");
					$("#sm_max_participant").text("제출 완료");
					
					if ($("#max_participant_response").val() == "")
						$("#sv_max_participant").val("의견 없음");
					else
						$("#sv_max_participant").val($("#max_participant_response").val());
					
					if ($("#max_participant_others").val() == "")
						$("#sv_max_participant_others").val("의견 없음");
					else
						$("#sv_max_participant_others").val($("#max_participant_others").val());
					
					$("#sv_max_participant").attr("readonly", "readonly");
					$("#sv_max_participant_others").attr("readonly", "readonly");
				}
			}
			
			if ($("#note_survey_id").val() > 0)
			{
				$("#cr_note").css("display", "none");
				result = createNoteSurvey();
				document.getElementById("result_note").innerHTML = result;
				
				if ($("#min_participant_response_id").val() > 0)
				{
					$("#sm_note").attr("disabled", "disabled");
					$("#sm_note").text("제출 완료");
					
					if ($("#note_response").val() == "")
						$("#sv_note").val("의견 없음");
					else
						$("#sv_note").val($("#note_response").val());
					
					if ($("#note_others").val() == "")
						$("#sv_note_others").val("의견 없음");
					else
						$("#sv_note_others").val($("#note_others").val());
					
					$("#sv_note").attr("readonly", "readonly");
					$("#sv_note_others").attr("readonly", "readonly");
				}
			}
			
			$(".btn-success").click(function()
			{
				if (parseInt($("#max_participant").val()) <= parseInt($("#parti_num").val()))
				{
					alert("이미 최대인원이 채워졌습니다. 참여가 불가능합니다.");
					return;
				}
				
				if ($(this).val() < 1)
				{
					if (confirm("해당 모먼트에 참여하시겠습니까?"))
					{
						$("#myForm").submit();
					}
				}
				else
				{
					if (confirm("해당 모먼트의 참여를 취소하시겠습니까?"))
					{
						location.href = "momentcancel.action?moment_id=" + $("#moment_id").val() + "&group_id=" + $("#group_id").val();
					}
				}
			});
			
			$("#cr_moment_name").click(function()
			{
				if (confirm("모먼트명 설문을 생성하시겠습니까?"))
				{
					result = createMoment_nameSurvey();
					document.getElementById("result_moment_name").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
									 + "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}
			});
			
			$("#cr_date_name").click(function()
			{
				if (confirm("일시 설문을 생성하시겠습니까?"))
				{
					result = createDate_nameSurvey();
					document.getElementById("result_date_name").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
									 + "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}
			});
			
			$("#cr_place_name").click(function()
			{
				if (confirm("장소 설문을 생성하시겠습니까?"))
				{
					result = createPlace_nameSurvey();
					document.getElementById("result_place_name").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
					 				+ "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}
			});
			
			$("#cr_min_participant").click(function()
			{
				if (confirm("최소 인원 설문을 생성하시겠습니까?"))
				{
					result = createMin_participantSurvey();
					document.getElementById("result_min_participant").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
					 				 + "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}

			});
		
			$("#cr_max_participant").click(function()
			{
				if (confirm("최대 인원 설문을 생성하시겠습니까?"))
				{
					result = createMax_participantSurvey();
					document.getElementById("result_max_participant").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
									 + "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}
			});
			
			$("#cr_note").click(function()
			{
				if (confirm("참고사항 설문을 생성하시겠습니까?"))
				{
					result = createNoteSurvey();
					document.getElementById("result_note").innerHTML = result;
					location.href = "momentsurveyinsert.action?moment_id=" + $("#moment_id").val() + "&type_id=" + $(this).val()
									 + "&group_id=" + $("#group_id").val();
					$(this).css("display", "none");
					
					alert("설문이 생성되었습니다.");
				}

			});
			
		$(".btn-survey").click(function()
		{
			if (confirm("답변을 제출하시겠습니까? 제출 후 수정이 불가능합니다."))
			{
				switch ($(this).val())
				{
				case "ST01": $(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
						 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_moment_name").val()
						 	 + "&group_id=" + $("#group_id").val()  + "&others=" + $("#sv_moment_name_others").val());
					break;
				case "ST02": 
				if ($("#sv_date_name").val() == "" && $("#sv_time").val() != "")
				{
					alert("시간만 선택하는 것은 불가능합니다.");
					break;
				} 
				else
				{
					$(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
				 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_date_name").val() + $("#sv_time").val()
				 	 + "&others=" + $("#sv_date_name_others").val()
				 	 + "&impossible_date=" + $("#sv_impossible_date").val() + "&group_id=" + $("#group_id").val());
				}
				
				break;
				case "ST03": $(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
						 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_place_name").val()
						 	 + "&group_id=" + $("#group_id").val() +  + "&others=" + $("#sv_place_name_others").val());
					break;
				case "ST04": $(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
						 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_min_participant").val()
						 	 + "&group_id=" + $("#group_id").val() + "&others=" + $("#sv_min_participant_others").val());
					break;
				case "ST05": $(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
						 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_max_participant").val()
						 	 + "&group_id=" + $("#group_id").val() + "&others=" + $("#sv_max_participant_others").val());
					break;
				case "ST06": $(location).attr("href", "momentsurveyresponseinsert.action?moment_id=" + $("#moment_id").val()
						 	 + "&type_id=" + $(this).val() + "&response=" + $("#sv_note").val()
						 	 + "&group_id=" + $("#group_id").val() + "&others=" + $("#sv_note_others").val());
					break;
				}
				
				alert("제출이 완료되었습니다.");
				
			}
				
		});
				
		
		// 투표 생성 이후
		if ($("#moment_name_check").val() != "[]" && $("#moment_name_check").val() != "" && $("#moment_name_check").val() != null)
		{
			$("#result_moment_name").css("display", "none");
			$("#vote_moment_name").css("display", "inline");
		}
		
		if ($("#moment_name_voteNum").val() != "" && $("#moment_name_voteNum").val() > 0)
		{
			$("#voteResult_moment_name").attr("disabled", "disabled");
			$("#voteResult_moment_name").text("투표 완료");
			$("#" + $("#moment_name_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_moment_name']").click(function()
			{
				return false;
			});
		}
		if ($("#date_name_voteNum").val() != "" && $("#date_name_voteNum").val() > 0)
		{
			$("#voteResult_date_name").attr("disabled", "disabled");
			$("#voteResult_date_name").text("투표 완료");
			$("#" + $("#date_name_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_date_name']").click(function()
			{
				return false;
			});
		}
		if ($("#place_name_voteNum").val() != "" && $("#place_name_voteNum").val() > 0)
		{
			$("#voteResult_place_name").attr("disabled", "disabled");
			$("#voteResult_place_name").text("투표 완료");
			$("#" + $("#place_name_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_place_name']").click(function()
			{
				return false;
			});
		}
		if ($("#min_participant_voteNum").val() != "" && $("#min_participant_voteNum").val() > 0)
		{
			$("#voteResult_min_participant").attr("disabled", "disabled");
			$("#voteResult_min_participant").text("투표 완료");
			$("#" + $("#min_participant_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_min_participant']").click(function()
			{
				return false;
			});
		}
		if ($("#max_participant_voteNum").val() != "" && $("#max_participant_voteNum").val() > 0)
		{
			$("#voteResult_max_participant").attr("disabled", "disabled");
			$("#voteResult_max_participant").text("투표 완료");
			$("#" + $("#max_participant_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_max_participant']").click(function()
			{
				return false;
			});
		}
		if ($("#note_voteNum").val() != "" && $("#note_voteNum").val() > 0)
		{
			$("#voteResult_note").attr("disabled", "disabled");
			$("#voteResult_note").text("투표 완료");
			$("#" + $("#note_selectId").val()).attr("checked", "checked");
			$("input:radio[name='vote_note']").click(function()
			{
				return false;
			});
		}
		
			if ($("#date_name_check").val() != "[]" && $("#date_name_check").val() != "" && $("#date_name_check").val() != null)
			{
				$("#result_date_name").css("display", "none");
				$("#vote_date_name").css("display", "inline");
			}
			if ($("#place_name_check").val() != "[]" && $("#place_name_check").val() != "" && $("#place_name_check").val() != null)
			{
				$("#result_place_name").css("display", "none");
				$("#vote_place_name").css("display", "inline");
			}
			if ($("#min_participant_check").val() != "[]" && $("#min_participant_check").val() != "" && $("#min_participant_check").val() != null)
			{
				$("#result_min_participant").css("display", "none");
				$("#vote_min_participant").css("display", "inline");
			}
			if ($("#max_participant_check").val() != "[]" && $("#max_participant_check").val() != "" && $("#max_participant_check").val() != null)
			{
				$("#result_max_participant").css("display", "none");
				$("#vote_max_participant").css("display", "inline");
			}
			if ($("#note_check").val() != "[]" && $("#note_check").val() != "" && $("#note_check").val() != null)
			{
				$("#result_note").css("display", "none");
				$("#vote_note").css("display", "inline");
			}
		
			if ($("#moment_name_complete").val() != "" || $("#moment_name_complete").val() != null)
			{
				$("#vote_moment_name").css("display", "none");
			}
			if ($("#date_name_complete").val() != "" || $("#date_name_complete").val() != null)
			{
				$("#vote_date_name").css("display", "none");
			}
			if ($("#place_name_complete").val() != "" || $("#place_name_complete").val() != null)
			{
				$("#vote_place_name").css("display", "none");
			}
			if ($("#min_participant_complete").val() != "" || $("#min_participant_complete").val() != null)
			{
				$("#vote_min_participant").css("display", "none");
			}
			if ($("#max_participant_complete").val() != "" || $("#max_participant_complete").val() != null)
			{
				$("#vote_max_participant").css("display", "none");
			}
			if ($("#note_complete").val() != "" || $("#note_complete").val() != null)
			{
				$("#vote_note").css("display", "none");
			}
			
			$(".btn-vote").click(function()
			{
				if ($("input:radio[name='vote_moment_name']:checked").val() == "" || $("input:radio[name='vote_moment_name']:checked").val() == null)
				{
					alert("선택 후 투표 제출이 가능합니다.");
					return;
				}
				else if (confirm("투표를 완료하시겠습니까? 제출 후 수정이 불가능합니다."))
				{
					switch ($(this).val())
					{
					case "ST01": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_moment_name']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#moment_name_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					case "ST02": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_date_name']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#date_name_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					case "ST03": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_place_name']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#place_name_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					case "ST04": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_min_participant']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#min_participant_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					case "ST05": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_max_participant']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#max_participant_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					case "ST06": $(location).attr("href", "momentvoteresponseinsert.action?moment_id=" + $("#moment_id").val()
								 + "&survey_response_id=" + $("input:radio[name='vote_note']:checked").val()
								 + "&type_id=" + $(this).val() + "&survey_id=" + $("#note_svId").val()
							 	 + "&group_id=" + $("#group_id").val());
						break;
					}
					
					alert("제출이 완료되었습니다.");
					
				}
				
			});
			
			
			$(".btn-default").click(function()
			{
				$(location).attr("href", "group.action?group_id=" + $("#group_id").val());
			});

			
		});
		
		function createMoment_nameSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<input type='text' id='sv_moment_name' name='sv_moment_name' class='form-control'";
			result += "placeholder='모먼트명 입력' maxlength='30' style='width: 970px;'>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_moment_name_others' placeholder='ex) 내 이름 넣어줘~' name='sv_moment_name_others' class='form-control'";
			result += "style='width: 970px;'>";
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_moment_name'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST01'>제출</button></td>";
			
			return result;
		}
		
		function createDate_nameSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<input type='text' id='sv_date_name' placeholder='일자 선택' name='sv_date_name' class='form-control'";
			result += "style='width: 261px;'><br>";
			result += "<select id='sv_time' name='sv_time' class='form-control' style='width: 261px;'>";
			result += "<option value='-1' selected='selected'>시간 선택</option>";
			
			for (var i = 0; i < 24; i++)
			{
				if (i < 10)
				{
					result += "<option value=' " + "0" + i + ":00:00'>" + "0" + i + ":00:00</option>";
				}
				else
					result += "<option value=' " + i + ":00:00'>" + i + ":00:00</option>";
			}
			
			result += "</select><br>";
			
			result += "<h4 style='font-weight: bold;'>불가능 날짜</h4>";
			result += "<input type='text' id='sv_impossible_date' placeholder='일자 선택' name='sv_impossible_date' class='form-control'";
			result += "style='width: 261px;'>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_date_name_others' placeholder='ex) 이왕이면 주말이 좋아요.' name='sv_date_name_others' class='form-control'";
			result += "style='width: 970px;'>";
			
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_date_name'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST02'>제출</button>";
			
			return result;
		}
		
		function createPlace_nameSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<input type='text' id='sv_place_name' name='sv_place_name' class='form-control'";
			result += "placeholder='장소 입력' style='width: 970px;'>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_place_name_others' placeholder='ex) 인천 사람 배려 좀;;' name='sv_place_name_others' class='form-control'";
			result += "style='width: 970px;'>";
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_place_name'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST03'>제출</button></td>";
			
			return result;
		}
		
		function createMin_participantSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<input type='text' id='sv_min_participant' name='sv_min_participant' class='form-control'";
			result += "placeholder='ex) 2' maxlength='30' style='width: 970px;'>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_min_participant_others' placeholder='ex) 3명 밑으로 만나면 난 빠질게' name='sv_min_participant_others' class='form-control'";
			result += "style='width: 970px;'>";
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_min_participant'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST04'>제출</button></td>";
			
			return result;
		}
		
		function createMax_participantSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<input type='text' id='sv_max_participant' name='sv_max_participant' class='form-control'";
			result += "placeholder='ex) 5' maxlength='30' style='width: 970px;'>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_max_participant_others' placeholder='ex) 5명 이상은 좀 부담스러워 ㅠoㅠ' name='sv_max_participant_others' class='form-control'";
			result += "style='width: 970px;'>";
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_max_participant'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST05'>제출</button></td>";
			
			return result;
		}
		
		function createNoteSurvey()
		{
			result = "<td><h4 style='font-weight: bold;'>내 답변</h4>";
			result += "<textarea id='sv_note' name='sv_note' class='form-control' cols='101' rows='10'";
			result += "placeholder='ex) 노트북 챙겨와!' maxlength='200'";
			result += "style='text-align: left; width: 970px; resize: none;'></textarea>";
			result += "<br><h4 style='font-weight: bold;'>기타 의견</h4>";
			result += "<input type='text' id='sv_note_others' placeholder='ex) 드레스코드 정하자' name='sv_note_others' class='form-control'";
			result += "style='width: 261px;'>";
			result += "<br><button type='button' class='btn btn-primary btn-survey' id='sm_note'";
			result += "style='font-size: 12pt; font-weight: bold; width: 100px; height: 35px;' value='ST06'>제출</button></td>";
			
			return result;
		}
		

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
					모먼트 빌드 조회
				<p></p>
				<p style="font-size: small; color: blue;">▷ 현재 ${momentList.parti_num }명이 참여 중인 모먼트입니다.<br>
					<b style="font-size: small; color: purple;">&nbsp &nbsp &nbsp 빌드 마감 : ${momentList.plan_end_date}</b>
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
									value="${momentList.moment_name }" style="width: 870px;">
									&nbsp;&nbsp;&nbsp; 
									<button type="button" class="btn btn-info" id="cr_moment_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST01">설문 생성</button>
									<input type="hidden" id="moment_name_survey_id" class="survey_id" value="${countSurvey[0] }">
									<input type="hidden" id="moment_name_response_id" class="response_id" value="${countResponseNum1 }">
									<input type="hidden" id="moment_name_response" class="response" value="${countResponse1.response }">
									<input type="hidden" id="moment_name_others" class="others" value="${countResponse1.others }">
								</div>
							</td>
						</tr>
						<tr id="result_moment_name">
						</tr>
						
						
						<tr id="vote_moment_name" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>모먼트명을 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse1 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_moment_name" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="moment_name_svId">
									<input type="hidden" id="moment_name_voteNum" class="voteNum" value="${voteResponseNum1 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse1 }" id="moment_name_check">
								<input type="hidden" value="${voteSelectId1 }" id="moment_name_selectId">
								<input type="hidden" value="${check1 }" id="moment_name_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_moment_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST01">투표 제출</button>
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
									value="${momentList.date_name }" style="width: 870px;">
									&nbsp&nbsp&nbsp 
									<button type="button" class="btn btn-info" id="cr_date_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST02">설문 생성</button>
									<input type="hidden" id="date_name_survey_id" class="survey_id" value="${countSurvey[1] }">
									<input type="hidden" id="date_name_response_id" class="response_id" value="${countResponseNum2 }">
									<input type="hidden" id="date_name_response" class="response" value="${countResponse2.response }">
									<input type="hidden" id="date_name_others" class="others" value="${countResponse2.others }">
									<input type="hidden" id="date_name_impossible_date" class="impossible_date" value="${countResponse2.impossible_date }">
								</div>
							</td>
						</tr>
						<tr id="result_date_name">
						</tr>
						
						<tr id="vote_date_name" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>일시를 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse2 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_date_name" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="date_name_svId">
									<input type="hidden" id="date_name_voteNum" class="voteNum" value="${voteResponseNum2 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse2 }" id="date_name_check">
								<input type="hidden" value="${voteSelectId2 }" id="date_name_selectId">
								<input type="hidden" value="${check2 }" id="date_name_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_date_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST02">투표 제출</button>
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
									value="${momentList.place_name }" style="width: 870px;">
									&nbsp&nbsp&nbsp 
									<button type="button" class="btn btn-info" id="cr_place_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST03">설문 생성</button>
									<input type="hidden" id="place_name_survey_id" class="survey_id" value="${countSurvey[2] }">
									<input type="hidden" id="place_name_response_id" class="response_id" value="${countResponseNum3 }">
									<input type="hidden" id="place_name_response" class="response" value="${countResponse3.response }">
									<input type="hidden" id="place_name_others" class="others" value="${countResponse3.others }">
								</div>
							</td>
						</tr>
						<tr id="result_place_name">
						</tr>
						
						<tr id="vote_place_name" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>장소를 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse3 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_place_name" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="place_name_svId">
									<input type="hidden" id="place_name_voteNum" class="voteNum" value="${voteResponseNum3 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse3 }" id="place_name_check">
								<input type="hidden" value="${voteSelectId3 }" id="place_name_selectId">
								<input type="hidden" value="${check3 }" id="place_name_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_place_name"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST03">투표 제출</button>
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
									value="${momentList.min_participant }" style="width: 870px;">
									&nbsp&nbsp&nbsp 
									<button type="button" class="btn btn-info" id="cr_min_participant"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST04">설문 생성</button>
									<input type="hidden" id="min_participant_survey_id" class="survey_id" value="${countSurvey[3] }">
									<input type="hidden" id="min_participant_response_id" class="response_id" value="${countResponseNum4 }">
									<input type="hidden" id="min_participant_response" class="response" value="${countResponse4.response }">
									<input type="hidden" id="min_participant_others" class="others" value="${countResponse4.others }">
								</div>
							</td>
						</tr>
						<tr id="result_min_participant">
						</tr>
						
						<tr id="vote_min_participant" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>최소 인원을 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse4 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_min_participant" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="min_participant_svId">
									<input type="hidden" id="min_participant_voteNum" class="voteNum" value="${voteResponseNum4 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse4 }" id="min_participant_check">
								<input type="hidden" value="${voteSelectId4 }" id="min_participant_selectId">
								<input type="hidden" value="${check4 }" id="min_participant_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_min_participant"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST04">투표 제출</button>
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
									value="${momentList.max_participant }" style="width: 870px;">
									&nbsp &nbsp &nbsp 
									<button type="button" class="btn btn-info" id="cr_max_participant"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST05">설문 생성</button>
									<input type="hidden" id="max_participant_survey_id" class="survey_id" value="${countSurvey[4] }">
									<input type="hidden" id="max_participant_response_id" class="response_id" value="${countResponseNum5 }">
									<input type="hidden" id="max_participant_response" class="response" value="${countResponse5.response }">
									<input type="hidden" id="max_participant_others" class="others" value="${countResponse5.others }">
								</div>
							</td>
						</tr>
						<tr id="result_max_participant">
						</tr>
						
						<tr id="vote_max_participant" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>최대 인원을 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse5 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_max_participant" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="max_participant_svId">
									<input type="hidden" id="max_participant_voteNum" class="voteNum" value="${voteResponseNum5 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse5 }" id="max_participant_check">
								<input type="hidden" value="${voteSelectId5 }" id="max_participant_selectId">
								<input type="hidden" value="${check5 }" id="max_participant_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_max_participant"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST05">투표 제출</button>
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
									<textarea rows="10" cols="101" id="note" name="note" class="form-control"
									 readonly="readonly" style="text-align: left; width: 870px; resize: none;">
									${momentList.note }
									</textarea>&nbsp&nbsp&nbsp 
									<button type="button" class="btn btn-info" id="cr_note"
									style="font-size: 12pt; font-weight: bold; height: 216px;" value="ST06">설문 생성</button>
									<input type="hidden" id="note_survey_id" class="survey_id" value="${countSurvey[5] }">
									<input type="hidden" id="note_response_id" class="response_id" value="${countResponseNum6 }">
									<input type="hidden" id="note_response" class="response" value="${countResponse6.response }">
									<input type="hidden" id="note_others" class="others" value="${countResponse6.others }">
								</div>
							</td>
						</tr>
						<tr id="result_note">
						</tr>
						
						<tr id="vote_note" style="display: none;">
							<td>
							<h4 style='font-weight: bold;'>참고사항을 골라주세요. (택 1)</h4>
								<c:forEach var="selection" items="${voteReponse6 }">
									<label style="${selection.response == null ? 'display: none;' : 'display: inline;'}" 
									for="${selection.survey_response_id }">- ${selection.response }</label>
									<input type="radio" value="${selection.survey_response_id }" id="${selection.survey_response_id }"
									name="vote_note" style="width: 972px; 
									${selection.response == null ? 'display: none;' : 'display: inline;'}"><br>
									<input type="hidden" value="${selection.survey_id }" id="note_svId">
									<input type="hidden" id="note_voteNum" class="voteNum" value="${voteResponseNum6 }">
								</c:forEach>
								<input type="hidden" value="${voteReponse6 }" id="note_check">
								<input type="hidden" value="${voteSelectId6 }" id="note_selectId">
								<input type="hidden" value="${check6 }" id="note_complete">
								<br><button type="button" class="btn btn-primary btn-vote" id="voteResult_note"
									style="font-size: 12pt; font-weight: bold; height: 35px;" value="ST06">투표 제출</button>
							</td>
						</tr>
						
						<tr style="height: 30px;">
						</tr>
						
						<tr>
							<td style="text-align: center;">
								<button type="button" id="countJoin" class="btn btn-success" value="${countJoin }">
								${countJoin > 0 ? "참여 취소" : "참여" }</button>
								<button type="button" class="btn btn-default">목록으로</button>
								<input type="hidden" id="moment_id" name="moment_id" value="${momentList.moment_id }">
								<input type="hidden" id="phase" name="phase" value="${momentList.phase }">
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