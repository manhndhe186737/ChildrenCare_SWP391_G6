/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import dal.CustomerDBContext;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author DELL
 */
public class testnet {
    public static void main(String[] args) {
        CustomerDBContext cdb = new CustomerDBContext();
        ArrayList<User> customerSearch = cdb.getUsersByName("Customer", "L", "Name");
        System.out.println(customerSearch.size());
    }
}
