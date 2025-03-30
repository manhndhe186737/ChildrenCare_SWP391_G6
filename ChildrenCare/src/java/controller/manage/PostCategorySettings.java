package controller.manage;

import controller.auth.BaseRBAC;
import dal.PostCategoryDBContext;
import model.PostCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;

@WebServlet("/admin/settings-postcategory")
public class PostCategorySettings extends BaseRBAC {

    private PostCategoryDBContext categoryDB = new PostCategoryDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String nameFilter = request.getParameter("name");
        Boolean statusFilter = null;
        String statusParam = request.getParameter("status");
        if (statusParam != null && !statusParam.isEmpty()) {
            statusFilter = Boolean.parseBoolean(statusParam);
        }
        
        if (nameFilter != null) {
            nameFilter = nameFilter.trim();
        }

        ArrayList<PostCategory> categories = categoryDB.getCategoriesWithFilterAndPagination(nameFilter, statusFilter, page, 10);
        int totalCategories = categoryDB.getTotalCategories(nameFilter, statusFilter);
        int totalPages = (int) Math.ceil(totalCategories / 10.0);

        request.setAttribute("categories", categories);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("nameFilter", nameFilter);
        request.setAttribute("statusFilter", statusFilter);

        request.getRequestDispatcher("post-category-settings.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                boolean status = request.getParameter("status") != null;

                PostCategory category = new PostCategory();
                category.setId(id);
                category.setName(name);
                category.setDescription(description);
                category.setStatus(status);
                
                categoryDB.updateCategory(category);

                request.getSession().setAttribute("message", "Category updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/settings-postcategory");
            } else if ("add".equals(action)) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                boolean status = request.getParameter("status") != null;

                // Debug logging
                System.out.println("Adding new post category: Name=" + name + ", Status=" + status + ", Description=" + description);
                
                PostCategory category = new PostCategory();
                category.setName(name);
                category.setDescription(description);
                category.setStatus(status);
                
                categoryDB.addCategory(category);

                request.getSession().setAttribute("message", "Post category added successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/settings-postcategory");
            } else if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));

                categoryDB.updateCategoryStatus(id, status);
                response.getWriter().write("Status updated successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Add detailed error logging
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }
}