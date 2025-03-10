<%-- 
    Document   : pharmacy-shop-cart
    Created on : Feb 22, 2025, 6:45:21 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
/* Giới hạn chiều cao của bảng dữ liệu và làm cho nó có thể cuộn */
.table-responsive {
    max-height: 400px; /* Tùy chỉnh chiều cao tối đa theo yêu cầu */
    overflow-y: auto; /* Cho phép cuộn dọc */
}

/* Giữ khoảng cách giữa phần nội dung và footer */
.footer-spacing {
    margin-top: 30px;
}

.table-container {
    max-height: 400px; /* Cố định chiều cao */
    margin-bottom: 30px; /* Fixed margin to maintain space between table and pagination */
}

.pagination-container {
    margin-top: 30px; /* Ensure there's always a fixed gap above the pagination section */
}

.table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed; /* Ngăn cản việc thay đổi chiều rộng cột */
}

.table th, .table td {
    padding: 20px;
    text-align: left;
    border: 1px solid #ddd;
    height: 60px;  /* Set a fixed height for each row */
}

/* Ensure empty rows take the same height */
.empty-row td {
    height: 60px;  /* Ensure empty rows have the same height */
    background-color: #f8f9fa;  /* Optional: to differentiate empty rows */
}

/* Styling for responsive table */
.table-responsive {
    max-height: 400px; /* Cố định chiều cao */
    overflow-y: auto;   /* Hiển thị thanh cuộn khi có nhiều dữ liệu */
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
                    <a class="logo" href="./c/home">
                        <span class="logo-light-mode">
                            <img src="./assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                            <img src="./assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                        </span>
                        <img src="./assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
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
                            <a href="c/Cart">
                                <div class="btn btn-icon btn-pills btn-primary"><i data-feather="heart" class="fea icon-sm"></i></div>
                            </a>
                        </li>
                    </c:if>

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
                                        <a class="dropdown-item text-dark" href="profile">
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
                                    <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                    <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                    </c:if>
                                <li><a href="doctor-dashboard.html" class="sub-menu-item">Staff List</a></li>
                            </ul>
                        </li>

                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="./service-list" class="sub-menu-item">Services List</a></li>
                                <li><a href="myreservation" class="sub-menu-item">My Reservation</a></li>
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                <li><a href="./blog" class="sub-menu-item">Blogs</a></li>
                                    <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                    <li><a href="blogs.html" class="sub-menu-item">Blogs - Management</a></li>
                                    </c:if>
                                    
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
        <!-- Search and Filter Row -->
        <div class="row mb-3">
            <!-- Search Box -->
            <div class="col-md-4">
                <form action="myreservation" method="get">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search Service Name" value="${param.search}">
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </div>
                </form>
            </div>

            <!-- Status Filter -->
            <div class="col-md-4">
                <form action="myreservation" method="get">
                    <div class="input-group">
                        <select class="form-control" name="status">
                            <option value="">All Status</option>
                            <option value="Scheduled" ${param.status == 'Scheduled' ? 'selected' : ''}>Scheduled</option>
                            <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        </select>
                        <button class="btn btn-outline-primary" type="submit">Filter</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Reservation Table -->
        <div class="table-container">
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive bg-white shadow rounded">
                        <table class="table table-center table-padding mb-0">
                            <thead>
                                <tr>
                                    <th class="border-bottom text-center p-3" style="width: 250px;"> <!-- Cố định chiều rộng cho cột Service Name -->
                                        <a href="myreservation?search=${param.search}&status=${param.status}&sort=${param.sort == 'asc' ? 'desc' : 'asc'}"
                                           class="text-decoration-none text-dark">
                                            Service Name
                                        </a>
                                    </th>
                                    <th class="border-bottom text-center p-3" style="width: 150px;">DateBook</th> <!-- Cố định chiều rộng cho cột DateBook -->
                                    <th class="border-bottom text-center p-3" style="width: 120px;">
                                        <a href="myreservation?search=${param.search}&status=${param.status}&sortPrice=${param.sortPrice == 'asc' ? 'desc' : 'asc'}"
                                            class="text-decoration-none text-dark">
                                            Price
                                        </a>
                                    </th>
                                    <th class="border-bottom text-center p-3" style="width: 120px;">Status</th>
                                    <th class="border-bottom text-center p-3" style="width: 120px;">Start Time</th>
                                    <th class="border-bottom text-center p-3" style="width: 120px;">End Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reservation" items="${paginatedReservations}">
                                    <tr class="table-row">
                                        <td class="p-3 text-center">${reservation.service.name}</td>
                                        <td class="p-3 text-center"><fmt:formatDate value="${reservation.bookdate}" pattern="yyyy-MM-dd" /></td>
                                        <td class="text-center p-3">${reservation.service.price}</td>
                                        <td class="text-center p-3">
                                            <span class="badge
                                                  ${reservation.status == 'Complete' ? 'badge-success' : 
                                                    reservation.status == 'Cancelled' ? 'badge-warning' : 'badge-danger'}">
                                                  ${reservation.status}
                                            </span>
                                        </td>
                                        <td class="border-bottom text-center p-3"><fmt:formatDate value="${reservation.start}" pattern="HH:mm" /></td>
                                        <td class="border-bottom text-center p-3"><fmt:formatDate value="${reservation.end}" pattern="HH:mm" /></td>
                                    </tr>
                                </c:forEach>

                                <!-- Add empty rows if there are fewer than 5 elements -->
                                <c:if test="${paginatedReservations.size() < 5}">
                                    <c:forEach var="i" begin="${paginatedReservations.size() + 1}" end="5">
                                        <tr class="empty-row">
                                            <td colspan="6"></td> <!-- Ensure empty rows span all columns -->
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Pagination Controls -->
        <div class="pagination-container text-center">
            <c:if test="${currentPage > 1}">
                <a href="myreservation?page=${currentPage - 1}&search=${param.search}&status=${param.status}&sort=${param.sort}" class="btn btn-secondary">Previous</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:if test="${i == currentPage}">
                    <span class="btn btn-primary">${i}</span>
                </c:if>
                <c:if test="${i != currentPage}">
                    <a href="myreservation?page=${i}&search=${param.search}&status=${param.status}&sort=${param.sort}" class="btn btn-outline-primary">${i}</a>
                </c:if>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="myreservation?page=${currentPage + 1}&search=${param.search}&status=${param.status}&sort=${param.sort}" class="btn btn-secondary">Next</a>
            </c:if>
        </div>
        
    </div>
</section>





<!-- Footer with spacing -->
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


            <!-- Offcanvas Start -->
            <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
                <div class="offcanvas-body d-flex align-items-center align-items-center">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="text-center">
                                    <h4>Search now${pageContext.request.contextPath}${pageContext.request.contextPath}.</h4>
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
                        <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="light-version" alt="">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="dark-version" alt="">
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
                                        <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                        <li class="d-grid"><a href="${pageContext.request.contextPath}/admin/index.html" target="_blank" class="mt-4"><img src="${pageContext.request.contextPath}/assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
                        <li class="list-inline-item mb-0"><a href="${pageContext.request.contextPath}/${pageContext.request.contextPath}/${pageContext.request.contextPath}/index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                    </ul><!--end icon-->
                </div>
            </div>
            <!-- Offcanvas End -->

            <!-- javascript -->
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
            <!-- Icons -->
            <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
            <!-- Main Js -->
            <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>


        </body>

        
<script>
    // Lắng nghe sự kiện submit của form
    document.querySelector('form').addEventListener('submit', function(event) {
        // Lấy giá trị từ trường select status
        let status = document.querySelector('select[name="status"]').value.trim();

        // Danh sách các trạng thái hợp lệ
        const validStatuses = ['Scheduled', 'Cancelled', 'Completed'];

        // Kiểm tra nếu giá trị của status không hợp lệ và không phải là giá trị trống
        if (status && !validStatuses.includes(status)) {
            // Ngừng việc gửi form và hiển thị thông báo lỗi
            event.preventDefault();
            alert("Vui lòng chọn trạng thái hợp lệ: Scheduled, Cancelled hoặc Completed.");
        }
    });
</script>


    </html>
