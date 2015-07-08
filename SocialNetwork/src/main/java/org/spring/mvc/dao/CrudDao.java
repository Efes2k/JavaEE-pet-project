package org.spring.mvc.dao;

import java.io.Serializable;
import java.util.List;

import org.spring.mvc.exception.DalException;

/**
 * CRUD interface
 * 
 * @author efes2k
 */
public interface CrudDao {

	<T> T merge(T t) throws DalException;

	<T, PK extends Serializable> void delete(Class<T> type, PK id)	throws DalException;

	<T, PK extends Serializable> T find(Class<T> type, PK id)	throws DalException;

	<T> List<T> list(Class<T> type) throws DalException;
	
	<T> T save(T o) throws DalException;

	<T> void saveOrUpdate(T o) throws DalException;
	
	
}
