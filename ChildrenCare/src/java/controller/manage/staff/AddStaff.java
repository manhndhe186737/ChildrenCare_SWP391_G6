/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.staff;

import controller.auth.BaseRBAC;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import model.User;
import dal.StaffDBContext;
import model.Account;
import config.PasswordUtil;
import java.util.ArrayList;

/**
 *
 * @author FPTSHOP
 */
public class AddStaff extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        StaffDBContext staffDAO = new StaffDBContext();
    ArrayList<User> staffList = staffDAO.getAllStaff();

    // Kiểm tra danh sách nhân viên (DEBUG)
//    System.out.println("Danh sách nhân viên khi mở trang:");
//    if (staffList == null || staffList.isEmpty()) {
//        System.out.println("⚠️ Không có nhân viên nào trong danh sách!");
//    } else {
//        for (User staff : staffList) {
//            System.out.println("✅ " + staff.getFullname() + " | " + staff.getAccount().getEmail());
//        }
//    }

    // Gửi danh sách nhân viên đến JSP
    req.setAttribute("staffList", staffList);
        req.getRequestDispatcher("../admin/add-staff.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullname = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String genderStr = req.getParameter("gender");
        String dobStr = req.getParameter("dob");

        System.out.println();
        System.out.println("name: " + fullname + ", email: " + email + ", phone: " + phone + ", address: " + address + ", gender: " + genderStr + ", dob: " + dobStr);

        // Xử lý chuyển đổi ngày sinh (dob)
        Date dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            dob = Date.valueOf(dobStr);
        }

        // Xử lý giới tính
        Boolean gender = "GY".equals(genderStr) ? false : true; // "GY" cho nữ, mặc định cho nam

        // Tạo đối tượng User và cập nhật thông tin
        User user = new User();
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setAddress(address);
        user.setGender(gender);
        user.setDob(dob);

        // Tạo đối tượng Account và gán email vào đó
        Account newAccount = new Account();
        newAccount.setEmail(email);

        // Đặt mật khẩu mặc định và mã hóa nó
        String defaultPassword = "123456";
        String hashedPassword = null;

        try {
            hashedPassword = PasswordUtil.hashPassword(defaultPassword);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error hashing password.");
            req.getRequestDispatcher("../admin/add-staff.jsp").forward(req, resp);
            return;
        }

        // Tạo đối tượng StaffDBContext và thêm Staff vào cơ sở dữ liệu
        StaffDBContext staffDAO = new StaffDBContext();
        int userId = staffDAO.registerStaffWithProfile(user, email, hashedPassword); // Truyền mật khẩu đã mã hóa
          ArrayList<User> staffList = staffDAO.getAllStaff();
    req.setAttribute("staffList", staffList);

        // Kiểm tra nếu tài khoản được tạo thành công
        if (userId != -1) {
            req.setAttribute("successMessage", "Staff added successfully.");
        } else {
            req.setAttribute("errorMessage", "Failed to create staff.");
        }
        req.getRequestDispatcher("../admin/add-staff.jsp").forward(req, resp);
    }

}
