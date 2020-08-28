package com.nicegold.servlet;

import com.nicegold.dao.CardDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.CardDeck;
import com.nicegold.model.Message;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddCategory extends HttpServlet {
   
   
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
        HttpSession s = request.getSession();
        PrintWriter out= response.getWriter();
        String cat = request.getParameter("catname");
        CardDao dao = new CardDao(ConnectionProvider.getConnection());
        if(dao.addCategory(cat)){
            ArrayList<CardDeck> cards = new ArrayList<>();
            cards = dao.getCard();
            s.setAttribute("carddeck", cards);
            Message msg = new Message("Successfully Added","success","alert-success");
            s.setAttribute("msgcategoryedit", msg);
            out.println("success");
        }
        else{
            Message msg = new Message("Something Went Wrong! ","error","alert-danger");
            s.setAttribute("msgcategoryedit", msg);
            out.println("error");
        }
    }

  
}
