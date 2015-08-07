package org.spring.mvc.entity;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Business object representing a friends.
 *
 * @author Andrei Bykov
 */
@Entity
@Table(name = "my_friends")
public class MyFriends extends Model implements Serializable {

	private static final long serialVersionUID = -1249180944994329007L;

	@ManyToOne
	@JoinColumn(name = "me_id")
	private User me;

	@ManyToOne
	@JoinColumn(name = "friend_id")
	private User myFriend;

	public MyFriends() {
		super();
		MyFriends.class.getSimpleName();
	}

	public MyFriends(User me, User myFriend) {
		super();
		this.me = me;
		this.myFriend = myFriend;
	}

	public User getMe() {
		return me;
	}

	public void setMe(User me) {
		this.me = me;
	}

	public User getMyFriend() {
		return myFriend;
	}

	public void setMyFriend(User myFriend) {
		this.myFriend = myFriend;
	}

}
