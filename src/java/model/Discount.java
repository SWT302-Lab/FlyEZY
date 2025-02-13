/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class Discount {

    private int id;
    private String code;
    private double percentage;
    private int min_order;
    private Date date_created;
    private Date valid_until;
    private int Airline_id;
    private int Status_id;

    public Discount() {
    }

    public Discount(String code, double percentage, int min_order, Date date_created, Date valid_until, int Airline_id, int Status_id) {
        this.code = code;
        this.percentage = percentage;
        this.min_order = min_order;
        this.date_created = date_created;
        this.valid_until = valid_until;
        this.Airline_id = Airline_id;
        this.Status_id = Status_id;
    }

    public Discount(String code, double percentage, int min_order, Date date_created, Date valid_until, int Airline_id) {
        this.code = code;
        this.percentage = percentage;
        this.min_order = min_order;
        this.date_created = date_created;
        this.valid_until = valid_until;
        this.Airline_id = Airline_id;
    }

    public Discount(int id,String code, double percentage, int min_order, Date date_created, Date valid_until, int Airline_id, int Status_id) {
        this.id = id;
        this.code = code;
        this.percentage = percentage;
        this.min_order = min_order;
        this.date_created = date_created;
        this.valid_until = valid_until;
        this.Airline_id = Airline_id;
        this.Status_id = Status_id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    public int getMin_order() {
        return min_order;
    }

    public void setMin_order(int min_order) {
        this.min_order = min_order;
    }

    public Date getDate_created() {
        return date_created;
    }

    public void setDate_created(Date date_created) {
        this.date_created = date_created;
    }

    public Date getValid_until() {
        return valid_until;
    }

    public void setValid_until(Date valid_until) {
        this.valid_until = valid_until;
    }

    public int getAirline_id() {
        return Airline_id;
    }

    public void setAirline_id(int Airline_id) {
        this.Airline_id = Airline_id;
    }

    public int getStatus_id() {
        return Status_id;
    }

    public void setStatus_id(int Status_id) {
        this.Status_id = Status_id;
    }

}
