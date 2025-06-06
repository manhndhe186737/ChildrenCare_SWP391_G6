<%-- 
    Document   : staff-dashboard
    Created on : Feb 8, 2025, 4:09:42 PM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Children Service Booking System Booking System</title>
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
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

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
            <div class="container-fluid">
                <!-- Logo container-->
                <a class="logo" href="index.html">
                    <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                    <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </a>                
                <!-- Logo End -->

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
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                    <img src="../assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">Calvin Carlo</span>
                                        <small class="text-muted">Orthopedic</small>
                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="staff-dashboard.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                <a class="dropdown-item text-dark" href="doctor-profile-setting.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="login.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                            </div>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left">

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                    <c:if test="${requestScope.role.contains('Staffs')}">
                                    <li><a href="../c/staff-dashboard" class="sub-menu-item">Dashboard</a></li>
                                    <li><a href="doctor-appointment.html" class="sub-menu-item">Reservation</a></li>
                                    <li><a href="patient-list.html" class="sub-menu-item">Customers</a></li>
                                    
                                    <li><a href="invoices.html" class="sub-menu-item">Invoices</a></li>
                                    
                                    </c:if>
                                
                            </ul>
                        </li>

                        <c:if test="${requestScope.role.contains('Customer')}">
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
                                <li><a href="pharmacy-shop.html" class="sub-menu-item">Services List</a></li>
                                <li><a href="pharmacy-product-detail.html" class="sub-menu-item">Service Detail</a></li>
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
                                    <a href="javascript:void(0)" class="menu-item"> Blogs </a><span class="submenu-arrow"></span>
                                    <ul class="submenu">
                                        <li><a href="blogs.html" class="sub-menu-item">Blogs</a></li>
                                        <li><a href="blog-detail.html" class="sub-menu-item">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li><a href="terms.html" class="sub-menu-item">Terms & Policy</a></li>
                                <li><a href="privacy.html" class="sub-menu-item">Privacy Policy</a></li>
                            </ul>
                        </li>
                        <c:if test="${requestScope.role.contains('Admin')}">
                            <li><a href="../admin/index.html" class="sub-menu-item" target="_blank">Admin</a></li>
                            </c:if>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Start Hero -->
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="../assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                            </div>

                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="../assets/images/doctors/01.jpg" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">Dr. Calvin Carlo</h5>
                                <p class="text-muted mb-0">Orthopedic</p>
                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-dashboard.html" class="navbar-link"><i class="ri-airplay-line align-middle navbar-icon"></i> Dashboard</a></li>
                                <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Appointment</a></li>
                                <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i> Schedule Timing</a></li>
                                <li class="navbar-item"><a href="invoices.html" class="navbar-link"><i class="ri-pages-line align-middle navbar-icon"></i> Invoices</a></li>
                                <li class="navbar-item"><a href="doctor-messages.html" class="navbar-link"><i class="ri-mail-unread-line align-middle navbar-icon"></i> Messages</a></li>
                                <li class="navbar-item"><a href="doctor-profile.html" class="navbar-link"><i class="ri-user-line align-middle navbar-icon"></i> Profile</a></li>
                                <li class="navbar-item"><a href="doctor-profile-setting.html" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Profile Settings</a></li>
                                <li class="navbar-item"><a href="patient-list.html" class="navbar-link"><i class="ri-empathize-line align-middle navbar-icon"></i> Patients</a></li>
                                <li class="navbar-item"><a href="patient-review.html" class="navbar-link"><i class="ri-chat-1-line align-middle navbar-icon"></i> Patients Review</a></li>
                                <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Chat</a></li>
                                <li class="navbar-item"><a href="login.html" class="navbar-link"><i class="ri-login-circle-line align-middle navbar-icon"></i> Login</a></li>
                                <li class="navbar-item"><a href="forgot-password.html" class="navbar-link"><i class="ri-device-recover-line align-middle navbar-icon"></i> Forgot Password</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-9 col-lg-8 col-md-7 mt-4 mt-sm-0">
                        <h5 class="mb-0">Dashboard</h5>
                        <div class="row">
                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Appointment <span class="badge badge-pill badge-soft-primary ms-1">+15%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-1"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Patients <span class="badge badge-pill badge-soft-success ms-1">+20%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-2"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Urgent <span class="badge badge-pill badge-soft-warning ms-1">+5%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-3"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Canceled <span class="badge badge-pill badge-soft-danger ms-1">-5%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-4"></div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="d-flex justify-content-between p-4 border-bottom">
                                        <h6 class="mb-0"><i class="uil uil-calender text-primary me-1 h5"></i> Latest Appointment</h6>
                                        <h6 class="text-muted mb-0">55 Patients</h6>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4">
                                        <li>
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Calvin Carlo</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Joya Khan</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Amelia Muli</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/04.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Nik Ronaldo</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/05.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Crista Joseph</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="d-flex justify-content-between p-4 border-bottom">
                                        <h6 class="mb-0"><i class="uil uil-calendar-alt text-primary me-1 h5"></i> Upcoming Appointment</h6>
                                        <h6 class="text-muted mb-0">55 Patients</h6>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4">
                                        <li>
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Cristino Murphy</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Nick Jons</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/08.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Alex Dirio</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Vrunda Koli</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="../assets/images/client/10.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Aisha Low</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-12 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <h6 class="mb-0">Patient's Review</h6>
                                    </div>

                                    <div class="p-4">
                                        <div class="client-review-slider">
                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only melodies in order to have a 'ready-made' text to sing with the melody of the originalthe 'Lorem Ipsum', which is said to have originated century. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/01.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Thomas Israel <small class="text-muted">C.E.O</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" The advantage of its writing melodies in order to have a 'ready-made' text to sing with the melody and the to itself or distract the viewer's attention from the layout. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/02.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Carl Oliver <small class="text-muted">P.A</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" There is now an in order to have a 'ready-made' text to sing with the melody alternatives to the classic Lorem Ipsum texts are amusing. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/03.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Barbara McIntosh <small class="text-muted">M.D</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" According to most sources in order to have a 'ready-made' text to sing with the melody the origin of the text by compiling all the instances. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/04.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Christa Smith <small class="text-muted">Manager</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only in order to have a 'ready-made' text to sing with the melody 'Lorem Ipsum', which is said to have originated 16th century. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/05.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Dean Tolle <small class="text-muted">Developer</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only lyrics when writing melodies in order to have a 'ready-made' text to sing with the melody of time certain letters were added or deleted at the text. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="../assets/images/client/06.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Jill Webb <small class="text-muted">Designer</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->
                                        </div><!--end carousel-->

                                        <div class="row justify-content-center mt-3">
                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="../assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="../assets/images/client/google.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="../assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="../assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-message align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">New Messages</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">Read more <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-envelope-star align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Latest Proposals</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">View more <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-hourglass align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Package Expiry</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">Check here <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-heart align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Saved Items</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">View items <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Footer Start -->
        <footer class="bg-footer py-4">
            <div class="container-fluid">
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

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <!-- Chart -->
        <script src="../assets/js/apexcharts.min.js"></script>
        <script src="../assets/js/areachart.init.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
    </body>

</html>
