/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Fantasy
 */
public class PassengerType {
    private int id;
    private String name;
    private float price;
    private int numberOfType;

    public PassengerType() {
    }

    public PassengerType(int id, String name, float price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }

    public PassengerType(int id, String name, float price,int numberOfType) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.numberOfType = numberOfType;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumberOfType() {
        return numberOfType;
    }

    public void setNumberOfType(int numberOfType) {
        this.numberOfType = numberOfType;
    }
    
}
