/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
import java.sql.Date;
import java.sql.Timestamp;

public class Accounts {

    private int id;
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

    public Accounts() {
    }

    public Accounts(int id, String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId, Timestamp created_at, Timestamp updated_at, int Status_id) {
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

    public Accounts(String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId, Timestamp created_at,int status_id) {
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
        this.Status_id  = status_id;
    }

    public Accounts(int id, String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId, Timestamp created_at, Timestamp updated_at) {
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
    }

     public Accounts( int id,String name, String email, String phoneNumber, String address, String image, Date dob) {
          this.id = id;
         this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.image = image;
        this.dob = dob;
    }
     
    public Accounts(int id, String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId) {
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
    }

    

    public Accounts(String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.image = image;
        this.dob = dob;
        this.roleId = roleId;
        this.airlineId = airlineId;
    }

    public Accounts(String name, String email, String password, String phoneNumber, int roleId) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.roleId = roleId;
    }

    public Accounts(int id, String name, String email, String password, String phoneNumber, String address, String image, Date dob, int roleId, int airlineId, Timestamp created_at) {
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
    }
    public Accounts(String name, String email, String password, String phoneNumber, int roleId, int airlineID, Timestamp created_at,int Status_id) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.roleId = roleId;
        this.airlineId = airlineID;
        this.created_at = created_at;
        this.Status_id = Status_id;
    }

    public int getStatus_id() {
        return Status_id;
    }

    public void setStatus_id(int Status_id) {
        this.Status_id = Status_id;
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

    
    @Override
    public String toString() {
        return "Accounts{" + "id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phoneNumber=" + phoneNumber + ", address=" + address + ", image=" + image + ", dob=" + dob + ", roleId=" + roleId + ", airlineId=" + airlineId + ", created_at=" + created_at + ", updated_at=" + updated_at + '}';
    }

}
