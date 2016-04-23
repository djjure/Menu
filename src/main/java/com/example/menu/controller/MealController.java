package com.example.menu.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.menu.entity.Food;
import com.example.menu.entity.Meal;
import com.example.menu.entity.MealType;
import com.example.menu.entity.User;
import com.example.menu.service.FoodService;
import com.example.menu.service.MealService;
import com.example.menu.service.MealTypeService;
import com.example.menu.service.UserService;

@Controller
@RequestMapping("/meal")
public class MealController {

	@Autowired
	MealService mealService;

	@Autowired
	FoodService foodService;

	@Autowired
	UserService userService;

	@Autowired
	MealTypeService mealTypeService;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@Transactional(readOnly = false)
	public ModelAndView addMeal(@RequestParam long korisnik, @RequestParam @DateTimeFormat(iso = ISO.DATE) Date datum,
			@RequestParam(required = false) String spremi, @RequestParam(required = false) Long korisnik2, @RequestParam(required = false) Long obrok,
			@RequestParam(required = false) Double udio, @RequestParam(required = false) String prenesi, @RequestParam MultiValueMap<String, String> params,
			ModelMap model) {
		datum.setHours(0);
		datum.setMinutes(0);
		datum.setSeconds(0);
		User user = userService.findById(korisnik);
		List<Meal> meals = mealService.listMeal(korisnik, datum);
		for (Meal m : meals) {
			mealService.deleteMeal(m.getId());
		}
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < params.get("namir[" + i + "][]").size(); j++) {
				if ((Long.valueOf(params.get("namir[" + i + "][]").get(j)) != -1) && (params.get("kolicina[" + i + "][]").get(j).compareTo("") != 0)) {
					Meal m = new Meal();
					MealType mt = mealTypeService.findById(i);
					m.setMealType(mt);
					Food f = foodService.findById(Long.valueOf(params.get("namir[" + i + "][]").get(j)));
					m.setFood(f);
					m.setQuantityInGrams(Double.valueOf(params.get("kolicina[" + i + "][]").get(j)));
					m.setUser(user);
					m.setDate(datum);
					mealService.addMeal(m);
				}
			}
		}

		if (prenesi != null) {
			List<Meal> mealsFrom = mealService.listMeal(korisnik, datum, obrok);
			List<Meal> mealsTo = mealService.listMeal(korisnik2, datum, obrok);
			User userTo = userService.findById(korisnik2);
			for (Meal mt : mealsTo) {
				mealService.deleteMeal(mt.getId());
			}
			for (Meal mf : mealsFrom) {
				Meal mt = new Meal();
				mt.setDate(datum);
				mt.setFood(mf.getFood());
				mt.setMealType(mf.getMealType());
				mt.setQuantityInGrams(mf.getQuantityInGrams() * udio / 100);
				mt.setUser(userTo);
				mealService.addMeal(mt);

				mf.setQuantityInGrams(mf.getQuantityInGrams() * (100 - udio) / 100);
				mealService.addMeal(mf);
			}
		}

		ModelAndView mav = new ModelAndView("redirect:/meal/all");
		mav.addObject("korisnik", korisnik);
		mav.addObject("datum", new SimpleDateFormat("yyyy-MM-dd").format(datum));
		return mav;
	}

	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public String showMeal(@RequestParam(required = false) Long korisnik, @RequestParam(required = false) @DateTimeFormat(iso = ISO.DATE) Date datum,
			ModelMap model, Principal principal) {
		if (datum == null) {
			datum = new Date();
		}
		datum.setHours(0);
		datum.setMinutes(0);
		datum.setSeconds(0);
		User currentUser;
		if (korisnik == null) {
			currentUser = userService.findByName(principal.getName());
		} else {
			currentUser = userService.findById(korisnik);
		}
		List<Food> foods = foodService.listFoods();
		List<Meal> meals = mealService.listMeal(currentUser.getId(), datum);
		List<User> users = userService.listUsers();
		List<MealType> mealTypes = mealTypeService.listMealTypes();
		model.addAttribute("foods", foods);
		model.addAttribute("meals", meals);
		model.addAttribute("users", users);
		model.addAttribute("mealTypes", mealTypes);
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("datum", datum);
		return "meal";
	}

}
