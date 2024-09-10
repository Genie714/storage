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
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class GroupController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/grouplist.action", method = RequestMethod.GET)
	public String groupList(Model model, HttpSession session)
	{
		String result = "";
		
		String user_id = (String) session.getAttribute("user_id");
		

	    if (user_id == null)
	    {
	    	result = "redirect:loginform.action";
			return result;
	    }
	    
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		ArrayList<GroupDTO> list = new ArrayList<GroupDTO>();
		
		list = dao.list();
		
		for (GroupDTO dto : list)
		{
			String group_id = dto.getId();
			String memberCount = dao.groupMemberCount(group_id);
			dto.setMemberCount(memberCount);
		}
		
		GroupDTO dtoActive = dao.activeGroupId();
		String activeGroup_id = dtoActive.getGroup_id();
		String activeCount = dtoActive.getCount();
		
		GroupDTO dtoLarge = dao.largeGroupId();
		String largeGroup_id = dtoLarge.getGroup_id();
		String largeCount = dtoLarge.getCount();
		
		// 회원이 속한 그룹 코드 전달
		IPersonalDAO daoPersonal = sqlSession.getMapper(IPersonalDAO.class);
		ArrayList<GroupDTO> findGroup = daoPersonal.findGroup(user_id);
		
		
		model.addAttribute("findGroup", findGroup);
		model.addAttribute("largeGroup", dao.groupInformation(largeGroup_id));
		model.addAttribute("largeCount", largeCount);
		model.addAttribute("activeGroup", dao.groupInformation(activeGroup_id));
		model.addAttribute("activeCount", activeCount);
		model.addAttribute("count", dao.count());
		model.addAttribute("list", list);
		model.addAttribute("creationList", dao.creationList());
		model.addAttribute("creationCount", dao.creationCount());
		model.addAttribute("recentList", dao.recentList());
		
		
		result = "/WEB-INF/view/GroupList.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/searchgroup.action", method = RequestMethod.GET)
	public String searchGroup(Model model, HttpServletRequest request)
	{
		String result = "";
		
		String name = request.getParameter("keyword");
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		ArrayList<GroupDTO> resultList = new ArrayList<GroupDTO>();
		
		resultList = dao.searchGroupResult(name);
		
		model.addAttribute("count", dao.groupNameCount(name));
		model.addAttribute("resultList", resultList);
		
		
		result = "/WEB-INF/view/SearchGroup.jsp";
		
		
		
		return result;
	}
	
	@RequestMapping("/groupnamecount.action")
	public String groupNameCount(Model model, String name)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		result = "/WEB-INF/view/GroupNameCountAjax.jsp?count=" + dao.groupNameCount(name);
		System.out.println(dao.groupNameCount(name));
		

		return result;
	}
	
	
	@RequestMapping(value = "/groupcreationform.action", method = RequestMethod.GET)
	public String groupCreationForm(Model model, HttpSession session)
	{
		String result = "";
		
		String user_id = (String) session.getAttribute("user_id");

	    if (user_id == null)
	    {
	    	result = "redirect : loginform.action";
			return result;
	    }
		
	    
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		model.addAttribute("count", dao.creationGroupCount(user_id));
		model.addAttribute("nextGCId", dao.nextGTId());
		model.addAttribute("nextGMId", dao.nextGMId());
		
		result = "/WEB-INF/view/GroupCreationForm.jsp";
		
		
		
		return result;
	}
	
	@RequestMapping(value = "/groupcreationList.action", method = RequestMethod.GET)
	public String groupCreationList(Model model, HttpSession session)
	{
		String result = "";
		
		String user_id = (String) session.getAttribute("user_id");

	    if (user_id == null)
	    {
	    	result = "redirect:loginform.action";
			return result;
	    }
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		ArrayList<GroupDTO> creationList = dao.creationList();
		
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("list", creationList);
		model.addAttribute("count", dao.creationCount());
		
		result = "/WEB-INF/view/GroupCreationList.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/groupcreationinsert.action", method = RequestMethod.POST)
	public String groupCreationInsert(GroupDTO dto, Model model, HttpSession session, GroupInviteDTO dtoInvite)
	{
		String result = "";
		
		String user_id = (String)session.getAttribute("user_id");
		
		if (user_id == null)
	    {
	        throw new IllegalArgumentException("User ID is missing from session.");
	    }
		
		dto.setUser_id(user_id);
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		dao.creationAdd(dto);
		dao.matchAdd(dto);
		
		System.out.println(dtoInvite.getCreate_id());
		
		// 초기 초대 INSERT
		dtoInvite.generateUniqueId();
		dtoInvite.setReception_id(dto.getMatch_id());
		dtoInvite.setCreate_id(dto.getId());
		dtoInvite.setWhether_id("SW01");
		dao.preinviteAdd(dtoInvite);

		
		result = "redirect:groupcreationList.action";
		
		
		return result;
	}
	
	@RequestMapping(value = "/groupsignupquestionform.action", method = RequestMethod.GET)
	public String groupSignupQuestionForm(HttpServletRequest request, Model model)
	{
		String result = "";
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		String group_id = request.getParameter("group_id");
		
		
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
	    
	    String[] answers = dto.getAnswers();
	    String[] questionIds = dto.getQuestionIds();
	
    	for (int i = 0; i < answers.length; i++)
		{
    		dto.generateUniqueId();
    		
    		dto.setContent(answers[i]);
    		dto.setQuestion_id(questionIds[i]);
			
    		dao.answerAdd(dto);
		}

		result = "redirect:grouplist.action";
		
		return result;
		 
	}
	
	@RequestMapping(value = "/groupinvite.action", method = RequestMethod.GET)					// groupinvite.action?gmId=GM01&gjId=GJ01 or groupinvite.action?gmId=GM01&gjId=GJ02  (초대하는 버튼 url → 초대받는 사람이 보는 페이지)
	public String GroupInvite(Model model)
	{
		String result = "";
		
		result = "/WEB-INF/view/GroupInvite.jsp";
		
		
		return result;
	}
	// 초기초대
   @RequestMapping(value = "/grouppreinvitewhetherinsert.action", method = RequestMethod.POST)
   public String GroupPreInviteController(@RequestParam("matchId") String match_id,
                                 @RequestParam("typeId") String type_id,
                                 @RequestParam("response") String response ) 
   {
      if ("0".equals(response))      // 수락 버튼 눌렀을 경우
      {
         
      }
      else if ("1".equals(response))
      {
         
      }
      return "redirect:main.action";
   
   }
	@RequestMapping(value = "/groupinvitewhetherinsert.action", method = RequestMethod.GET)		// groupinvitewhetherinsert.action?gmId=GM01&gjId=GJ01 (초대받은 사람이 수락/거절 누르는 액션 → 개인페이지)
	public String GroupInviteWhetherInsert(Model model, GroupInviteDTO dtoInvite, GroupDTO dto, HttpServletRequest request, HttpSession session)
	{
		String result = "";
		
		
		String user_id = (String)session.getAttribute("user_id");
		
		if (user_id == null)
		{
			result = "redirect : loginform.action";
			return result;
		}
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		String outgoing_id = request.getParameter("matchId");
		String type_id = request.getParameter("typeId");
		String whether_id = request.getParameter("response");

		// GR_MATCH INSERT
		dto.setUser_id(user_id);
		String gmId = dao.nextGMId();
		dto.setMatch_id(gmId);
		String group_id = dao.searchGRId(outgoing_id);
		dto.setGroup_id(group_id);
		dto.setType_id(type_id);
		dao.matchAdd(dto);
		System.out.println(user_id);
		System.out.println(gmId);
		System.out.println(group_id);
		System.out.println(type_id);
		
		// GR_INVITE INSERT
		dtoInvite.generateUniqueId();
		dtoInvite.setUser_id(user_id);
		dtoInvite.setGroup_id(group_id);
		System.out.println(gmId);
		dtoInvite.setReception_id(gmId);
		System.out.println(outgoing_id);
		dtoInvite.setOutgoing_id(outgoing_id);
		dtoInvite.setGroup_id(group_id);
		dtoInvite.setWhether_id(whether_id);
		dao.inviteAdd(dtoInvite);
		
		
		
		result = "redirect:grouplist.action";
		
		
	
		return result;
	}
	
	
	
	
	
	
}
