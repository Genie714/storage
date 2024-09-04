/*====================
	IMomentDAO.java
	- 인터페이스
====================*/

package com.test.prj;

import java.util.ArrayList;

public interface IMomentDAO
{
	// 그룹 페이지에서 모먼트 리스트 확인
	public ArrayList<MomentDTO> list(String group_id);
	
	// 모먼트 등록 인원 수 확인
	public int count(String group_id);
	
	// 그룹원 수 확인
	public int countMember(String group_id);

	// 날짜 컬럼 수 확인
	public int countDate();
	
	// 모먼트 날짜 데이터 입력(추가)
	public int addDate(MomentDTO dto);
	
	// 장소 컬럼 수 확인
	public int countPlace();
	
	// 모먼트 장소 데이터 입력(추가)
	public int addPlace(MomentDTO dto);
	
	// 모먼트 데이터 입력(추가)
	public int addMoment(MomentDTO dto);

	// 모먼트 참여자 데이터 입력(추가)
	public int addMomentMember(MomentDTO dto);

	// 모먼트 일시/장소 데이터 입력(추가)
	public int addDatePlace(MomentDTO dto);
	
	// 모먼트 데이터 확인
	public MomentDTO search(String moment_id);
	
	// 모먼트 데이터 수정
	public int modify(MomentDTO dto);
	
	// 모먼트 데이터 삭제
	public int remove(String moment_id);
}
