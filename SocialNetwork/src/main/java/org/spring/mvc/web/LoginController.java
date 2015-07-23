package org.spring.mvc.web;

import java.security.Principal;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(method = RequestMethod.GET)
public class LoginController {
	private final String ERROR_MESSAGE = "Incorrect login/password";
	
	private static final Logger logger = Logger.getLogger(LoginController.class);

	
	@RequestMapping(value = "/")
	public String home() {
		logger.info("Authorization succes");
		return "login";
	}
	
	@RequestMapping(value = "/signin")
    public String login() {
        return "login";
    }
 
    @RequestMapping(value = "/signin-failure")
    public String loginerror(ModelMap model,Principal user) {
        model.addAttribute("error", ERROR_MESSAGE);
        logger.info("Authorization failure");
        return "login";
    }
 
    @RequestMapping(value = "/logout")
    public String logout() {
    	logger.info("Logout success.");
        return "login";
    }
	
}