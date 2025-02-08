/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import dal.CustomerDBContext;
import dal.StaffDBContext;
import java.util.ArrayList;
import model.Profile;
import model.User;

/**
 *
 * @author DELL
 */
public class testnet {
    public static void main(String[] args) {
        StaffDBContext sdb = new StaffDBContext();
        System.out.println(sdb.getStaffReserv(3).size());
    }
}
