package org.spring.mvc.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.spring.mvc.dao.LocationDao;
import org.spring.mvc.dao.UserDAO;
import org.spring.mvc.entity.User;
import org.spring.mvc.entity.UserRole;
import org.spring.mvc.entity.location.City;
import org.spring.mvc.entity.location.Country;
import org.spring.mvc.exception.DalException;
import org.spring.mvc.service.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RegistrationController {
	
	private final String SUCCESS_MESSAGE = "Registration succes";
	private final String ERROR_MESSAGE = "User with current username already exist";
	private static final Logger logger = Logger.getLogger(RegistrationController.class);

	
	@Autowired
	private UserDAO userDao  ;
	
	@Autowired
	private PasswordHelper ph;
	
	@Autowired
	private LocationDao locDao  ;

	@ModelAttribute("user")
	public User populateUser() {
		return new User();
	}

	@RequestMapping(value = "/register")
	public String regJsp(Model model) throws DalException {
		model.addAttribute("countryList",userDao.list(Country.class));
		return "register";
	}

	@RequestMapping(value = "/contactList")
	public String contactList(Model model) throws DalException {
		model.addAttribute("contactList", userDao.list(User.class));
		return "contactList";
	}
	 
	
	@RequestMapping(value = "/add")
	public String loginJsp(@Valid@ModelAttribute User user, BindingResult result,Model model,@RequestParam Integer cityId) {
		try {
			model.addAttribute("countryList",userDao.list(Country.class));
			if (result.hasErrors()) return "register";
			
			if(userDao.findByName(user.getUsername()) != null ){
				model.addAttribute("error", ERROR_MESSAGE);
				return "register";
				}
			
			model.addAttribute("success", SUCCESS_MESSAGE);
			user.setCity(userDao.find(City.class,cityId));
			UserRole ur = userDao.find(UserRole.class, 2);
			user.setUserRoles(ur);
			user.setAccountNonLocked(true);
			user.setPassword(ph.encode(user.getPassword()));
			userDao.save(user);
		} catch (DalException e) {
			logger.warn("Registration failure: " + e.getMessage() );
			return "register";
		}
		logger.info("Registration success: " + user.getUsername());
		return "login";
	}
	
	
	@RequestMapping(value="/register/getCities", method= RequestMethod.GET,consumes="text/plain" )
	public @ResponseBody List<City> getCities(HttpServletRequest request) throws DalException{
		return locDao.getCitues(Integer.parseInt(request.getParameter("countryId")));
	}

	
}