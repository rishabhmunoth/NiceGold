package com.nicegold.servlet;

import com.nicegold.dao.ProductDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.helper.ImageHelper;
import com.nicegold.helper.PathHelper;
import com.nicegold.model.Message;
import com.nicegold.model.ProductCard;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddProductCardServlet extends HttpServlet {

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
        ProductCard card = new ProductCard();
        Part part = request.getPart("img");
        int id = Integer.parseInt(request.getParameter("category").trim());
        PrintWriter out = response.getWriter();
        card.setCatid(id);
        card.setProductdesc(request.getParameter("carddesc"));
        ProductDao dao = new ProductDao(ConnectionProvider.getConnection());
        id=dao.getLastCardId();
        card.setProductsrc("cardid_" + id + "_" +part.getSubmittedFileName());
        HttpSession s = request.getSession();
        String path = PathHelper.getpath(request) + "ProductCard" + File.separator + card.getProductsrc();
        if (dao.insertIntoProductCard(card)) {
            ImageHelper img = new ImageHelper();
            if (img.saveImage(part.getInputStream(), path)) {
                Message msg = new Message("Successfully Added", "success", "alert-success");
                s.setAttribute("msgcardmodal", msg);
                out.println("error");
            } else {
                dao.deleteCardByLastInserted();
                Message msg = new Message("Something Went Wrong", "error", "alert-danger");
                s.setAttribute("msgcardmodal", msg);
                out.println("error");
            }
        } else {
            Message msg = new Message("Something Went Wrong", "error", "alert-danger");
            s.setAttribute("msgcardmodal", msg);
            out.println("error");

        }
    }

}
