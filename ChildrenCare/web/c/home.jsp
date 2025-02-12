<%-- 
    Document   : home
    Created on : Feb 8, 2025, 12:43:38 PM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- SLIDER -->
        <link rel="stylesheet" href="../assets/css/tiny-slider.css"/>
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- Post btn -->
        <!-- Thêm Font Awesome từ CDN -->
        <!-- Thêm Font Awesome từ CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

        <style>
            /* Cập nhật cho nút Prev và Next */
            .tns-prev, .tns-next {
                background-color: rgba(0, 0, 0, 0.5);  /* Nền mờ */
                color: white;
                border: none;
                border-radius: 50%;
                font-size: 24px;
                padding: 10px;
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                z-index: 10;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .tns-prev {
                left: 10px;
            }

            .tns-next {
                right: 10px;
            }

            /* Thêm hiệu ứng hover */
            .tns-prev:hover, .tns-next:hover {
                background-color: rgba(0, 0, 0, 0.7);
            }

            /* Cập nhật icon mũi tên từ Font Awesome */
            .tns-prev:before {
                content: "\f104";  /* Mũi tên trái FontAwesome */
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;  /* Đảm bảo sử dụng icon Bold */
            }

            .tns-next:before {
                content: "\f105";  /* Mũi tên phải FontAwesome */
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;  /* Đảm bảo sử dụng icon Bold */
            }

            /* Cập nhật cho card */
            .card-body {
                height: 300px; /* Cố định chiều cao */
                overflow: hidden; /* Ẩn nội dung tràn ra ngoài */
                display: flex;
                flex-direction: column;
            }

            .card-body img {
                max-height: 150px; /* Giới hạn chiều cao hình ảnh */
                object-fit: cover; /* Đảm bảo hình ảnh không bị bóp méo */
            }

            .card-body .title {
                font-size: 18px;
                font-weight: bold;
                margin-top: 10px;
            }

            .card-body p {
                flex-grow: 1;
                font-size: 14px;
                color: #666;
                overflow: hidden; /* Ẩn phần text bị tràn */
                text-overflow: ellipsis; /* Hiển thị "..." nếu nội dung quá dài */
                white-space: nowrap; /* Ngừng xuống dòng */
            }

            .card-body .link {
                font-size: 14px;
                color: #007bff;
                text-decoration: none;
                margin-top: 10px;
            }

            .card-body .link:hover {
                text-decoration: underline;
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

        <!-- Navbar STart -->
        <header id="topnav" class="defaultscroll sticky">
            <div class="container">
                <!-- Logo container-->
                <div>
                    <a class="logo" href="../c/home">
                        <span class="logo-light-mode">
                            <img src="../assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                            <img src="../assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                        </span>
                        <img src="../assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
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
                        <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                            <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                        </a>
                    </li>

                    <li class="list-inline-item mb-0 ms-1">
                        <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                            <i class="uil uil-search"></i>
                        </a>
                    </li>

                    <li class="list-inline-item mb-0 ms-1">
                        <c:choose>
                            <c:when test="${sessionScope.user ne null}">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                    </button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                            <img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
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
                                        <a class="dropdown-item text-dark" href="../logout">
                                            <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                        </a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="../login" class="btn btn-soft-primary btn-sm">
                                    <i class="uil uil-user-circle align-middle h5 me-1"></i> Login
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>

                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left nav-light">

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                    <c:if test="${sessionScope.role.contains('Staff')}">
                                    <li><a href="../c/staff-dashboard" class="sub-menu-item">Dashboard</a></li>
                                    <li><a href="doctor-appointment.html" class="sub-menu-item">Reservation</a></li>
                                    <li><a href="patient-list.html" class="sub-menu-item">Customers</a></li>
                                    <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                    <li><a href="invoices.html" class="sub-menu-item">Invoices</a></li>
                                    <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                    </c:if>
                                <li><a href="doctor-dashboard.html" class="sub-menu-item">Staff List</a></li>
                            </ul>
                        </li>

                        <c:if test="${sessionScope.role.contains('Customer')}">
                            <li class="has-submenu parent-menu-item">
                                <a href="javascript:void(0)">Customers</a><span class="menu-arrow"></span>
                                <ul class="submenu">
                                    <li><a href="patient-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                                    <li><a href="patient-profile.html" class="sub-menu-item">Profile</a></li>
                                    <li><a href="booking-appointment.html" class="sub-menu-item">Book Services</a></li>
                                    <li><a href="patient-invoice.html" class="sub-menu-item">Invoice</a></li>
                                </ul>
                            </li>
                        </c:if>

                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="../service-list" class="sub-menu-item">Services List</a></li>
                                <li><a href="pharmacy-shop-cart.html" class="sub-menu-item">My Reservation</a></li>
                                <li><a href="pharmacy-checkout.html" class="sub-menu-item">Checkout</a></li>
                                <li><a href="pharmacy-account.html" class="sub-menu-item">Account</a></li>
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="aboutus.html" class="sub-menu-item"> About Us</a></li>
                                <li><a href="faqs.html" class="sub-menu-item">FAQs</a></li>
                                <li class="has-submenu parent-menu-item">
                                <li><a href="../blog" class="sub-menu-item">Blogs</a></li>
                                    <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                    <li><a href="blogs.html" class="sub-menu-item">Blogs - Management</a></li>
                                    </c:if>
                                <li><a href="terms.html" class="sub-menu-item">Posts</a></li>
                                    <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                    <li><a href="../post-list" class="sub-menu-item">Posts - Management</a></li>
                                    <li><a href="../slider" class="sub-menu-item">Sliders - Management</a></li>
                                    </c:if>
                                <li><a href="terms.html" class="sub-menu-item">Terms & Policy</a></li>
                                <li><a href="privacy.html" class="sub-menu-item">Privacy Policy</a></li>
                            </ul>
                        </li>
                        <c:if test="${sessionScope.role.contains('Admin')}">
                            <li><a href="../admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                            </c:if>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Start Hero -->
        <section class="bg-half-170 d-table w-100" id="home">
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row justify-content-center mt-5">
                    <div class="col-xl-10">
                        <div class="heading-title text-center">
                            <img src="../assets/images/logo-icon.png" height="50" alt="">
                            <h4 class="heading fw-bold text-white title-dark mt-3 mb-4">Booking Your Appointments</h4>
                            <p class="para-desc mx-auto text-white-50 mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>

                            <div class="mt-4 pt-2">
                                <form class="rounded text-start shadow p-4 bg-white-50">
                                    <div class="row align-items-center">
                                        <div class="col-md">
                                            <div class="input-group bg-white border rounded" style="opacity: 0.7;">
                                                <span class="input-group-text bg-white border-0"><i class="ri-map-pin-line text-primary h5 fw-normal mb-0"></i></span>
                                                <input name="name" id="location" type="text" class="form-control border-0" placeholder="Location:">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-md mt-4 mt-sm-0">
                                            <div class="input-group bg-white border rounded" style="opacity: 0.7;">
                                                <span class="input-group-text bg-white border-0"><i class="ri-user-2-line text-primary h5 fw-normal mb-0"></i></span>
                                                <input name="name" id="name" type="text" class="form-control border-0" placeholder="Doctor Name:">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-md-auto mt-4 mt-sm-0">
                                            <div class="d-grid d-md-block">
                                                <button type="submit" class="btn btn-primary">Search</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form><!--end form-->
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Start -->
        <section class="section bg-white pb-0">
            <!--Blog-->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Newest Blog</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <c:set var="b" value="${requestScope.blog}"/>

                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-6">
                        <div class="position-relative">
                            <img src="../assets/images/blog/${blog.featuredImage}" class="img-fluid" alt="">
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-7 col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="section-title ms-lg-5">
                            <span class="badge badge-pill badge-soft-primary">About Children Care</span>
                            <h4 class="title mt-3 mb-4">${blog.title}</h4>
                            <p class="para-desc text-muted">${blog.content}</p>
                            <div class="mt-4">
                                <a href="../blog?id=2" class="btn btn-soft-primary">Read More</a>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->


            <!-- Start Post List with Tiny Slider -->
            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Posts</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="tiny-slider">
                    <div class="row">
                        <c:forEach var="p" items="${requestScope.posts}">
                            <div class="col-xl-3 col-md-4 col-12 mt-5">
                                <div class="card features feature-primary bg-transparent border-0">
                                    <div class="card-body p-0 mt-3">
                                        <img src="../${p.img}" class="img-fluid" alt="">
                                        <a href="#" class="title text-dark h5">${p.title}</a>
                                        <p class="text-muted mt-3">${p.content}</p>
                                        <a href="#" class="link">View More <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->
                </div><!--end tiny-slider-->
            </div><!--end container-->
            <!-- End Post List -->



            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Services</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <c:forEach var="s" items="${requestScope.services}">
                        <div class="col-xl-3 col-md-4 col-12 mt-5">
                            <div class="card features feature-primary bg-transparent border-0">
                                <div class="card-body p-0 mt-3">
                                    <a href="#" class="title text-dark h5">${s.name}</a>
                                    <p class="text-muted mt-3">${s.description}</p>
                                    <a href="#" class="link">View More <i class="ri-arrow-right-line align-middle"></i></a>
                                </div>
                            </div>
                        </div><!--end col-->
                    </c:forEach>
                </div><!--end row-->
            </div><!--end container-->
        </section>

        </br>
        </br>

        <!-- Start -->
        <footer class="bg-footer">
            <div class="container">
                <div class="row">
                    <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                        <a href="#" class="logo-footer">
                            <img src="../assets/images/logo-light.png" height="22" alt="">
                        </a>
                        <p class="mt-4 me-xl-5">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div><!--end col-->

                    <div class="col-xl-7 col-lg-8 col-md-12">
                        <div class="row">
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Company</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li><a href="aboutus.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> About us</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Services</a></li>
                                    <li><a href="doctor-team-two.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                                    <li><a href="blog-detail.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                                    <li><a href="blogs.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Blog</a></li>
                                    <li><a href="login.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Login</a></li>
                                </ul>
                            </div><!--end col-->

                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Departments</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Eye Care</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Psychotherapy</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Dental Care</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Orthopedic</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Cardiology</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Gynecology</a></li>
                                    <li><a href="departments.html" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Neurology</a></li>
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
                    <img src="../assets/images/logo-dark.png" height="24" class="light-version" alt="">
                    <img src="../assets/images/logo-light.png" height="24" class="dark-version" alt="">
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
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="../admin/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
                    <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                </ul><!--end icon-->
            </div>
        </div>
        <!-- Offcanvas End -->

        <!-- MOdal Start -->
        <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content video-modal rounded overflow-hidden">
                    <video class="w-100" controls autoplay muted loop>
                        <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">>
                        <!--Browser does not support <video> tag -->
                    </video>
                </div>
            </div>
        </div>
        <!-- MOdal End -->

        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <script src="../assets/js/easy_background.js"></script>

        <!-- Select2 -->
        <script src="../assets/js/select2.min.js"></script>
        <script src="../assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/flatpickr.min.js"></script>
        <script src="../assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/jquery.timepicker.min.js"></script> 
        <script src="../assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <script>
                                        var sliderImages = [
            <c:forEach var="s" items="${sliders}">
                                            "../${s.getImg()}",
            </c:forEach>
                                        ];

                                        easy_background("#home", {
                                            slide: sliderImages,
                                            delay: [3000, 3000, 3000]
                                        });
        </script>



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>

                                        var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : "" %>';
                                        var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "" %>';

                                        // Kiểm tra nếu alertMessage và alertType không rỗng thì hiển thị Swal.fire
                                        if (alertMessage.trim() !== "" && alertType.trim() !== "") {
                                            Swal.fire({
                                                icon: alertType,
                                                title: alertMessage,
                                                showConfirmButton: false,
                                                timer: 3000
                                            });
                                        }


            <%
            session.removeAttribute("alertMessage");
            session.removeAttribute("alertType");
            %>
        </script>

        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <script>
                                        var slider = tns({
                                            container: '.tiny-slider .row',
                                            items: 4, // Hiển thị 4 bài viết trên mỗi slide
                                            slideBy: 'page',
                                            autoplay: true,
                                            autoplayButtonOutput: false,
                                            controls: false, // Cho phép điều khiển slide
                                            nav: true, // Cho phép navigation
                                            controlsPosition: 'outside', // Đặt nút prev, next bên ngoài slider
                                            responsive: {
                                                '0': {
                                                    items: 1, // 1 item cho các màn hình nhỏ
                                                },
                                                '600': {
                                                    items: 2, // 2 items cho các màn hình trung bình
                                                },
                                                '1024': {
                                                    items: 4, // 4 items cho màn hình lớn
                                                }
                                            }
                                        });
        </script>



    </body>

</html>