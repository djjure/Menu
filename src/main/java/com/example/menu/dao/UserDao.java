package com.example.menu.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.menu.entity.User;

@Repository
public class UserDao {

	@Autowired
	private SessionFactory sessionFactory;

	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public User findById(long id) {
		return (User) getCurrentSession().get(User.class, id);
	}

	public User findByName(String name) {
		Criteria criteria = getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("userName", name));
		List<User> users = criteria.list();
		return users.get(0);
	}

	public List<User> listUsers() {
		Criteria criteria = getCurrentSession().createCriteria(User.class);
		return criteria.list();
	}

}
