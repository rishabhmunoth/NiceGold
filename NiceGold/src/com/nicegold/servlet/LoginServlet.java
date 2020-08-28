package com.nicegold.servlet;

import com.nicegold.dao.UserDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
   
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
        String email=request.getParameter("useremail2");
        String password = request.getParameter("userpassword2");
        PrintWriter out= response.getWriter();
        HttpSession s = request.getSession();
        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        if(dao.checkUserByEmailAndPassword(email, password,s))
        {
            Message msg= new Message("Login Successful","success","alert-success");
            s.setAttribute("msg", msg);
        }else{
            Message msg= new Message("Invalid Credential","error","alert-danger");
            s.setAttribute("msglogin", msg);
            out.println("error");
        }
    }
}
