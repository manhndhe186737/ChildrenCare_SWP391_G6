/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import dal.AccountController;
import java.sql.SQLException;

/**
 *
 * @author FPTSHOP
 */
public class NewClass1 {
    public static void main(String[] args) throws SQLException {
        AccountController a = new AccountController();
        System.out.println(a.getAccount("manhnguyenduc153@gmail.com", "123").getEmail());
        System.out.println(a.getAccount1().size());
        System.out.println(a.getAllUsers().size());
    }
}
