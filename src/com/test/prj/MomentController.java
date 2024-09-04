/*============================
 	MomentController.java
============================*/

package com.test.prj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MomentController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 사용자의 요청 주소와 메소드를 매핑하는 과정 필요
	// 『@RequestMapping(value = "요청주소", method = 전송방식)』
	// 이때, 전송 방식은 폼을 이용한 submit 액션인 경우만 POST
	// 나머지 전송 방식은 GET으로 처리한다.
	
	@RequestMapping("/group.action")
	public String momentList(Model model, String group_id)
	{
		String result = null;
		group_id = "GR01";
		
		IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
		
		model.addAttribute("count", dao.count(group_id));
		model.addAttribute("list", dao.list(group_id));
		
		result = "/WEB-INF/view/Group.jsp";
		
		return result;
	}
	
	@RequestMapping("/momentoperform.action")
	public String MomentOperForm(Model model, String group_id)
	{
		String result = null;
		group_id = "GR01";
		
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
		
		model.addAttribute("date_id", dto.getDate_id());
		model.addAttribute("year", dto.getYear());
		model.addAttribute("month", dto.getMonth());
		model.addAttribute("day", dto.getDay());
		model.addAttribute("time", dto.getTime());
		
		result = "/WEB-INF/view/MomentDateAjax.jsp";
		
		return result;
	}
	
	@RequestMapping("/momentplaceinsert.action")
	public String momentPlaceInsert(Model model, String place_name, String detail_id)
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
		
		model.addAttribute("place_id", dto.getPlace_id());
		model.addAttribute("place_name", dto.getPlace_name());
		
		result = "/WEB-INF/view/MomentPlaceAjax.jsp";
		
		return result;
	}
	
	/*
	@RequestMapping(value = "/studentinsert.action", method = RequestMethod.POST)
	public String studentInsert(StudentDTO s)
	{
		String result = null;
		
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		dao.add(s);
		
		result = "redirect:studentlist.action";
		
		return result;
	}
	
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
