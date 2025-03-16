/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.Feature;
import model.Role;
import java.sql.SQLException;
import model.Post;

/**
 *
 * @author FPTSHOP
 */
public class test extends DBContext {
    public static void main(String[] args) {
        RoleDBContext rdb = new RoleDBContext();
        System.out.println(rdb.getRoles().get(0).getFeatures().size());
    }
}
