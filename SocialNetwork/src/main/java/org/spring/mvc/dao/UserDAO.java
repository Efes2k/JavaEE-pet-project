package org.spring.mvc.dao;

import java.util.List;

import org.spring.mvc.entity.User;
import org.spring.mvc.entity.message.Comment;
import org.spring.mvc.entity.message.Message;
import org.spring.mvc.exception.DalException;

public interface UserDAO extends CrudDao {

	User findByName(String username) throws DalException;
	
	List<Message> getUserMessages(String field,int id) throws DalException;

	void changeAvatar(User user) throws DalException;
	
	void deleteFriend(Integer id) throws DalException;
	
	void deleteMessage(Integer id) throws DalException;
	
	void deleteUser(Integer id) throws DalException;
	
	public void changeStatus(String field, boolean changes,int id)throws DalException;

	List<User> searchCr(String searchString) throws DalException;

	List<Comment> getComments(int id) throws DalException;
	
	void changeField(String field, String changes, int id);
	
}
