package com.example.menu.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.menu.entity.Food;

import java.util.List;

@Repository
public class FoodDao {

	@Autowired
	private SessionFactory sessionFactory;

	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public Food findById(long id) {
		return (Food) getCurrentSession().get(Food.class, id);
	}

	public void saveOrUpdate(Food food) {
		getCurrentSession().saveOrUpdate(food);
	}

	public void delete(Food food) {
		getCurrentSession().delete(food);
	}

	public List<Food> findByName(String name) {
		Criteria criteria = getCurrentSession().createCriteria(Food.class);
		criteria.add(Restrictions.like("name", name, MatchMode.START));
		return criteria.list();
	}

	public List<Food> listFoods() {
		Criteria criteria = getCurrentSession().createCriteria(Food.class);
		return criteria.list();
	}
}
