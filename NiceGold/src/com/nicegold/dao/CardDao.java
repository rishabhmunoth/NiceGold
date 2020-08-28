package com.nicegold.dao;

import com.nicegold.model.CardDeck;
import com.nicegold.model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class CardDao {

    private final Connection conn;

    public CardDao(Connection con) {
        this.conn = con;
    }

    public int getLastCardId() {
        int a = 0;
        try {
            String query = "select max(cardid) as cardid from carddeck";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                a = rs.getInt("cardid");
            }
        } catch (Exception e) {
        }
        return a + 1;
    }

    public ArrayList<Category> getCategory() throws SQLException {
        ArrayList<Category> cat = new ArrayList<>();
        try {
            String query = "select * from category";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Category c = new Category();
                c.setCat(rs.getString("cat"));
                c.setCatid(rs.getInt("catid"));
                cat.add(c);
            }
        } catch (Exception e) {
        }
        return cat;
    }

    public boolean deleteCategoryById(int id){
        boolean f=false;
        try{
            String query="delete from category where catid=?";
            PreparedStatement ps= conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            f=true;
        }catch(Exception e){}
        return f;
    }
    public boolean addCategory(String name){
        boolean f= false;
        try{
            String query="insert into category(cat) values(?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.executeUpdate();
            f=true;
        }catch(Exception e){}
        return f;
    }
    public ArrayList<CardDeck> getCard() {
        ArrayList<CardDeck> cards = new ArrayList<>();
        try {
            String query = "select * from carddeck";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                CardDeck card = new CardDeck();
                card.setCardid(rs.getInt("cardid"));
                card.setCardtitle(rs.getString("cardtitle"));
                card.setCardimg(rs.getString("cardimg"));
                card.setCardcontent(rs.getString("cardcontent"));
                card.setCategory(rs.getString("category"));
                cards.add(card);
            }
        } catch (Exception e) {
        }
        return cards;
    }
    
    public String getCardImageNameByCardId(int id){
        String name="";
        try{
            String query="select * from carddeck where cardid=?";
            PreparedStatement ps= conn.prepareStatement(query);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                name=rs.getString("cardimg");
            }
            
        }catch(Exception e){}
        return name;
    }
    
    public boolean insertcarddeck(CardDeck card) {
        boolean f = false;
        try {
            String query = "insert into carddeck(cardtitle, cardimg, category, cardcontent) values(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, card.getCardtitle());
            ps.setString(2, card.getCardimg());
            ps.setString(3, card.getCategory());
            ps.setString(4, card.getCardcontent());
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public boolean deleteCardByLastInserted() {
        boolean f = false;
        try {
            String query = "delete from carddeck order by cardid desc limit 1";
            Statement st = conn.createStatement();
            st.executeUpdate(query);
            f = true;
        } catch (Exception e) {
        }
        return f;
    }
    public boolean deleteCardById( int id){
        boolean f = false;
        try{
            String query="delete from carddeck where cardid=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, id);
            st.executeUpdate();
            f=true;
        }catch(Exception e){}
        return f;
    }
}
