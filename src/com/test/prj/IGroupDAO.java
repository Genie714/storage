package com.test.prj;

import java.util.ArrayList;



public interface IGroupDAO
{

	// 그룹 수 확인
	public int count();
	
	// 그룹 리스트 확인
	public ArrayList<GroupDTO> list();
	
	// (임의) 다음 그룹 생성 코드 가져오기
	public String nextGCId();
	
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
	
	
}



















