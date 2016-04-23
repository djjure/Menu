package com.example.menu.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.menu.entity.Meal;

@Repository
public class MealDao {

	@Autowired
	private SessionFactory sessionFactory;

	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public Meal findById(long id) {
		return (Meal) getCurrentSession().get(Meal.class, id);
	}

	public void saveOrUpdate(Meal meal) {
		getCurrentSession().saveOrUpdate(meal);
	}

	public void delete(Meal meal) {
		getCurrentSession().delete(meal);
	}

	/*
	 * public List<Meal> findByName(String name) { Criteria criteria =
	 * getCurrentSession().createCriteria(Meal.class);
	 * criteria.add(Restrictions.like("name", name, MatchMode.EXACT)); return
	 * criteria.list(); }
	 */

	public List<Meal> findByFoodId(long id) {
		Criteria criteria = getCurrentSession().createCriteria(Meal.class);
		criteria.add(Restrictions.eq("food.id", id));
		return criteria.list();
	}

	public List<Meal> listMeal() {
		Criteria criteria = getCurrentSession().createCriteria(Meal.class);
		return criteria.list();
	}

	public List<Meal> listMeal(long korisnik, Date datum) {
		Criteria criteria = getCurrentSession().createCriteria(Meal.class);
		criteria.add(Restrictions.eq("user.id", korisnik));
		criteria.add(Restrictions.eq("date", datum));
		return criteria.list();
	}

	public List<Meal> listMeal(long korisnik, Date datum, long obrok) {
		Criteria criteria = getCurrentSession().createCriteria(Meal.class);
		criteria.add(Restrictions.eq("user.id", korisnik));
		criteria.add(Restrictions.eq("date", datum));
		criteria.add(Restrictions.eq("mealType.id", obrok));
		return criteria.list();
	}

}
