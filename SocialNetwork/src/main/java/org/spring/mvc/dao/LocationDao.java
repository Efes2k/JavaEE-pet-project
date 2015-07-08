package org.spring.mvc.dao;

import java.util.List;

import org.spring.mvc.entity.location.City;
import org.spring.mvc.exception.DalException;

public interface LocationDao {
	
	List<City> getCitues(int id) throws DalException;
	
}
