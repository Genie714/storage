package com.test.prj;

import java.util.ArrayList;

public interface IComplaintDAO
{
	// 신고 사유 리스트 불러오기
	public ArrayList<CPReasonDTO> reasonList();
	
	// 신고 접수 처리
	public int complaintInsert(ComplaintDTO complaint);
}
