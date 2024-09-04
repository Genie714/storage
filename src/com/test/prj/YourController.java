package com.test.prj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class YourController
{
	//@Autowired
	//private SqlSession sqlSession;
	
	/*
	@RequestMapping(value = "main.action", method = RequestMethod.GET)
	public String main(Model model)
	{
		return "/WEB-INF/view/Main.jsp"; 
	}

	@RequestMapping(value = "loginform.action", method = RequestMethod.GET)
	public String loginForm(Model model)
	{
		return "LoginForm";
	}

	@RequestMapping(value = "grouplist.action", method = RequestMethod.GET)
	public String groupList(Model model)
	{
		String result = "";
		
		// 프로젝트에 없어서 주석처리했음(대진)
		//IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		//model.addAttribute("count", dao.count());
		//model.addAttribute("list", dao.list());
		
		result = "/WEB-INF/view/GroupList.jsp";
		
		return result;
	}

	@RequestMapping(value = "paneltyannounce.action", method = RequestMethod.GET)
	public String paneltyAnnounce(Model model)
	{
		return "PaneltyAnnounce";
	}

	@RequestMapping(value = "personal.action", method = RequestMethod.GET)
	public String personal(Model model)
	{
		return "Personal";
	}

	@RequestMapping(value = "findid.action", method = RequestMethod.GET)
	public String findId(Model model)
	{
		return "FindId";
	}

	@RequestMapping(value = "findpw.action", method = RequestMethod.GET)
	public String findPw(Model model)
	{
		return "FindPw";
	}
	

	@RequestMapping(value = "momentoper.action", method = RequestMethod.GET)
	public String momentOper(Model model)
	{
		return "MomentOper";
	}

	@RequestMapping(value = "momentbuild.action", method = RequestMethod.GET)
	public String momentBuild(Model model)
	{
		return "MomentBuild";
	}

	@RequestMapping(value = "momentinfo.action", method = RequestMethod.GET)
	public String momentInfo(Model model)
	{
		return "MomentInfo";
	}

	@RequestMapping(value = "groupsignupquestionupdate.action", method = RequestMethod.GET)
	public String groupSignupQuestionUpdate(Model model)
	{
		return "GroupSignupQuestionUpdate";
	}

	@RequestMapping(value = "groupsignupquestionform.action", method = RequestMethod.GET)
	public String groupSignupQuestionForm(Model model)
	{
		return "GroupSignupQuestionForm";
	}

	@RequestMapping(value = "groupsignupcheck.action", method = RequestMethod.GET)
	public String groupSignupCheck(Model model)
	{
		return "GroupSignupCheck";
	}

	@RequestMapping(value = "groupsignupcheckproposer.action", method = RequestMethod.GET)
	public String groupSignupCheckProposer(Model model)
	{
		return "GroupSignupCheckProposer";
	}

	@RequestMapping(value = "groupcreationform.action", method = RequestMethod.GET)
	public String groupCreationForm(Model model)
	{
		return "GroupCreationForm";
	}

	@RequestMapping(value = "groupinvitee.action", method = RequestMethod.GET)
	public String groupInvitee(Model model)
	{
		return "GroupInvitee";
	}

	@RequestMapping(value = "groupinviteactivate.action", method = RequestMethod.GET)
	public String groupInviteActivate(Model model)
	{
		return "GroupInviteactivate";
	}

	@RequestMapping(value = "managerselection.action", method = RequestMethod.GET)
	public String managerSelection(Model model)
	{
		return "ManagerSelection";
	}

	@RequestMapping(value = "managercandidateinvitation.action", method = RequestMethod.GET)
	public String managerCandidateInvitation(Model model)
	{
		return "ManagerCandidateInvitation";
	}

	@RequestMapping(value = "managercandidatelist.action", method = RequestMethod.GET)
	public String managerCandidateList(Model model)
	{
		return "ManagerCandidateList";
	}

	@RequestMapping(value = "managerselectiondecision.action", method = RequestMethod.GET)
	public String managerSelectionDecision(Model model)
	{
		return "ManagerSelectionDecision";
	}

	@RequestMapping(value = "managervote.action", method = RequestMethod.GET)
	public String managerVote(Model model)
	{
		return "ManagerVote";
	}

	@RequestMapping(value = "groupproposallist.action", method = RequestMethod.GET)
	public String groupProposalList(Model model)
	{
		return "GroupProposalList";
	}

	@RequestMapping(value = "groupproposalinsert.action", method = RequestMethod.GET)
	public String groupProposalInsert(Model model)
	{
		return "GroupProposalInsert";
	}

	@RequestMapping(value = "groupproposalupdate.action", method = RequestMethod.GET)
	public String groupProposalUpdate(Model model)
	{
		return "GroupProposalUpdate";
	}

	@RequestMapping(value = "groupannouncementinsert.action", method = RequestMethod.GET)
	public String groupAnnouncementInsert(Model model)
	{
		return "GroupAnnouncementInsert";
	}

	@RequestMapping(value = "groupannouncementupdate.action", method = RequestMethod.GET)
	public String groupAnnouncementUpdate(Model model)
	{
		return "GroupAnnouncementUpdate";
	}

	@RequestMapping(value = "grouppolicyinsert.action", method = RequestMethod.GET)
	public String groupPolicyInsert(Model model)
	{
		return "GroupPolicyInsert";
	}

	@RequestMapping(value = "grouppenaltyinsert.action", method = RequestMethod.GET)
	public String groupPenaltyInsert(Model model)
	{
		return "GroupPenaltyInsert";
	}

	@RequestMapping(value = "grouppenalty.action", method = RequestMethod.GET)
	public String groupPenalty(Model model)
	{
		return "GroupPenalty";
	}

	@RequestMapping(value = "groupalarminsert.action", method = RequestMethod.GET)
	public String groupAlarmInsert(Model model)
	{
		return "GroupAlarmInsert";
	}

	@RequestMapping(value = "managerlist.action", method = RequestMethod.GET)
	public String managerList(Model model)
	{
		return "ManagerList";
	}

	@RequestMapping(value = "managerinsertform.action", method = RequestMethod.GET)
	public String managerInsertForm(Model model)
	{
		return "ManagerInsertForm";
	}

	@RequestMapping(value = "adjustment.action", method = RequestMethod.GET)
	public String adjustment(Model model)
	{
		return "AdjustMent";
	}

	@RequestMapping(value = "gallerylist.action", method = RequestMethod.GET)
	public String galleryList(Model model)
	{
		return "GalleryList";
	}

	@RequestMapping(value = "gallerypost.action", method = RequestMethod.GET)
	public String galleryPost(Model model)
	{
		return "GalleryPost";
	}

	@RequestMapping(value = "admin.action", method = RequestMethod.GET)
	public String admin(Model model)
	{
		return "Admin";
	}

	@RequestMapping(value = "admincomplaint.action", method = RequestMethod.GET)
	public String adminComplaint(Model model)
	{
		return "AdminComplaint";
	}

	@RequestMapping(value = "complaintinsert.action", method = RequestMethod.GET)
	public String complaintInsert(Model model)
	{
		return "ComplaintInsert";
	}
	
	@RequestMapping(value = "complaintinsertform.action", method = RequestMethod.GET)
	public String complaintInsertForm(Model model)
	{
		return "/WEB-INF/view/ComplaintInsertForm.jsp";
	}

	@RequestMapping(value = "alarm.action", method = RequestMethod.GET)
	public String alarm(Model model)
	{
		return "Alarm";
	}
	
	//테스트용 삭제 예정
	@RequestMapping(value = "complainttest.action", method = RequestMethod.GET)
	public String complaintTest(Model model)
	{
		return "/WEB-INF/view/ComplainTest.jsp";
	}
	
	*/
}
