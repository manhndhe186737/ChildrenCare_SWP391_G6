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

        <style>
            /* Ngăn cuộn trang khi popup mở */
            body.no-scroll {
                overflow: hidden;
            }

            /* Overlay che toàn bộ màn hình */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                z-index: 999;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            /* Popup container */
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9); /* Bắt đầu với scale nhỏ hơn */
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.2);
                width: 500px; /* Tăng kích thước */
                max-width: 90%; /* Responsive */
                text-align: center;
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.3s ease, transform 0.3s ease;
            }

            .popup.show,
            .overlay.show {
                display: block;
                opacity: 1;
            }

            .popup.show {
                transform: translate(-50%, -50%) scale(1); /* Phóng to khi hiển thị */
            }

            .close {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 28px;
                cursor: pointer;
                color: #555;
                transition: color 0.2s ease;
            }

            .close:hover {
                color: #ff4d4d; /* Hiệu ứng hover cho nút đóng */
            }

            /* Star Rating */
            .star-rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: center;
                gap: 8px;
                margin-bottom: 20px;
            }

            .star-rating input {
                display: none;
            }

            .star-rating label {
                font-size: 35px;
                color: #ddd;
                cursor: pointer;
                transition: color 0.3s ease, transform 0.2s ease;
            }

            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #f5c518; /* Màu vàng đậm */
                transform: scale(1.2); /* Hiệu ứng phóng to khi hover */
            }

            /* Textarea */
            textarea {
                width: 100%;
                padding: 12px;
                border-radius: 8px;
                border: 1px solid #ccc;
                margin-bottom: 20px;
                resize: none;
                font-size: 16px;
                box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
                transition: border-color 0.3s ease;
            }

            textarea:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }

            /* File Input (nếu có) */
            input[type="file"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                background-color: #f9f9f9;
                cursor: pointer;
            }

            /* Preview Image (nếu có) */
            .preview-container img {
                display: none;
                max-width: 100%;
                max-height: 200px;
                border-radius: 10px;
                border: 1px solid #ddd;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                object-fit: cover;
                margin-top: 10px;
            }

            /* Button */
            .btn-primary {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.3s ease, transform 0.2s ease;
                width: 100%;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                transform: translateY(-2px); /* Hiệu ứng nâng nút khi hover */
            }

            .btn-primary:active {
                transform: translateY(0);
            }

            .btn-primary.loading::after {
                content: "";
                display: inline-block;
                width: 16px;
                height: 16px;
                border: 2px solid #fff;
                border-top: 2px solid transparent;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin-left: 10px;
                vertical-align: middle;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
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

                <div class="col-lg-12">
                    <div class="d-flex justify-content-between">
                        <button onclick="window.location.href = 'myreservation'" class="btn btn-primary" style="width: auto; height: 40px; padding: 5px 10px;">Back</button>
                    </div>
                </div>

                &nbsp;

                <!-- Reservation Table -->
                <div class="table-container">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive bg-white shadow rounded">
                                <table class="table table-center table-padding mb-0">
                                    <thead>
                                        <tr>
                                            <th class="border-bottom text-center p-3" style="width: 150px;"> <!-- Cố định chiều rộng cho cột Service Name -->
                                                <a class="text-decoration-none text-dark">Customer Name</a>
                                            </th>
                                            <th class="border-bottom text-center p-3" style="width: 250px;"> <!-- Cố định chiều rộng cho cột Service Name -->
                                                <a class="text-decoration-none text-dark">Customer Address</a>
                                            </th>
                                            <th class="border-bottom text-center p-3" style="width: 150px;">DateBook</th> <!-- Cố định chiều rộng cho cột DateBook -->
                                            <th class="border-bottom text-center p-3" style="width: 120px;">Status</th>
                                            <th class="border-bottom text-center p-3" style="width: 250px;">Note</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="table-row">
                                            <td class="p-3 text-center">${requestScope.reserv.customerName}</td>
                                            <td class="p-3 text-center">${requestScope.reserv.customerAddress}</td>
                                            <td class="p-3 text-center"><fmt:formatDate value="${requestScope.reserv.bookdate}" pattern="yyyy-MM-dd" /></td>
                                            <td class="text-center p-3">
                                                <span class="badge
                                                      ${requestScope.reserv.status == 'Completed' ? 'badge-success' : 
                                                        requestScope.reserv.status == 'Scheduled' ? 'badge-warning' : 'badge-danger'}">
                                                          ${requestScope.reserv.status}
                                                      </span>
                                                </td>
                                                <td class="border-bottom text-center p-3">${requestScope.reserv.note}</td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <!-- Service Info - Left Side -->
                        <div class="col-md-6">
                            <h5>Service</h5>
                            <div class="service-info bg-light p-3 rounded shadow d-flex" style="gap: 20px; height: 180px; max-height: 180px;">
                                <!-- Image on the left -->
                                <img src="${pageContext.request.contextPath}/${requestScope.reserv.service.img}" alt="" class="img-fluid rounded" style="max-width: 150px; max-height: 150px; object-fit: cover;">
                                <!-- Information on the right -->
                                <div class="d-flex flex-column justify-content-center" style="height: 100%; text-align: left;">
                                    <p><strong>${requestScope.reserv.service.name}</strong></p>
                                    <p>${requestScope.reserv.service.description}</p>
                                    <p>$${requestScope.reserv.service.price}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Staff Info - Right Side -->
                        <div class="col-md-6">
                            <h5>Staff</h5>
                            <div class="staff-info bg-light p-3 rounded shadow d-flex" style="gap: 20px; height: 180px; max-height: 180px;">
                                <!-- Image on the left -->
                                <img src="${pageContext.request.contextPath}/${requestScope.reserv.staff.avatar}" alt="${requestScope.reserv.staff.fullname}" class="img-fluid rounded" style="max-width: 150px; max-height: 150px; object-fit: cover;">
                                <!-- Information on the right -->
                                <div class="d-flex flex-column justify-content-center" style="height: 100%; text-align: left;">
                                    <p><strong>${requestScope.reserv.staff.fullname}</strong> </p>
                                    <p>${requestScope.profile.certification}</p>
                                    <p>${requestScope.profile.specialties}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="staff-info bg-light p-3 rounded shadow">
                                <table class="table mb-0">
                                    <tbody>
                                        <tr>
                                            <td class="text-center"><strong>Method</strong></td>
                                            <td class="text-center">${requestScope.reserv.payment.method}</td>
                                            <td rowspan="3" class="align-middle text-center">
                                                <div class="d-flex flex-column align-items-center">
                                                    <c:choose>
                                                        <c:when test="${requestScope.reserv.status eq 'Completed'}">
                                                            <c:choose>
                                                                <c:when test="${requestScope.hasFeedback}">
                                                                    <button class="btn btn-info mb-2 w-100 feedbackBtn" data-reserv-id="${requestScope.reserv.id}">Update Feedback</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-success mb-2 w-100 feedbackBtn" data-reserv-id="${requestScope.reserv.id}">Feedback</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <button class="btn btn-primary mb-2 w-100">Reschedule</button>
                                                        </c:when>
                                                        <c:when test="${requestScope.reserv.status eq 'Cancelled'}">
                                                            <form id="fbook" action="c/BookingStaff" method="post" class="w-100">
                                                                <input type="hidden" name="service_id" value="${requestScope.reserv.service.id}"/>
                                                                <input type="hidden" name="service_name" value="${requestScope.reserv.service.name}"/>
                                                                <input type="submit" class="btn btn-primary mb-2 w-100" value="Reschedule"/>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form id="fcancel" action="cancelReservation" method="post" class="w-100">
                                                                <input type="hidden" name="rsv_id" value="${requestScope.reserv.id}"/>
                                                                <input type="submit" class="btn btn-danger mb-2 w-100" value="Cancel"/>
                                                            </form>
                                                            <!--                                                            <button class="btn btn-danger mb-2 w-100">Cancel</button>-->
                                                            <button class="btn btn-warning mb-2 w-100" data-bs-toggle="modal" data-bs-target="#updateModal">
                                                                Update
                                                            </button>

                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center"><strong>Status</strong></td>
                                            <td class="text-center">${requestScope.reserv.payment.status}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-center"><strong>Amount</strong></td>
                                            <td class="text-center">${requestScope.reserv.payment.amount} VND</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
            </section>


            <!-- Overlay -->
            <div class="overlay" id="overlay"></div>

            <!-- Popup -->
            <div class="popup" id="feedbackPopup">
                <div class="popup-content">
                    <span id="closePopup" class="close">×</span>
                    <h2>Feedback</h2>
                    <form id="feedbackForm" enctype="multipart/form-data">
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5">
                            <label for="star5">★</label>
                            <input type="radio" id="star4" name="rating" value="4">
                            <label for="star4">★</label>
                            <input type="radio" id="star3" name="rating" value="3">
                            <label for="star3">★</label>
                            <input type="radio" id="star2" name="rating" value="2">
                            <label for="star2">★</label>
                            <input type="radio" id="star1" name="rating" value="1">
                            <label for="star1">★</label>
                        </div>
                        <textarea id="feedbackText" name="comment" placeholder="Nhập phản hồi của bạn..." rows="5"></textarea>

                        <!-- Input chọn ảnh -->
                        <label for="feedbackImage" class="file-label">Choose image</label>
                        <input type="file" id="feedbackImage" name="imageFile" accept="image/*">

                        <!-- Xem trước ảnh -->
                        <div class="preview-container">
                            <img id="previewImage" src="" alt="Ảnh xem trước" style="display:none;">
                        </div>

                        <input type="hidden" id="reservId" name="reserv_id">
                        <button type="submit" class="btn btn-primary">Send</button>
                    </form>
                </div>
            </div>                                      







            <!-- Modal Update -->
            <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateModalLabel">Update Reservation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="updateReservation" method="POST" id="updateForm">
                                <!-- Hidden fields for existing reservation data -->
                                <input type="hidden" name="rid" value="${requestScope.reserv.id}" />

                                <div class="mb-3">
                                    <label class="form-label">Customer Name</label>
                                    <input type="text" name="cus_name" class="form-control" value="${requestScope.reserv.customerName}" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Customer Address</label>
                                    <input type="text" name="cus_address" class="form-control" value="${requestScope.reserv.customerAddress}" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Service</label>
                                    <input type="text" readonly class="form-control" value="${requestScope.reserv.service.name}" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Comments</label>
                                    <textarea name="comments" rows="4" class="form-control" placeholder="Additional comments">${requestScope.reserv.note}</textarea>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary ms-2">Save Changes</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>


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


            <!-- javascript -->
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
            <!-- Icons -->
            <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
            <!-- Main Js -->
            <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

            <script>
                document.getElementById('fcancel').addEventListener('submit', function (event) {
                    event.preventDefault();  // Ngừng việc gửi form ngay lập tức

                    // Hiển thị thông báo xác nhận
                    Swal.fire({
                        title: 'Are you sure?',
                        text: 'Do you really want to cancel the reservation?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Yes, cancel it!',
                        cancelButtonText: 'No, keep it'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Nếu người dùng chọn "Yes", submit form
                            event.target.submit();
                        }
                    });
                });

            </script>

            <script>


                var alertMessage = '<%= session.getAttribute("success") != null ? session.getAttribute("success") : "" %>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "success" %>'; // Lấy alertType nếu có, mặc định là "error"

                // Kiểm tra nếu có thông báo thì hiển thị Swal.fire
                if (alertMessage.trim() !== "") {
                    Swal.fire({
                        icon: alertType, // success, error, warning
                        title: alertMessage,
                        showConfirmButton: false,
                        timer: 3000  // Thời gian hiển thị thông báo là 3 giây
                    });
                    // Xóa thông báo khỏi session sau khi hiển thị
                <%
                session.removeAttribute("success");
                session.removeAttribute("alertType");
                %>
                }

                // Lắng nghe sự kiện submit của form
                document.querySelector('form').addEventListener('submit', function (event) {
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

                var alertMessage = '<%= session.getAttribute("errorMessage") != null ? session.getAttribute("errorMessage") : "" %>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "error" %>'; // Lấy alertType nếu có, mặc định là "error"

                // Kiểm tra nếu có thông báo thì hiển thị Swal.fire
                if (alertMessage.trim() !== "") {
                    Swal.fire({
                        icon: alertType, // success, error, warning
                        title: alertMessage,
                        showConfirmButton: false,
                        timer: 3000  // Thời gian hiển thị thông báo là 3 giây
                    });
                    // Xóa thông báo khỏi session sau khi hiển thị
                <%
                session.removeAttribute("errorMessage");
                session.removeAttribute("alertType");
                %>
                }

                $(document).ready(function () {
                    $("#updateForm").submit(function (e) {
                        // Ngừng hành động mặc định của form
                        e.preventDefault();

                        // Lấy giá trị từ các trường
                        var customerName = $("input[name='cus_name']").val().trim();
                        var customerAddress = $("input[name='cus_address']").val().trim();
                        var comments = $("textarea[name='comments']").val().trim();

                        // Kiểm tra trường Customer Name
                        if (customerName === "") {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Customer Name is required!',
                            });
                            return false;
                        }

                        // Kiểm tra trường Customer Address
                        if (customerAddress === "") {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Customer Address is required!',
                            });
                            return false;
                        }

                        // Nếu không có lỗi, gửi form
                        this.submit();
                    });
                });

            </script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const feedbackPopup = document.getElementById("feedbackPopup");
                    const overlay = document.getElementById("overlay");
                    const feedbackForm = document.getElementById("feedbackForm");
                    const closePopupBtn = document.getElementById("closePopup");
                    const feedbackText = document.getElementById("feedbackText");
                    const feedbackImage = document.getElementById("feedbackImage");
                    const previewImage = document.getElementById("previewImage");
                    const submitBtn = feedbackForm.querySelector(".btn-primary");

                    // Hàm cập nhật màu sao dựa trên ratingValue
                    function updateStarColors(ratingValue) {
                        document.querySelectorAll('.star-rating label').forEach((label, index) => {
                            const input = document.getElementById(label.getAttribute("for"));
                            label.style.color = input && parseInt(input.value) <= parseInt(ratingValue) ? "#f5c518" : "#ddd";
                        });
                    }

                    // Xem trước ảnh với kiểm tra kích thước file
                    feedbackImage.addEventListener("change", function (event) {
                        const file = event.target.files[0];
                        if (file) {
                            if (file.size > 5 * 1024 * 1024) {
                                alert("Ảnh quá lớn! Vui lòng chọn ảnh dưới 5MB.");
                                feedbackImage.value = "";
                                previewImage.style.display = "none";
                                return;
                            }
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                previewImage.src = e.target.result;
                                previewImage.style.display = "block";
                            };
                            reader.readAsDataURL(file);
                        } else {
                            previewImage.style.display = "none";
                        }
                    });

                    // Hàm mở popup
                    function openPopup(reservId, isUpdate) {
                        if (!reservId) {
                            console.error("Không tìm thấy ID đặt chỗ.");
                            alert("ID đặt chỗ không hợp lệ!");
                            return;
                        }

                        console.log("Mở popup với reserv_id:", reservId, "isUpdate:", isUpdate);

                        document.getElementById("reservId").value = reservId;
                        feedbackPopup.style.display = "block";
                        overlay.style.display = "block";

                        setTimeout(() => {
                            feedbackPopup.classList.add("show");
                            overlay.classList.add("show");
                            document.body.classList.add("no-scroll");
                        }, 10);

                        if (isUpdate) {
                            console.log("Đang lấy dữ liệu feedback từ server...");
                            fetch("${pageContext.request.contextPath}/feedback?reserv_id=" + reservId)
                                    .then(response => {
                                        if (!response.ok) {
                                            throw new Error(`Lỗi HTTP! Trạng thái: ${response.status}`);
                                        }
                                        return response.json();
                                    })
                                    .then(data => {
                                        console.log("Dữ liệu từ server:", data);
                                        if (data.success && data.data) {
                                            const feedbackData = data.data;
                                            feedbackText.value = feedbackData.comment || "";
                                            const ratingValue = String(feedbackData.rating || 1);
                                            document.querySelectorAll('input[name="rating"]').forEach(input => {
                                                input.checked = input.value === ratingValue;
                                            });
                                            updateStarColors(ratingValue);

                                            if (feedbackData.img) {
                                                previewImage.src = "${pageContext.request.contextPath}/" + feedbackData.img;
                                                previewImage.style.display = "block";
                                            } else {
                                                previewImage.style.display = "none";
                                            }
                                        } else {
                                            console.error("Lỗi từ server:", data.message || "Không lấy được dữ liệu feedback");
                                            feedbackForm.reset();
                                            previewImage.style.display = "none";
                                            alert("Không thể tải dữ liệu feedback: " + (data.message || "Lỗi không xác định"));
                                        }
                                    })
                                    .catch(error => {
                                        console.error("Lỗi khi lấy feedback:", error);
                                        feedbackForm.reset();
                                        previewImage.style.display = "none";
                                        alert("Lỗi khi tải dữ liệu feedback: " + error.message);
                                    });
                        } else {
                            feedbackForm.reset();
                            previewImage.style.display = "none";
                            updateStarColors(0); // Reset sao về màu xám khi tạo mới
                        }
                    }

                    // Hàm đóng popup
                    function closePopup() {
                        feedbackPopup.classList.remove("show");
                        overlay.classList.remove("show");
                        document.body.classList.remove("no-scroll");

                        setTimeout(() => {
                            feedbackPopup.style.display = "none";
                            overlay.style.display = "none";
                            feedbackForm.reset();
                        }, 300);
                    }

                    // Thêm sự kiện change để cập nhật màu sao khi người dùng chọn
                    document.querySelectorAll('input[name="rating"]').forEach(input => {
                        input.addEventListener('change', function () {
                            updateStarColors(this.value);
                        });
                    });

                    document.querySelectorAll(".feedbackBtn").forEach(button => {
                        button.addEventListener("click", function () {
                            openPopup(this.getAttribute("data-reserv-id"), this.textContent.trim() === "Update Feedback");
                        });
                    });

                    if (closePopupBtn)
                        closePopupBtn.addEventListener("click", closePopup);
                    overlay.addEventListener("click", closePopup);

                    // Gửi feedback kèm ảnh với xác nhận và loading
                    feedbackForm.addEventListener("submit", function (event) {
                        event.preventDefault();

                        if (!confirm("Bạn có chắc chắn muốn gửi phản hồi này?")) {
                            return;
                        }

                        submitBtn.disabled = true;
                        submitBtn.textContent = "Đang gửi...";

                        let formData = new FormData(feedbackForm);
                        const reservId = document.getElementById("reservId").value;

                        fetch("${pageContext.request.contextPath}/feedback", {
                            method: "POST",
                            body: formData
                        })
                                .then(response => {
                                    if (!response.ok)
                                        throw new Error("Lỗi HTTP: " + response.status);
                                    return response.json();
                                })
                                .then(data => {
                                    if (data.success) {
                                        alert(data.message);
                                        closePopup();
                                        window.location.href = "${pageContext.request.contextPath}/reserv-infor?rid=" + reservId;
                                    } else {
                                        alert("Gửi phản hồi thất bại: " + (data.message || "Lỗi không xác định"));
                                    }
                                })
                                .catch(error => {
                                    console.error("Lỗi khi gửi feedback:", error);
                                    alert("Gửi phản hồi thất bại: " + error.message);
                                })
                                .finally(() => {
                                    submitBtn.disabled = false;
                                    submitBtn.textContent = "Gửi";
                                });
                    });
                });
            </script>

        </body>
    </html>
