/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.FlightDetailDAO;
import dal.FlightManageDAO;
import dal.LocationDAO;
import dal.SeatCategoryDAO;
import dal.TicketDAO;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.FlightDetails;
import model.Flights;
import model.Location;
import model.Order;
import model.SeatCategory;
import model.Ticket;

public class EmailServlet {

    SeatCategoryDAO seat = new SeatCategoryDAO();
    TicketDAO td = new TicketDAO();
    FlightDetailDAO fd = new FlightDetailDAO();
    FlightManageDAO fmd = new FlightManageDAO();
    LocationDAO l = new LocationDAO();
    
    final String from = "flyezy.work@gmail.com";
    //pass flyezySWP2024
    final String passWord = "ylis mjup krwy nrck";

    public String generateOTP(int length) {
        StringBuilder otp = new StringBuilder();
        Random rand = new Random();
        for (int i = 0; i < length; i++) {
            otp.append(rand.nextInt(10)); // Thêm số ngẫu nhiên từ 0 đến 9
        }
        return otp.toString();
    }

    // Gửi email chứa mã OTP để xác thực
    public void sendOTPEmail(String to, String otp) {
        if (to == null || to.isEmpty()) {
            throw new IllegalArgumentException("Email người nhận không thể là null hoặc rỗng.");
        }
        if (otp == null || otp.isEmpty()) {
            throw new IllegalArgumentException("OTP không thể là null hoặc rỗng.");
        }
        if (from == null || from.isEmpty()) {
            throw new IllegalArgumentException("Email người gửi không thể là null hoặc rỗng.");
        }
        if (passWord == null || passWord.isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không thể là null hoặc rỗng.");
        }

        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        Session session = Session.getInstance(pro, authen);

        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Mã OTP Xác Thực Của Bạn", "UTF-8");
            msg.setSentDate(new Date());

            // Nội dung email bao gồm mã OTP
            msg.setText("Mã OTP của bạn là: " + otp + "\nMã này có hiệu lực trong vòng 5 phút.", "UTF-8");

            Transport.send(msg);
            System.out.println("Email OTP đã được gửi thành công!");
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public void sendPasswordEmail(String to, String newPassword) {
        //Properties: khai bao cac thuoc tinh
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        //port tls 587 
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        //sesion
        Session session = Session.getInstance(pro, authen);

        //send email
        //final String to = "chunloveptht@gmail.com";
        //create to message email
        MimeMessage msg = new MimeMessage(session);
        try {
            //content style
            msg.addHeader("Content-type", "text/HTML");
            //the person send and receiver:
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //The subject of email
            msg.setSubject("Khôi Phục Lại Mật Khẩu Của Bạn", "UTF-8");
            //date
            msg.setSentDate(new Date());
            //quy dinh email phan hoi
            //msg.setReplyTo(InternetAddress.parse(from, false));

            //content
            msg.setText("Mật Khẩu Mới của bạn là: " + newPassword, "UTF-8");

            //send email
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public void sendOrderEmail(String to, Order o) {
        //Properties: khai bao cac thuoc tinh
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        //port tls 587 
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        //sesion
        Session session = Session.getInstance(pro, authen);

        //send email
        //final String to = "chunloveptht@gmail.com";
        //create to message email
        MimeMessage msg = new MimeMessage(session);
        try {
            //content style
            msg.addHeader("Content-type", "text/HTML");
            //the person send and receiver:
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //The subject of email
            msg.setSubject("The Order Has Been Successfully Submitted", "UTF-8");
            //date
            msg.setSentDate(new Date());
            //quy dinh email phan hoi
            //msg.setReplyTo(InternetAddress.parse(from, false));

            //content
            msg.setContent("The customer: <b>" + o.getContactName() + "</b><br>"
                    + "Your code order is: " + o.getCode() + "<br>"
                    + "The total cost of your flight: " + o.getTotalPrice() + "<br>"
                    + "Please make the payment at least 10 days before the flight.",
                    "text/html");

            //send email
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public void sendPaymentSuccessfulbyEmail(String to, Order o) {
        //Properties: khai bao cac thuoc tinh
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        //port tls 587 
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        //sesion
        Session session = Session.getInstance(pro, authen);

        //send email
        //final String to = "chunloveptht@gmail.com";
        //create to message email
        MimeMessage msg = new MimeMessage(session);
        try {
            //content style
            msg.addHeader("Content-type", "text/HTML");
            //the person send and receiver:
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //The subject of email
            msg.setSubject("Payment Successful Notification", "UTF-8");
            //date
            msg.setSentDate(new Date());
            //quy dinh email phan hoi
            //msg.setReplyTo(InternetAddress.parse(from, false));

            //content
            StringBuilder content = new StringBuilder();
            content.append("The customer: <b>" + o.getContactName() + "</b><br>"
                    + "Your code order is: " + o.getCode() + "<br>"
                    + "You have paid successfully total price of flight is: " + o.getTotalPrice() + " VND<br>"
                    + "Payment time: "+ o.getPaymentTime()+ "<br>");
            List<Ticket> ticket = td.getAllTicketSuccessfulPaymentByOrderId(o.getId());
            for (Ticket t : ticket) {
                FlightDetails f = fd.getFlightDetailsByID(t.getFlightDetailId());
                Flights fl = fmd.getFlightById(f.getFlightId());
                Location dep = l.getLocationById(fl.getDepartureAirportId());
                Location des = l.getLocationById(fl.getDestinationAirportId());
                content.append("<br> Ticket has seat type: <b>" + seat.getSeatCategoryNameById(t.getSeat_Categoryid()) + "</b><br>"
                        +"Your position on the flight is: " + t.getCode() + "<br>"
                        +"Flight date: " + f.getDate() + "<br>"
                        +"The flight time is: " + f.getTime() + "<br>"
                        +"The flight have departure from " + dep.getName() + " to destination " + des.getName()+ "<br>"        
                );
            }
            content.append("Please check in for your flight on time.");
            msg.setContent(content.toString(), "text/html; charset=UTF-8");

            //send email
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        EmailServlet email = new EmailServlet();
        String otp = email.generateOTP(6);
        System.out.println(otp);
        email.sendOTPEmail("quanhthe187097@fpt.edu.vn", otp);

//        email.sendOrderEmail("duongnthe186310@fpt.edu.vn", null);
    }
}
