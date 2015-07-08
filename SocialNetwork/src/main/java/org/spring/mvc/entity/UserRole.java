package org.spring.mvc.entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="role")
public class UserRole extends Model implements Serializable{
	
	private static final long serialVersionUID = 1711019956176897243L;

	@OneToMany(mappedBy="userRoles")
	private List<User> users;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "title")
	private ListRole listRole;
	
	public UserRole(){
		super();
	}
	
	public UserRole(int id){
		super(id);
		
	}

	public ListRole getListRole() {
		return listRole;
	}

	public void setListRole(ListRole listRole) {
		this.listRole = listRole;
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
		result = prime * result
				+ ((listRole == null) ? 0 : listRole.hashCode());
		result = prime * result + ((users == null) ? 0 : users.hashCode());
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
		UserRole other = (UserRole) obj;
		if (listRole != other.listRole)
			return false;
		if (users == null) {
			if (other.users != null)
				return false;
		} else if (!users.equals(other.users))
			return false;
		return true;
	}


	
}
