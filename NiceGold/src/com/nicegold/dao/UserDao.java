package com.nicegold.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import com.nicegold.model.Message;
import com.nicegold.model.User;

public class UserDao {

	private final Connection conn;

	public UserDao(Connection con) {
		this.conn = con;
	}

	public boolean updateUserDetails(User user) {
		boolean f = false;
		try {
			String query = "update user set username=?, firmname=?, emailid=? where userid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getFirmname());
			ps.setString(3, user.getEmailid());
			ps.setInt(4, user.getUserid());
			ps.executeUpdate();
			f = true;
		} catch (Exception e) {
		}
		return f;
	}

	public boolean changePassword(User user) {
		boolean f = false;
		try {
			String query = "update user set password=? where userid=?";
			PreparedStatement st = conn.prepareStatement(query);
			st.setString(1, user.getPassword());
			st.setInt(2, user.getUserid());
			st.executeUpdate();
			f = true;
		} catch (Exception e) {
		}
		return f;
	}

	public boolean saveUser(User user) {
		boolean f = false;
		try {
			String query = "insert into user(username, firmname, mobile, emailid, password, userstate) values(?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getFirmname());
			ps.setString(3, user.getMobile());
			ps.setString(4, user.getEmailid());
			ps.setString(5, user.getPassword());
			ps.setString(6, user.getUserstate());
			ps.executeUpdate();
			f = true;
		} catch (SQLException ex) {
		}
		return f;
	}

	public boolean checkuser(User user, HttpSession s) {
		boolean f = false;
		try {
			String query = "select * from user where mobile=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, user.getMobile());
			ResultSet rs = ps.executeQuery();
			if (!rs.next()) {
				query = "select * from user where emailid=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, user.getEmailid());
				rs = ps.executeQuery();
				if (rs.next()) {
					Message msg = new Message("Email Id Already Exists!", "error", "alert-danger");
					s.setAttribute("msgreg", msg);
				} else {
					f = true;
				}
			} else {
				Message msg = new Message("Mobile No. Already Exists!", "error", "alert-danger");
				s.setAttribute("msgreg", msg);
			}
		} catch (Exception e) {
		}
		return f;
	}

	public boolean checkUserByEmailAndPassword(String email, String pass, HttpSession s) {
		boolean f = false;
		try {
			String query = "select * from user where emailid=? and password =?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUsername(rs.getString("username"));
				user.setFirmname(rs.getString("firmname"));
				user.setEmailid(rs.getString("emailid"));
				user.setMobile(rs.getString("mobile"));
				user.setPassword(rs.getString("password"));
				user.setUserid(rs.getInt("userid"));
				user.setUserstate(rs.getString("userstate"));
				user.setUserrole(rs.getString("userrole"));
				s.setAttribute("user", user);
				f = true;
			}
		} catch (Exception e) {
		}
		return f;
	}
}
