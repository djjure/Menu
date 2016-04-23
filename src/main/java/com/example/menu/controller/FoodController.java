package com.example.menu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.menu.entity.Food;
import com.example.menu.entity.Meal;
import com.example.menu.service.FoodService;
import com.example.menu.service.MealService;

@Controller
@RequestMapping("/food")
public class FoodController {

	@Autowired
	private FoodService foodService;

	@Autowired
	private MealService mealService;

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String showFood(@PathVariable long id, ModelMap model) {
		model.addAttribute("food", foodService.findById(id));
		return "food";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String showAddFood(ModelMap model) {
		Food food = new Food();
		food.setId(-1);
		model.addAttribute("food", food);
		return "addfood";
	}

	@RequestMapping(value = "/add/{id}", method = RequestMethod.GET)
	public String showAddFood(@PathVariable long id, ModelMap model) {
		model.addAttribute("food", foodService.findById(id));
		return "addfood";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addFood(Food food, ModelMap model) {
		if (food.getId() == -1) {
			food.setId(0);
			foodService.addFood(food);
		} else {
			foodService.addFood(food);
		}
		return "redirect:/food/all";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String deleteFood(@PathVariable long id, ModelMap model) {
		List<Meal> meal = mealService.findByFoodId(id);
		if (meal.size() == 0) {
			foodService.deleteFood(id);
			return "redirect:/food/all";
		} else {
			model.addAttribute("food", foodService.findById(id));
			model.addAttribute("error", "Food added to meal");
			return "food";
		}
	}

	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public String showFoods(ModelMap model) {
		model.addAttribute("foods", foodService.listFoods());
		return "foods";
	}
}
