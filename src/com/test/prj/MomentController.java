/*============================
 	MomentController.java
============================*/

package com.test.prj;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MomentController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 모먼트 조회
	@RequestMapping("/group.action")
	public String momentList(Model model, String group_id, HttpSession session) throws ParseException
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		String moment_id = "";
		String type_id = "";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sysdate = dateFormat.format(new java.util.Date());
		
		ArrayList<MomentDTO> endTimeList = dao.searchEndMoment(group_id);
		
		if (endTimeList != null)
		{
			for (MomentDTO dto : endTimeList)
			{
				String plan_end_date = dto.getPlan_end_date();
				java.util.Date d1 = dateFormat.parse(plan_end_date);
				java.util.Date d2 = dateFormat.parse(sysdate);
				long end_time = (d1.getTime() - d2.getTime()) / 1000;
				
				if (end_time <= 0)
				{
					if (dto.getMoment_name() == null
							|| dto.getDate_name().length() < 19
							|| dto.getPlace_name()  == null
							|| String.valueOf(dto.getMin_participant()) == null
							|| dto.getMax_participant()  == null)
					{
						type_id = "NY01";
					
					/*	// 임시로 주석처리
					else if (dto.getMin_participant() > dto.getParti_num())
						type_id = "NY02";
					*/
					
					// 신고받아서 지워지는 경우도 추후 추가
					
					moment_id = dto.getMoment_id();
					dao.addNonactiveMoment(moment_id, type_id);
					}
				}
				
			}
		}
			
		String member_id = dao.searchMemberId(user_id, group_id);
		
		model.addAttribute("allCount", dao.allCount(group_id));
		model.addAttribute("allList", dao.allList(group_id));
		model.addAttribute("myList", dao.myList(group_id, member_id));
		model.addAttribute("myCount", dao.myCount(group_id, member_id));
		
		result = "/WEB-INF/view/Group.jsp";
		
		return result;
	}
	
	// 오퍼
	@RequestMapping("/momentoperform.action")
	public String MomentOperForm(Model model, String group_id)
	{
		String result = null;
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		model.addAttribute("countMember", dao.countMember(group_id));
		result = "/WEB-INF/view/MomentOperForm.jsp";
		
		return result;
	}
	
	@RequestMapping("/momentdateinsert.action")
	public String momentDateInsert(Model model, String year, String month, String day, String time, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		String date_name = "";
		String doublePlan = "-1";
		
		MomentDTO dto = new MomentDTO();
		
		day = day.trim();
		day = day.replace("%20", "");
		
		if (day.equals("-1"))
			day = "";
		
		if (time.equals("-1"))
			time = "";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		if (!year.equals("") && !month.equals("") && !day.equals(""))
		{
			date_name = String.format("%s-%s-%s", year, month, day);
			doublePlan = String.valueOf(dao.momentDateCount(user_id, date_name));
		}
		

		int count = dao.countDate();
		String date_id = String.format("MD0%s", count + 1);
		
		dto.setDate_id(date_id);
		dto.setYear(year);
		dto.setMonth(month);
		dto.setDay(day);
		dto.setTime(time);
	  
		dao.addDate(dto);
		
		model.addAttribute("year", dto.getYear());
		model.addAttribute("month", dto.getMonth());
		model.addAttribute("day", dto.getDay());
		model.addAttribute("time", dto.getTime());
		
		result = "/WEB-INF/view/MomentDateAjax.jsp?date_id=" + dto.getDate_id() + "&doublePlan=" + doublePlan;
		
		return result;
	}
	
	@RequestMapping("/momentplaceinsert.action")
	public String momentPlaceInsert(Model model, String place_name, String detail_id, HttpServletRequest request)
	{
		String result = null;
		MomentDTO dto = new MomentDTO();
		
		if (detail_id.equals("1"))
			detail_id = "ML01";
		else if (detail_id.equals("2"))
			detail_id = "ML02";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		int count = dao.countPlace();
		String place_id = String.format("MP0%s", count + 1);
		
		dto.setPlace_id(place_id);
		dto.setPlace_name(place_name);
		dto.setDetail_id(detail_id);
		
		dao.addPlace(dto);
		
		model.addAttribute("place_name", dto.getPlace_name());
		
		result = "/WEB-INF/view/MomentPlaceAjax.jsp?place_id=" + dto.getPlace_id();
		
		return result;
	}
	
	
	@RequestMapping(value = "/momentinsert.action", method = RequestMethod.POST)
	public String momentInsert(MomentDTO dto, String group_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		String phase_id = "MH01";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		String member_id = dao.searchMemberId(user_id, group_id);
		
		int count = dao.countMoment();
		String moment_id = String.format("MM0%s", count + 1);
		
		dto.setMoment_id(moment_id);
		dto.setGroup_id(group_id);
		dto.setMember_id(member_id);
		dto.setPhase_id(phase_id);
		
		dao.addMoment(dto);
		dao.addMomentMember(dto);
		System.out.println(user_id);
		result = "redirect:group.action?group_id=" + group_id;
		
		return result;
	}
	
	@RequestMapping("/momentoper.action")
	public String momentOper(Model model, String group_id, String moment_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		MomentDTO momentList = dao.momentList(moment_id);
		ArrayList<MomentDTO> partiList = dao.getPartiName(moment_id); 
		String date_name = momentList.getDate_name();
		
		if (date_name.length() >= 10)
		{
			if (date_name.length() > 10)
			{
				date_name = date_name.substring(0, 10);
			}
			model.addAttribute("countDate", dao.momentDateCount(user_id, date_name));
		}
		
		
		model.addAttribute("momentList", momentList);
		model.addAttribute("partiList", partiList);
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
		
		result = "/WEB-INF/view/MomentOper.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/momentjoin.action", method = RequestMethod.POST)
	public String momentJoin(MomentDTO dto, String group_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		String member_id = dao.searchMemberId(user_id, group_id);
		
		dto.setMember_id(member_id);
		
		dao.addMomentMember(dto);
		
		MomentDTO dto2 = dao.momentList(dto.getMoment_id());
		
		int countParti = dto2.getParti_num();
		int countMin = dto2.getMin_participant();
		
		if (countParti >= countMin)
		{
			String phase_id = "MH02";
			dao.modifyPhase(dto.getMoment_id(), phase_id);
		}
		
		result = "redirect:group.action?group_id=" + group_id;
		
		return result;
	}
	
	@RequestMapping("/momentcancel.action")
	public String momentCancel(String group_id, String moment_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		String member_id = dao.searchMemberId(user_id, group_id);
		String participant_id = dao.getPartiId(member_id, moment_id);
		
		dao.cancelMoment(participant_id);
		
		result = "redirect:group.action?group_id=" + group_id;
		
		return result;
	}
	
	// 빌드
	@RequestMapping("/momentbuild.action")
	public String momentBuild(Model model, String moment_id, String group_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		String survey_id = "";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		MomentDTO dto = dao.momentList(moment_id);
		ArrayList<MomentDTO> partiList = dao.getPartiName(moment_id);
		String date_name = dto.getDate_name();
		
		if (date_name.length() >= 10)
		{
			if (date_name.length() > 10)
			{
				date_name = date_name.substring(0, 10);
			}
			model.addAttribute("countDate", dao.momentDateCount(user_id, date_name));
		}
		
		int countJoin = dao.momentJoinCount(user_id, moment_id);
		
		String type_id = "";
		int[] typeCount = new int[6];
		
		for (int i = 1; i <= 6; i++)
		{
			type_id = "ST0";
			type_id = type_id + i;
			typeCount[i - 1] = dao.surveyCount(moment_id, type_id);
			survey_id = dao.searchSurveyId(type_id, moment_id);
			
			if (dao.surveyCount(moment_id, type_id) > 0)
			{
				String member_id = dao.searchMemberId(user_id, group_id);
				String participant_id = dao.getPartiId(member_id, moment_id);
				
				int countResponseNum = dao.countSurveyResponseNum(survey_id, participant_id, moment_id);
				model.addAttribute("countResponseNum" + i, countResponseNum);

				MomentDTO countResponse = dao.countSurveyResponse(survey_id, participant_id, moment_id);
				model.addAttribute("countResponse" + i, countResponse);
			}
				
			if (survey_id != null)	//-- 설문이 생성되었다면
			{
				ArrayList<MomentDTO> checkResponse = dao.checkSurveyComplete(moment_id, survey_id);
				String voteCount = String.valueOf(dao.voteCount(survey_id, type_id));
				int countAll = dao.momentJoinAllCount(moment_id);
				if (Integer.parseInt(voteCount) < 1)	//-- 투표 생성 전이라면
				{
					ArrayList<MomentDTO> checkResponseOne = dao.checkSurveyOneComplete(moment_id, survey_id);
					if (checkResponseOne.size() == 1)		// 설문이 하나라면
					{
						String survey_response_id = "";
						for (MomentDTO response : checkResponseOne)
						{
							survey_response_id = response.getSurvey_response_id();
						}
						
						switch (type_id)
						{
						case "ST01": dao.modifyMomentName(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;
						
						case "ST02": dao.modifyDateName(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;
						case "ST03": dao.modifyPlaceName(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;
						case "ST04": dao.modifyMinParticipant(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;
						case "ST05": dao.modifyMaxParticipant(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;
						case "ST06": dao.modifyNote(survey_response_id, moment_id);
									 dao.modifyWhetherSurvey(survey_response_id);
							break;	
						
						}
						model.addAttribute("check" + i, 1);
					}
					else if (checkResponse.size() >= countAll)	//-- 모든 응답이 null일 때도 확인해야 함
					{
						int count = dao.countVoteNum();
						String vote_id = String.format("MV0%s", count + 1);
						dao.addVote(vote_id, survey_id, type_id);
						model.addAttribute("voteReponse" + i, checkResponse);
					}
				}
				else	//-- 이미 투표가 존재한다면
				{
					String member_id = dao.searchMemberId(user_id, group_id);
					String participant_id = dao.getPartiId(member_id, moment_id);
					
					// 로그인한 유저가 투표 참여했는지 확인
					int voteResponseNum = dao.CountVoteResponseNum(type_id, participant_id);
					
					model.addAttribute("voteReponse" + i, checkResponse);
					model.addAttribute("voteResponseNum" + i, voteResponseNum);
					
					// 유저가 투표 완료했다면
					if (voteResponseNum > 0)
					{
						String vote_select_id = dao.getVoteResponse(participant_id, type_id);
						model.addAttribute("voteSelectId" + i, vote_select_id);
					}
					
					String vote_id = dao.getVoteId(survey_id);
					int check = 0;
					
					// 수정된 적 없고
					if (dao.checkModifyComplete(vote_id) > 0)
					{
						// 투표 자체가 끝났다면
						if (dao.checkVoteComplete(vote_id) >= countAll)
						{
							// 1위한 값 찾아오기
							String survey_response_id = dao.getVoteMax(vote_id);
							
							switch (type_id)
							{
							case "ST01": dao.modifyMomentName(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;
							
							case "ST02": dao.modifyDateName(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;
							case "ST03": dao.modifyPlaceName(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;
							case "ST04": dao.modifyMinParticipant(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;
							case "ST05": dao.modifyMaxParticipant(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;
							case "ST06": dao.modifyNote(survey_response_id, moment_id);
										 dao.modifyWhetherVote(vote_id);
								break;	
							
							}
						}
						
						model.addAttribute("check" + i, check);
					}
					else
					{
						check = 1;
						model.addAttribute("check" + i, check);
					}
				}
			}
				
		}
		
		model.addAttribute("momentList", dto);
		model.addAttribute("partiList", partiList);
		model.addAttribute("countJoin", countJoin);
		model.addAttribute("countSurvey", typeCount);
		
		result = "/WEB-INF/view/MomentBuild.jsp";
		
		return result;
	}
	
	@RequestMapping("/momentsurveyinsert.action")
	public String momentSurveyInsert(Model model, String type_id, String moment_id, String group_id, HttpSession session)
	{
		String result = null;
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);

		int count = dao.countSurveyNum();
		
		String survey_id = String.format("MS0%s", count + 1);
		
		dao.addSurvey(survey_id, moment_id, type_id);
		
		result = "redirect:momentbuild.action?moment_id=" + moment_id + "&group_id=" + group_id;
		
		return result;
	}
	
	
	@RequestMapping("/momentsurveyresponseinsert.action")
	public String momentSurveyResponseInsert(Model model, String moment_id, String group_id, String type_id, String response, String others, String impossible_date, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		String survey_id = dao.searchSurveyId(type_id, moment_id);
		String member_id = dao.searchMemberId(user_id, group_id);
		String participant_id = dao.getPartiId(member_id, moment_id);
		
		if (type_id == "ST02" && response.equals("-1"))
			response = null;
		
		dao.addSurveyResponse(survey_id, participant_id, response, others, impossible_date);
		
		result = "redirect:momentbuild.action?moment_id=" + moment_id  + "&group_id=" + group_id;
		
		return result;
	}
	
	@RequestMapping("/momentvoteresponseinsert.action")
	public String momentVoteResponseInsert(Model model, String moment_id, String group_id, String type_id, String survey_id, String survey_response_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		String member_id = dao.searchMemberId(user_id, group_id);
		String participant_id = dao.getPartiId(member_id, moment_id);
		String vote_id = dao.getVoteId(survey_id);
		System.out.println(vote_id);
		
		dao.addVoteResponse(vote_id, survey_response_id, participant_id);
		
		result = "redirect:momentbuild.action?moment_id=" + moment_id  + "&group_id=" + group_id;
		
		return result;
	}
	
}
