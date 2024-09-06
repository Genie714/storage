package com.test.prj;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MangerController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/grouppage.action", method = RequestMethod.GET)
	public String groupPage(Model model, String user_id)
	{
		if (user_id == null)
		{
			user_id = "US08";
		}
		
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);

		GroupMemberDTO dto = new GroupMemberDTO();
		dto = dao.searchId(user_id);
		
		int managerCount = dao.managerCount(dto.getGroup_id());
		
		ArrayList<GroupMemberDTO> group = new ArrayList<GroupMemberDTO>();
		group = dao.managerList(dto.getGroup_id());
		
		ManagerVoteDTO vote = new ManagerVoteDTO();
		vote.setGroup_id(dto.getGroup_id());
		vote.setId("MV03");
		dao.voteAdd(vote);
		
		ArrayList<GroupMemberDTO> voteeList = new ArrayList<GroupMemberDTO>();
		
		voteeList = dao.voteList(dto.getGroup_id());
		for (GroupMemberDTO member : voteeList)
		{
			ManagerVoteeDTO votee = new ManagerVoteeDTO();
			
			//votee.setId("VE03");
			votee.generateUniqueId();
			votee.setVote_id(vote.getId());
			votee.setVotee_id(member.getMatch_id());
			
			dao.voteeAdd(votee);
		}
		
		model.addAttribute("group_id", dto.getGroup_id());
		model.addAttribute("match_id", dto.getMatch_id());
		model.addAttribute("managerCount", managerCount);
		model.addAttribute("managerList", group);
		
		return "/WEB-INF/view/GroupPage.jsp";
	}
	
	@RequestMapping(value="/managervote.action", method=RequestMethod.GET)
	public String managerList(Model model, GroupMemberDTO dto) 
	{ 
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		
		ArrayList<GroupMemberDTO> candidates = dao.voteList(dto.getGroup_id());
		
		model.addAttribute("candidates", candidates);
		model.addAttribute("group_id", dto.getGroup_id());
		
		return "/WEB-INF/view/ManagerVote.jsp";
	}
	
	@RequestMapping(value="/managervotefin.action", method=RequestMethod.POST)
	public String managerVoteFin(Model model, GroupMemberDTO dto, ManagerVoteDTO vote,
           						@RequestParam("candidateMatchId") String match_id)
	{
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		
		ManagerVoterDTO voter = new ManagerVoterDTO();
		
		/*
		System.out.println("group_id : " + group_id);
		System.out.println("match_id : " +  match_id);
		System.out.println("vote_id : " +  vote.getId());
		System.out.println("match_id : " + member.getMatch_id());
		*/
		
		String group_id = dto.getGroup_id();
		
		voter.generateUniqueId();
		voter.setVote_id(vote.getId());
		voter.setGrmrvotee_id(dao.searchGrmrVoteeId(group_id, match_id));
		voter.setVoter_id(dto.getMatch_id());
		
		dao.voterAdd(voter);
		
		return "redirect:grouppage.action";
	
	}
	
	
	
}
