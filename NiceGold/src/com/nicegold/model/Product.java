package com.nicegold.model;

import java.security.Timestamp;

public class Product {

    private String productid;
    private String productsrc;
    private String productcat;
    private int catid;
    private Timestamp addtime;

    public String getProductcat() {
        return productcat;
    }

    public void setProductcat(String productcat) {
        this.productcat = productcat;
    }

    public Product(String productid, String productsrc, String productcat, int catid) {
        this.productid = productid;
        this.productsrc = productsrc;
        this.productcat = productcat;
        this.catid = catid;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getProductsrc() {
        return productsrc;
    }

    public void setProductsrc(String productsrc) {
        this.productsrc = productsrc;
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

    public Product() {
        super();
    }
}
