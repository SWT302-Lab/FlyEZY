/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author PMQUANG
 */
public class Airline {
    private int id;
    private String name;
    private String image;
    private String info;
    private int statusId;

    public Airline(int id) {
        this.id = id;
    }

    public Airline(String name, String image) {
        this.name = name;
        this.image = image;
    }

    public Airline(String name, String image, String info) {
        this.name = name;
        this.image = image;
        this.info = info;
    }


    public Airline(int id, String name, String image) {
        this.id = id;
        this.name = name;
        this.image = image;
    }

    public Airline(int id, String name, String image, String info) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.info = info;
    }

    public Airline(int id, String name, String image, String info, int statusId) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.info = info;
        this.statusId = statusId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    @Override
    public String toString() {
        return "Airline{" + "id=" + id + ", name=" + name + ", image=" + image + ", info=" + info + ", statusId=" + statusId + '}';
    }



}
