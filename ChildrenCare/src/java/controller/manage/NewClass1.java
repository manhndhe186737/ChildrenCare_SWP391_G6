/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import dal.AccountController;
import dal.AccountDBContext;
import java.sql.SQLException;

/**
 *
 * @author FPTSHOP
 */
public class NewClass1 {
    public static void main(String[] args) throws SQLException {
        AccountController a = new AccountController();
        System.out.println(a.getAccount("manhnguyenduc153@gmail.com", "123").getEmail());
        AccountDBContext adb = new AccountDBContext();
        System.out.println(adb.getRoles("manhnguyenduc153@gmail.com").get(0).getFeatures().size());
    }
}
