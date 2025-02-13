/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class SeatCategory {
    private int id;
    private String name;
    private int numberOfSeat;
    private String image;
    private String info;
    private int seatEachRow;
    private float surcharge;
    private int Plane_Categoryid;
    private int statusId;
    private int countSeat;
    public SeatCategory() {
    }

    public SeatCategory(String name, int numberOfSeat,int countSeat) {
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.countSeat = countSeat;
    }
   
    public SeatCategory(String name, int numberOfSeat, String image, String info, int seatEachRow, float surcharge, int Plane_Categoryid, int statusId) {
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.image = image;
        this.info = info;
        this.seatEachRow = seatEachRow;
        this.surcharge = surcharge;
        this.Plane_Categoryid = Plane_Categoryid;
        this.statusId = statusId;
    }
    public SeatCategory(int id, String name, int numberOfSeat, String image, String info, int seatEachRow, float surcharge, int Plane_Categoryid, int statusId) {
        this.id = id;
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.image = image;
        this.info = info;
        this.seatEachRow = seatEachRow;
        this.surcharge = surcharge;
        this.Plane_Categoryid = Plane_Categoryid;
        this.statusId = statusId;
    }

    public SeatCategory(int id, String name, int numberOfSeat, String image, String info, int seatEachRow, float surcharge, int Plane_Categoryid, int statusId, int countSeat) {
        this.id = id;
        this.name = name;
        this.numberOfSeat = numberOfSeat;
        this.image = image;
        this.info = info;
        this.seatEachRow = seatEachRow;
        this.surcharge = surcharge;
        this.Plane_Categoryid = Plane_Categoryid;
        this.statusId = statusId;
        this.countSeat = countSeat;
    }

    

    public int getCountSeat() {
        return countSeat;
    }

    public void setCountSeat(int countSeat) {
        this.countSeat = countSeat;
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

    public int getNumberOfSeat() {
        return numberOfSeat;
    }

    public void setNumberOfSeat(int numberOfSeat) {
        this.numberOfSeat = numberOfSeat;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPlane_Categoryid() {
        return Plane_Categoryid;
    }

    public void setPlane_Categoryid(int Plane_Categoryid) {
        this.Plane_Categoryid = Plane_Categoryid;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public float getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(float surcharge) {
        this.surcharge = surcharge;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getSeatEachRow() {
        return seatEachRow;
    }

    public void setSeatEachRow(int seatEachRow) {
        this.seatEachRow = seatEachRow;
    }
    
    
    
}
