/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.staff;

import controller.auth.BaseRBAC;
import dal.StaffDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.Profile;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class ListStaff extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        StaffDBContext sdb = new StaffDBContext();

        String searchTerm = req.getParameter("search");
        String sortColumn = req.getParameter("sort");
        String sortDirection = req.getParameter("direction");
        String pageIndexStr = req.getParameter("page");
        int pageSize = 10; // Số nhân viên trên mỗi trang
        int pageIndex = (pageIndexStr != null) ? Integer.parseInt(pageIndexStr) : 1;

        if (sortColumn == null || sortColumn.isEmpty()) {
            sortColumn = "fullname";
        }

        if (sortDirection == null || (!sortDirection.equalsIgnoreCase("ASC") && !sortDirection.equalsIgnoreCase("DESC"))) {
            sortDirection = "ASC";
        }

// Lấy tổng số nhân viên để tính số trang
        int totalStaff = sdb.getTotalStaffCount(searchTerm);
        int totalPages = (int) Math.ceil((double) totalStaff / pageSize);

// Gọi DBContext để lấy danh sách nhân viên theo tiêu chí
        ArrayList<User> staff = sdb.getFilteredStaff(searchTerm, sortColumn, sortDirection, pageIndex, pageSize);

        req.setAttribute("staff", staff);
        req.setAttribute("searchTerm", searchTerm);
        req.setAttribute("sortColumn", sortColumn);
        req.setAttribute("sortDirection", sortDirection);
        req.setAttribute("currentPage", pageIndex);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("../admin/staff.jsp").forward(req, resp);

        //        ArrayList<User> staff = sdb.getUsers("Staff");
//        
//        req.setAttribute("staff", staff);
//        req.getRequestDispatcher("../admin/staff.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
