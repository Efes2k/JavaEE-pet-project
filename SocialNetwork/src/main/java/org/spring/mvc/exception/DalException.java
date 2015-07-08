package org.spring.mvc.exception;

/**
 * DAL layour exception
 * 
 */
public class DalException extends Exception {
	private static final long serialVersionUID = 6153465871039740957L;

	/**
	 * {@inheritDoc}
	 */
	public DalException() {
		super();
	}

	/**
	 * {@inheritDoc}
	 */
	public DalException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * {@inheritDoc}
	 */
	public DalException(Throwable cause) {
		super(cause);
	}

}
