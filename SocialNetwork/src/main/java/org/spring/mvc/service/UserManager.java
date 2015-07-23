package org.spring.mvc.service;

import org.apache.log4j.Logger;
import org.spring.mvc.dao.UserDAO;
import org.spring.mvc.entity.User;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserManager implements UserDetailsService {
	
	@Autowired
	private UserDAO userDao;
	
	private static final Logger logger = Logger.getLogger(UserManager.class);

	
	public UserManager(){
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User result = null;
		
		try {
			result = (User)userDao.findByName(username);
		
		} catch (DalException e) {
			e.printStackTrace();
		}
		
		if(result == null) {
			logger.info("User " + username + " - incorrect login/password");
			throw new AuthenticationServiceException("Incorrect login/password");
		}

		if(result.isAccountNonLocked() == false) {
			logger.info("User " + username + " account has been suspended.");
			throw new AuthenticationServiceException ("Your account has been suspended. Contact with administrator.");
		}
		return result;
	}
	
	
}
