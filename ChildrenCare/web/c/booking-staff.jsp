<%-- 
    Document   : staff
    Created on : Feb 8, 2025, 8:39:43 AM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
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
                                        <a href="Cart">
                                            <div class="btn btn-icon btn-pills btn-primary"><i data-feather="heart" class="fea icon-sm"></i></div>
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
                                                        <a class="dropdown-item text-dark" href="../profile">
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
                                    <ul class="navigation-menu nav-left nav-dark">

                                        <li class="has-submenu parent-parent-menu-item">
                                            <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li class="has-submenu parent-menu-item">
                                                    <c:if test="${sessionScope.role.contains('Staffs')}">
                                                    <li><a href="doctor-appointment.html" class="sub-menu-item">Reservation</a></li>
                                                    <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                                    <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                                    </c:if>
                                                <li><a href="doctor-dashboard.html" class="sub-menu-item">Staff List</a></li>
                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-menu-item">
                                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li><a href="../service-list" class="sub-menu-item">Services List</a></li>
                                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                                    <li><a href="../myreservation" class="sub-menu-item">My Reservation</a></li>
                                                    <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li class="has-submenu parent-menu-item">
                                                <li><a href="../blog" class="sub-menu-item">Blogs</a></li>

                                                <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                                    <li><a href="../post-list" class="sub-menu-item">Posts - Management</a></li>
                                                    <li><a href="../slider" class="sub-menu-item">Sliders - Management</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>
                                        <c:if test="${sessionScope.role.contains('Admin')}">
                                            <li><a href="../admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                                            </c:if>

                                    </ul><!--end navigation menu-->
                                </div><!--end navigation-->
                            </div><!--end container-->
                        </header><!--end header-->
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <div class="card border-0 shadow rounded overflow-hidden">
                                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded-0 shadow overflow-hidden bg-light mb-0" id="pills-tab" role="tablist">

                                        </ul>

                                        <c:if test="${not empty requestScope.err}">
                                            <div class="alert alert-danger">
                                                ${requestScope.err}
                                            </div>
                                        </c:if>

                                        <div class="tab-content p-4" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-clinic" role="tabpanel" aria-labelledby="clinic-booking">
                                                <form action="BookingStaff" method="POST" id="staff-form">                                     
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <div class="mb-3">
                                                                <label class="form-label">Date <span class="text-danger">*</span></label>
                                                                <input name="date" id="date" type="date" value="${requestScope.date}" class="form-control" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" placeholder="" >

                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-3">
                                                            <div class="mb-3">
                                                                <label class="form-label">Start Time <span class="text-danger">*</span></label>
                                                                <input name="starttime" id="starttime" type="time" value="${requestScope.starttime}" class="form-control" placeholder="" >
                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-3">
                                                            <div class="mb-3">
                                                                <label class="form-label">End Time <span class="text-danger">*</span></label>
                                                                <input name="endtime" id="endtime" type="time" value="${requestScope.endtime}" class="form-control" placeholder="" >
                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-3">
                                                            <div class="mb-3">
                                                                <c:choose>
                                                                    <c:when test="${(requestScope.service_id ne null) or (requestScope.service_name ne null)}">
                                                                        <label class="form-label">Service</label>
                                                                        <select name="service" class="form-control department-name select2input">
                                                                            <option value="${requestScope.service_id}">${requestScope.service_name}</option>
                                                                        </select>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <label class="form-label">Services</label>
                                                                        <select name="service" class="form-control department-name select2input selectedService">
                                                                            <c:forEach var="s" items="${requestScope.services}">
                                                                                <option value="${s.id}"
                                                                                        <c:if test="${requestScope.sid eq s.id}">
                                                                                            selected
                                                                                        </c:if>
                                                                                        >${s.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div><!--end col-->

                                                        <c:if test="${(requestScope.service_id ne null) or (requestScope.service_name ne null)}">
                                                            <input type="hidden" name="service_id" value="${requestScope.service_id}" />
                                                            <input type="hidden" name="service_name" value="${requestScope.service_name}" />
                                                        </c:if>

                                                        <c:if test="${requestScope.isFromCart ne null}">
                                                            <input type="hidden" name="isFromCart" value="${requestScope.isFromCart}" />
                                                        </c:if>

                                                        <div class="col-lg-12">
                                                            <div class="d-grid">
                                                                <button type="submit" class="btn btn-primary">View Available Staff</button>
                                                            </div>
                                                        </div><!--end col-->
                                                    </div><!--end row-->
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div><!--end container-->
                        <!-- Staff List -->
                        <div id="staff-list" class="row row-cols-md-2 row-cols-lg-5">
                            <c:forEach var="s" items="${requestScope.staff}">
                                <div class="col mt-4">
                                    <div class="card team border-0 rounded shadow overflow-hidden">
                                        <div class="team-img position-relative">
                                            <img src="${pageContext.request.contextPath}/${s.avatar}" class="img-fluid" alt="">
                                        </div>
                                        <div class="card-body content text-center">
                                            <form id="form-staff" action="booking-reserv" method="post">
                                                <input type="hidden" name="date" value="${requestScope.date}"/>
                                                <input type="hidden" name="starttime" value="${requestScope.starttime}"/>
                                                <input type="hidden" name="endtime" value="${requestScope.endtime}"/>
                                                <input type="hidden" name="staff_id" value="${s.id}"/>
                                                <input type="hidden" name="booked" value="1"/>
                                                <input type="hidden" readonly name="inputSelectedService" value=""/>
                                                <c:if test="${(requestScope.service_id ne null) or (requestScope.service_name ne null)}">
                                                    <input type="hidden" name="serviceCart" value="${requestScope.service_id}"/>
                                                </c:if>

                                                <c:if test="${requestScope.isFromCart ne null}">
                                                    <input type="hidden" name="isFromCart" value="${requestScope.isFromCart}" />
                                                </c:if>
                                                <a href="#" class="title text-dark h5 d-block mb-0" onclick="submitStaff(this);">${s.fullname}</a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination Controls -->
                        <div id="pagination-controls" class="d-flex justify-content-center mt-4">
                            <button id="prev-page" class="btn btn-primary" disabled>Prev</button> &nbsp;
                            <button id="next-page" class="btn btn-primary">Next</button>
                        </div>

                        <!-- Paging with Prev and Next -->
                        <div class="mt-4">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <!-- Page Numbers -->
                                    <c:if test="${not empty requestScope.pageNumbers}">
                                        <c:forEach var="page" items="${requestScope.pageNumbers}">
                                            <li class="page-item ${page == param.page ? 'active' : ''}">
                                                <a class="page-link" href="staff?page=${page}&search=${param.search}&sort=${param.sort}">${page}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>


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
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="../c/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
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
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const staffList = document.getElementById('staff-list');
                                            const staffItems = Array.from(staffList.getElementsByClassName('col'));
                                            const itemsPerPage = 5;
                                            const totalPages = Math.ceil(staffItems.length / itemsPerPage);

                                            let currentPage = 1;

                                            function showPage(page) {
                                                // Hide all staff items
                                                staffItems.forEach(item => item.style.display = 'none');

                                                // Show the staff items for the current page
                                                const start = (page - 1) * itemsPerPage;
                                                const end = start + itemsPerPage;
                                                const itemsToShow = staffItems.slice(start, end);

                                                itemsToShow.forEach(item => item.style.display = 'block');

                                                // Disable/enable pagination buttons
                                                const prevButton = document.getElementById('prev-page');
                                                const nextButton = document.getElementById('next-page');

                                                prevButton.disabled = (page <= 1);  // Nếu trang là 1 thì disable prev
                                                nextButton.disabled = (page >= totalPages); // Nếu trang là cuối cùng thì disable next
                                            }

                                            // Next page
                                            document.getElementById('next-page').addEventListener('click', function () {
                                                if (currentPage < totalPages) {
                                                    currentPage++;
                                                    showPage(currentPage);
                                                }
                                            });

                                            // Previous page
                                            document.getElementById('prev-page').addEventListener('click', function () {
                                                if (currentPage > 1) {
                                                    currentPage--;
                                                    showPage(currentPage);
                                                }
                                            });

                                            // Initial page setup
                                            showPage(currentPage);
                                        });


                                        function submitStaff(element) {
                                            var form = document.getElementById("staff-form"); // Form chọn ngày/giờ
                                            var startTimeInput = form.querySelector("input[name='starttime']"); // Lấy input thời gian bắt đầu
                                            var endTimeInput = form.querySelector("input[name='endtime']"); // Lấy input thời gian kết thúc
                                            var dateInput = form.querySelector("input[name='date']"); // Lấy input ngày

                                            if (!startTimeInput || !endTimeInput || !dateInput)
                                                return; // Kiểm tra nếu không tìm thấy input

                                            var selectedDate = dateInput.value;
                                            var selectedStartTime = startTimeInput.value;
                                            var selectedEndTime = endTimeInput.value;

                                            if (!selectedDate || !selectedStartTime || !selectedEndTime) {
                                                Swal.fire({
                                                    icon: "warning",
                                                    title: "Missing Information!",
                                                    text: "Please select a date, start time, and end time before proceeding.",
                                                });
                                                return;
                                            }

                                            // Lấy thời gian hiện tại
                                            var now = new Date();
                                            var currentDate = now.toISOString().split("T")[0]; // Lấy ngày hiện tại (YYYY-MM-DD)
                                            var currentTime = now.getHours().toString().padStart(2, '0') + ":" + now.getMinutes().toString().padStart(2, '0'); // Lấy giờ hiện tại (HH:mm)

                                            // Chuyển đổi startTime thành số phút từ 00:00
                                            function timeToMinutes(time) {
                                                var parts = time.split(":");
                                                return parseInt(parts[0]) * 60 + parseInt(parts[1]);
                                            }

                                            var currentMinutes = timeToMinutes(currentTime);
                                            var startMinutes = timeToMinutes(selectedStartTime);
                                            var endMinutes = timeToMinutes(selectedEndTime);

                                            // Kiểm tra nếu ngày được chọn là hôm nay và thời gian bắt đầu phải lớn hơn thời gian hiện tại ít nhất 60 phút
                                            if (selectedDate === currentDate && startMinutes - currentMinutes < 50) {
                                                Swal.fire({
                                                    icon: "error",
                                                    title: "Invalid Time!",
                                                    text: "The start time must be at least 60 minutes later than the current time!",
                                                });
                                                return;
                                            }

                                            // Kiểm tra nếu End không lớn hơn Start ít nhất 60 phút
                                            if (endMinutes - startMinutes < 60) {
                                                Swal.fire({
                                                    icon: "error",
                                                    title: "Invalid Time!",
                                                    text: "The end time must be at least 60 minutes later than the start time!",
                                                });
                                                return;
                                            }

                                            var staffForm = element.closest("form"); // Tìm form gần nhất chứa thẻ <a> được nhấn
                                            staffForm.submit(); // Gửi form tương ứng
                                        }




