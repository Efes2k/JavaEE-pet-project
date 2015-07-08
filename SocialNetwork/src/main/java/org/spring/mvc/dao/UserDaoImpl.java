package org.spring.mvc.dao;


import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.spring.mvc.entity.User;
import org.spring.mvc.entity.message.Comment;
import org.spring.mvc.entity.message.Message;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class UserDaoImpl extends CrudDaoBean implements UserDAO  {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public UserDaoImpl() {
		
	}

	@Override
	@Transactional
	public User findByName(String username) throws DalException {
		Query query = currentSession().createQuery("from User where username = :username");
		query.setParameter("username", username);
		User user = (User)query.uniqueResult();
		if(user != null) return user;
		return null;
		
	}
	
	@Override
	@SuppressWarnings(value="unchecked")
	@Transactional
	public List<Message> getUserMessages(String field,int id) throws DalException {
		Query query = currentSession().createQuery("from Message where " +  field +" = :where_id");
		query.setParameter("where_id", id);
		List<Message> listMess = query.list();
		Collections.reverse(listMess);
		return listMess;
	}
	
	@Override
	@SuppressWarnings(value="unchecked")
	@Transactional
	public List<Comment> getComments(int id) throws DalException {
		Query query = currentSession().createQuery("from Comment where whereMess_id = :whereMess_id");
		query.setParameter("whereMess_id", id);
		List<Comment> listComm = query.list();
		return listComm;
	}
	

	@Override
	@Transactional
	public void changeAvatar(User user) throws DalException {
		Query query = currentSession().createQuery("update User set avatar = :newAvatar"  + " where id = :id");
		query.setParameter("id", user.getId());
		query.setParameter("newAvatar", user.getAvatar());
		query.executeUpdate();
	}

	
	@Override
	@Transactional
	public void changeField(String field, String changes,int id) {
		Query query = currentSession().createQuery("update User set "+ field +" = :field" + " where id = :id");
		query.setParameter("id", id);
		query.setParameter("field", changes);
		query.executeUpdate();
		
	}
	
	
	@Transactional
	public void changeStatus(String field, boolean changes,int id) {
		Query query = currentSession().createQuery("update User set "+ field +" = :field" + " where id = :id");
		query.setParameter("id", id);
		query.setParameter("field", changes);
		System.out.println(" updating " + id + "  " + changes);
		query.executeUpdate();
	}
	
	
	@Override
	@SuppressWarnings(value="unchecked")
	@Transactional
	public List<User> searchCr(String searchString) throws DalException {
		
		Criterion lastN = Restrictions.ilike("lastName", searchString,MatchMode.ANYWHERE);
		Criterion firstN = Restrictions.ilike("firstName", searchString,MatchMode.ANYWHERE);
		Criterion oneWord = Restrictions.or(lastN, firstN);
		Criterion moreWords = (Restrictions.or(
				Restrictions.in("firstName", parseQuery(searchString)),
				Restrictions.in("lastName", parseQuery(searchString))));
		Criteria criteria = currentSession().createCriteria(User.class);
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		if(parseQuery(searchString).size() > 1) criteria.add(moreWords);
		else	criteria.add(oneWord);

	return criteria.list();
	}
	

	@Override
	@Transactional
	public void deleteFriend(Integer id) throws DalException {
		Query query = currentSession().createQuery("delete from MyFriends where id = :id");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	
	@Override
	@Transactional
	public void deleteMessage(Integer id) throws DalException {
		Message mess = (Message) currentSession().createCriteria(Message.class).add(Restrictions.eq("id", id)).uniqueResult();
		currentSession().delete(mess);
		currentSession().flush();
		
	}
	

	@Override
	@Transactional
	public void deleteUser(Integer id) throws DalException {
		User user = (User) currentSession().createCriteria(User.class).add(Restrictions.eq("id", id)).uniqueResult();
		currentSession().delete(user);
		currentSession().flush();
		
		
	}
	
	
	private HashSet<String> parseQuery(String searchString){
		String[] arr = searchString.split("[,;:.!?\\s]+");
		HashSet<String> list = new HashSet<String>();
		for (int i = 0; i < arr.length; i++) {
			list.add(arr[i]);
		}
		return list;
	}
	
	
	private Session currentSession() {
		Session currentSession = sessionFactory.getCurrentSession();		
		return currentSession;
	}
	
	
	
}
