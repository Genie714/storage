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
      String user_id = "";
      String moment_id = "";
      String type_id = "";
      
      user_id = (String)session.getAttribute("user_id");
      
      if (user_id == null)
         result = "redirect:loginform.action";
      
      IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
      
      DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String sysdate = dateFormat.format(new java.util.Date());
      
      ArrayList<MomentDTO> endTimeList = dao.searchEndMoment(group_id);
      
      if (endTimeList != null)
      {
         for (MomentDTO dto : endTimeList)
         {
            // 현재 날짜로부터 계획기간까지 남은 시간 구하기
            String plan_end_date = dto.getPlan_end_date();
            java.util.Date d1 = dateFormat.parse(plan_end_date);
            java.util.Date d2 = dateFormat.parse(sysdate);
            long end_time = (d1.getTime() - d2.getTime()) / 1000;
            
            // ① 계획기간 끝나기 전에 멤버가 0명이 되면
            if (dto.getParti_num() == 0)
            {
               type_id = "NY02";
               moment_id = dto.getMoment_id();
               dao.addNonactiveMoment(moment_id, type_id);
            }
            
            // 계획기간이 끝났을 때
            if (end_time <= 0)
            {
               // ② 모먼트 요소 미완성
               if (dto.getMoment_name() == null
                     || dto.getDate_name().length() < 19
                     || dto.getPlace_name()  == null
                     || String.valueOf(dto.getMin_participant()) == null
                     || dto.getMax_participant()  == null)
               {
                  type_id = "NY01";
                  moment_id = dto.getMoment_id();
                  dao.addNonactiveMoment(moment_id, type_id);
               }   // ③ 0명은 아니지만 최소인원 미달
               else if (dto.getMin_participant() > dto.getParti_num())
               {
                  type_id = "NY02";
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
      
      // 그룹 초대합류 관련 코드 → 여기부터 합본
       IGroupDAO groupDao = sqlSession.getMapper(IGroupDAO.class);
         
       GroupInviteDTO groupDto = new GroupInviteDTO();
       groupDto.setUser_id(user_id);
       groupDto.setGroup_id(group_id);
       String gmId = groupDao.GroupMemberGMId(groupDto);
         
       model.addAttribute("gmId", gmId);
         
         
       // 그룹 관련 데이터 조회
       int managerCount = groupDao.managerCount(group_id);
       model.addAttribute("managerCount", managerCount);
         
       ArrayList<GroupDTO> managerList = new ArrayList<GroupDTO>();
       managerList = groupDao.managerList(group_id);
       model.addAttribute("managerList", managerList);
         
       ArrayList<GroupDTO> generalMemberList = new ArrayList<GroupDTO>();
       generalMemberList = groupDao.generalMemberList(group_id);
       model.addAttribute("generalMemberList", generalMemberList);
         
       String memberTotalCount = groupDao.groupMemberCount(group_id);
       model.addAttribute("memberTotalCount", memberTotalCount);
       System.out.println(memberTotalCount);
         
         
       IManagerDAO mDao = sqlSession.getMapper(IManagerDAO.class);
         
       GroupMemberDTO mDto = new GroupMemberDTO();
       mDto.setMatch_id(member_id);
       System.out.println(mDto.getMatch_id());
         
       model.addAttribute("group_id", group_id);
       model.addAttribute("member_id", member_id);
       
       int mTotCount = Integer.parseInt(memberTotalCount);
         
       if ( (mTotCount >= 5 && mTotCount <= 20 && managerCount < 1)  ||
            (mTotCount >= 21 && mTotCount <= 40 && managerCount < 2) ||
            (mTotCount >= 41 && mTotCount <= 60 && managerCount < 3) ||
            (mTotCount >= 61 && mTotCount <= 80 && managerCount < 4) ||
            (mTotCount >= 81 && mTotCount <= 100 && managerCount < 5) )
        {
           // 투표 관련 데이터 조회(매니저 최소인원보다 부족할 시에만 실행)
            ManagerVoteDTO vote = new ManagerVoteDTO();
            vote.setId(mDao.nextVoteId());
            vote.setGroup_id(group_id);
            mDao.voteAdd(vote);
            
            ArrayList<GroupMemberDTO> voteeList = new ArrayList<GroupMemberDTO>();
            voteeList = mDao.voteList(group_id);
            
            for (GroupMemberDTO member : voteeList)
            {
               ManagerVoteeDTO votee = new ManagerVoteeDTO();
               
               votee.generateUniqueId();
               votee.setVote_id(vote.getId());
               votee.setVotee_id(member.getMatch_id());   
               
               mDao.voteeAdd(votee);
            }
            
            model.addAttribute("vote_id", vote.getId());
         
         }
      
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
      
      if (countParti >= countMin && dto.getPhase_id() == "MH01")
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
      String member_id = "";
      String type_id = "";
      
      IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);

      member_id = dao.searchMemberId(user_id, group_id);
      
      // 모먼트 요소들 완성도 확인
      MomentDTO dto = dao.momentList(moment_id);
      
      if (dto.getDate_name().length() == 19 && dto.getDetail_id().equals("ML02")
         && dto.getMax_participant() != null
         && dao.checkMomentCompleteCount(moment_id) < 1)
      {
         model.addAttribute("infoCheck", 1);
      }
      
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
      
      int[] typeCount = new int[6];
      
      for (int i = 1; i <= 6; i++)
      {
         type_id = "ST0";
         type_id = type_id + i;
         typeCount[i - 1] = dao.surveyCount(moment_id, type_id);
         survey_id = dao.searchSurveyId(type_id, moment_id);
         
         if (dao.surveyCount(moment_id, type_id) > 0)
         {
            String participant_id = dao.getPartiId(member_id, moment_id);
            
            int countResponseNum = dao.countSurveyResponseNum(survey_id, participant_id, moment_id);
            model.addAttribute("countResponseNum" + i, countResponseNum);

            MomentDTO countResponse = dao.countSurveyResponse(survey_id, participant_id, moment_id);
            model.addAttribute("countResponse" + i, countResponse);
         }
            
         if (survey_id != null)   //-- 설문이 생성되었다면
         {
            ArrayList<MomentDTO> checkResponse = dao.checkSurveyComplete(moment_id, survey_id);
            int voteCount = dao.voteCount(survey_id, type_id);
            int countAll = dao.momentJoinAllCount(moment_id);
            if (voteCount < 1)   //-- 투표 생성 전이라면
            {
               if (dao.checkModifySurveyComplete(survey_id) > 0)   // 아직 모먼트가 수정된 적 없고
               {
                  if (checkResponse.size() >= countAll)   //-- 모든 응답이 null일 때도 확인해야 함
                  {
                     ArrayList<MomentDTO> checkResponseOne = dao.checkSurveyOneComplete(moment_id, survey_id);
                     
                     if (checkResponseOne.size() == 1)      // 유효한 설문이 하나라면
                     {
                        String survey_response_id = "";
                        for (MomentDTO response : checkResponseOne)
                        {
                           survey_response_id = response.getSurvey_response_id();
                        }
                        
                        switch (type_id)
                        {
                        case "ST01": dao.modifyMomentName(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                           break;
                        case "ST02": dao.modifyDateName(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                           break;
                        case "ST03": dao.modifyPlaceName(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                                  dao.modifyPlaceDetail(moment_id);
                           break;
                        case "ST04": dao.modifyMinParticipant(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                           break;
                        case "ST05": dao.modifyMaxParticipant(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                           break;
                        case "ST06": dao.modifyNote(survey_response_id, moment_id);
                                  dao.modifyWhetherSurvey(survey_id);
                           break;   
                        }
                        
                        model.addAttribute("check" + i, 1);
                     }
                     else
                     {
                        int count = dao.countVoteNum();
                        String vote_id = String.format("MV0%s", count + 1);
                        dao.addVote(vote_id, survey_id, type_id);
                        model.addAttribute("voteReponse" + i, checkResponse);
                     }
                  }
               }
               else
               {
                  model.addAttribute("check" + i, 1);
               }
               
            }
            else   //-- 이미 투표가 존재한다면
            {
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
               
               // 아직 모먼트가 수정된 적 없고
               if (dao.checkModifyVoteComplete(vote_id) > 0)
               {
                  // 투표 자체가 끝났다면
                  if (dao.checkVoteComplete(vote_id) >= countAll)
                  {
                     // 1위한 값 찾아오기
                     String survey_response_id = dao.getVoteMax(vote_id);
                     switch (type_id)
                     {
                     case "ST01": dao.modifyMomentName(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                        break;
                     
                     case "ST02": dao.modifyDateName(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                        break;
                     case "ST03": dao.modifyPlaceName(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                               dao.modifyPlaceDetail(moment_id);
                        break;
                     case "ST04": dao.modifyMinParticipant(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                        break;
                     case "ST05": dao.modifyMaxParticipant(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                        break;
                     case "ST06": dao.modifyNote(survey_response_id, moment_id);
                               dao.modifyWhetherSurvey(survey_id);
                               dao.modifyWhetherVote(vote_id);
                        break;   
                     
                     }
                     
                     check = 1;
                  }
                  
               }
               else
               {
                  check = 1;
               }
               
               model.addAttribute("check" + i, check);
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
      
      dao.addVoteResponse(vote_id, survey_response_id, participant_id);
      
      result = "redirect:momentbuild.action?moment_id=" + moment_id  + "&group_id=" + group_id;
      
      return result;
   }
   
   // 인포
   @RequestMapping("/momentinfochange.action")
   public String momentVoteInfchange(Model model, String moment_id, String group_id, HttpSession session)
   {
      String result = null;
      String user_id = (String)session.getAttribute("user_id");
      String phase_id = "MH03";
      
      IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
      
      dao.modifyPhase(moment_id, phase_id);
      
      result = "redirect:group.action?group_id=" + group_id;
      
      return result;
   }
   
   @RequestMapping("/momentinfo.action")
   public String momentInfo(Model model, String group_id, String moment_id, HttpSession session) throws ParseException
   {
      String result = null;
      String user_id = (String)session.getAttribute("user_id");
      String plan_end_date = "";
      String sysdate = "";
      String date_name = "";
      
      IMomentDAO dao = sqlSession.getMapper(IMomentDAO.class);
      
      MomentDTO momentList = dao.momentList(moment_id);
      ArrayList<MomentDTO> partiList = dao.getPartiName(moment_id); 
      
      MomentDTO dto = dao.momentList(moment_id);
      plan_end_date = dto.getPlan_end_date();
      //System.out.println(plan_end_date);
      //--==>> 2024-09-10 17:00:00
      
      DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      sysdate = dateFormat.format(new java.util.Date());
      date_name = momentList.getDate_name();
      
      // 이미 완료된 모먼트인지(모먼트 일시가 현재 날짜보다 전인지) 확인
      java.util.Date d1 = dateFormat.parse(date_name);
      java.util.Date d2 = dateFormat.parse(sysdate);
      long end_time = (d1.getTime() - d2.getTime()) / 1000;
      
      if (end_time <= 0)
         model.addAttribute("endMoment", end_time);
      
      // 계획기간 지났는지 확인
      java.util.Date d3 = dateFormat.parse(plan_end_date);
      long plan_end_time = (d3.getTime() - d2.getTime()) / 1000;
      
      if (plan_end_time <= 0)
         model.addAttribute("planEndMoment", plan_end_time);
      
      date_name = date_name.substring(0, 10);
      model.addAttribute("countDate", dao.momentDateCount(user_id, date_name));
      model.addAttribute("momentList", momentList);
      model.addAttribute("partiList", partiList);
      model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
      
      result = "/WEB-INF/view/MomentInfo.jsp";
      
      return result;
   }
   
}
