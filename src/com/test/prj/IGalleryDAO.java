/*====================
	IGalleryDAO.java
	- 인터페이스
====================*/

package com.test.prj;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface IGalleryDAO
{
	// 갤러리 페이지의 작성글 가져오기
	public ArrayList<GalleryDTO> galleryList(@Param("moment_id") String moment_id);
	
}
