<%-- 
    Document   : cart
    Created on : Feb 18, 2025, 8:44:44 PM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <title>VNPay Payment Result</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">

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

                    <c:if test="${sessionScope.role.contains('Customer')}">
                        <li class="list-inline-item mb-0">
                            <a href="Cart">
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
                                            <a class="dropdown-item text-dark" href="../admin/dashboard">
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


                                </c:if>

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
        <!-- Navbar End -->

        <!-- Hero Start -->

        <div class="position-relative">
            <div class="shape overflow-hidden text-white">
                <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
                </svg>
            </div>
        </div>
        <!-- Hero End -->

        <!-- Start -->
        <section class="section">
            <div class="container mt-5">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Payment Result</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${param.vnp_ResponseCode == '00'}">
                                <div class="alert alert-success text-center" role="alert">
                                    <strong>Payment successful!</strong>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger text-center" role="alert">
                                    <strong>Payment failed!</strong>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <h5>Transaction Details:</h5>
                        <ul class="list-group">
                            <li class="list-group-item"><strong>Transaction ID:</strong> ${param.vnp_TxnRef}</li>
                            <li class="list-group-item"><strong>Order Info:</strong> ${param.vnp_OrderInfo}</li>
                            <li class="list-group-item"><strong>Amount:</strong> <fmt:formatNumber value="${param.vnp_Amount / 100}" type="currency" currencyCode="VND"/></li>
                            <li class="list-group-item"><strong>Payment Date:</strong> ${param.vnp_PayDate}</li>
                            <li class="list-group-item"><strong>Bank Code:</strong> ${param.vnp_BankCode}</li>
                            <li class="list-group-item"><strong>Response Code:</strong> ${param.vnp_ResponseCode}</li>
                            <li class="list-group-item"><strong>Transaction Status:</strong> <c:choose>
                                    <c:when test="${param.vnp_ResponseCode == '00'}">Success</c:when>
                                    <c:otherwise>Failed</c:otherwise>
                                </c:choose></li>
                        </ul>

                        <div class="text-center mt-3">
                            <a href="c/home" class="btn btn-primary">Return to Home</a>
                        </div>
                    </div>
                </div>
            </div>
        </section><!--end section-->
        <!-- End -->

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


        <!-- Offcanvas End -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
    </body>

</html>
