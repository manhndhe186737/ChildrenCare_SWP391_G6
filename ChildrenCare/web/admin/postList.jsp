<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, model.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <meta charset="utf-8" />
            <title>Children Care - Service Booking System</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
            <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
            <meta name="author" content="Shreethemes" />
            <meta name="email" content="support@shreethemes.in" />
            <meta name="website" content="./././index.html" />
            <meta name="Version" content="v1.2.0" />
            <!-- favicon -->
            <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
            <!-- Bootstrap -->
            <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
            <!-- simplebar -->
            <link href="./assets/css/simplebar.css" rel="stylesheet" type="text/css" />
            <!-- Icons -->
            <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
            <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
            <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
            <!-- Css -->
            <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
            <style>
                /* General Styles */
                body {
                    font-family: 'Inter', sans-serif;
                    background-color: #f8f9fa;
                }

                /* Table Styling */
                table {
                    width: 100%;
                    border-collapse: collapse;
                    background: #fff;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                table th, table td {
                    padding: 12px 15px;
                    text-align: left;
                    border-bottom: 1px solid #ddd;
                }

                table th {
                    background: #556ee6;
                    color: #fff;
                    font-weight: 600;
                }

                table tr:hover {
                    background-color: #eef2ff;
                }

                table img {
                    border-radius: 5px;
                }

                /* Form Styling */
                form {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 10px;
                    align-items: center;
                    margin-bottom: 20px;
                }

                form input,
                form select,
                form button {
                    padding: 8px 12px;
                    border: 1px solid #556ee6;
                    border-radius: 5px;
                    font-size: 14px;
                }

                form button {
                    background: #556ee6;
                    color: white;
                    cursor: pointer;
                    border: none;
                }

                form button:hover {
                    background: #4455c9;
                }

                /* Action Buttons */
                .btn {
                    padding: 6px 12px;
                    border-radius: 5px;
                    text-decoration: none;
                    font-size: 14px;
                    transition: 0.3s;
                    display: inline-block;
                    text-align: center;
                }

                .btn-view {
                    background: #556ee6;
                    color: #fff;
                }

                .btn-edit {
                    background: #ffc107;
                    color: #fff;
                }

                .btn-hide {
                    background: #dc3545;
                    color: #fff;
                }

                .btn-show {
                    background: #28a745;
                    color: #fff;
                }

                .btn-add {
                    display: block;
                    width: max-content;
                    background: #556ee6;
                    color: white;
                    margin : 20px auto 5px auto;
                    padding: 12px 18px;
                    font-size: 16px;
                    font-weight: 600;
                    border-radius: 6px;
                    text-transform: uppercase;
                    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                    transition: background 0.3s, box-shadow 0.3s;
                    text-align: center;
                }

                .btn-add:hover {
                    background: #4455c9;
                    box-shadow: 0px 6px 8px rgba(0, 0, 0, 0.15);
                }

                /* Pagination */
                .pagination {
                    margin-bottom: 20px !important;
                    display: flex;
                    justify-content: end;
                    list-style: none;
                    padding: 0;
                }

                .pagination .page-item {
                    margin: 0 5px;
                }

                .pagination .page-link {
                    padding: 8px 12px;
                    border-radius: 5px;
                    background: #eef2ff;
                    text-decoration: none;
                    color: #556ee6;
                    border: none;
                    transition: background 0.3s;
                }

                .pagination .page-link:hover {
                    background: #556ee6;
                    color: white;
                }

                .pagination .active .page-link {
                    background: #556ee6;
                    color: white;
                }


            </style>


        </head>

        <body>
            <!-- Loader -->
            <div id="preloader">
                <div id="status">
                    <div class="spinner">
                        <div class="double-bounce1"></div>
                        <div class="double-bounce2"></div>
                    </div>
                </div>
            </div>
            <!-- Loader -->

            <div class="page-wrapper doctris-theme">
                <nav id="sidebar" class="sidebar-wrapper">
                    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                        <div class="sidebar-brand">
                            <a href="index.html">
                                <img src="./assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                <img src="./assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                            </a>
                        </div>


                        <!-- sidebar-menu  -->
                    </div>
                    <!-- sidebar-content  -->
                    <ul class="sidebar-footer list-unstyled mb-0">
                        <li class="list-inline-item mb-0 ms-1">
                            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                                <i class="uil uil-comment icons"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- sidebar-wrapper  -->

                <!-- Start Page Content -->
                <main class="page-content bg-light">
                    <div class="top-header">
                        <div class="header-bar d-flex justify-content-between border-bottom">
                            <div class="d-flex align-items-center">
                                <a href="#" class="logo-icon">
                                    <img src="./assets/images/logo-icon.png" height="30" class="small" alt="">
                                    <span class="big">
                                        <img src="./assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                        <img src="./assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                    </span>
                                </a>
                                <div class="sidebar-brand">
                                    <a href="./c/home">
                                        <!--<a href="index.html">-->
                                        <img src="./assets/images/logo-icon-child.png" height="24" class="logo-light-mode" alt="">
                                    </a>
                                </div>

                            </div>

                            <ul class="list-unstyled mb-0">
                                <li class="list-inline-item mb-0">
                                    <div class="dropdown dropdown-primary">
                                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="./assets/images/language/american.png" class="avatar avatar-ex-small rounded-circle p-2" alt=""></button>
                                        <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2" data-simplebar style="height: 175px;">
                                            <a href="javascript:void(0)" class="d-flex align-items-center">
                                                <img src="./assets/images/language/chinese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                <div class="flex-1 text-left ms-2 overflow-hidden">
                                                    <small class="text-dark mb-0">Chinese</small>
                                                </div>
                                            </a>

                                            <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                <img src="./assets/images/language/european.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                <div class="flex-1 text-left ms-2 overflow-hidden">
                                                    <small class="text-dark mb-0">European</small>
                                                </div>
                                            </a>

                                            <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                <img src="./assets/images/language/indian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                <div class="flex-1 text-left ms-2 overflow-hidden">
                                                    <small class="text-dark mb-0">Indian</small>
                                                </div>
                                            </a>

                                            <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                <img src="./assets/images/language/japanese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                <div class="flex-1 text-left ms-2 overflow-hidden">
                                                    <small class="text-dark mb-0">Japanese</small>
                                                </div>
                                            </a>

                                            <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                                <img src="./assets/images/language/russian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                                <div class="flex-1 text-left ms-2 overflow-hidden">
                                                    <small class="text-dark mb-0">Russian</small>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </li>

                                <li class="list-inline-item mb-0 ms-1">
                                    <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                        <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                                    </a>
                                </li>

                                <li class="list-inline-item mb-0 ms-1">
                                    <div class="dropdown dropdown-primary">
                                        <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="mail" class="fea icon-sm"></i></button>
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">4 <span class="visually-hidden">unread mail</span></span>

                                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2" data-simplebar style="height: 320px; width: 300px;">
                                            <a href="#" class="d-flex align-items-center justify-content-between py-2">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Janalia</b> <small class="text-muted fw-normal d-inline-block">1 hour ago</small></small>
                                                </div>
                                            </a>

                                            <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/Codepen.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>codepen</b>  <small class="text-muted fw-normal d-inline-block">4 hour ago</small></small>
                                                </div>
                                            </a>

                                            <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Cristina</b> <small class="text-muted fw-normal d-inline-block">5 hour ago</small></small>
                                                </div>
                                            </a>

                                            <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/dribbble.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Dribbble</b> <small class="text-muted fw-normal d-inline-block">24 hour ago</small></small>
                                                </div>
                                            </a>

                                            <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Donald Aghori</b> <small class="text-muted fw-normal d-inline-block">1 day ago</small></small>
                                                </div>
                                            </a>

                                            <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                                <div class="d-inline-flex position-relative overflow-hidden">
                                                    <img src="./assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Calvin</b> <small class="text-muted fw-normal d-inline-block">2 day ago</small></small>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </li>

                                <li class="list-inline-item mb-0 ms-1">
                                    <c:choose>
                                        <c:when test="${sessionScope.user ne null}">
                                            <div class="dropdown dropdown-primary">
                                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <img src="./assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                                </button>
                                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                    <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                                        <img src="./assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="flex-1 ms-2">
                                                            <span class="d-block mb-1">${sessionScope.user.fullname}</span>
                                                        </div>
                                                    </a>
                                                    <c:if test="${sessionScope.role.contains('Admin')}">
                                                        <a class="dropdown-item text-dark" href="doctor-dashboard.html">
                                                            <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                                        </a>
                                                    </c:if>
                                                    <a class="dropdown-item text-dark" href="doctor-profile-setting.html">
                                                        <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                                    </a>
                                                    <div class="dropdown-divider border-top"></div>
                                                    <a class="dropdown-item text-dark" href="logout">
                                                        <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                                    </a>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="login" class="btn btn-soft-primary btn-sm">
                                                <i class="uil uil-user-circle align-middle h5 me-1"></i> Login
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between">
                                <div>

                                    <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                                        <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                            <li class="breadcrumb-item"><a href="index.html">Children Care</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Post</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>

                            <h2>Post List</h2>

                            <!-- Bộ lọc -->
                            <form method="GET" action="post-list">
                                <input type="text" name="search" placeholder="Search by title" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

                                <!-- Lọc theo category (Tải từ database) -->
                                <select name="category">
                                    <option value="">All Categories</option>
                                    <% 
                                        List<String> categories = (List<String>) request.getAttribute("categories");
                                        String selectedCategory = request.getParameter("category");
                                    %>
                                    <% for (String category : categories) { %>
                                    <option value="<%= category %>" <%= (selectedCategory != null && selectedCategory.equals(category)) ? "selected" : "" %>>
                                        <%= category %>
                                    </option>
                                    <% } %>
                                </select>

                                <!-- Lọc theo author (Tải từ database) -->
                                <select name="author">
                                    <option value="">All Authors</option>
                                    <% 
                                        List<String[]> authors = (List<String[]>) request.getAttribute("authors");
                                        String selectedAuthor = request.getParameter("author");
                                    %>
                                    <% for (String[] author : authors) { %>
                                    <option value="<%= author[0] %>" <%= (selectedAuthor != null && selectedAuthor.equals(author[0])) ? "selected" : "" %>>
                                        <%= author[1] %>
                                    </option>
                                    <% } %>
                                </select>

                                <select name="status">
                                    <option value="">All Status</option>
                                    <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Active</option>
                                    <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Inactive</option>
                                </select>
                                <select name="sortBy">
                                    <option value="title" <%= "title".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Title</option>
                                    <option value="category" <%= "category".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Category</option>
                                    <option value="author_name" <%= "author_name".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Author</option>
                                    <option value="status" <%= "status".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Status</option>
                                </select>

                                <button type="submit" name="order" value="<%= "ASC".equals(request.getParameter("order")) ? "DESC" : "ASC" %>">
                                    Order: <%= "ASC".equals(request.getParameter("order")) ? "Descending" : "Ascending" %>
                                </button>

                                <button type="submit">Filter</button>
                            </form>


                            <!-- Danh sách bài viết -->
                            <table border="1">
                                <tr>
                                    <th>ID</th>
                                    <th>Thumbnail</th>
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
                                    <td><%= p.getId() %></td>
                                    <td><img src="<%= p.getImg() %>" width="50"></td>
                                    <td><%= p.getTitle() %></td>
                                    <td><%= p.getCategory() %></td>
                                    <td><%= p.getAuthor() %></td>
                                    <td><%= p.getStatus().equals("1") ? "Active" : "Hidden" %></td>
                                    <td>
                                        <a href="post-view?id=<%= p.getId() %>" class="btn btn-view">View</a>
                                        <a href="post-edit?id=<%= p.getId() %>" class="btn btn-edit">Edit</a>

                                        <form method="POST" action="post-list" style="display:inline;">
                                            <input type="hidden" name="postId" value="<%= p.getId() %>">
                                            <input type="hidden" name="action" value="<%= p.getStatus().equals("1") ? "hide" : "show" %>">
                                            <button type="submit" class="btn <%= p.getStatus().equals("1") ? "btn-hide" : "btn-show" %>">
                                                <%= p.getStatus().equals("1") ? "Hide" : "Show" %>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>
                            </table>
                            <!-- Nút thêm bài viết -->
                            <a href="post-add" class="btn btn-add">Add New Post</a>
                            <!-- Phân trang -->
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <ul class="pagination justify-content-end mb-0 list-unstyled">
                                        <% if (currentPage > 1) { %>
                                        <li class="page-item">
                                            <a class="page-link" href="post-list?page=<%= currentPage - 1 %>" aria-label="Previous">Prev</a>
                                        </li>
                                        <% } %>

                                        <% for (int i = 1; i <= totalPages; i++) { %>
                                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                                            <a class="page-link" href="post-list?page=<%= i %>"><%= i %></a>
                                        </li>
                                        <% } %>

                                        <% if (currentPage < totalPages) { %>
                                        <li class="page-item">
                                            <a class="page-link" href="post-list?page=<%= currentPage + 1 %>" aria-label="Next">Next</a>
                                        </li>
                                        <% } %>
                                    </ul>
                                </div>
                            </div>




                            <!-- Footer Start -->
                            <footer class="bg-white shadow py-3">
                                <div class="container-fluid">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-sm-start text-center">

                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </div><!--end container-->
                            </footer><!--end footer-->
                            <!-- End -->
                            </main>
                            <!--End page-content" -->
                        </div>
                        <!-- page-wrapper -->

                        <!-- Offcanvas Start -->
                        <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                            <div class="offcanvas-header p-4 border-bottom">
                                <h5 id="offcanvasRightLabel" class="mb-0">
                                    <img src="./assets/images/logo-dark.png" height="24" class="light-version" alt="">
                                    <img src="./assets/images/logo-light.png" height="24" class="dark-version" alt="">
                                </h5>
                                <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
                            </div>
                            <div class="offcanvas-body p-4 px-md-5">
                                <div class="row">
                                    <div class="col-12">
                                        <!-- Style switcher -->
                                        <div id="style-switcher">
                                            <div>
                                                <ul class="text-center list-unstyled mb-0">
                                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="./assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="./assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                    <li class="d-grid"><a href="./landing/index.html" target="_blank" class="mt-4"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- end Style switcher -->
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div>

                            <div class="offcanvas-footer p-4 border-top text-center">
                                <ul class="list-unstyled social-icon mb-0">
                                    <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="./././index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                                </ul><!--end icon-->
                            </div>
                        </div>
                        <!-- Offcanvas End -->

                        <!-- Start Modal -->
                        <div class="modal fade" id="newblogadd" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom p-3">
                                        <h5 class="modal-title" id="exampleModalLabel">Add Blog</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>

                                    <div class="modal-body p-3 pt-4">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="d-grid">
                                                    <p class="text-muted">Upload your blog image here, Please click "Upload Image" Button.</p>
                                                    <div class="preview-box d-block justify-content-center rounded shadow overflow-hidden bg-light p-1"></div>
                                                    <input type="file" id="input-file" name="input-file" accept="image/*" onchange={
                                                           handleChange()} hidden />
                                                    <label class="btn-upload btn btn-primary mt-4" for="input-file">Upload Image</label>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-8 mt-4 mt-sm-0">
                                                <div class="ms-md-4">
                                                    <form>
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Blog Title <span class="text-danger">*</span></label>
                                                                    <input name="name" id="name" type="text" class="form-control" placeholder="Title :">
                                                                </div>
                                                            </div><!--end col-->

                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label"> Date : </label>
                                                                    <input name="date" type="text" class="form-control" id="date" value="09 January 2021">
                                                                </div>
                                                            </div><!--end col-->

                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label"> Time to read : </label>
                                                                    <input name="time" type="text" class="form-control" id="time" value="5 min read">
                                                                </div>
                                                            </div><!--end col-->

                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tag</label>
                                                                    <select class="form-control">
                                                                        <option value="EY">Eye Care</option>
                                                                        <option value="GY">Gynecologist</option>
                                                                        <option value="PS">Psychotherapist</option>
                                                                        <option value="OR">Orthopedic</option>
                                                                        <option value="DE">Dentist</option>
                                                                        <option value="GA">Gastrologist</option>
                                                                        <option value="UR">Urologist</option>
                                                                        <option value="NE">Neurologist</option>
                                                                    </select>
                                                                </div>
                                                            </div><!--end col-->

                                                            <div class="col-lg-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Description <span class="text-danger">*</span></label>
                                                                    <textarea name="comments" id="comments" rows="4" class="form-control" placeholder="Blog description :"></textarea>
                                                                </div>
                                                            </div><!--end col-->

                                                            <div class="col-lg-12 text-end">
                                                                <button type="submit" class="btn btn-primary">Add Blog</button>
                                                            </div><!--end col-->
                                                        </div>
                                                    </form>
                                                </div>
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End modal -->

                        <!-- javascript -->
                        <script src="./assets/js/bootstrap.bundle.min.js"></script>
                        <!-- simplebar -->
                        <script src="./assets/js/simplebar.min.js"></script>
                        <!-- Icons -->
                        <script src="./assets/js/feather.min.js"></script>
                        <!-- Main Js -->
                        <script src="./assets/js/app.js"></script>

                        <script>
                                                        const handleChange = () => {
                                                            const fileUploader = document.querySelector('#input-file');
                                                            const getFile = fileUploader.files
                                                            if (getFile.length !== 0) {
                                                                const uploadedFile = getFile[0];
                                                                readFile(uploadedFile);
                                                            }
                                                        }

                                                        const readFile = (uploadedFile) => {
                                                            if (uploadedFile) {
                                                                const reader = new FileReader();
                                                                reader.onload = () => {
                                                                    const parent = document.querySelector('.preview-box');
                                                                    parent.innerHTML = `<img class="preview-content" src=${reader.result} />`;
                                                                };

                                                                reader.readAsDataURL(uploadedFile);
                                                            }
                                                        };
                        </script>
                        </body>


                        </html>
