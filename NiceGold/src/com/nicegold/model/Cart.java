package com.nicegold.model;

public class Cart {

	private int userid;
	private String productid;
	private int qty;
	private String productcat;
	private String productsrc;

	public String getProductcat() {
		return productcat;
	}

	public void setProductcat(String productcat) {
		this.productcat = productcat;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
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

	public Cart(int userid, String productid, int qty, String productcat, String productsrc) {
		this.userid = userid;
		this.productid = productid;
		this.qty = qty;
		this.productcat = productcat;
		this.productsrc = productsrc;
	}

	public Cart() {

	}

}
