package com.nicegold.servlet;

import com.nicegold.dao.ProductDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.model.Product;
import com.nicegold.model.User;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SeeAllPostServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("catid"));
        ArrayList<Product> products = new ArrayList<>();
        HttpSession s = request.getSession();
        ProductDao dao = new ProductDao(ConnectionProvider.getConnection());
        User user = (User) s.getAttribute("user");
        String userrole = user.getUserrole().trim();
        if(userrole.equals("GOLD")) {
            products=dao.getProductsByCatIdForGoldUser(id);
        }
        else if(userrole.equals("PLATINUM") || userrole.equals("ADMIN")){
            products=dao.getProductsByCatIdForPlatinumUser(id);
        }
        s.setAttribute("products", products);
        response.sendRedirect("AllProducts.jsp");
    }

}
