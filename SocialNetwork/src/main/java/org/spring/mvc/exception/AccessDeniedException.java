package org.spring.mvc.exception;


public class AccessDeniedException extends Exception {

	private static final long serialVersionUID = 5699198879002003036L;

	public AccessDeniedException() {
		super();
	}

	public AccessDeniedException(String message) {
		super(message);
	}
	
	public AccessDeniedException(String message, Throwable cause) {
		super(message, cause);
	}

	public AccessDeniedException(Throwable cause) {
		super(cause);
	}

}
