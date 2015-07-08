package org.spring.mvc.service;

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
public class UserManager  implements UserDetailsService {
	
	@Autowired
	private UserDAO userDao;
	
	public UserManager(){
		
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		User result = null;
		try {
			result = (User)userDao.findByName(username);
		
		} catch (DalException e) {
			e.printStackTrace();
		}
		
		
		
		if(result == null) {
			System.out.println("user not found");
			throw new AuthenticationServiceException("Incorrect login/password");
		}
		System.out.println(result.getPassword());

		if(result.isAccountNonLocked() == false) {
			throw new AuthenticationServiceException ("Your account has been suspended. Contact with administrator.");
		}
	
		return result;
	}
	
	

}
