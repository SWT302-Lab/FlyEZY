/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class UserGoogleDto {

    private String id; //neu de int thi google se khong get duoc nen phai tao ra mot doi tuong khac
    private String name;
    private String email;
    private String password;
    private String phoneNumber;
    private String address;
    private String image;
    private Date dob;
    private int roleId;
    private int airlineId;
    private Timestamp created_at;
    private Timestamp updated_at;
    private int Status_id;

    public UserGoogleDto(String id, String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId, Timestamp created_at, Timestamp updated_at, int Status_id) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.image = image;
        this.dob = dob;
        this.roleId = roleId;
        this.airlineId = airlineId;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.Status_id = Status_id;
    }

    public UserGoogleDto(String name, String email, String password, String phoneNumber, String image, int roleId, int airlineId, Timestamp created_at, int Status_id) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.image = image;
        this.roleId = roleId;
        this.airlineId = airlineId;
        this.created_at = created_at;
        this.Status_id = Status_id;
    }

   

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
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

    public int getStatus_id() {
        return Status_id;
    }

    public void setStatus_id(int Status_id) {
        this.Status_id = Status_id;
    }

    @Override
    public String toString() {
        return "UserGoogleDto{" + "id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phoneNumber=" + phoneNumber + ", address=" + address + ", image=" + image + ", dob=" + dob + ", roleId=" + roleId + ", airlineId=" + airlineId + ", created_at=" + created_at + ", updated_at=" + updated_at + ", Status_id=" + Status_id + '}';
    }

    
    
    

}
