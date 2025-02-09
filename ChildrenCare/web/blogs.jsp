<%--
    Document   : blogs
    Created on : Feb 8, 2025, 10:03:12 AM
    Author     : dell
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.BlogDBContext" %>
<%@ page import="model.Post" %> 
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Doctris - Doctor Appointment Booking System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
    <!-- Css -->
    <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <link rel="stylesheet" href="assets/css/blog.css">
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

    <!-- Navbar STart -->
    <header id="topnav" class="defaultscroll sticky">
        <div class="container">
            <!-- Logo container-->
            <div>
                <a class="logo" href="index.jsp">
                    <span class="logo-light-mode">
                        <img src="assets/images/logo-dark.png" class="l-dark" height="24" alt="">
                        <img src="assets/images/logo-light.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
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
                <li class="list-inline-item mb-0">
                    <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                       aria-controls="offcanvasRight">
                        <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings"
                                                                           class="fea icon-sm"></i></div>
                    </a>
                </li>

                <li class="list-inline-item mb-0 ms-1">
                    <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas"
                       data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                        <i class="uil uil-search"></i>
                    </a>
                </li>

                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                src="assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle"
                                alt=""></button>
                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                             style="min-width: 200px;">
                            <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                <img src="assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow"
                                     alt="">
                                <div class="flex-1 ms-2">
                                    <span class="d-block mb-1">Calvin Carlo</span>
                                    <small class="text-muted">Orthopedic</small>
                                </div>
                            </a>
                            <a class="dropdown-item text-dark" href="doctor-dashboard.html"><span
                                    class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span>
                                Dashboard</a>
                            <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span
                                    class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span>
                                Profile Settings</a>
                            <div class="dropdown-divider border-top"></div>
                            <a class="dropdown-item text-dark" href="login.html"><span
                                    class="mb-0 d-inline-block me-1"><i
                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
            <!-- Start Dropdown -->

            <div id="navigation">
                <!-- Navigation Menu-->
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Home</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="index.jsp" class="sub-menu-item">Index One</a></li>
                            <li><a href="index-two.html" class="sub-menu-item">Index Two</a></li>
                            <li><a href="index-three.html" class="sub-menu-item">Index Three</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Doctors</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Dashboard </a><span
                                        class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="doctor-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                                    <li><a href="doctor-appointment.html" class="sub-menu-item">Appointment</a></li>
                                    <li><a href="patient-list.html" class="sub-menu-item">Patients</a></li>
                                    <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                    <li><a href="invoices.html" class="sub-menu-item">Invoices</a></li>
                                    <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                    <li><a href="doctor-messages.html" class="sub-menu-item">Messages</a></li>
                                    <li><a href="doctor-profile.html" class="sub-menu-item">Profile</a></li>
                                    <li><a href="doctor-profile-setting.html" class="sub-menu-item">Profile Settings</a></li>
                                    <li><a href="doctor-chat.html" class="sub-menu-item">Chat</a></li>
                                    <li><a href="login.html" class="sub-menu-item">Login</a></li>
                                    <li><a href="signup.html" class="sub-menu-item">Sign Up</a></li>
                                    <li><a href="forgot-password.html" class="sub-menu-item">Forgot Password</a></li>
                                </ul>
                            </li>
                            <li><a href="doctor-team-one.html" class="sub-menu-item">Doctors One</a></li>
                            <li><a href="doctor-team-two.html" class="sub-menu-item">Doctors Two</a></li>
                            <li><a href="doctor-team-three.html" class="sub-menu-item">Doctors Three</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Patients</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="patient-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                            <li><a href="patient-profile.html" class="sub-menu-item">Profile</a></li>
                            <li><a href="booking-appointment.html" class="sub-menu-item">Book Appointment</a></li>
                            <li><a href="patient-invoice.html" class="sub-menu-item">Invoice</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Pharmacy</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="pharmacy.html" class="sub-menu-item">Pharmacy</a></li>
                            <li><a href="pharmacy-shop.html" class="sub-menu-item">Shop</a></li>
                            <li><a href="pharmacy-product-detail.html" class="sub-menu-item">Medicine Detail</a></li>
                            <li><a href="pharmacy-shop-cart.html" class="sub-menu-item">Shop Cart</a></li>
                            <li><a href="pharmacy-checkout.html" class="sub-menu-item">Checkout</a></li>
                            <li><a href="pharmacy-account.html" class="sub-menu-item">Account</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span
                            class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="aboutus.html" class="sub-menu-item"> About Us</a></li>
                            <li><a href="departments.html" class="sub-menu-item">Departments</a></li>
                            <li><a href="faqs.html" class="sub-menu-item">FAQs</a></li>
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)" class="menu-item"> Blogs </a><span
                                        class="submenu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="/ChildrenCare/blog" class="sub-menu-item">Blogs</a></li>
                                    <li><a href="blog-detail.html" class="sub-menu-item">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="terms.html" class="sub-menu-item">Terms & Policy</a></li>
                            <li><a href="privacy.html" class="sub-menu-item">Privacy Policy</a></li>
                            <li><a href="error.html" class="sub-menu-item">404 !</a></li>
                            <li><a href="contact.html" class="sub-menu-item">Contact</a></li>
                        </ul>
                    </li>
                    <li><a href="../admin/index.jsp" class="sub-menu-item" target="_blank">Admin</a></li>
                </ul><!--end navigation menu-->
            </div><!--end navigation-->
        </div><!--end container-->
    </header><!--end header-->
    <!-- Navbar End -->

    <!-- Start Hero -->
    <section class="bg-half-170 d-table w-100" style="background: url('assets/images/bg/02.jpg') center center;">
        <div class="bg-overlay bg-overlay-dark"></div>
        <div class="container">
            <div class="row mt-5 justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center">
                        <h3 class="sub-title mb-4 text-white title-dark">Blogs & News</h3>
                        <p class="para-desc mx-auto text-white-50">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>

                        <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                            <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                <li class="breadcrumb-item"><a href="index.jsp">Doctris</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Blogs</li>
                            </ul>
                        </nav>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <div class="position-relative">
        <div class="shape overflow-hidden text-white">
            <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
            </svg>
        </div>
    </div>
    <!-- End Hero -->

    <!-- Start -->
 <!-- Start -->
