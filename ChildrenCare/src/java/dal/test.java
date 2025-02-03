/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.Feature;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
public class test {
    public static void main(String[] args) {
        CustomerDBContext cdb = new CustomerDBContext();
        AccountDBContext adb = new AccountDBContext();
        System.out.println(cdb.getUsers("Customer").size());
        System.out.println(adb.getAccount("manh@gmail.com", "123").getEmail());
    }
}
