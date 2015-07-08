package org.spring.mvc.entity.location;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.spring.mvc.entity.Model;
import org.spring.mvc.entity.User;

@Entity
@Table(name="city")
@JsonIgnoreProperties({ "countryIn"})
public class City extends Model implements Serializable {

	private static final long serialVersionUID = 8873977608833214477L;

	@Column(name="city_name")
	private String cityName;

	@ManyToOne
	@JoinColumn(name = "country_id")
	private Country countryIn;
	
	@OneToMany(mappedBy = "city")
	private List<User> users;
	
	public City() {
		super();
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public Country getCountryIn() {
		return countryIn;
	}

	public void setCountryIn(Country countryIn) {
		this.countryIn = countryIn;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result	+ ((cityName == null) ? 0 : cityName.hashCode());
		result = prime * result	+ ((countryIn == null) ? 0 : countryIn.hashCode());
		return result;
	}

	@Override
	public String toString() {
		return cityName + ", " + countryIn;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (getClass() != obj.getClass())
			return false;
		if (!super.equals(obj))
			return false;
		City other = (City) obj;
		if (cityName == null) {
			if (other.cityName != null)
				return false;
		} else if (!cityName.equals(other.cityName))
			return false;
		if (countryIn == null) {
			if (other.countryIn != null)
				return false;
		} else if (!countryIn.equals(other.countryIn))
			return false;
		return true;
	}
	
	
}