<section class="section">
        <div class="container">
          
            <div class="row" id="blog-list">
                <c:choose>
                    <c:when test="${not empty blogs}">
                        <c:forEach var="blog" items="${blogs}">
                                    <div class="col-lg-4 col-md-6 col-12 mb-4 pb-2 blog-item">
    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
        <img src="./assets/images/blog/${blog.featuredImage}" class="img-fluid" alt="${blog.title}">
        <div class="card-body p-4">
            <ul class="list-unstyled mb-2">
                <li class="list-inline-item text-muted small me-3">
                    <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                    <fmt:formatDate value="${blog.createdAt}" pattern="yyyy-MM-dd" />
                </li>
            </ul>
            <a href="/ChildrenCare/blog?id=${blog.blogId}" class="text-dark title h5">${blog.title}</a>
            <p>${fn:substring(blog.content, 0, 150)}...</p>
            <a href="/ChildrenCare/blog?id=${blog.blogId}" class="btn btn-primary">Read More</a>
        </div>
    </div>
</div>

                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>No results found for "${param.search}".</p>
                    </c:otherwise>
                </c:choose>
            </div><!--end row-->

            <!-- Pagination -->
           <div class="row text-center">
    <div class="col-12">
        <ul class="pagination justify-content-center mb-0 list-unstyled" id="pagination">
            <!-- Các nút phân trang sẽ được tạo động bởi JavaScript -->
        </ul>
    </div><!--end col-->
</div><!--end row-->

        </div><!--end container-->
    </section><!--end section-->
    <!-- Start -->
    <footer class="bg-footer">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                    <a href="#" class="logo-footer">
                        <img src="assets/images/logo-light.png" height="22" alt="">
                    </a>
                    <p class="mt-4 me-xl-5">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                </div><!--end col-->

                <div class="col-xl-7 col-lg-8 col-md-12">
                    <div class="row">
                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Company</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> About us</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Services</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Blog</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Login</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Departments</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Eye Care</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Psychotherapy</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Dental Care</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Orthopedic</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Cardiology</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Gynecology</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Neurology</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Contact us</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li class="d-flex align-items-center">
                                    <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="mailto:contact@example.com" class="text-foot ms-2">contact@example.com</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="tel:+152534-468-854" class="text-foot ms-2">+152 534-468-854</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="javascript:void(0)" class="video-play-icon text-foot ms-2">View on Google map</a>
                                </li>
                            </ul>

                            <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="facebook" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></a></li>
                            </ul><!--end icon-->
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-5">
            <div class="pt-4 footer-bar">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="text-sm-start text-center">
                            <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="../../../index.jsp" target="_blank" class="text-reset">Shreethemes</a>.</p>
                        </div>
                    </div><!--end col-->

                    <div class="col-sm-6 mt-4 mt-sm-0">
                        <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                            <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Terms</a></li>
                            <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Privacy</a></li>
                            <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">About</a></li>
                            <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Contact</a></li>
                        </ul>
                    </div><!--end col-->
                </div><!--end row-->
            </div>
        </div><!--end container-->
    </footer><!--end footer-->
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
                            <h4>Search now.....</h4>
                            <div class="subcribe-form mt-4">
                                   <form action="/ChildrenCare/search" method="GET">
                                    <div class="mb-0">
                                        <input type="text" id="search-term" name="search" class="border bg-white rounded-pill" required="" placeholder="Search">
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
                <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
                <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
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
                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                <li class="d-grid"><a href="../admin/index.jsp" target="_blank" class="mt-4"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
                <li class="list-inline-item mb-0"><a href="../../../index.jsp" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
            </ul><!--end icon-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- javascript -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="assets/js/app.js"></script>
    <script>   
