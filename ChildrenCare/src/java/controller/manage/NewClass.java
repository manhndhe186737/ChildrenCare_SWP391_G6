/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import DAO.UserDAO;

/**
 *
 * @author FPTSHOP
 */
public class NewClass {
    public static void main(String[] args) {
        UserDAO u = new UserDAO();
        System.out.println(u.getUserRoles("manhvipyb1@gmail.com").getRoles().get(0).getRname());
    }
}
