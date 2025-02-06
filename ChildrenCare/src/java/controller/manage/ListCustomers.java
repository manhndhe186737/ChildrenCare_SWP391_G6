/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import controller.auth.BaseRBAC;
import dal.CustomerDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class ListCustomers extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        CustomerDBContext cdb = new CustomerDBContext();

        String searchName = req.getParameter("s");
        if (searchName == null || searchName.length() == 0) {
            searchName = "";
        }

        String sortBy = req.getParameter("sortBy");
        if (sortBy == null) {
            sortBy = "None";
        }

        int page = 1;
        int pageSize = 5;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1; 
            }
        }

        ArrayList<User> customers = cdb.getUsersByNameWithPagination("Customer", searchName, sortBy, page, pageSize);

        int totalCustomers = cdb.getTotalUsersCount("Customer", searchName);
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        req.setAttribute("customers", customers);
        req.setAttribute("searchName", searchName);
        req.setAttribute("sortBy", sortBy);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("../admin/customers.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        CustomerDBContext cdb = new CustomerDBContext();

        String searchName = req.getParameter("s");
        if (searchName == null || searchName.length() == 0) {
            searchName = "";
        }
        String sortBy = req.getParameter("sortBy");

        ArrayList<User> customerSearch = cdb.getUsersByName("Customer", searchName, sortBy);

        req.setAttribute("sortBy", sortBy);
        req.setAttribute("customers", customerSearch);
        req.getRequestDispatcher("../admin/customers.jsp").forward(req, resp);
    }

}
