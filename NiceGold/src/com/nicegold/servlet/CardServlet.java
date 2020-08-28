package com.nicegold.servlet;

import com.nicegold.dao.CardDao;
import com.nicegold.helper.ConnectionProvider;
import com.nicegold.helper.ImageHelper;
import com.nicegold.helper.PathHelper;
import com.nicegold.model.CardDeck;
import com.nicegold.model.Message;
import java.io.File;
//import java.io.FileOutputStream;
import java.io.IOException;
//import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class CardServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {      
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CardDeck card = new CardDeck();
        card.setCardtitle(request.getParameter("cardtitle"));
        card.setCategory(request.getParameter("category"));
        PrintWriter out = response.getWriter();
        card.setCardcontent(request.getParameter("cardcontent"));
        Part part = request.getPart("cardimg");
        CardDao dao = new CardDao(ConnectionProvider.getConnection());
        int id = dao.getLastCardId();
        HttpSession s = request.getSession();
        String filename = part.getSubmittedFileName();
        card.setCardimg("cardid_" + id + "_" + filename);
        ImageHelper img = new ImageHelper();
        if (dao.insertcarddeck(card)) {
            String basepath = PathHelper.getpath(request);
            String inputpath = basepath + File.separator + "CardImages"+ File.separator + card.getCardimg();
            //String outpath = basepath + File.separator + "CardImages" + File.separator + "Card"  + File.separator + card.getCardimg();
            if (img.saveImage(part.getInputStream(), inputpath)) {
                Message msg = new Message("Successfully Added", "success", "alert-success");
                s.setAttribute("msgcardmodal", msg);
            } else {
                dao.deleteCardByLastInserted();
                out.println("error");
                Message msg = new Message("Something Went Wrong! Please Try Again", "error", "alert-danger");
                s.setAttribute("msgcardmodal", msg);
            }
        } else {
            out.println("error");
            Message msg = new Message("Something Went Wrong! Please Try Again", "error", "alert-danger");
            s.setAttribute("msgcardmodal", msg);
        }
    }
}
