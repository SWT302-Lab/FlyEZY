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
public class Refund {
    private int id;
    private String bank;
    private String bankAccount;
    private Timestamp requestDate;
    private Timestamp refundDate;
    private int refundPrice;

    public Refund(int id, String bank, String bankAccount, Timestamp requestDate, Timestamp refundDate, int refundPrice, int Ticketid, int Statusid) {
        this.id = id;
        this.bank = bank;
        this.bankAccount = bankAccount;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.refundPrice = refundPrice;
        this.Ticketid = Ticketid;
        this.Statusid = Statusid;
    }
    private int Ticketid;
    private int Statusid;

    public Refund(int id, String bank, String bankAccount, Timestamp requestDate, Timestamp refundDate, int Ticketid, int Statusid) {
        this.id = id;
        this.bank = bank;
        this.bankAccount = bankAccount;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.Ticketid = Ticketid;
        this.Statusid = Statusid;
    }

    public Refund(String bank, String bankAccount, Timestamp requestDate, Timestamp refundDate, int Ticketid, int Statusid) {
        this.bank = bank;
        this.bankAccount = bankAccount;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.Ticketid = Ticketid;
        this.Statusid = Statusid;
    }

    public Refund(String bank, String bankAccount, Timestamp requestDate, Timestamp refundDate, int refundPrice, int Ticketid, int Statusid) {
        this.bank = bank;
        this.bankAccount = bankAccount;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.refundPrice = refundPrice;
        this.Ticketid = Ticketid;
        this.Statusid = Statusid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public Timestamp getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Timestamp requestDate) {
        this.requestDate = requestDate;
    }

    public Timestamp getRefundDate() {
        return refundDate;
    }

    public void setRefundDate(Timestamp refundDate) {
        this.refundDate = refundDate;
    }

    public int getTicketid() {
        return Ticketid;
    }

    public void setTicketid(int Ticketid) {
        this.Ticketid = Ticketid;
    }

    public int getStatusid() {
        return Statusid;
    }

    public void setStatusid(int Statusid) {
        this.Statusid = Statusid;
    }

    public int getRefundPrice() {
        return refundPrice;
    }

    public void setRefundPrice(int refundPrice) {
        this.refundPrice = refundPrice;
    }
    
    
}
