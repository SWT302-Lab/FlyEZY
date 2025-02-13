/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
/**
 *
 * @author PMQUANG
 */
public class Baggages {
    private int id;
    private float weight;
    private int price;
    private int airlineId;
    private int statusId;

    public Baggages(float weight, int price, int airlineId) {
        this.weight = weight;
        this.price = price;
        this.airlineId = airlineId;
    }
    
    public Baggages(int id, float weight, int price) {
        this.id = id;
        this.weight = weight;
        this.price = price;
    }
    
    public Baggages(int id, float weight, int price, int airlineId) {
        this.id = id;
        this.weight = weight;
        this.price = price;
        this.airlineId = airlineId;
    }

    public Baggages(int id, float weight, int price, int airlineId, int statusId) {
        this.id = id;
        this.weight = weight;
        this.price = price;
        this.airlineId = airlineId;
        this.statusId = statusId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    

    
    

    
    
}
