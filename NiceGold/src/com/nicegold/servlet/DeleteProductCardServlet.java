package com.nicegold.servlet;

import com.nicegold.dao.CardDao;
import com.nicegold.dao.ProductDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.helper.ImageHelper;
import com.nicegold.helper.PathHelper;
import com.nicegold.model.Message;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProductCardServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("cardid"));
        HttpSession s = request.getSession();
        PrintWriter out = response.getWriter();
        ProductDao dao = new ProductDao(ConnectionProvider.getConnection());
        String imgname = dao.getCardImageNameByCardId(id);
        if (dao.deleteProductCardById(id)) {
            String basepath = PathHelper.getpath(request);
            ImageHelper img = new ImageHelper();
            if (img.deleteimagefromfolder(basepath + File.separator + "ProductCard" + File.separator + imgname)) {
                out.println("success");
            }
        } else {
            out.println("error");
        }
    }

}
