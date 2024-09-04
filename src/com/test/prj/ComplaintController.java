/*
 * ComplainController.java
 * 신고 처리를 위한 컨트롤러
 * 1. 신고 버튼을 통해 인서트폼 호출
 * 2. 신고 제출 액션 수행
 * 3. 신고 리스트 확인
 * 4. 신고 알림 처리
 * 
 */
package com.test.prj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ComplaintController
{
	@Autowired
	private SqlSession sqlSession;

	// 테스트용 삭제 예정
	@RequestMapping(value = "complaintbutton.action", method = RequestMethod.GET)
	public String complaintTest(Model model)
	{	
		return "/WEB-INF/view/ComplaintButton.jsp";
	}
	
	@RequestMapping(value = "complaintinsertform.action", method = RequestMethod.GET)
	public String complaintInsertForm(Model model)
	{
		IComplaintDAO dao = sqlSession.getMapper(IComplaintDAO.class);
		
		model.addAttribute("reasonList",dao.reasonList()); 
		
		return "/WEB-INF/view/ComplaintInsertForm.jsp";
	}
	
	@RequestMapping(value = "complaintinsert.action", method = RequestMethod.POST)
	public String complaintInsert(Model model, ComplaintDTO complaint)
	{
		IComplaintDAO dao = sqlSession.getMapper(IComplaintDAO.class);
		
		dao.complaintInsert(complaint);
		
		return "/WEB-INF/view/Main.jsp";
	}

}
