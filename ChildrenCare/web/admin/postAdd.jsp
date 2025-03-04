<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            .search-bar .menu-search form {
                position: relative;
                padding: 0px;
            }
            /* Form Styling */
            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                background: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: auto;
            }

            form label {
                font-weight: bold;
            }

            form input,
            form select,
            form textarea {
                padding: 10px;
                border: 1px solid #556ee6;
                border-radius: 5px;
                font-size: 14px;
                width: 100%;
            }

            form button {
                background: #556ee6;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
            }

            form button:hover {
                background: #4455c9;
            }

            /* Back Button */
            .back-btn {
                display: block;
                width: max-content;
                margin: 20px auto;
                padding: 10px 15px;
                background: #6c757d;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 14px;
                text-align: center;
                transition: background 0.3s;
            }

            .back-btn:hover {
                background: white;
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
                                                <a class="dropdown-item text-dark" href="./profile">
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
                                        <li class="breadcrumb-item active" aria-current="page">Posts</li>
                                    </ul>
                                </nav>
                            </div>


                        </div>
                        <div class="container">
                            <h2>Add New Post</h2>

                            <form method="POST" action="post-add" enctype="multipart/form-data">
                                <label>Title:</label>
                                <input type="text" name="title" required>

                                <label>Content:</label>
                                <textarea name="content" required></textarea>

                                <label>Category:</label>
                                <select name="category">
                                    <% List<String> categories = (List<String>) request.getAttribute("categories");
           for (String category : categories) { %>
                                    <option value="<%= category %>"><%= category %></option>
                                    <% } %>
                                </select>

                                <label>Status:</label>
                                <select name="status">
                                    <option value="1">Active</option>
                                    <option value="0">Hidden</option>
                                </select>

                                <label>Upload Image:</label>
                                <input type="file" name="imageFile" accept="image/*">

                                <label>Author:</label>
                                <select name="author">
                                    <% 
                                        List<String[]> authors = (List<String[]>) request.getAttribute("authors"); 
                                        if (authors == null || authors.isEmpty()) { 
                                    %>
                                    <option value="">No authors available</option>
                                    <% 
                                        } else { 
                                            for (String[] author : authors) { 
                                    %>
                                    <option value="<%= author[0] %>"><%= author[1] %></option>
                                    <% 
                                            }
                                        } 
                                    %>
                                </select>

                                <% String error = request.getParameter("error"); %>
                                <% if (error != null) { %>
                                <p style="color: red;">
                                    <% if ("missing_author".equals(error)) { %>
                                    Please select an author.
                                    <% } else if ("invalid_author".equals(error)) { %>
                                    Invalid author selection.
                                    <% } %>
                                </p>
                                <% } %>

                                <button type="submit">Add Post</button>
                            </form>


                            <a href="post-list" class="back-btn">Back to Post List</a>
                        </div>
                        <!-- Footer Start -->

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

