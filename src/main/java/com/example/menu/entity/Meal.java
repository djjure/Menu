package com.example.menu.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "meals")
public class Meal {

	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	private long id;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(referencedColumnName = "id", nullable = false)
	private Food food;
	private double quantityInGrams;
	private Date date;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(referencedColumnName = "id", nullable = false)
	private MealType mealType;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(referencedColumnName = "USER_ID", nullable = false)
	private User user;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Food getFood() {
		return food;
	}

	public void setFood(Food food) {
		this.food = food;
	}

	public double getQuantityInGrams() {
		return quantityInGrams;
	}

	public void setQuantityInGrams(double quantityInGrams) {
		this.quantityInGrams = quantityInGrams;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public MealType getMealType() {
		return mealType;
	}

	public void setMealType(MealType mealType) {
		this.mealType = mealType;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
