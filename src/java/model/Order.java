/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Order {

    private int id;
    private String code;
    private String contactName;
    private String contactPhone;
    private String contactEmail;
    private int totalPrice;
    private Integer accountsId; 
    private int paymentTypesId;
    private Timestamp paymentTime; 
    private Timestamp created_at; 
    private Integer discountId; 
    private int Status_id;

    public Order() {
    }

    public Order(int id, String code, String contactName, String contactPhone, String contactEmail, int totalPrice, Integer accountsId, int paymentTypesId, Timestamp paymentTime,Timestamp created_at, Integer discountId, int Status_id) {
        this.id = id;
        this.code = code;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.contactEmail = contactEmail;
        this.totalPrice = totalPrice;
        this.accountsId = accountsId;
        this.paymentTypesId = paymentTypesId;
        this.paymentTime = paymentTime;
        this.created_at = created_at;
        this.discountId = discountId;
        this.Status_id = Status_id;
    }

    public Order(String code, String contactName, String contactPhone, String contactEmail, Integer accountsId, int paymentTypesId, Timestamp paymentTime, int Status_id) {
        this.code = code;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.contactEmail = contactEmail;
        this.accountsId = accountsId;
        this.paymentTypesId = paymentTypesId;
        this.paymentTime = paymentTime;
        this.Status_id = Status_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Integer getAccountsId() {
        return accountsId;
    }

    public void setAccountsId(Integer accountsId) {
        this.accountsId = accountsId;
    }

    public int getPaymentTypesId() {
        return paymentTypesId;
    }

    public void setPaymentTypesId(int paymentTypesId) {
        this.paymentTypesId = paymentTypesId;
    }

    public Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }



    public Integer getDiscountId() {
        return discountId;
    }

    public void setDiscountId(Integer discountId) {
        this.discountId = discountId;
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
    
    



    
}

