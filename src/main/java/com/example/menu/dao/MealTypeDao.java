package com.example.menu.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.menu.entity.MealType;

@Repository
public class MealTypeDao {

	@Autowired
	private SessionFactory sessionFactory;

	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public MealType findById(long id) {
		return (MealType) getCurrentSession().get(MealType.class, id);
	}

	public List<MealType> listMealTypes() {
		Criteria criteria = getCurrentSession().createCriteria(MealType.class);
		return criteria.list();
	}
}
