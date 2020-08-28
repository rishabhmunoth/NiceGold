package com.nicegold.model;

public class OrderIdDetail {

	private int orderid;
	private String productid;
	private String productsrc;

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
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

	public OrderIdDetail() {
		super();
	}

	public OrderIdDetail(int orderid, String productid, String productsrc) {
		super();
		this.orderid = orderid;
		this.productid = productid;
		this.productsrc = productsrc;
	}

}