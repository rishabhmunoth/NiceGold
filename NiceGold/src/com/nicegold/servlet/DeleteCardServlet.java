package com.nicegold.servlet;

import com.nicegold.dao.CardDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.helper.ImageHelper;
import com.nicegold.helper.PathHelper;
import com.nicegold.model.CardDeck;
import com.nicegold.model.Message;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteCardServlet extends HttpServlet {

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
        CardDao dao = new CardDao(ConnectionProvider.getConnection());
        String imgname = dao.getCardImageNameByCardId(id);
        if (dao.deleteCardById(id)) {
            String basepath = PathHelper.getpath(request);
            ImageHelper img = new ImageHelper();
            if (img.deleteimagefromfolder(basepath + File.separator + "CardImages" + File.separator + imgname)) {
                Message msg = new Message("Deleted Successfully", "success", "alert-success");
                s.setAttribute("msg", msg);
                out.println("success");
            }
        } else {
            Message msg = new Message("Something Went Wrong", "error", "alert-danger");
            s.setAttribute("msg", msg);
            out.println("error");
        }
    }

}
