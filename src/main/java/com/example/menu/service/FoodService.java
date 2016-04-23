package com.example.menu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.menu.dao.FoodDao;
import com.example.menu.entity.Food;

@Service
public class FoodService {

	@Autowired
	private FoodDao foodDao;

	@Transactional(readOnly = true)
	public List<Food> listFoods() {
		return foodDao.listFoods();
	}

	@Transactional(readOnly = true)
	public Food findById(long id) {
		return foodDao.findById(id);
	}

	@Transactional(readOnly = false)
	public void addFood(Food food) {
		foodDao.saveOrUpdate(food);
	}

	@Transactional(readOnly = false)
	public void deleteFood(long id) {
		Food food = foodDao.findById(id);
		if (food != null) {
			foodDao.delete(food);
		}
	}
}
