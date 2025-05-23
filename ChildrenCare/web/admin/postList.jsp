<%-- 
    Document   : staff
    Created on : Feb 8, 2025, 8:39:43 AM
    Author     : FPTSHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post" %>
<%@ page import="java.util.List, model.Post, model.PostCategory, java.util.ArrayList" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Children Service Booking System</title>
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
        <!-- Select2 -->
        <link href="./assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="./assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8f9fa;

            }
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            .page-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }



            .bg-footer {
                margin-top: auto;
            }



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

            .container-fluid {
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
                padding-left: 20px;
                padding-right: 20px;
            }

            .layout-specing {
                margin-left: 0;
                margin-right: 0;
                padding: 20px;
            }

            table {
                width: 100%;
                margin: 0 auto;
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
                        <header id="topnav" class="defaultscroll sticky">
                            <div class="container">
                                <!-- Logo container-->
                                <div>
                                    <a class="logo" href="./c/home">
                                        <span class="logo-light-mode">
                                            <img src="./assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                                            <img src="./assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                                        </span>
                                        <img src="./assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
                                    </a>
                                </div>
                                <!-- End Logo container-->

                                <!-- Start Mobile Toggle -->
                                <div class="menu-extras">
                                    <div class="menu-item">
                                        <!-- Mobile menu toggle-->
                                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                                            <div class="lines">
                                                <span></span>
                                                <span></span>
                                                <span></span>
                                            </div>
                                        </a>
                                        <!-- End mobile menu toggle-->
                                    </div>
                                </div>
                                <!-- End Mobile Toggle -->

                                <!-- Start Dropdown -->
                                <ul class="dropdowns list-inline mb-0">
                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                        <li class="list-inline-item mb-0">
                                            <a href="c/Cart">
                                                <div class="btn btn-icon btn-pills btn-primary"><i data-feather="heart" class="fea icon-sm"></i></div>
                                            </a>
                                        </li>
                                    </c:if>

                                    <li class="list-inline-item mb-0 ms-1">
                                        <c:choose>
                                            <c:when test="${sessionScope.user ne null}">
                                                <div class="dropdown dropdown-primary">
                                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                                    </button>
                                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                        <a class="dropdown-item d-flex align-items-center text-dark">
                                                            <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                            <div class="flex-1 ms-2">
                                                                <span class="d-block mb-1">${sessionScope.user.fullname}</span>
                                                            </div>
                                                        </a>
                                                        <c:if test="${sessionScope.role.contains('Admin')}">
                                                            <a class="dropdown-item text-dark" href="admin/dashboard">
                                                                <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                                            </a>
                                                        </c:if>
                                                        <a class="dropdown-item text-dark" href="./profile">
                                                            <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                                        </a>
                                                        <div class="dropdown-divider border-top"></div>
                                                        <a class="dropdown-item text-dark" href="./logout">
                                                            <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="./login" class="btn btn-soft-primary btn-sm">
                                                    <i class="uil uil-user-circle align-middle h5 me-1"></i> Login
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                                <!-- Start Dropdown -->

                                <div id="navigation">
                                    <!-- Navigation Menu-->   
                                    <ul class="navigation-menu nav-left nav-dark">

                                        <li class="has-submenu parent-parent-menu-item">
                                            <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li class="has-submenu parent-menu-item">
                                                    <c:if test="${sessionScope.role.contains('Staffs')}">
                                                    <li><a href="doctor-appointment.html" class="sub-menu-item">Reservation</a></li>


                                                </c:if>

                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-menu-item">
                                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li><a href="./service-list" class="sub-menu-item">Services List</a></li>
                                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                                    <li><a href="./myreservation" class="sub-menu-item">My Reservation</a></li>
                                                    <li><a href="c/BookingStaff" class="sub-menu-item">Reservation</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li class="has-submenu parent-menu-item">
                                                <li><a href="./blog" class="sub-menu-item">Blogs</a></li>

                                                <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                                    <li><a href="./post-list" class="sub-menu-item">Posts - Management</a></li>
                                                    <li><a href="./slider" class="sub-menu-item">Sliders - Management</a></li>
                                                    <li><a href="./feedbacklist" class="sub-menu-item">Feedback - Management</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>
                                        <c:if test="${sessionScope.role.contains('Admin')}">
                                            <li><a href="./admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                                            </c:if>

                                    </ul><!--end navigation menu-->
                                </div><!--end navigation-->
                            </div><!--end container-->
                        </header><!--end header-->
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

                        <!-- Bộ lọc đã được cập nhật -->
                        <form method="GET" action="post-list">
                            <input type="text" name="search" placeholder="Search by title" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

                            <!-- Lọc theo categoryId (Tải từ database) -->
                            <select name="categoryId">
                                <option value="">All Categories</option>
                                <% 
                                    ArrayList<PostCategory> categories = (ArrayList<PostCategory>) request.getAttribute("categories");
                                    String selectedCategoryId = request.getParameter("categoryId");
                                %>
                                <% for (PostCategory category : categories) { %>
                                <option value="<%= category.getId() %>" <%= (selectedCategoryId != null && selectedCategoryId.equals(String.valueOf(category.getId()))) ? "selected" : "" %>>
                                    <%= category.getName() %>
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
                                <option value="p.title" <%= "p.title".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Title</option>
                                <option value="category_name" <%= "category_name".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Category</option>
                                <option value="author_name" <%= "author_name".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Author</option>
                                <option value="p.status" <%= "p.status".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Status</option>
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
                                <td><%= p.getCategoryName() %></td>
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
                    </div>
                </div>
                                
                        <!-- Start -->
                        <footer class="bg-footer">
                            <div class="container">
                                <div class="row">
                                    <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                                        <a class="logo-footer">
                                        </a>
                                        <p class="mt-4 me-xl-5">
                                            We are committed to providing the best healthcare services for children, ensuring their overall development and optimal health.
                                        </p>
                                    </div>

                                    <div class="col-xl-7 col-lg-8 col-md-12">
                                        <div class="row">
                                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                                <h5 class="text-light title-dark footer-head">About Us</h5>
                                                <ul class="list-unstyled footer-list mt-4">
                                                    <li>Our Mission</li>
                                                    <li>Our Team</li>
                                                    <li>Our Services</li>
                                                    <li>Success Stories</li>
                                                    <li>Blog & Updates</li>
                                                </ul>
                                            </div>

                                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                                <h5 class="text-light title-dark footer-head">Healthcare Services</h5>
                                                <ul class="list-unstyled footer-list mt-4">
                                                    <li>Quick Haircut</li>
                                                    <li>Massage</li>
                                                    <li>Babysitting</li>
                                                    <li>Special Skin Treatment</li>
                                                    <li>Physical Therapy</li>
                                                </ul>
                                            </div>

                                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                                <h5 class="text-light title-dark footer-head">Contact Us</h5>
                                                <ul class="list-unstyled footer-list mt-4">
                                                    <li class="d-flex align-items-center">
                                                        <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                                        <span class="text-foot ms-2">contact@childrencare.com</span>
                                                    </li>

                                                    <li class="d-flex align-items-center">
                                                        <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                                        <span class="text-foot ms-2">+1 234 567 890</span>
                                                    </li>

                                                    <li class="d-flex align-items-center">
                                                        <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                                        <span class="video-play-icon text-foot ms-2">Find us on the map</span>
                                                    </li>
                                                </ul>

                                                <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                                    <li class="list-inline-item"><span class="rounded-pill"><i data-feather="facebook" class="fea icon-sm fea-social"></i></span></li>
                                                    <li class="list-inline-item"><span class="rounded-pill"><i data-feather="instagram" class="fea icon-sm fea-social"></i></span></li>
                                                    <li class="list-inline-item"><span class="rounded-pill"><i data-feather="twitter" class="fea icon-sm fea-social"></i></span></li>
                                                    <li class="list-inline-item"><span class="rounded-pill"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></span></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container mt-5">
                                <div class="pt-4 footer-bar">
                                    <div class="row align-items-center">
                                        <div class="col-sm-6">
                                            <div class="text-sm-start text-center">
                                                <p class="text-foot mb-0">© 2025 Children Care. All Rights Reserved.</p>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 mt-4 mt-sm-0">
                                            <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                                                <li class="list-inline-item">Terms</li>
                                                <li class="list-inline-item">Privacy</li>
                                                <li class="list-inline-item">About</li>
                                                <li class="list-inline-item">Contact</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </footer>
                        <!-- End -->

                        <!-- Back to top -->
                        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
                        <!-- Back to top -->

                        <!-- Offcanvas Start -->
                        <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
                            <div class="offcanvas-body d-flex align-items-center align-items-center">
                                <div class="container">
                                    <div class="row">
                                        <div class="col">
                                            <div class="text-center">
                                                <h4>Search now...</h4>
                                                <div class="subcribe-form mt-4">
                                                    <form>
                                                        <div class="mb-0">
                                                            <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                                            <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </div><!--end container-->
                            </div>
                        </div>
                        <!-- Offcanvas End -->

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
                                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="./assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="./assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                    <li class="d-grid"><a href="./admin/index.html" target="_blank" class="mt-4"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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

                        <!-- javascript -->
                        <script src="./assets/js/bootstrap.bundle.min.js"></script>
                        <!-- SLIDER -->
                        <script src="./assets/js/tiny-slider.js"></script>
                        <script src="./assets/js/tiny-slider-init.js"></script>
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
