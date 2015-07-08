package org.spring.mvc.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.inject.Named;

import org.apache.log4j.Logger;
import org.spring.mvc.web.LoginController;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Named
public class PasswordHelper implements PasswordEncoder{

	private MessageDigest md;
	private static final Logger logger = Logger.getLogger(LoginController.class);
	
	 public PasswordHelper() {
		 try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			logger.warn("No algorithm exception" + e.getMessage());
			e.printStackTrace();
		}
	}
	
	@Override
	public String encode(CharSequence rawPassword) {
		if(md == null) {
			logger.info(md  == null);
			return rawPassword.toString();
		}
		
		md.update(rawPassword.toString().getBytes());
		byte byteData[] = md.digest();
		
		StringBuffer hexString = new StringBuffer();
		for(int i = 0 ; i < byteData.length; i++){
			String hex = Integer.toHexString(0xff & byteData[i]);
			if(hex.length() == 1) hexString.append('0');
			hexString.append(hex);
		}
		
		return hexString.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodePassword) {
		
		return encode(rawPassword).equals(encodePassword);
	}
	
	
}
