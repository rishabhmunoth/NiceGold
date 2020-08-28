package com.nicegold.model;

public class Cart {

	private String userid;
	private String productid;
	private String productsrc;
	private int catid;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getProductid() {
		return productid;
	}

	public void setProductid(String productid) {
		this.productid = productid;
	}

	public String getProductsrc() {
		return productsrc;
	}

	public void setProductsrc(String productsrc) {
		this.productsrc = productsrc;
	}

	public int getCatid() {
		return catid;
	}

	public void setCatid(int catid) {
		this.catid = catid;
	}

	public Cart(String userid, String productid, String productsrc, int catid) {
		super();
		this.userid = userid;
		this.productid = productid;
		this.productsrc = productsrc;
		this.catid = catid;
	}

	public Cart() {
		super();
	}

}
