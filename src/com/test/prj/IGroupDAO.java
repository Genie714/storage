package com.test.prj;

import java.util.ArrayList;

public interface IGroupDAO
{

   // 그룹 수 확인
   public int count();
   
   // 그룹 리스트 확인
   public ArrayList<GroupDTO> list();
   
   // 특정 그룹의 그룹원 수 확인(그룹 총원)
   public String groupMemberCount(String group_id);
   
   // (임의) 다음 그룹 생성 코드 가져오기
   public String nextGTId();
   
   // 그룹 생성 신청 데이터 입력(insert)
   public int creationAdd(GroupDTO dto);
   
   // 가개설 그룹 리스트 확인
   public ArrayList<GroupDTO> creationList();
   
   // 가개설 그룹 수 확인
   public int creationCount();
   
   // 해당 그룹 그룹신청서 질문 가져오기
   public ArrayList<GroupDTO> questionForm(String group_id);
   
   // 다음 그룹 매치 코드 가져오기
   public String nextGMId();
   
   // 그룹 매치 데이터 입력(insert)
   public int matchAdd(GroupDTO dto);
   
   // 다음 그룹 가입 코드 가져오기
   public String nextSUId();
   
   // 그룹 자발 가입 데이터 입력(insert)
   public int signupAdd(GroupDTO dto);
   
   // 그룹 신청서 응답 데이터 입력(insert);
   public int answerAdd(GroupDTO dto);
   
   // 다음 응답 코드 가져오기
   public String nextSAId();
   
   // 해당그룹회원 특정매칭코드 가져오기
   public String GroupMemberGMId(GroupInviteDTO dto);
   
   // 그룹 초기 초대 데이터 입력(insert)
   public int preinviteAdd(GroupInviteDTO dto);
   
   // 그룹 초대 합류 데이터 입력(insert)
   public int inviteAdd(GroupInviteDTO dto);
   
   // 그룹 매치 아이디로 그룹 아이디 조회
   public String searchGRId(String gmId);
   
   // 매니저 수 확인
   public int managerCount(String group_id);
   
   // 매니저 리스트 확인
   public ArrayList<GroupDTO> managerList(String group_id);
   
   // 일반 회원 리스트 확인
   public ArrayList<GroupDTO> generalMemberList(String group_id);
   
   // 인포 모먼트 가장 많은 그룹 아이디 조회
   public GroupDTO activeGroupId();

   // 특정 그룹 정보 조회
   public GroupDTO groupInformation(String group_id);
		
   // 최근 일주일 이내에 생성된 그룹 조회
   public ArrayList<GroupDTO> recentList();
		
   // 그룹원이 제일 많은 그룹 아이디 조회
   public GroupDTO largeGroupId();
		
   // 특정 그룹명 COUNT 조회
   public int groupNameCount(String name);
		
   // 그룹명 검색 결과 조회
   public ArrayList<GroupDTO> searchGroupResult(String name);
		
   // 특정 회원의 가개설 그룹 COUNT 조회
   public int creationGroupCount(String user_id);

  
}
