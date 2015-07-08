package org.spring.mvc.entity.message;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.spring.mvc.entity.Model;
import org.spring.mvc.entity.User;

@Entity()
@Table(name="comment")
@JsonIgnoreProperties({ "messageWhere"})
public class Comment extends Model implements Serializable {

	private static final long serialVersionUID = -4231281762997585246L;

	@Column(name = "text",nullable = false, length = 200)
	private String text;
	
	@Column(name = "date",nullable = false)
	private Date date;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User author;

	@ManyToOne
	@JoinColumn(name = "whereMess_id")
	private Message messageWhere;

	
	public Comment() {
		super();
		date = new Date();
	}
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public Message getMessageWhere() {
		return messageWhere;
	}

	public void setMessageWhere(Message messageWhere) {
		this.messageWhere = messageWhere;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + ((text == null) ? 0 : text.hashCode());
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
		Comment other = (Comment) obj;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (text == null) {
			if (other.text != null)
				return false;
		} else if (!text.equals(other.text))
			return false;
		return true;
	}
	
	
}
