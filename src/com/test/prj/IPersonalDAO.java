package com.test.prj;

import java.util.ArrayList;

public interface IPersonalDAO
{
	public MemberDTO findInfo(String user_id);
	
	public ArrayList<GroupDTO> findGroup(String user_id);
	
	public ArrayList<MomentDTO> findMoment(String user_id);
}
