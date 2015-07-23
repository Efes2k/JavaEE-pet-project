package org.spring.mvc.web;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(method = RequestMethod.GET)
public class LoginController {
	private final String ERROR_MESSAGE = "Incorrect login/password";
	
	@RequestMapping(value = "/")
	public String home() {
		return "login";
	}
	
	@RequestMapping(value = "/signin")
    public String login() {
        return "login";
    }
 
    @RequestMapping(value = "/signin-failure")
    public String loginerror(ModelMap model,Principal user) {
        model.addAttribute("error", ERROR_MESSAGE);
        return "login";
    }
 
    @RequestMapping(value = "/logout")
    public String logout() {
        return "login";
    }
	
}