<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, model.Service, model.ServiceCategory"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Service List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
            }

            body {
                background-color: #ffffff;
                padding: 40px 20px 20px;
                display: flex;
                justify-content: center;
                flex-direction: column;
                align-items: center;
            }

            h2 {
                text-align: center;
                width: 100%;
                margin-bottom: 20px;
            }

            .container {
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 20px;
                max-width: 1200px;
                width: 100%;
                margin-top: 20px;
            }

            /* Sidebar */
            .sidebar {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .search-box {
                width: 100%;
                padding: 12px;
                border: 2px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                outline: none;
            }

            .category-title {
                font-size: 18px;
                font-weight: bold;
                margin-top: 20px;
                margin-bottom: 10px;
                color: #333;
            }

            .category-filters label {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 16px;
                margin-bottom: 10px;
                cursor: pointer;
            }

            .btn-filter {
                width: 100%;
                background-color: #3498db;
                color: white;
                font-size: 16px;
                padding: 10px;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                margin-top: 10px;
                transition: background 0.3s;
            }

            .btn-filter:hover {
                background-color: #2980b9;
            }

            /* Service Grid */
            .service-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                gap: 20px;
                padding: 10px;
                margin-bottom: 40px;
            }

            /* Service Box */
            .service-box {
                background: linear-gradient(135deg, #e0f7fa, #ffffff);
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
                text-align: left;
                position: relative;
                overflow: hidden;
            }

            .service-box:hover {
                transform: scale(1.08);
                box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.2);
            }

            .service-name {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 8px;
                color: #2c3e50;
            }

            .service-description {
                font-size: 14px;
                color: #555;
                margin-bottom: 10px;
            }

            .service-price {
                font-size: 18px;
                color: #16a085;
                font-weight: bold;
                margin-bottom: 15px;
            }

            /* Buttons */
            .actions {
                display: flex;
                justify-content: space-between;
                gap: 10px;
                margin-top: 10px;
            }

            .actions a {
                flex: 1;
                text-align: center;
                text-decoration: none;
                padding: 10px;
                border-radius: 8px;
                color: white;
                font-size: 16px;
                transition: 0.3s;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-details {
                background-color: #3498db;
            }
            .btn-details:hover {
                background-color: #2980b9;
            }

            .btn-buy {
                background-color: #27ae60;
            }
            .btn-buy:hover {
                background-color: #219150;
            }

            .btn-feedback {
                background-color: #e74c3c;
            }
            .btn-feedback:hover {
                background-color: #c0392b;
            }

            /* Pagination */
            .pagination {
                margin-top: 50px;
                text-align: center;
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .pagination a {
                display: inline-block;
                padding: 10px 15px;
                border-radius: 8px;
                background-color: #ddd;
                color: #333;
                text-decoration: none;
                transition: 0.3s;
                font-size: 16px;
                font-weight: bold;
            }

            .pagination a.active {
                background-color: #3498db;
                color: white;
            }

            .pagination a:hover {
                background-color: #bbb;
            }


        </style>
    </head>
    <body>

        <h2 style="text-align: center;">Available Services</h2>

        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <form action="ServiceList" method="GET">
                    <input type="text" name="search" class="search-box" placeholder="Search services..." 
                           value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">

                    <div class="category-title">Filter by Category</div>
                    <div class="category-filters">
                        <%
                            ArrayList<ServiceCategory> categories = (ArrayList<ServiceCategory>) request.getAttribute("categories");
                            if (categories != null) {
                                for (ServiceCategory category : categories) {
                                    boolean checked = request.getParameterValues("category") != null && 
                                        java.util.Arrays.asList(request.getParameterValues("category")).contains(String.valueOf(category.getId()));
                        %>
                        <label>
                            <input type="checkbox" name="category" value="<%= category.getId() %>" <%= checked ? "checked" : "" %>>
                            <%= category.getCategoryname() %>
                        </label>
                        <% 
                                }
                            }
                        %>
                    </div>

                    <button type="submit" class="btn-filter">Apply Filters</button>
                </form>
            </div>

            <!-- Service List -->
            <div class="service-container">
                <%
                    ArrayList<Service> services = (ArrayList<Service>) request.getAttribute("services");
                    if (services != null && !services.isEmpty()) {
                        for (Service s : services) {
                %>
                <div class="service-box">
                    <div class="service-name"><%= s.getName() %></div>
                    <div class="service-description"><%= s.getDescription() %></div>
                    <div class="service-price">$<%= s.getPrice() %></div>
                    <div class="actions">
                        <a href="ServiceDetailServlet?id=<%= s.getId() %>" class="btn-details"><i class="fas fa-info-circle"></i></a>
                        <a href="cart.jsp?add=<%= s.getId() %>" class="btn-buy"><i class="fas fa-shopping-cart"></i></a>
                        <a href="feedback.jsp?service_id=<%= s.getId() %>" class="btn-feedback"><i class="fas fa-comment-alt"></i></a>
                    </div>
                </div>
                <% } } else { %>
                <p>No services available.</p>
                <% } %>
            </div>
        </div>
        <!-- Pagination -->
        <div class="pagination">
            <%
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");

                if (totalPages > 1) {
                    for (int i = 1; i <= totalPages; i++) { 
            %>
            <a href="ServiceList?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
            <%
                    }
                }
            %>
        </div>

    </body>
</html>
