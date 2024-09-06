package com.test.prj;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class GroupController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/grouplist.action", method = RequestMethod.GET)
	public String groupList(Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		model.addAttribute("count", dao.count());
		model.addAttribute("list", dao.list());
		
		result = "/WEB-INF/view/GroupList.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/groupcreationform.action", method = RequestMethod.GET)
	public String groupCreationForm(Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		model.addAttribute("nextGCId", dao.nextGCId());
		
		result = "/WEB-INF/view/GroupCreationForm.jsp";
		
		
		
		return result;
	}
	
	@RequestMapping(value = "/groupcreationList.action", method = RequestMethod.GET)
	public String groupCreationList(Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		model.addAttribute("list", dao.creationList());
		model.addAttribute("count", dao.creationCount());
		
		result = "/WEB-INF/view/GroupCreationList.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/groupcreationinsert.action", method = RequestMethod.POST)
	public String groupCreationInsert(GroupDTO dto, Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		dao.creationAdd(dto);
		
		result = "redirect:groupcreationList.action";
		
		
		return result;
	}
	
	@RequestMapping(value = "/groupsignupquestionform.action", method = RequestMethod.GET)
	public String groupSignupQuestionForm(HttpServletRequest request, Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		String group_id = request.getParameter("id");
		
		
		model.addAttribute("nextGMId", dao.nextGMId());
		model.addAttribute("nextSUId", dao.nextSUId());
		model.addAttribute("question", dao.questionForm(group_id));
		
		result = "/WEB-INF/view/GroupSignupQuestionForm.jsp";
		
		
		return result;
	}
	
	@RequestMapping(value = "/groupsignupinsert.action", method = RequestMethod.POST)
	public String groupSignupInsert(Model model, HttpSession session, GroupDTO dto)
	{
	    String result = "";
	    String user_id = (String) session.getAttribute("user_id");

	    if (user_id == null)
	    {
	        throw new IllegalArgumentException("User ID is missing from session.");
	    }

	    IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
	    

	    dto.setUser_id(user_id);
	    dao.matchAdd(dto);
	    dao.signupAdd(dto);
	    
	    String[] temp = dto.getAnswers();
	    String[] temp1 = dto.getQuestionIds();
	
    	for (int i = 0; i < temp.length; i++)
		{
    		dto.generateUniqueId();
    		dto.setQuestion_id(dto.getQuestion_id());
    		
    		dto.setContent(temp[i]);
    		dto.setAnswer_id(dto.getAnswer_id());
    		dto.setQuestion_id(temp1[i]);
			
    		dao.answerAdd(dto);
		}

		result = "redirect:grouplist.action";
		
		return result;
		 
	}
	
	
	
}
