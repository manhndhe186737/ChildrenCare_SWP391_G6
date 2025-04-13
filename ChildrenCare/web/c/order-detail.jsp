<%-- 
    Document   : order-detail
    Created on : Apr 12, 2025, 10:16:40 AM
    Author     : dell
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Order Details - Children Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Children Service Booking System" />
    <meta name="keywords" content="Appointment, Booking, System, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .table-container {
            margin-bottom: 30px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .table th, .table td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd;
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

    <!-- Navbar Start -->
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
                                <li><a href="./myorders" class="sub-menu-item">My Orders</a></li>
                                <li><a href="c/BookingStaff" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="./blog" class="sub-menu-item">Blogs</a></li>
                            <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                <li><a href="./post-list" class="sub-menu-item">Posts - Management</a></li>
                                <li><a href="./slider" class="sub-menu-item">Sliders - Management</a></li>
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
    <!-- Navbar End -->

    <section class="section">
        <div class="container">
            <h2 class="mb-4">Order Details - Order #${order.orderId}</h2>

            <!-- Order Information -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Order Information</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Order ID:</strong> ${order.orderId}</p>
                            <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></p>
                            <p><strong>Customer Name:</strong> ${order.customerName}</p>
                            <p><strong>Address:</strong> ${order.address}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Amount:</strong> $ ${order.amount}</p>
                            <p><strong>Payment Method:</strong> ${order.paymentMethod}</p>
                            <p><strong>Payment Status:</strong> ${order.paymentStatus}</p>
                            <p><strong>Status:</strong>
                                <span class="badge
                                      ${order.status == 'Delivered' ? 'badge-success' :
                                        order.status == 'Shipped' ? 'badge-info' :
                                        order.status == 'Pending' ? 'badge-warning' : 'badge-danger'}">
                                    ${order.status}
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <div class="table-container">
                <div class="row">
                    <div class="col-12">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table table-center table-padding mb-0">
                                <thead>
                                    <tr>
                                        <th class="border-bottom text-center p-3" style="width: 150px;">Detail ID</th>
                                        <th class="border-bottom text-center p-3" style="width: 150px;">Product ID</th>
                                        <th class="border-bottom text-center p-3" style="width: 300px;">Product Name</th>
                                        <th class="border-bottom text-center p-3" style="width: 120px;">Quantity</th>
                                        <th class="border-bottom text-center p-3" style="width: 120px;">Price</th>
                                        <th class="border-bottom text-center p-3" style="width: 120px;">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${orderDetails}">
                                        <tr>
                                            <td class="text-center p-3">${detail.odetailId}</td>
                                            <td class="text-center p-3">${detail.productId}</td>
                                            <td class="text-center p-3">${detail.productName}</td>
                                            <td class="text-center p-3">${detail.quantity}</td>
                                            <td class="text-center p-3">$ ${detail.price}</td>
                                            <td class="text-center p-3">$ ${detail.quantity * detail.price}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Back to My Orders -->
            <div class="text-center">
                <a href="myorders" class="btn btn-primary">Back to My Orders</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-footer footer-spacing">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
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

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>