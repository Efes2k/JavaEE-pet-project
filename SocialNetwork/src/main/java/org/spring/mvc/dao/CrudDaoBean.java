package org.spring.mvc.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Transactional
public class CrudDaoBean implements CrudDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	public CrudDaoBean() {
	}

	@SuppressWarnings("unchecked")
	public <T> T merge(T t) throws DalException {
		try {
			return (T) currentSession().merge(t);
		} catch (HibernateException e) {
			throw new DalException(e);
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public <T> T save(T o) throws DalException {
		try {
			return (T) currentSession().save(o);
		} catch (HibernateException e) {
			throw new DalException();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public <T, PK extends Serializable> T find(Class<T> type, PK id)
			throws DalException {
		try {			
			return (T) currentSession().get(type, id);
		} catch (HibernateException e) {
			throw new DalException(e);
		}
	}
	

	public <T, PK extends Serializable> void delete(Class<T> type, PK id) throws DalException {
		try {
			Session currentSession = currentSession();
			Object object = currentSession.get(type, id);
			currentSession.delete(object);
			currentSession.flush();							
		} catch (HibernateException e) {
			throw new DalException(e);
		}
	}
	

	@SuppressWarnings({ "unchecked" })
	public <T> List<T> list(Class<T> type) throws DalException {
		try {
			return currentSession().createCriteria(type).list();			
		} catch (HibernateException e) {
			throw new DalException(e);
		}
	}

	
	@Override
	public <T> void saveOrUpdate(T o) throws DalException {
		try {
			 currentSession().saveOrUpdate(o);
		} catch (HibernateException e) {
			throw new DalException();
		}
	}
	

	
	private Session currentSession() {
		Session currentSession = sessionFactory.getCurrentSession();		
		return currentSession;
	}
	
}