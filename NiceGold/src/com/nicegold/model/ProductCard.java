package com.nicegold.model;

import java.security.Timestamp;

public class ProductCard {

    private int productcardid;
    private String productsrc;
    private String productdesc;
    private int catid;
    private Timestamp addtime;

    public ProductCard() {
    }
    
    public int getProductcardid() {
        return productcardid;
    }

    public void setProductcardid(int productcardid) {
        this.productcardid = productcardid;
    }

    public String getProductsrc() {
        return productsrc;
    }

    public void setProductsrc(String productsrc) {
        this.productsrc = productsrc;
    }

    public String getProductdesc() {
        return productdesc;
    }

    public void setProductdesc(String productdesc) {
        this.productdesc = productdesc;
    }

    public int getCatid() {
        return catid;
    }

    public void setCatid(int catid) {
        this.catid = catid;
    }

    public Timestamp getAddtime() {
        return addtime;
    }

    public void setAddtime(Timestamp addtime) {
        this.addtime = addtime;
    }
 
    public ProductCard(String productsrc, String productdesc, int catid) {
        this.productsrc = productsrc;
        this.productdesc = productdesc;
        this.catid = catid;
    }

}
