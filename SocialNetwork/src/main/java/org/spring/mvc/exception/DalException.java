package org.spring.mvc.exception;

public class DalException extends Exception {
	
	private static final long serialVersionUID = 6153465871039740957L;

	public DalException() {
		super();
	}

	public DalException(String message, Throwable cause) {
		super(message, cause);
	}

	public DalException(Throwable cause) {
		super(cause);
	}

	
}
