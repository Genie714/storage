package com.test.prj;

import java.util.ArrayList;

public interface IManagerDAO
{
	// 회원코드로 그룹코드 확인
	public GroupMemberDTO searchId(String user_id, String group_id);
	
	// 매니저 수 확인
	public int managerCount(String group_id);
	
	// 매니저 리스트 확인
	public ArrayList<GroupMemberDTO> managerList(String group_id);
	
	// 매니저 임명투표 후보전체리스트 확인
	public ArrayList<GroupMemberDTO> voteList(String group_id); 
	
	// 매니저 임명투표 추가
	public int voteAdd(ManagerVoteDTO vote);
	
	// 매니저 임명후보자 추가
	public int voteeAdd(ManagerVoteeDTO votee);
	
	// 매니저 임명투표자 추가
	public int voterAdd(ManagerVoterDTO voter);
	
	// 선택된 후보자의 매치코드로 후보자코드 확인
	public String searchSelectedId(GroupMemberDTO dto);
	
	// 다음 투표 코드 가져오기
	public String nextVoteId();
	
}
