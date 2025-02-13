/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
/**
 *
 * @author Fantasy
 */
public class Feedbacks {
    private int id;
    private int Accountsid;
    private int ratedStar;
    private String comment;
    private Timestamp date;
    private Timestamp created_at;
    private Timestamp updated_at;
    private int Statusid;
    private int Order_id;

    public Feedbacks(int Accountsid, int ratedStar, String comment, Timestamp updated_at, int Order_id) {
        this.Accountsid = Accountsid;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.updated_at = updated_at;
        this.Order_id = Order_id;
    }
 
    
    public Feedbacks(int id, int Accountsid, int ratedStar, String comment, Timestamp date, Timestamp created_at, Timestamp updated_at, int Statusid, int Order_id) {
        this.id = id;
        this.Accountsid = Accountsid;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.date = date;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.Statusid = Statusid;
        this.Order_id = Order_id;
    }

    public Feedbacks(int id, int Accountsid, int ratedStar, String comment, Timestamp date, Timestamp created_at, int Statusid, int Order_id) {
        this.id = id;
        this.Accountsid = Accountsid;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.date = date;
        this.created_at = created_at;
        this.Statusid = Statusid;
        this.Order_id = Order_id;
    }

    public Feedbacks(int Accountsid, int ratedStar, String comment, Timestamp date, Timestamp created_at, int Statusid, int Order_id) {
        this.Accountsid = Accountsid;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.date = date;
        this.created_at = created_at;
        this.Statusid = Statusid;
        this.Order_id = Order_id;
    }

    public Feedbacks(int Accountsid, int ratedStar, String comment, Timestamp date, Timestamp created_at, Timestamp updated_at, int Statusid, int Order_id) {
        this.Accountsid = Accountsid;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.date = date;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.Statusid = Statusid;
        this.Order_id = Order_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountsid() {
        return Accountsid;
    }

    public void setAccountsid(int Accountsid) {
        this.Accountsid = Accountsid;
    }

    public int getRatedStar() {
        return ratedStar;
    }

    public void setRatedStar(int ratedStar) {
        this.ratedStar = ratedStar;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public int getStatusid() {
        return Statusid;
    }

    public void setStatusid(int Statusid) {
        this.Statusid = Statusid;
    }

    public int getOrder_id() {
        return Order_id;
    }

    public void setOrder_id(int Order_id) {
        this.Order_id = Order_id;
    }
    
    
}
