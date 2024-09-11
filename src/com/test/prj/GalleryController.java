/*============================
 	GalleryController.java
============================*/

package com.test.prj;

import java.io.File;
import java.io.IOException;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class GalleryController
{
	@Autowired
	private SqlSession sqlSession;
	
	String PATH = "C:\\Final\\FinalProjectApp\\WebContent\\images\\img\\gallery";

	@RequestMapping("/gallery.action")
	public String GalleryList(Model model, String moment_id, String group_id, String countJoin, HttpSession session)
	{
		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String moment_name = "";
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		GalleryDTO dto = dao.getMomentName(moment_id);
		moment_name = dto.getMoment_name();
		
		model.addAttribute("momentName", moment_name);
		model.addAttribute("galleryList", dao.galleryList(moment_id));
		model.addAttribute("galleryCount", dao.galleryList(moment_id).size());
		model.addAttribute("countJoin", countJoin);
		model.addAttribute("moment_id", moment_id);
		model.addAttribute("group_id", group_id);

		result = "/WEB-INF/view/Gallery.jsp";

		return result;
	}

	@RequestMapping("/galleryinsertform.action")
	public String GalleryInsertForm(Model model, String moment_id, String group_id, HttpSession session)
	{

		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String member_id = "";
		String participant_id = "";
		String moment_name = "";
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		GalleryDTO dto = dao.getMomentName(moment_id);
		moment_name = dto.getMoment_name();
		
		member_id = dao.searchMemberId(user_id, group_id);
		participant_id = dao.getPartiId(member_id, moment_id);
		
		model.addAttribute("momentName", moment_name);
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
		model.addAttribute("moment_id", moment_id);
		model.addAttribute("group_id", group_id);

		result = "/WEB-INF/view/GalleryInsertForm.jsp";

		return result;
	}

	
	@RequestMapping(value = "/galleryinsert.action", method = RequestMethod.POST)
	public String GalleryInsert(Model model, HttpServletRequest request, HttpSession session) throws IOException
	{
		String result = null;
		String user_id = (String)session.getAttribute("user_id");
		
		String moment_id = "";
		String group_id = "";
		String member_id = "";
		String participant_id = "";
		String root = "";
		String countJoin = "";
		
		int countFile = 0;
		
		MultipartRequest multi = new MultipartRequest(request, PATH, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		
		String countFileStr = multi.getParameter("countFile");
		countFile = Integer.parseInt(countFileStr);
		
		String[] file_realname = new String[countFile];
		String[] file_settingname = new String[countFile];
		
		moment_id = multi.getParameter("moment_id");
		group_id = multi.getParameter("group_id");
		countJoin = multi.getParameter("countJoin");
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		for (int i = 0; i < countFile; i++)
		{
			file_realname[i] = multi.getOriginalFileName("file" + (i + 1));
			file_settingname[i] = multi.getFilesystemName("file" + (i + 1));
			
			if (file_settingname[i] != null)
	        {
	            File f = new File(PATH);
	            
	            if (!f.exists())
	               f.mkdir();
	            
	            File file = new File(f, file_settingname[i]);
	            
	            if (!file.exists())
	            file.createNewFile();
	            
	            root = file.getAbsolutePath().replace("C:\\Final\\FinalProjectApp\\WebContent", "");
	            root = root.replace(file_settingname[i], "");
	            
	            member_id = dao.searchMemberId(user_id, group_id);
	            participant_id = dao.getPartiId(member_id, moment_id);
	            
	            dao.addGallery(moment_id, participant_id, file_realname[i], file_settingname[i], root);		
	         }
		}
		
			
		result = "redirect:gallery.action?group_id=" + group_id + "&moment_id=" + moment_id + "&countJoin=" + countJoin;
		
		return result;
	}

	@RequestMapping("/gallerypage.action")
	public String GalleryPage(Model model, String group_id, String gallery_id, String moment_id, HttpSession session) throws ParseException
	{
		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String member_id = "";
		String participant_id = "";
		String uploade_date = "";
		String sysdate = "";
		String moment_name = "";
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		GalleryDTO dto = dao.getMomentName(moment_id);
		moment_name = dto.getMoment_name();
		
		member_id = dao.searchMemberId(user_id, group_id);
		participant_id = dao.getPartiId(member_id, moment_id);
		
		GalleryDTO myGalleryList = dao.myGalleryList(gallery_id);
		ArrayList<GalleryDTO> commentList = dao.galleryCommentList(gallery_id, member_id);
		
		int count = dao.countMyPicture(gallery_id, participant_id);
		
		if (count > 0)
		{
			uploade_date = dao.PictureDeleteOk(gallery_id, participant_id);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			sysdate = dateFormat.format(new java.util.Date());
			
			java.util.Date d1 = dateFormat.parse(uploade_date);
			java.util.Date d2 = dateFormat.parse(sysdate);
			long time = (d2.getTime() - d1.getTime()) / 1000;
			
			if (time < 600)
				model.addAttribute("deleteOk", 1);
			
		}

		model.addAttribute("momentName", moment_name);
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
		model.addAttribute("myGalleryList", myGalleryList);
		model.addAttribute("commentList", commentList);
		model.addAttribute("countComment", dao.countComment(gallery_id));
		model.addAttribute("group_id", group_id);

		result = "/WEB-INF/view/GalleryPage.jsp";

		return result;
	}

	@RequestMapping("/gallerycommentinsert.action")
	public String GalleryCommentInsert(Model model, String group_id, String gallery_id, String moment_id
									 , String contents, HttpSession session)
	{
		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String member_id = "";

		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		member_id = dao.searchMemberId(user_id, group_id);
		dao.addGalleryComment(gallery_id, member_id, contents);
		
		model.addAttribute("countJoin", dao.momentJoinCount(user_id, moment_id));
		
		result = "redirect:gallerypage.action?group_id=" + group_id + "&gallery_id=" + gallery_id
					+ "&moment_id=" + moment_id;

		return result;
	}
	
	@RequestMapping("/galleryremove.action")
	public String GalleryRemove(Model model, String group_id, String gallery_id, String moment_id, HttpSession session)
	{
		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String countJoin = "";
		String file_settingname = "";
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		
		// ① 실제 파일 삭제
		GalleryDTO dto = dao.getSettingFileName(gallery_id);
		file_settingname = dto.getFile_settingname();
		
		if (file_settingname != null)
		{
			File file = new File(PATH + file_settingname);
			if (file.exists())
				file.delete();
			
			// ② 해당 갤러리 댓글 다 삭제
			dao.removeGalleryCommentAll(gallery_id);
			
			// ③ DB 데이터 삭제
			dao.removeGallery(gallery_id);
		}
		
		countJoin = String.valueOf(dao.momentJoinCount(user_id, moment_id));
		
		result = "redirect:gallery.action?group_id=" + group_id + "&moment_id=" + moment_id
				 + "&countJoin=" + countJoin;
		
		return result;
	}
	
	@RequestMapping("/gallerycommentremove.action")
	public String GalleryCommentRemove(Model model, String group_id, String gallery_id, String comment_id
									   , String moment_id, HttpSession session)
	{
		String result = null;
		String user_id = (String) session.getAttribute("user_id");
		String countJoin = "";
		
		IGalleryDAO dao = sqlSession.getMapper(IGalleryDAO.class);
		
		dao.removeGalleryComment(comment_id);
		
		countJoin = String.valueOf(dao.momentJoinCount(user_id, moment_id));
		
		result = "redirect:gallerypage.action?group_id=" + group_id + "&gallery_id=" + gallery_id
				+ "&moment_id=" + moment_id;
		
		return result;
	}


}
