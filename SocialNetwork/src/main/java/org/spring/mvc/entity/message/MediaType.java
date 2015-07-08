package org.spring.mvc.entity.message;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class MediaType implements Serializable {

	private static final long serialVersionUID = -6786694201480181428L;
	private static MediaType instance;
	private  List<String> typeList;
	
	private MediaType (){
		typeList = new ArrayList<String>();
		typeList.add("image/jpeg");
		typeList.add("image/gif");
		typeList.add("image/png");
		typeList.add("audio/mpeg");
		typeList.add("audio/mp3");
		
	}
	
	public static MediaType getInstance() {
		if(instance == null) instance = new MediaType();
		
		return instance;
	}

	public List<String> getTypeList() {
		return typeList;
	}
	

}
