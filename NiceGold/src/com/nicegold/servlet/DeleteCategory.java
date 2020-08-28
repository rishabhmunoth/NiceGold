package com.nicegold.servlet;

import com.nicegold.dao.CardDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteCategory extends HttpServlet {
   
   
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
            PrintWriter out= response.getWriter();
        Integer id=Integer.parseInt(request.getParameter("catid").replaceAll("/",""));
        HttpSession s = request.getSession();
        CardDao dao = new CardDao(ConnectionProvider.getConnection());
        if(dao.deleteCategoryById(id))
        {
            Message msg= new Message("Deleted Successfully","success","alert-success");
            s.setAttribute("msgcategoryedit", msg);
            out.println("success");
        }
        else{
            Message msg= new Message("Something Went Wrong!","error","alert-danger");
            s.setAttribute("msgcategoryedit", msg);
            out.println("error");
        }
    }

  
}
