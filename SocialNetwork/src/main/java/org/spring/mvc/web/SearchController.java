package org.spring.mvc.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.spring.mvc.dao.UserDAO;
import org.spring.mvc.entity.User;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value="/list" , method=RequestMethod.GET)
public class SearchController {
	
	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(value="{username}/buttonSearch")
	public String buttonSerch(Model model,@RequestParam(value = "mess", required = false) String mess) throws DalException{
		if(mess != null) model.addAttribute("searchList",userDao.searchCr(mess));
		return "search";
	}
	
	@RequestMapping(value="{username}/buttonSearchAjax")
	public @ResponseBody List<User> buttonSerchAjax(@RequestParam String mess,HttpServletRequest request) throws DalException{
		return userDao.searchCr(request.getParameter("mess"));
	}
	
	@RequestMapping(value = "{username}/getTags")
	public @ResponseBody List<User> getTags(@RequestParam String tagName) throws DalException {
		return userDao.searchCr(tagName);
	}
	
	@RequestMapping(value = "/getTags")
	public @ResponseBody List<User> getTags2(@RequestParam String tagName) throws DalException {
		return userDao.searchCr(tagName);
	}
	
	
	
}
