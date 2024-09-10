/*============================
 	GalleryController.java
============================*/

package com.test.prj;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GalleryController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/gallery.action")
	public String MemberInsertForm(Model model, String moment_id, String group_id, HttpSession session)
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		model.addAttribute("galleryList", dao.galleryList(moment_id));
		model.addAttribute("galleryCount", dao.galleryList(moment_id).size());
		model.addAttribute("moment_id", moment_id);
		model.addAttribute("group_id", group_id);
		
		result = "/WEB-INF/view/Gallery.jsp";
		
		return result;
	}
	
	/*
	@RequestMapping("/memberidcount.action")
	public String memberIdCount(String my_id)
	{
		String result = null;
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		result = "/WEB-INF/view/MyIdCountAjax.jsp?count=" + dao.idCount(my_id);
		
		return result;
	}
	
	@RequestMapping("/membernamecount.action")
	public String memberNameInsert(String user_name)
	{
		String result = null;
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		result = "/WEB-INF/view/NameCountAjax.jsp?count=" + dao.nameCount(user_name);
		
		return result;
	}
	
	@RequestMapping(value = "/memberinsert.action", method = RequestMethod.POST)
	public String userInsert(MemberDTO dto)
	{
		String result = null;
		
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);

		int count = dao.userCount();
		
		String user_id = String.format("US0%s", count + 1);
		dto.setUser_id(user_id);
		dao.addUser(dto.getUser_id());
		
		dao.addUserInformation(dto);
		
		result = "redirect:main.action";
		
		return result;
	}
	*/
	
}
