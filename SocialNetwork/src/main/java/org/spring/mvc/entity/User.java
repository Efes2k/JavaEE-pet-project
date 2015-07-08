package org.spring.mvc.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.spring.mvc.entity.location.City;
import org.spring.mvc.entity.message.Message;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "user")
@JsonIgnoreProperties({ "owner", "where", "messagesWhere","userRoles","avatar","city","screenImage","myFriends","messages"})
public class User extends Model implements UserDetails,Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "username",nullable = false, length = 100)
	@Pattern(regexp = "^[a-z0-9_-]{3,15}$", message = "username should be more than 3 characters long")
	private String username;

	@Column(name = "password",nullable = false, length = 100)
	@Pattern(regexp = "^[a-z0-9_-]{3,50}$", message = "password should be more than 3 characters long")
	private String password;

	@Column(name = "email",nullable = false, length = 100)
	@Pattern(regexp = ".+@.+\\.[a-z]+", message = "not well-formed e-mail")
	private String email;

	@Column(name = "firstName",nullable = false, length = 100)
	@Pattern(regexp = "[A-Za-z]{3,}", message = "incorrect firstname")
	private String firstName;

	@Column(name = "lastName",nullable = false, length = 100)
	@Pattern(regexp = "[A-Za-z]{3,}", message = "incorrect lastname")
	private String lastName;

	@Column(name = "phoneNumber",nullable = false, length = 100)
	@Pattern(regexp = "[\\d]{7,10}", message = "not well-formed phone number")
	private String phoneNumber;

	@Column(name = "dateOfBirth",nullable = false)
	private Date dateOfBirth;
	
	@ManyToOne
	@JoinColumn(name = "city_id")
	private City city;

	@OneToMany(mappedBy = "owner")
	@Cascade({CascadeType.SAVE_UPDATE, CascadeType.DELETE})  
	private List<Message> messages;

	@OneToMany(mappedBy = "where")
	@Cascade({CascadeType.SAVE_UPDATE, CascadeType.DELETE})  
	private List<Message> messagesWhere;

	@ManyToOne
	@JoinColumn(name = "role_id")
	private UserRole userRoles;

	@Column(name = "avatar",nullable = true)
	private byte[] avatar;

	
	@OneToMany(targetEntity = MyFriends.class, mappedBy = "me",fetch = FetchType.EAGER, orphanRemoval = true)
	@Cascade({CascadeType.SAVE_UPDATE, CascadeType.DELETE, CascadeType.REMOVE })  
	private List<MyFriends> myFriends;
	
	@Column(name = "accountNonLocked",nullable = false)
	private boolean accountNonLocked;
	

	public User() {
		super();
	}

	public User(int id) {
		super(id);
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}



	public List<MyFriends> getMyFriends() {
		return myFriends;
	}

	public void setMyFriends(List<MyFriends> myFriends) {
		this.myFriends = myFriends;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}



	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public byte[] getAvatar() {
		return avatar;
	}

	public void setAvatar(byte[] avatar) {
		this.avatar = avatar;
	}

	public List<Message> getMessagesWhere() {
		return messagesWhere;
	}

	public void setMessagesWhere(List<Message> messagesWhere) {
		this.messagesWhere = messagesWhere;
	}
	

	public UserRole getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(UserRole userRoles) {
		this.userRoles = userRoles;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<SimpleGrantedAuthority> result = new ArrayList<SimpleGrantedAuthority>();
			result.add(new SimpleGrantedAuthority(userRoles.getListRole().name()));
		return result;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	
	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return accountNonLocked;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}



	@Override
	public String toString() {
		return "User [username=" + username + ", firstName=" + firstName
				+ ", lastName=" + lastName + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result + ((dateOfBirth == null) ? 0 : dateOfBirth.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result	+ ((firstName == null) ? 0 : firstName.hashCode());
		result = prime * result	+ ((lastName == null) ? 0 : lastName.hashCode());
		result = prime * result	+ ((password == null) ? 0 : password.hashCode());
		result = prime * result	+ ((phoneNumber == null) ? 0 : phoneNumber.hashCode());
		result = prime * result	+ ((username == null) ? 0 : username.hashCode());
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
		User other = (User) obj;
			if (city == null) {
			if (other.city != null)
				return false;
		} else if (!city.equals(other.city))
			return false;
		if (dateOfBirth == null) {
			if (other.dateOfBirth != null)
				return false;
		} else if (!dateOfBirth.equals(other.dateOfBirth))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (firstName == null) {
			if (other.firstName != null)
				return false;
		} else if (!firstName.equals(other.firstName))
			return false;
		if (lastName == null) {
			if (other.lastName != null)
				return false;
		} else if (!lastName.equals(other.lastName))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (phoneNumber == null) {
			if (other.phoneNumber != null)
				return false;
		} else if (!phoneNumber.equals(other.phoneNumber))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}

}
