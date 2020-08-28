package com.nicegold.model;

public class Category {

	private int catid;
	private String cat;

	public int getCatid() {
		return catid;
	}

	public void setCatid(int catid) {
		this.catid = catid;
	}

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
	}

	public Category(int catid, String cat) {
		super();
		this.catid = catid;
		this.cat = cat;
	}

	public Category() {
		super();
	}
}
