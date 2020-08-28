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

public class UpdateDetailsServlet extends HttpServlet {
   
   
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
        User user = new User();
        PrintWriter out= response.getWriter();
        HttpSession s= request.getSession();
        user=(User)s.getAttribute("user");
        user.setUsername(request.getParameter("username"));
        user.setFirmname(request.getParameter("firmname"));
        user.setEmailid(request.getParameter("useremail"));
        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        if(dao.updateUserDetails(user)){
            s.setAttribute("user", user);
            Message msg = new Message("Details Updated", "success", "alert-success");
            s.setAttribute("msg", msg);
            out.println("success");
        }
        else{
            Message msg = new Message("Email Id Already Exixts. Please Try Again", "error", "alert-danger");
            s.setAttribute("msgdetailsalert", msg);
            out.println("error");
        }
    }
}
