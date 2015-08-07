package org.spring.mvc.entity.message;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.spring.mvc.entity.Model;


/**
 * Simple business object representing a messages medias, like photo/audio/video.
 *
 * @author Andrei Bykov
 */
@Entity()
@Table(name="message_media")
public class MessageMedia extends Model implements Serializable {

	private static final long serialVersionUID = -2548812752627741924L;

	@Column(name = "media")
	private byte[] media;
	
	@Column(name= "type")
	private String type;
	
	@Column(name= "file_name",nullable = true, length = 50)
	private String fileName;
	
	@OneToMany(mappedBy = "messMedia", orphanRemoval=true)
	private List<Message> message;
	
	public MessageMedia() {
		super();
	}
	
	public MessageMedia(byte[] media, String type,String fileName) {
		super();
		this.media = media;
		this.type = type;
		this.fileName = fileName;
	}
	
	public byte[] getMedia() {
		return media;
	}

	public void setMedia(byte[] media) {
		this.media = media;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}

	public List<Message> getMessage() {
		return message;
	}

	public void setMessage(List<Message> message) {
		this.message = message;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result	+ ((fileName == null) ? 0 : fileName.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		MessageMedia other = (MessageMedia) obj;
		if (fileName == null) {
			if (other.fileName != null)
				return false;
		} else if (!fileName.equals(other.fileName))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	
}
