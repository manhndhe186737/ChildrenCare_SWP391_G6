/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import dal.ServiceDAO;
import dal.ServiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Feedback;
import model.Service;
import model.ServiceFeedback;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ServiceDetail", urlPatterns = {"/service-detail"})
public class ServiceDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy service_id từ request
        String serviceIdParam = request.getParameter("id");
        int serviceId = serviceIdParam != null ? Integer.parseInt(serviceIdParam) : 0;

        // Lấy thông tin chi tiết của dịch vụ từ database
        ServiceDBContext serviceDB = new ServiceDBContext();
        Service service = serviceDB.getServiceById(serviceId);

        if (!service.getCategory().isStatus()) {
            response.sendRedirect("service-list");
            return;
        }

        if (!service.isActive) {
            response.sendRedirect("service-list");
            return;
        }

        if (service == null) {
            response.sendRedirect("service-list");
            return;
        }

        int categoryId = service.getCategory().getId();

        // Lấy danh sách các related services
        java.util.ArrayList<Service> relatedServices = serviceDB.getServicesByCategoryId(categoryId);
        relatedServices.removeIf(s -> s.getId() == service.getId());

        ServiceDAO sd = new ServiceDAO();
        List<ServiceFeedback> feedbacks = sd.getServiceFeedback(serviceId);
        double avgRating = 0.0;
        int totalFeedbacks = feedbacks.size();

        if (totalFeedbacks > 0) {
            double totalRating = 0;
            for (ServiceFeedback feedback : feedbacks) {
                totalRating += feedback.getRating();
            }
            avgRating = totalRating / totalFeedbacks; // Tính trung bình
        }

        java.util.HashMap<Integer, Double> relatedServicesAvgRating = new java.util.HashMap<>();
        java.util.HashMap<Integer, Integer> relatedServicesTotalFeedbacks = new java.util.HashMap<>();

        for (Service relatedService : relatedServices) {
            List<ServiceFeedback> relatedFeedbacks = sd.getServiceFeedback(relatedService.getId());
            int relatedTotalFeedbacks = relatedFeedbacks.size();
            double relatedAvgRating = 0.0;

            if (relatedTotalFeedbacks > 0) {
                double relatedTotalRating = 0;
                for (ServiceFeedback feedback : relatedFeedbacks) {
                    relatedTotalRating += feedback.getRating();
                }
                relatedAvgRating = relatedTotalRating / relatedTotalFeedbacks;
            }

            relatedServicesAvgRating.put(relatedService.getId(), relatedAvgRating);
            relatedServicesTotalFeedbacks.put(relatedService.getId(), relatedTotalFeedbacks);
        }

        // Gửi dữ liệu đến JSP
        request.setAttribute("feedback", feedbacks);
        request.setAttribute("service", service);
        request.setAttribute("relatedServices", relatedServices);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("totalFeedbacks", totalFeedbacks);
        request.setAttribute("relatedServicesAvgRating", relatedServicesAvgRating); // Thêm avgRating của related services
        request.setAttribute("relatedServicesTotalFeedbacks", relatedServicesTotalFeedbacks); // Thêm total feedbacks của related services

        request.getRequestDispatcher("c/service-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý POST nếu cần
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ví dụ hiển thị thông báo
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Service Detail</title></head><body>");
            out.println("<h1>Service Detail</h1>");
            out.println("</body></html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Service Detail Servlet";
    }
}
