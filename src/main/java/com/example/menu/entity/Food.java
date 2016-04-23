package com.example.menu.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "foods")
public class Food {

	@Id
	@GenericGenerator(name = "generator", strategy = "increment")
	@GeneratedValue(generator = "generator")
	private long id;
	private String name;
	private double quantityInGrams;
	private double kiloCalories;
	private double proteinsInGrams;
	private double carbonHydratesInGrams;
	private double lipidsInGrams;
	private double kolesterolInMiligrams;
	private double gi;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getQuantityInGrams() {
		return quantityInGrams;
	}

	public void setQuantityInGrams(double quantityInGrams) {
		this.quantityInGrams = quantityInGrams;
	}

	public double getKiloCalories() {
		return kiloCalories;
	}

	public void setKiloCalories(double kiloCalories) {
		this.kiloCalories = kiloCalories;
	}

	public double getProteinsInGrams() {
		return proteinsInGrams;
	}

	public void setProteinsInGrams(double proteinsInGrams) {
		this.proteinsInGrams = proteinsInGrams;
	}

	public double getCarbonHydratesInGrams() {
		return carbonHydratesInGrams;
	}

	public void setCarbonHydratesInGrams(double carbonHydratesInGrams) {
		this.carbonHydratesInGrams = carbonHydratesInGrams;
	}

	public double getLipidsInGrams() {
		return lipidsInGrams;
	}

	public void setLipidsInGrams(double lipidsInGrams) {
		this.lipidsInGrams = lipidsInGrams;
	}

	public double getKolesterolInMiligrams() {
		return kolesterolInMiligrams;
	}

	public void setKolesterolInMiligrams(double kolesterolInMiligrams) {
		this.kolesterolInMiligrams = kolesterolInMiligrams;
	}

	public double getGi() {
		return gi;
	}

	public void setGi(double gi) {
		this.gi = gi;
	}

}

