/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 *
 * @author Admin
 */
public class EncodeController {
    
    public static String SECRET_KEY = "maiyeudomdomjj98";

    public EncodeController() {
    }
    
    //QuanHT: create encode function
    public static String encryptAES(String str, String key) throws Exception {
        // str chuỗi cần mã hóa còn key là khóa ta truyền vào
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");

        // Thiết lập Cipher cho mã hóa
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        //encrypt thành byte
        byte[] encryptedBytes = cipher.doFinal(str.getBytes());
        // chuyển nó thành String để đọc
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public static String decryptAES(String str, String key) throws Exception {

        SecretKeySpec secretkey = new SecretKeySpec(key.getBytes(), "AES");

        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretkey);

        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(str));

        return new String(decryptedBytes);
    }

    public static void main(String[] args) throws Exception {
        String str_en = "1";
        String key = SECRET_KEY;

        String encode = encryptAES(str_en, key);
        System.out.println("ma khi duoc ma hoa:" + encode);
        String decode = decryptAES("eJm7mXOhxdULW3Lye/UPbw==", key);
        System.out.println("Code sau khi giai ma:" + decode);
    }
}
