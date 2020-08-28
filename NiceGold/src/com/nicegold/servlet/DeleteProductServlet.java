package com.nicegold.servlet;

import com.nicegold.dao.ProductDao;
import com.nicegold.helper.ConnectionProvider;
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

public class DeleteProductServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        HttpSession s = request.getSession();
        try {
            int catid = Integer.parseInt(request.getParameter("category").trim());
            String productid = (request.getParameter("productid").trim()).toUpperCase();
            String basepath = PathHelper.getpath(request) + "Product" + File.separator;//mail folder path with added product folder
            ProductDao dao = new ProductDao(ConnectionProvider.getConnection());
            String folder = dao.getCategoryNameById(catid);
            String filename = "catId_" + catid + "_" + productid + ".%";
            filename = dao.checkProductById(filename);
            if (filename.equals("") || filename.equals(" ")) {
                Message msg = new Message("This Product Does Not Exists", "error", "alert-danger");
                s.setAttribute("msgproductdelete", msg);
                out.println("error");
            } else {
                if (dao.deleteProductByProductId(filename)) {
                    String filepathtodelete = basepath + folder + File.separator + filename;
                    if (deletefile(filepathtodelete)) {
                        Message msg = new Message("Delete Successfully", "success", "alert-success");
                        s.setAttribute("msgproductdelete", msg);
                        out.println("success");
                    }
                }
            }
        } catch (Exception e) {
            Message msg = new Message("Something Went Wrong "+e, "error", "alert-danger");
            s.setAttribute("msgproductdelete", msg);
            out.println("error");
        }
    }

    private boolean deletefile(String path) {
        boolean f = false;
        try {
            File file = new File(path);
            f = file.delete();
        } catch (Exception e) {
        }
        return f;
    }
}
