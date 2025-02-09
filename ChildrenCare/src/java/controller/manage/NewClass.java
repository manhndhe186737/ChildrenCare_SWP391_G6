/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import DAO.UserDAO;
import dal.StaffDBContext;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
public class NewClass {
    public static void main(String[] args) {
        StaffDBContext sdb = new StaffDBContext();
        System.out.println(sdb.getProfileStaff(3).getAccount().getRoles().size());
        for (Role r : sdb.getProfileStaff(3).getAccount().getRoles()) {
            System.out.println(r.getRname());
        }
    }
}
