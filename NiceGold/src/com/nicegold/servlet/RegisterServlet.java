package com.nicegold.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nicegold.dao.UserDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Message;
import com.nicegold.model.User;

public class RegisterServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = new User();
		HttpSession s = request.getSession();
		PrintWriter out = response.getWriter();
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		user.setUsername(request.getParameter("username"));
		user.setFirmname(request.getParameter("firmname"));
		user.setEmailid(request.getParameter("useremail"));
		user.setMobile(request.getParameter("mobile"));
		user.setPassword(request.getParameter("password"));
		if (dao.checkuser(user, s)) {
			if (dao.saveUser(user)) {
                            if(dao.checkUserByEmailAndPassword(user.getEmailid(), user.getPassword(), s)){
				Message msg = new Message("Successfully Registered!", "success", "alert-success");
				s.setAttribute("msg", msg);
                            }
                            else{
                            	Message msg = new Message("Registered Successfully! Please Login", "success", "alert-success");
				s.setAttribute("msg", msg);
                            }
			} else {
				out.println("error");
				return;
			}
		} else {
			out.println("error");
			return;
		}
	}

}
