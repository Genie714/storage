/*
 * LoginController.java
 * 로그인 관련 컨트롤러
 * 1. 로그인 처리 O
 * 2. 로그아웃 처리 o
 * 3. 회원가입 처리
 * 4. 아이디 비밀번호 찾기 처리
 */
package com.test.prj;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController
{
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "loginform.action", method = RequestMethod.GET)
	public String loginForm()
	{
		String result = "/WEB-INF/view/LoginForm.jsp";

		return result;
	}

	@RequestMapping(value = "login.action", method = RequestMethod.POST)
	public String login(MemberDTO member, String admin, HttpSession session)
	{
		String result = "";
		String user_id = null;
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		MemberDTO resultMember;
		try
		{
			// 로그인 처리 → 대상에 따른 로그인 처리 방식 분기
			if (admin == null)
			{
				// 일반 사원 로그인
				resultMember = dao.login(member);
				if (resultMember != null)
				{
					user_id = resultMember.getUser_id();					
				}
			} else
			{
				// 관리자 로그인
				// 추후 처리
			}

			// 로그인 성공 여부에 따른 분기
			if (user_id == null)
			{
				// 로그인 실패 → 로그인 폼을 다시 요청할 수 있도록 안내
				return "redirect:loginform.action";
			} 
			else
			{
				// 로그인 성공 → 세션 구성
				session.setAttribute("user_id", user_id);
				result = "/WEB-INF/view/Main.jsp";
			}

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return result;
	}
	
	@RequestMapping(value = "logout.action", method = RequestMethod.GET)
	public String logout(HttpSession session)
	{
		session.removeAttribute("user_id");
		String result = "redirect:main.action";
		return result;
	}
}
