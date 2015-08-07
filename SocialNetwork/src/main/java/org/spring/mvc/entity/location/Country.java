package org.spring.mvc.entity.location;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.spring.mvc.entity.Model;

/**
 * Simple business object representing a country.
 *
 * @author Andrei Bykov
 */
@Entity
@Table(name="country")
public class Country extends Model implements Serializable{
	
	private static final long serialVersionUID = 5179370174432281796L;

	@Column(name="country_name")
	private String countryName;

	@OneToMany(mappedBy = "countryIn")
	@JsonBackReference
	private List<City> cities;

	public Country() {
		super();
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public List<City> getCities() {
		return cities;
	}

	public void setCities(List<City> cities) {
		this.cities = cities;
	}

	@Override
	public String toString() {
		return countryName ;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result	+ ((countryName == null) ? 0 : countryName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		Country other = (Country) obj;
		if (countryName == null) {
			if (other.countryName != null)
				return false;
		} else if (!countryName.equals(other.countryName))
			return false;
		return true;
	}
	
	
	
}
