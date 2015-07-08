package org.spring.mvc.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.spring.mvc.entity.location.City;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class LocationDaoImpl implements LocationDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	public LocationDaoImpl() {
	}


	@Override
	@SuppressWarnings(value="unchecked")
	@Transactional
	public List<City> getCitues(int id) throws DalException {
		Query query = currentSession().createQuery("from City where country_id = :country_id");
		query.setParameter("country_id", id);
		List<City> listCity = query.list();
		return listCity;
	}
	
	
	private Session currentSession() {
		Session currentSession = sessionFactory.getCurrentSession();		
		return currentSession;
	}

}
