/*============================
 	MomentController.java
============================*/

package com.test.prj;

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
	
	// 사용자의 요청 주소와 메소드를 매핑하는 과정 필요
	// 『@RequestMapping(value = "요청주소", method = 전송방식)』
	// 이때, 전송 방식은 폼을 이용한 submit 액션인 경우만 POST
	// 나머지 전송 방식은 GET으로 처리한다.
	
	// 모먼트 조회
	@RequestMapping("/group.action")
	public String momentList(Model model, String group_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		String moment_id = "";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		ArrayList<MomentDTO> endTimeList = dao.searchEndMoment(group_id);
		
		for (MomentDTO dto : endTimeList)
		{
			String temp = dto.getEnd_time();
			System.out.println(dto.getMoment_id());
			System.out.println(temp);
			
			if (dto.getMoment_id() != null && dto.getEnd_time() != null)
			{
				if (Long.parseLong(dto.getEnd_time()) <= 0)
				{
					moment_id = dto.getMoment_id();
					dao.addNonactiveMoment(moment_id);
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
	public String momentDateInsert(Model model, String year, String month, String day, String time)
	{
		String result = null;
		MomentDTO dto = new MomentDTO();
		
		day = day.trim();
		day = day.replace("%20", "");
		
		if (day.equals("-1"))
			day = "";
		
		if (time.equals("-1"))
			time = "";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);

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
		
		result = "/WEB-INF/view/MomentDateAjax.jsp?date_id=" + dto.getDate_id();
		
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
		
		MomentDTO dto = dao.momentList(moment_id);
		String date_name = dto.getDate_name();
		
		if (date_name.length() >= 10)
		{
			if (date_name.length() > 10)
			{
				date_name = date_name.substring(0, 10);
			}
			//System.out.println(date_name);
			//System.out.println(dao.momentDateCount(user_id, date_name));
			model.addAttribute("countDate", dao.momentDateCount(user_id, date_name));
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
		
		result = "/WEB-INF/view/MomentOper.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/momentoperjoin.action", method = RequestMethod.POST)
	public String momentOperJoin(MomentDTO dto, String group_id, HttpSession session)
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
	
	@RequestMapping("/momentopercancel.action")
	public String momentOperCancel(String group_id, String moment_id, HttpSession session)
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
		
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		MomentDTO dto = dao.momentList(moment_id);
		String date_name = dto.getDate_name();
		
		if (date_name.length() >= 10)
		{
			if (date_name.length() > 10)
			{
				date_name = date_name.substring(0, 10);
			}
			model.addAttribute("countDate", dao.momentDateCount(user_id, date_name));
		}
		
		String type_id = "";
		int[] typeCount = new int[6];
		
		for (int i = 1; i <= 6; i++)
		{
			type_id = "ST0";
			type_id = type_id + i;
			typeCount[i - 1] = dao.surveyCount(moment_id, type_id);
			if (dao.surveyCount(moment_id, type_id) > 0)
			{
				String survey_id = dao.searchSurveyId(type_id, moment_id);
				String member_id = dao.searchMemberId(user_id, group_id);
				String participant_id = dao.getPartiId(member_id, moment_id);
				
				int countResponseNum = dao.countSurveyResponseNum(survey_id, participant_id, moment_id);
				model.addAttribute("countResponseNum" + i, countResponseNum);

				MomentDTO countResponse = dao.countSurveyResponse(survey_id, participant_id, moment_id);
				model.addAttribute("countResponse" + i, countResponse);
			}
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
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
	
	
	/*
	@RequestMapping(value = "/studentupdateform.action", method = RequestMethod.GET)
	public String studentUpdateForm(String sid, Model model)
	{
		String result = null;
		
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		model.addAttribute("search", dao.search(sid));
		
		result = "/WEB-INF/view/StudentUpdateForm.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/studentupdate.action", method = RequestMethod.POST)
	public String studentUpdate(StudentDTO s)
	{
		String result = null;
		
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		dao.modify(s);
		
		result = "redirect:studentlist.action";
		
		return result;
	}
	
	@RequestMapping("/studentdelete.action")
	public String studentDelete(String sid)
	{
		String result = null;
		
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		dao.remove(sid);
		
		result = "redirect:studentlist.action";
		
		return result;
	}
	*/
}