let currentPage = 1;
let itemsPerPage = 6; // Số lượng bài viết hiển thị mỗi trang
let blogs = document.querySelectorAll('.blog-item');
let totalPages = Math.ceil(blogs.length / itemsPerPage);

// Hàm hiển thị các blog theo phân trang
function displayBlogs() {
    const start = (currentPage - 1) * itemsPerPage;
    const end = Math.min(start + itemsPerPage, blogs.length);

    blogs.forEach(blog => blog.style.display = 'none'); // Ẩn tất cả bài viết

    // Hiển thị các bài viết của trang hiện tại
    for (let i = start; i < end; i++) {
        if (blogs[i]) {
            blogs[i].style.display = 'block';
        }
    }
}

// Hàm cập nhật phân trang
function updatePagination() {
    const paginationContainer = document.getElementById('pagination');
    paginationContainer.innerHTML = '';  // Xóa nội dung cũ của phân trang

    // Nút Previous
    const prevLi = document.createElement('li');
    prevLi.className = 'page-item' + (currentPage === 1 ? ' disabled' : '');
    prevLi.innerHTML = `<a class="page-link" href="javascript:void(0)" onclick="changePage('prev')">Prev</a>`;
    paginationContainer.appendChild(prevLi);

    // Tạo các số trang
    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = 'page-item' + (i === currentPage ? ' active' : '');
        li.innerHTML = `<a class="page-link" href="javascript:void(0)" onclick="changePage(${i})">${i}</a>`;
        paginationContainer.appendChild(li);
    }

    // Nút Next
    const nextLi = document.createElement('li');
    nextLi.className = 'page-item' + (currentPage === totalPages ? ' disabled' : '');
    nextLi.innerHTML = `<a class="page-link" href="javascript:void(0)" onclick="changePage('next')">Next</a>`;
    paginationContainer.appendChild(nextLi);
}

// Hàm xử lý chuyển trang
function changePage(page) {
    if (page === 'prev' && currentPage > 1) {
        currentPage--;
    } else if (page === 'next' && currentPage < totalPages) {
        currentPage++;
    } else if (typeof page === 'number' && page >= 1 && page <= totalPages) {
        currentPage = page;
    }

    displayBlogs();  // Cập nhật lại danh sách các blog
    updatePagination();  // Cập nhật lại phân trang
}

document.addEventListener('DOMContentLoaded', function() {
    blogs = document.querySelectorAll('.blog-item');  // Cập nhật lại danh sách blogs khi DOM đã tải xong
    totalPages = Math.ceil(blogs.length / itemsPerPage); // Cập nhật tổng số trang
    if (blogs.length > 0) {
        displayBlogs();  // Hiển thị các bài viết ban đầu
        updatePagination();  // Cập nhật phân trang ban đầu
    }
});

// Xử lý form tìm kiếm
document.getElementById('search-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Ngăn chặn form submit mặc định

    let searchTerm = document.getElementById('search-term').value;

    // Gửi yêu cầu AJAX đến server (ví dụ: SearchServlet)
    fetch('/ChildrenCare/search?search=' + searchTerm)
        .then(response => response.text()) // hoặc .json() nếu trả về JSON
        .then(data => {
            // Cập nhật phần tử HTML để hiển thị kết quả
            document.getElementById('blog-list').innerHTML = data; // Thay thế nội dung hiện tại bằng kết quả từ server

            // Cập nhật lại danh sách các blog sau khi thay đổi dữ liệu
            blogs = document.querySelectorAll('.blog-item');
            totalPages = Math.ceil(blogs.length / itemsPerPage); // Cập nhật lại tổng số trang
            currentPage = 1; // Reset trang về 1 sau khi tìm kiếm

            displayBlogs();  // Hiển thị các bài viết của trang đầu tiên
            updatePagination();  // Cập nhật lại phân trang
        })
        .catch(error => {
            console.error('Error:', error);
        });
});

</script>
    
<form id="search-form">
        <div class="mb-0">
            <input type="text" id="search-term" name="search" class="border bg-white rounded-pill" required="" placeholder="Search">
            <button type="submit" class="btn btn-pills btn-primary">Search</button>
        </div>
    </form>

<script>
    document.getElementById('search-form').addEventListener('submit', function(event) {
        event.preventDefault(); // Ngăn chặn form submit mặc định

        let searchTerm = document.getElementById('search-term').value;

        // Gửi yêu cầu AJAX đến server (ví dụ: SearchServlet)
        fetch('/ChildrenCare/search?search=' + searchTerm)
            .then(response => response.text()) // hoặc .json() nếu trả về JSON
            .then(data => {
                // Cập nhật phần tử HTML để hiển thị kết quả
                document.getElementById('blog-list').innerHTML = data; // Thay thế nội dung hiện tại bằng kết quả từ server
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });
</script>   
</body>

</html>