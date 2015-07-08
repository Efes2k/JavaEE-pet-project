package org.spring.mvc.entity.message;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.spring.mvc.entity.Model;
import org.spring.mvc.entity.User;

@Entity
@Table(name="message")
public class Message extends Model implements Serializable {

	private static final long serialVersionUID = 984883387311559756L;

	public Message(){
		date = new Date();
	}
	
	@Column(name="message",nullable = false, length = 200)
	private String text;
	
	@Column(name="type", nullable = false, length = 20)
	private String type;
	
	@Column(name="date",nullable = false)
	private Date date;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User owner;

	@ManyToOne
	@JoinColumn(name = "message_media_id")
	@Cascade({ CascadeType.SAVE_UPDATE, CascadeType.DELETE })
	private MessageMedia messMedia;
	
	@ManyToOne
	@JoinColumn(name = "where_id")
	private User where;
	
	
	@OneToMany(mappedBy = "messageWhere", orphanRemoval=true)
	@Cascade({ CascadeType.SAVE_UPDATE, CascadeType.DELETE })
	private List<Comment> comments;
	

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public User getWhere() {
		return where;
	}

	public void setWhere(User where) {
		this.where = where;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public MessageMedia getMessMedia() {
		return messMedia;
	}

	public void setMessMedia(MessageMedia messMedia) {
		this.messMedia = messMedia;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result	+ ((messMedia == null) ? 0 : messMedia.hashCode());
		result = prime * result + ((owner == null) ? 0 : owner.hashCode());
		result = prime * result + ((text == null) ? 0 : text.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		result = prime * result + ((where == null) ? 0 : where.hashCode());
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
		Message other = (Message) obj;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (messMedia == null) {
			if (other.messMedia != null)
				return false;
		} else if (!messMedia.equals(other.messMedia))
			return false;
		if (owner == null) {
			if (other.owner != null)
				return false;
		} else if (!owner.equals(other.owner))
			return false;
		if (text == null) {
			if (other.text != null)
				return false;
		} else if (!text.equals(other.text))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		if (where == null) {
			if (other.where != null)
				return false;
		} else if (!where.equals(other.where))
			return false;
		return true;
	}
	
	
}
