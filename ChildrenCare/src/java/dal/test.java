/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.Feature;
import model.Role;
import java.sql.SQLException;

/**
 *
 * @author FPTSHOP
 */
public class test extends DBContext {
    public static void main(String[] args) {
        test test = new test();
        if (test.connection != null) {
            System.out.println("K?t n?i ??n MySQL thành công!");
        } else {
            System.out.println("K?t n?i ??n MySQL th?t b?i!");
        }
        try {
            if (test.connection != null) {
                test.connection.close();
                System.out.println("?ã ?óng k?t n?i!");
            }
        } catch (SQLException e) {
            System.err.println("L?i khi ?óng k?t n?i: " + e.getMessage());
        }
    }
}
