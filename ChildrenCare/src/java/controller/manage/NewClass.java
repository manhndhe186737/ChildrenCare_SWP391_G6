/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import DAO.UserDAO;
import dal.SliderDBContext;

/**
 *
 * @author FPTSHOP
 */
public class NewClass {
    public static void main(String[] args) {
        SliderDBContext u = new SliderDBContext();
        System.out.println(u.getActiveSliders());
    }
}
