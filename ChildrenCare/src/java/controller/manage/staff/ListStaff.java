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
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        StaffDBContext sdb = new StaffDBContext();

        String search = req.getParameter("search");
        String sort = req.getParameter("sort");
        String pageParam = req.getParameter("page");

        int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int pageSize = 10;

        ArrayList<User> staff = sdb.getUsers("Staff", search, sort, page, pageSize);

        int totalStaff = sdb.getTotalUsers("Staff", search);
        int totalPages = (int) Math.ceil((double) totalStaff / pageSize);

        req.setAttribute("staff", staff);
        req.setAttribute("pageNumbers", getPageNumbers(totalPages, page));

        req.getRequestDispatcher("../admin/staff.jsp").forward(req, resp);
    }

    private ArrayList<Integer> getPageNumbers(int totalPages, int currentPage) {
        ArrayList<Integer> pageNumbers = new ArrayList<>();
        for (int i = 1; i <= totalPages; i++) {
            pageNumbers.add(i);
        }
        return pageNumbers;
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
