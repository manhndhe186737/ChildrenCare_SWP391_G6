<%-- 
    Document   : staff-feedback
    Created on : Mar 19, 2025, 8:49:37 AM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Staff Feedback</title>
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
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Font Awesome for star icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- Custom CSS -->
        <style>
            .table th, .table td {
                padding: 20px !important;
                font-size: 16px !important;
                vertical-align: middle;
            }
            .table tr {
                height: 90px;
            }
            .avatar-md-sm {
                width: 50px !important;
                height: 50px !important;
            }
            .d-flex.align-items-center .ms-2 {
                margin-left: 15px !important;
            }
            .star-rating .fas {
                color: #f1c40f;
            }
            .star-rating .far {
                color: #ddd;
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

        <!-- Navbar Start -->
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
                <!-- End Dropdown -->

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
                                <li><a href="../service-list" class="sub-menu-item">Services List</a></li>
                                <c:if test="${sessionScope.role.contains('Customer')}">
                                    <li><a href="../myreservation" class="sub-menu-item">My Reservation</a></li>
                                    <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
                                </c:if>
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
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

        <!-- Start Hero -->
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="text-center avatar-profile position-relative pb-4 border-bottom mt-3">
                                <c:choose>
                                    <c:when test="${sessionScope.user.avatar.contains('upload')}">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/${sessionScope.user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                                <h5 class="mt-3 mb-1">${sessionScope.user.fullname}</h5>
                            </div>
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="../c/staff-reserv" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Reservation</a></li>
                                <li class="navbar-item active"><a href="../c/staff-feedback" class="navbar-link"><i class="ri-device-recover-line align-middle navbar-icon"></i> Feedback</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-xl-9 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="row">
                            <div class="col-xl-9 col-lg-6 col-md-4">
                                <h5 class="mb-0">Feedback for ${sessionScope.user.fullname}</h5>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <!-- Form lọc và tìm kiếm -->
                                    <form method="get" action="${pageContext.request.contextPath}/c/staff-feedback" class="p-3 border-bottom">
                                        <div class="row g-3 align-items-center">
                                            <!-- Lọc theo Rating -->
                                            <div class="col-md-2">
                                                <label for="filterRating" class="form-label">Rating</label>
                                                <select name="filterRating" id="filterRating" class="form-select">
                                                    <option value="">All</option>
                                                    <option value="1" ${param.filterRating == '1' ? 'selected' : ''}>1 Star</option>
                                                    <option value="2" ${param.filterRating == '2' ? 'selected' : ''}>2 Stars</option>
                                                    <option value="3" ${param.filterRating == '3' ? 'selected' : ''}>3 Stars</option>
                                                    <option value="4" ${param.filterRating == '4' ? 'selected' : ''}>4 Stars</option>
                                                    <option value="5" ${param.filterRating == '5' ? 'selected' : ''}>5 Stars</option>
                                                </select>
                                            </div>

                                            <!-- Tìm kiếm -->
                                            <div class="col-md-3">
                                                <label for="search" class="form-label">Search</label>
                                                <input type="text" name="search" id="search" class="form-control" placeholder="Comment, Service, Customer" value="${param.search}">
                                            </div>

                                            <!-- Nút áp dụng -->
                                            <div class="col-md-1 d-flex align-items-end">
                                                <button type="submit" class="btn btn-primary w-100">Apply</button>
                                            </div>

                                            <!-- Nút Reset -->
                                            <div class="col-md-1 d-flex align-items-end">
                                                <a href="${pageContext.request.contextPath}/c/staff-feedback" class="btn btn-secondary w-100">Reset</a>
                                            </div>
                                        </div>
                                        <input type="hidden" name="page" value="1">
                                    </form>

                                    <!-- Thông báo lỗi nếu có -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger mt-3">${error}</div>
                                    </c:if>

                                    <!-- Bảng dữ liệu -->
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Customer</th>
                                                <th class="border-bottom p-3">Service</th>
                                                <th class="border-bottom p-3">Rating</th>
                                                <th class="border-bottom p-3" style="min-width: 200px;">Comment</th>
                                                <th class="border-bottom p-3" style="min-width: 150px;">Date</th>
                                                <th class="border-bottom p-3" style="min-width: 100px;">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty feedbackList}">
                                                    <tr>
                                                        <td colspan="6" class="text-center p-3">
                                                            <c:choose>
                                                                <c:when test="${not empty param.search}">
                                                                    No feedback found matching "${param.search}".
                                                                </c:when>
                                                                <c:otherwise>
                                                                    No feedback available.
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <c:forEach begin="1" end="4">
                                                        <tr>
                                                            <td class="p-3"></td>
                                                            <td class="p-3"></td>
                                                            <td class="p-3"></td>
                                                            <td class="p-3"></td>
                                                            <td class="p-3"></td>
                                                            <td class="p-3"></td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="feedback" items="${feedbackList}" varStatus="loop">
                                                        <tr>
                                                            <td class="p-3">
                                                                <div class="d-flex align-items-center">
                                                                    <img src="${pageContext.request.contextPath}/${feedback.reservation.customer.avatar}" 
                                                                         class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                    <span class="ms-2">${feedback.reservation.customer.fullname}</span>
                                                                </div>
                                                            </td>
                                                            <td class="p-3">${feedback.reservation.service.name}</td>
                                                            <td class="p-3">
                                                                <div class="star-rating">
                                                                    <c:forEach begin="1" end="5" var="i">
                                                                        <i class="fas fa-star${i <= feedback.rating ? '' : '-o'}"></i>
                                                                    </c:forEach>
                                                                </div>
                                                            </td>
                                                            <td class="p-3">${feedback.comment}</td>
                                                            <td class="p-3">${feedback.date}</td>
                                                            <td class="text-end p-3">
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-primary" data-bs-toggle="modal" data-bs-target="#viewFeedback${feedback.id}">
                                                                    <i class="uil uil-eye"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${feedbackList.size() < 5}">
                                                        <c:forEach begin="${feedbackList.size()}" end="4">
                                                            <tr>
                                                                <td class="p-3"></td>
                                                                <td class="p-3"></td>
                                                                <td class="p-3"></td>
                                                                <td class="p-3"></td>
                                                                <td class="p-3"></td>
                                                                <td class="p-3"></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Showing ${(currentPage - 1) * pageSize + 1} - 
                                        ${currentPage * pageSize > totalFeedbacks ? totalFeedbacks : currentPage * pageSize} 
                                        out of ${totalFeedbacks}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!-- Previous Button -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="${pageContext.request.contextPath}/c/staff-feedback?page=${currentPage - 1}&filterRating=${param.filterRating}&search=${param.search}" 
                                               aria-label="Previous">Prev</a>
                                        </li>
                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" 
                                                   href="${pageContext.request.contextPath}/c/staff-feedback?page=${i}&filterRating=${param.filterRating}&search=${param.search}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <!-- Next Button -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="${pageContext.request.contextPath}/c/staff-feedback?page=${currentPage + 1}&filterRating=${param.filterRating}&search=${param.search}" 
                                               aria-label="Next">Next</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Modal for Viewing Feedback -->
        <c:forEach var="feedback" items="${feedbackList}">
            <div class="modal fade" id="viewFeedback${feedback.id}" tabindex="-1" aria-labelledby="viewFeedbackLabel${feedback.id}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-bottom p-3">
                            <h5 class="modal-title" id="viewFeedbackLabel${feedback.id}">Feedback Detail</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-3 pt-4" style="max-height: 70vh; overflow-y: auto;">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/${feedback.reservation.customer.avatar}" 
                                     class="avatar avatar-small rounded-pill" alt="">
                                <h5 class="mb-0 ms-3">${feedback.reservation.customer.fullname}</h5>
                            </div>
                            <ul class="list-unstyled mb-0 mt-4">
                                <li class="mb-3 d-flex">
                                    <h6 class="mb-0" style="width: 100px;">Service:</h6>
                                    <p class="text-muted ms-2">${feedback.reservation.service.name}</p>
                                </li>
                                <li class="mb-3 d-flex">
                                    <h6 class="mb-0" style="width: 100px;">Rating:</h6>
                                    <p class="text-muted ms-2">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star${i <= feedback.rating ? '' : '-o'}"></i>
                                        </c:forEach>
                                    </p>
                                </li>
                                <li class="mb-3 d-flex">
                                    <h6 class="mb-0" style="width: 100px;">Date:</h6>
                                    <p class="text-muted ms-2">${feedback.date}</p>
                                </li>
                                <li class="mb-3 d-flex">
                                    <h6 class="mb-0" style="width: 100px;">Comment:</h6>
                                    <p class="text-muted ms-2" style="word-wrap: break-word; overflow-wrap: break-word;">${feedback.comment}</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Footer Start -->
        <footer class="bg-footer">
            <div class="container">
                <div class="row">
                    <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                        <p class="mt-4 me-xl-5">We are committed to providing the best healthcare services for children, ensuring their overall development and optimal health.</p>
                    </div>
                    <div class="col-xl-7 col-lg-8 col-md-12">
                        <div class="row">
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">About Us</h5>
                                <ul class="list-unstyled footer-list mt-4"><li>Our Mission</li><li>Our Team</li><li>Our Services</li><li>Success Stories</li><li>Blog & Updates</li></ul>
                            </div>
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Healthcare Services</h5>
                                <ul class="list-unstyled footer-list mt-4"><li>Quick Haircut</li><li>Massage</li><li>Babysitting</li><li>Special Skin Treatment</li><li>Physical Therapy</li></ul>
                            </div>
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Contact Us</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li class="d-flex align-items-center"><i data-feather="mail" class="fea icon-sm text-foot align-middle"></i><span class="text-foot ms-2">contact@childrencare.com</span></li>
                                    <li class="d-flex align-items-center"><i data-feather="phone" class="fea icon-sm text-foot align-middle"></i><span class="text-foot ms-2">+1 234 567 890</span></li>
                                    <li class="d-flex align-items-center"><i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i><span class="video-play-icon text-foot ms-2">Find us on the map</span></li>
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
                        <div class="col-sm-6"><div class="text-sm-start text-center"><p class="text-foot mb-0">© 2025 Children Care. All Rights Reserved.</p></div></div>
                        <div class="col-sm-6 mt-4 mt-sm-0"><ul class="list-unstyled footer-list text-sm-end text-center mb-0"><li class="list-inline-item">Terms</li><li class="list-inline-item">Privacy</li><li class="list-inline-item">About</li><li class="list-inline-item">Contact</li></ul></div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>

        <!-- JavaScript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>
        <script src="../assets/js/select2.init.js"></script>
        <script src="../assets/js/flatpickr.min.js"></script>
        <script src="../assets/js/flatpickr.init.js"></script>
        <script src="../assets/js/jquery.timepicker.min.js"></script>
        <script src="../assets/js/timepicker.init.js"></script>
        <script src="../assets/js/feather.min.js"></script>
        <script src="../assets/js/app.js"></script>
    </body>
</html>