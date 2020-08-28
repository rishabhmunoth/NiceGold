package com.nicegold.model;

public class User {

	private int userid;
	private String username;
	private String firmname;
	private String mobile;
	private String emailid;
	private String userrole;
	private String password;

	public User() {
		super();
	}

	public User(String username, String firmname, String mobile, String emailid, String password) {
		super();
		this.username = username;
		this.firmname = firmname;
		this.mobile = mobile;
		this.emailid = emailid;
		this.password = password;
	}

	public User(int userid, String username, String firmname, String mobile, String emailid, String userrole,
			String password) {
		super();
		this.userid = userid;
		this.username = username;
		this.firmname = firmname;
		this.mobile = mobile;
		this.emailid = emailid;
		this.userrole = userrole;
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirmname() {
		return firmname;
	}

	public void setFirmname(String firmname) {
		this.firmname = firmname;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmailid() {
		return emailid;
	}

	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}

}
