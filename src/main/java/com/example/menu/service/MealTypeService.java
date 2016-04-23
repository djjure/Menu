package com.example.menu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.menu.dao.MealTypeDao;
import com.example.menu.entity.MealType;

@Service
public class MealTypeService {

	@Autowired
	private MealTypeDao mealTypeDao;

	@Transactional(readOnly = true)
	public List<MealType> listMealTypes() {
		return mealTypeDao.listMealTypes();
	}

	@Transactional(readOnly = true)
	public MealType findById(long id) {
		return mealTypeDao.findById(id);
	}
}