//                                        function submitStaff(element) {
//                                            var form = element.closest("form"); // Tìm form gần nhất chứa thẻ <a> được nhấn
//                                            form.submit(); // Gửi form tương ứng
//                                        }

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const serviceSelect = document.querySelector(".selectedService");

                if (serviceSelect) {
                    // Lấy giá trị được chọn hiện tại (nếu có)
                    let selectedValue = serviceSelect.value;

                    // Gán giá trị đã chọn vào input[name='inputSelectedService']
                    document.querySelectorAll("input[name='inputSelectedService']").forEach(input => {
                        input.value = selectedValue;
                    });

                    // Lắng nghe sự kiện thay đổi dropdown
                    serviceSelect.addEventListener("change", function () {
                        let newValue = this.value; // Lấy giá trị đã chọn mới

                        // Cập nhật tất cả input[name='inputSelectedService']
                        document.querySelectorAll("input[name='inputSelectedService']").forEach(input => {
                            input.value = newValue;
                        });
                    });
                }
            });


            document.addEventListener("DOMContentLoaded", function () {
                var startTimeInput = document.getElementById("starttime");
                var endTimeInput = document.getElementById("endtime");

                function updateHiddenFields() {
                    var hiddenStartTimeFields = document.querySelectorAll("input[name='starttime']");
                    var hiddenEndTimeFields = document.querySelectorAll("input[name='endtime']");

                    hiddenStartTimeFields.forEach(function (input) {
                        input.value = startTimeInput.value;
                    });

                    hiddenEndTimeFields.forEach(function (input) {
                        input.value = endTimeInput.value;
                    });
                }

                if (startTimeInput && endTimeInput) {
                    startTimeInput.addEventListener("input", updateHiddenFields);
                    endTimeInput.addEventListener("input", updateHiddenFields);
                }
            });

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var notAvailableMessage = "<c:out value='${requestScope.notAvailable}' />";

                if (notAvailableMessage && notAvailableMessage.trim() !== "") {
                    Swal.fire({
                        icon: "error",
                        title: notAvailableMessage,
                        confirmButtonText: "OK"
                    }).then(() => {
                        // Xóa requestScope.notAvailable bằng cách làm mới trạng thái lịch sử trình duyệt
                        window.history.replaceState({}, document.title, window.location.pathname);
                    });
                }
            });
        </script>



    </body>

</html>
