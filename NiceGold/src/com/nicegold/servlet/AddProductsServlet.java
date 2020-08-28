package com.nicegold.servlet;

import com.nicegold.dao.ProductDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.helper.PathHelper;
import com.nicegold.model.Message;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class AddProductsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int catid = Integer.parseInt(request.getParameter("categoryselect"));
        String usercat=request.getParameter("usercat");
        HttpSession s = request.getSession();
        ProductDao dao = new ProductDao(ConnectionProvider.getConnection());
        String folder = dao.getCategoryNameById(catid).trim();
        String basepath = PathHelper.getpath(request);
        String fileSavePath = basepath + File.separator + "Product" + File.separator + folder;
        int flag = 0;
        File file = new File(fileSavePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String query = "insert into product (productid,productsrc,productcat,catid) values ";
        int countToAddComma = 0;
        String filename = "";
        List<Part> fileparts = request.getParts().stream().filter(part -> "file".equals(part.getName())).collect(Collectors.toList());
        int size = fileparts.size();
        for (Part filepart : fileparts) {
            filename = "catId_" + catid + "_" + Paths.get(filepart.getSubmittedFileName()).getFileName().toString();
            if (countToAddComma > 0) {
                query = query + " , ";
            }
            countToAddComma++;
            query = query + " ( '" + filename + "' , '" +folder+ "' , '" +usercat+ "' , " + catid + " ) ";
            filepart.write(fileSavePath + File.separator + filename);
            flag++;
        }
        if (flag == size && dao.addProducts(query)) {
            Message msg = new Message("Successfully Added", "success", "alert-success");
            s.setAttribute("msg", msg);
            response.sendRedirect("AddProducts.jsp");
        } else {
            Message msg = new Message("Something Went Wrong. Please Try Again", "error", "alert-danger");
            s.setAttribute("msg", msg);
            response.sendRedirect("AddProducts.jsp");
        }
    }
}