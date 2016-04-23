package com.example.menu.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.menu.dao.MealDao;
import com.example.menu.entity.Meal;

@Service
public class MealService {

	@Autowired
	private MealDao mealDao;

	@Transactional(readOnly = true)
	public List<Meal> listMeal() {
		return mealDao.listMeal();
	}

	@Transactional(readOnly = true)
	public List<Meal> listMeal(long korisnik, Date datum) {
		return mealDao.listMeal(korisnik, datum);
	}

	@Transactional(readOnly = true)
	public List<Meal> listMeal(long korisnik, Date datum, long obrok) {
		return mealDao.listMeal(korisnik, datum, obrok);
	}

	@Transactional(readOnly = true)
	public Meal findById(long id) {
		return mealDao.findById(id);
	}

	@Transactional(readOnly = true)
	public List<Meal> findByFoodId(long id) {
		return mealDao.findByFoodId(id);
	}

	@Transactional(readOnly = false)
	public void addMeal(Meal meal) {
		mealDao.saveOrUpdate(meal);
	}

	@Transactional(readOnly = false)
	public void deleteMeal(long id) {
		Meal meal = mealDao.findById(id);
		if (meal != null) {
			meal.setFood(null);
			meal.setUser(null);
			meal.setMealType(null);
			mealDao.delete(meal);
		}
	}
}
