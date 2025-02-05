<%@ page import="java.util.List, model.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Post Management</title>
        <link rel="stylesheet" href="/css/styles.css">
        <style>/* Tổng thể */
            body {
                font-family: Arial, sans-serif;
                background-color: #e0f7fa; /* Màu xanh nhạt */
                color: #333;
                margin: 20px;
                padding: 0;
                text-align: center;
            }

            /* Tiêu đề */
            h2 {
                color: #0077b6;
                font-size: 28px;
                margin-bottom: 20px;
            }

            /* Form bộ lọc */
            form {
                background: #ffffff;
                padding: 15px;
                border-radius: 8px;
                display: inline-block;
                box-shadow: 0px 4px 10px rgba(0, 119, 182, 0.2);
                margin-bottom: 20px;
                transition: transform 0.3s ease-in-out;
            }

            form:hover {
                transform: scale(1.02);
            }

            form input,
            form select {
                padding: 8px;
                margin: 5px;
                border: 1px solid #0077b6;
                border-radius: 5px;
                outline: none;
            }

            form button {
                background-color: #0077b6;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                border-radius: 5px;
                transition: background 0.3s;
            }

            form button:hover {
                background: #005f87;
            }

            /* Bảng danh sách bài viết */
            table {
                width: 90%;
                margin: 0 auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0px 4px 10px rgba(0, 119, 182, 0.2);
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #0077b6;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f1faff;
            }

            /* Hiệu ứng hover cho bảng */
            tr:hover {
                background-color: #b3e5fc;
                transition: background 0.3s ease-in-out;
            }

            /* Nút hành động */
            a {
                text-decoration: none;
                padding: 5px 10px;
                margin: 5px;
                border-radius: 5px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            a[href*="edit"] {
                background-color: #ffa726;
                color: white;
            }

            a[href*="edit"]:hover {
                background-color: #f57c00;
            }

            a[href*="view"] {
                background-color: #4caf50;
                color: white;
            }

            a[href*="view"]:hover {
                background-color: #388e3c;
            }

            /* Nút thêm bài viết */
            a[href*="add"] {
                display: inline-block;
                margin-top: 15px;
                padding: 10px 15px;
                background-color: #0077b6;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                transition: background 0.3s ease-in-out, transform 0.2s;
            }

            a[href*="add"]:hover {
                background-color: #005f87;
                transform: scale(1.1);
            }

            /* Phân trang */
            div {
                margin-top: 15px;
            }

            div a {
                padding: 5px 10px;
                margin: 3px;
                background-color: #0077b6;
                color: white;
                border-radius: 5px;
                font-weight: bold;
                transition: background 0.3s ease-in-out;
            }

            div a:hover {
                background-color: #005f87;
            }

            /* Hiệu ứng số trang hiện tại */
            div strong {
                padding: 5px 10px;
                background: #004c70;
                color: white;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <h2>Post List</h2>

        <!-- Bộ lọc -->
        <form method="GET" action="PostList">
            <input type="text" name="search" placeholder="Search by title">
            <select name="category">
                <option value="">All Categories</option>
                <option value="Services">Services</option>
                <option value="Beauty Tips">Beauty Tips</option>
            </select>
            <select name="author">
                <option value="">All Authors</option>
                <option value="2">Mary Johnson</option>
                <option value="3">David Brown</option>
            </select>
            <select name="status">
                <option value="">All Status</option>
                <option value="1">Active</option>
                <option value="0">Inactive</option>
            </select>
            <button type="submit">Filter</button>
        </form>

        <!-- Danh sách bài viết -->
        <table border="1">
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Author</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <%
                List<Post> posts = (List<Post>) request.getAttribute("posts");
                int currentPage = (int) request.getAttribute("currentPage");
                int totalPages = (int) request.getAttribute("totalPages");

                for (Post p : posts) {
            %>
            <tr>
                <td><%= p.getTitle() %></td>
                <td><%= p.getCategory() %></td>
                <td><%= p.getAuthor() %></td>
                <td><%= p.getStatus() %></td>
                <td>
                    <a href="post/edit?id=<%= p.getId() %>">Edit</a> |
                    <a href="post/view?id=<%= p.getId() %>">View</a>
                </td>
            </tr>
            <% } %>
        </table>

        <!-- Phân trang -->
        <div>
            <%
                if (totalPages > 1) {
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.print("<strong>" + i + "</strong> ");
                        } else {
                            out.print("<a href='PostList?page=" + i + "'>" + i + "</a> ");
                        }
                    }
                }
            %>
        </div>

        <!-- Nút thêm bài viết -->
        <a href="post/add">Add New Post</a>
    </body>
</html>
