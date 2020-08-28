package com.nicegold.dao;

import com.nicegold.model.Category;
import com.nicegold.model.Product;
import com.nicegold.model.ProductCard;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ProductDao {

    private final Connection conn;

    public ProductDao(Connection con) {
        this.conn = con;
    }

    public int getLastCardId() {
        int a = 0;
        try {
            String query = "select max(productcardid) as productcardid from productcard";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                a = rs.getInt("productcardid");
            }
        } catch (Exception e) {
        }
        return a + 1;
    }

    public String getCategoryNameById(int id) {
        String name = "";
        String query = "select cat from category where catid=?";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("cat");
            }
        } catch (Exception e) {
        }
        return name;
    }

    public boolean deleteCardByLastInserted() {
        boolean f = false;
        try {
            String query = "delete from productcard order by productcardid desc limit 1";
            Statement st = conn.createStatement();
            st.executeUpdate(query);
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public boolean insertIntoProductCard(ProductCard card) {
        boolean f = false;
        try {
            String query = "insert into productcard(productsrc,productdesc,catid) values(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, card.getProductsrc());
            ps.setString(2, card.getProductdesc());
            ps.setInt(3, card.getCatid());
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public boolean addProducts(String query) {
        boolean f = false;
        try {
            Statement st = conn.createStatement();
            st.executeUpdate(query);
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public String checkProductById(String id) {
        String f = "";
        String query = "select * from product where productid LIKE ?";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = rs.getString("productid");
            }
        } catch (Exception e) {
        }
        return f;
    }

    public boolean deleteProductByProductId(String productid) {
        boolean f = false;
        try {
            String query = "delete from product where productid=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, productid);
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public ArrayList<ProductCard> getAllProductCard() throws SQLException {
        ArrayList<ProductCard> cards = new ArrayList<>();
        try {
            String query = "select * from productcard";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                ProductCard card = new ProductCard();
                card.setCatid(rs.getInt("catid"));
                card.setProductcardid(rs.getInt("productcardid"));
                card.setProductdesc(rs.getString("productdesc"));
                card.setProductsrc(rs.getString("productsrc"));
                cards.add(card);
            }
        } catch (Exception e) {
        }
        return cards;
    }

    public boolean deleteProductCardById(int id) {
        boolean f = false;
        try {
            String query = "delete from productcard where productcardid=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
        }
        return f;
    }

    public String getCardImageNameByCardId(int id) {
        String name = "";
        try {
            String query = "select * from productcard where productcardid=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("productsrc");
            }

        } catch (Exception e) {
        }
        return name;
    }

    public ArrayList<Product> getProductsByCatIdForGoldUser(int id) {
        String query = "select * from product where productid=? and productcat='GOLD'";
        ArrayList<Product> products = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                Product p = new Product();
                p.setProductid(rs.getString("productid"));
                p.setProductsrc(rs.getString("productsrc"));
                p.setProductcat(rs.getString("productcat"));
                p.setCatid(rs.getInt("catid"));
                products.add(p);
            }
        } catch (Exception e) {
        }
        return products;
    }
    public ArrayList<Product> getProductsByCatIdForPlatinumUser(int id) {
        String query = "select * from product where catid=?";
        ArrayList<Product> products = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                Product p = new Product();
                p.setProductid(rs.getString("productid"));
                p.setProductsrc(rs.getString("productsrc"));
                p.setProductcat(rs.getString("productcat"));
                p.setCatid(rs.getInt("catid"));
                products.add(p);
            }
        } catch (Exception e) {
        }
        return products;
    }
}
