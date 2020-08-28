package com.nicegold.model;

import java.security.Timestamp;

public class OrderDetail {

	private int orderid;
	private Timestamp ordertime;
	private int totalqty;
	private int userid;
	private Boolean completed;

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}

	public Timestamp getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(Timestamp ordertime) {
		this.ordertime = ordertime;
	}

	public int getTotalqty() {
		return totalqty;
	}

	public void setTotalqty(int totalqty) {
		this.totalqty = totalqty;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public Boolean getCompleted() {
		return completed;
	}

	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}

	public OrderDetail(int orderid, Timestamp ordertime, int totalqty, int userid, Boolean completed) {
		super();
		this.orderid = orderid;
		this.ordertime = ordertime;
		this.totalqty = totalqty;
		this.userid = userid;
		this.completed = completed;
	}

	public OrderDetail() {
		super();
	}

}
