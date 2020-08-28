package com.nicegold.servlet;

import com.nicegold.dao.UserDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Message;
import com.nicegold.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldpassword = request.getParameter("oldpassword").trim();
        PrintWriter out = response.getWriter();
        HttpSession s = request.getSession();
        String newpassword = request.getParameter("newpassword");
        User user = (User) s.getAttribute("user");
        String checkpass=(String) user.getPassword();
        if (checkpass.equals(oldpassword)) {
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            user.setPassword(newpassword);
            if (dao.changePassword(user)) {
                s.setAttribute("user", user);
                Message msg = new Message("Password Successfully Changed", "success", "alert-success");
                s.setAttribute("msg", msg);
            } else {
                Message msg = new Message("Something Went Wrong! ", "error", "alert-danger");
                s.setAttribute("msgpassword", msg);
                out.println("error");
            }
        } else {
            Message msg = new Message("Password is incorrect. Try Again ", "error", "alert-danger");
            s.setAttribute("msgpassword", msg);
            out.println("error");
        }

    }
}
