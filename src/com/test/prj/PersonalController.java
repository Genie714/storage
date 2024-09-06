package com.test.prj;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PersonalController
{
	@RequestMapping(value="personal.action", method = RequestMethod.GET )
	public String PersonalLoad()
	{
		String result = "";
		
		result = "/WEB-INF/view/Personal.jsp";
		
		return result;
	}
}
