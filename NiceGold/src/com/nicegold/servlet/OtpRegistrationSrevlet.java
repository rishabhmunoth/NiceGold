package com.nicegold.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nicegold.dao.UserDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Message;
import com.nicegold.model.User;

@WebServlet(urlPatterns = "/OtpRegistrationSrevlet", name = "OtpRegistrationSrevlet")
public class OtpRegistrationSrevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OtpRegistrationSrevlet() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		PrintWriter out = response.getWriter();
		HttpSession s = request.getSession();
		int otp = (Integer) s.getAttribute("userotp");
		int enteredOtp = Integer.parseInt((request.getParameter("otp").trim()));
		if (otp == enteredOtp) {
			User user = (User) s.getAttribute("userforotp");
			if (dao.saveUser(user)) {
				if (dao.checkUserByEmailAndPassword(user.getEmailid(), user.getPassword(), s)) {
					Message msg = new Message("Successfully Registered!", "success", "alert-success");
					s.setAttribute("msg", msg);
					s.removeAttribute("userforotp");
					out.println("success");
				} else {
					Message msg = new Message("Registered Successfully! Please Login", "success", "alert-success");
					s.setAttribute("msg", msg);
					out.println("successbutlogin");
				}
			} else {
				out.println("error");
			}
		} else {
			Message msg = new Message("Invalid Otp.", "error", "alert-danger");
			s.setAttribute("msgreg", msg);
			out.println("error");

		}
	}

}
