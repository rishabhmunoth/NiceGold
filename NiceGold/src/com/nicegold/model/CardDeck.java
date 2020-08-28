package com.nicegold.model;

public class CardDeck {

    private int cardid;
    private String cardtitle;
    private String cardimg;
    private String category;
    private String cardcontent;

    public String getCardimg() {
        return cardimg;
    }

    public CardDeck(String cardtitle, String cardimg, String category, String cardcontent) {
        this.cardtitle = cardtitle;
        this.cardimg = cardimg;
        this.category = category;
        this.cardcontent = cardcontent;
    }

    public CardDeck(int cardid, String cardtitle, String cardimg, String category, String cardcontent) {
        this.cardid = cardid;
        this.cardtitle = cardtitle;
        this.cardimg = cardimg;
        this.category = category;
        this.cardcontent = cardcontent;
    }

    public int getCardid() {
        return cardid;
    }

    public void setCardid(int cardid) {
        this.cardid = cardid;
    }

    public String getCardtitle() {
        return cardtitle;
    }

    public void setCardtitle(String cardtitle) {
        this.cardtitle = cardtitle;
    }

    public void setCardimg(String cardimg) {
        this.cardimg = cardimg;
    }


    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCardcontent() {
        return cardcontent;
    }

    public void setCardcontent(String cardcontent) {
        this.cardcontent = cardcontent;
    }


    public CardDeck() {
        super();
    }

}
