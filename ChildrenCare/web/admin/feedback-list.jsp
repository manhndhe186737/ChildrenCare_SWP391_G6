<%-- 
    Document   : feedback-list
    Created on : Mar 17, 2025, 10:12:01 AM
    Author     : dell
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Feedback Management</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- Favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/unicons.css" rel="stylesheet" type="text/css" />
        <!-- Main CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            /* Feedback Container */
            .feedback-container {
                margin-left: auto;
                margin-right: auto;
                padding: 20px;
                background: #ffffff;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 10px;
                width: 100%;
            }

            @media (max-width: 1200px) {
                .feedback-container {
                    padding: 15px;
                }
            }

            @media (max-width: 768px) {
                .feedback-container {
                    padding: 10px;
                }
            }

            .feedback-title {
                font-size: 24px;
                font-weight: 700;
                color: #333;
                margin-bottom: 20px;
            }

            /* Filter Form */
            .feedback-filter-form {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
                flex-wrap: wrap;
            }

            .feedback-filter-form label {
                font-weight: 500;
                color: #666;
            }

            .feedback-filter-form select,
            .feedback-filter-form input {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
                font-size: 14px;
            }

            .feedback-filter-form input[type="submit"],
            .feedback-filter-form input[type="button"] {
                background: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                transition: background 0.3s;
                padding: 8px 15px;
            }

            .feedback-filter-form input[type="submit"]:hover,
            .feedback-filter-form input[type="button"]:hover {
                background: #0056b3;
            }

            /* Table */
            .feedback-table {
                width: 100%;
                border-collapse: collapse;
            }

            .feedback-table th,
            .feedback-table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                height: 80px;
                font-size: 13px;
                vertical-align: middle;
            }

            .feedback-table th {
                background: #f5f5f5;
                font-weight: bold;
            }

            .feedback-table td img {
                width: 90px;
                border-radius: 5px;
                transition: transform 0.3s;
            }

            .feedback-table td img:hover {
                transform: scale(1.05);
            }

            .empty-row td {
                height: 60px;
                background-color: #f8f9fa;
                border: none;
            }

            .rating-stars {
                color: #FFD700;
                font-size: 14px;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px; /* Khoảng cách đều giữa các nút */
                width: 100%;
                flex-wrap: nowrap; /* Đảm bảo các nút không xuống dòng */
            }

            .action-buttons a {
                flex: 1; /* Chia đều chiều rộng cho các nút */
                padding: 10px 0; /* Điều chỉnh padding để nút không quá cao */
                border-radius: 8px;
                text-decoration: none;
                font-size: 14px; /* Giảm kích thước chữ để nút gọn hơn */
                text-align: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                white-space: nowrap;
            }

            .action-buttons .reply-btn,
            .action-buttons .update-btn {
                background: #ffc107; /* Màu vàng cho nút Reply và Update */
                color: #fff;
            }

            .action-buttons .hide-btn {
                background: #dc3545; /* Màu đỏ cho nút Hide */
                color: #fff;
            }

            .action-buttons .show-btn {
                background: #28a745; /* Màu xanh cho nút Show */
                color: #fff;
            }

            .action-buttons .reply-btn:hover,
            .action-buttons .update-btn:hover {
                background: #e0a800; /* Màu vàng đậm hơn khi hover */
                transform: scale(1.05);
                filter: brightness(0.9);
            }

            .action-buttons .hide-btn:hover {
                background: #c82333; /* Màu đỏ đậm hơn khi hover */
                transform: scale(1.05);
                filter: brightness(0.9);
            }

            .action-buttons .show-btn:hover {
                background: #218838; /* Màu xanh đậm hơn khi hover */
                transform: scale(1.05);
                filter: brightness(0.9);
            }

          /* Pagination */
.pagination-container {
    margin-top: 30px;
    text-align: center;
}

.pagination {
    display: inline-flex;
    padding-left: 0;
    list-style: none;
    border-radius: 5px;
}

.page-item {
    margin: 0 2px;
}

.page-item.disabled {
    display: none; /* Ẩn hoàn toàn khi disabled */
}

.page-item.active .page-link {
    z-index: 1;
    color: #fff;
    background-color: #28a745; /* Màu xanh lá */
    border-color: #28a745;
}

.page-link {
    position: relative;
    display: block;
    padding: 8px 14px;
    line-height: 1.25;
    color: #28a745; /* Màu xanh lá cho text */
    background-color: #fff;
    border: 1px solid #28a745; /* Viền xanh */
    border-radius: 5px;
    text-decoration: none;
    transition: all 0.3s ease;
}

.page-link:hover {
    color: #fff;
    background-color: #218838; /* Màu xanh đậm hơn khi hover */
    border-color: #218838;
    text-decoration: none;
}
            /* Layout */
            .container-fluid {
                width: 100%;
                padding: 0 20px;
            }

            .layout-specing {
                padding: 20px;
            }

            .filter-and-add {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            .page-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .bg-footer {
                margin-top: auto;
            }

            .status-visible {
                color: #28a745;
                font-weight: bold;
            }

            .status-hidden {
                color: #dc3545;
                font-weight: bold;
            }

            /* Popup Styles */
            body.no-scroll {
                overflow: hidden;
            }

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

            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9);
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.2);
                width: 500px;
                max-width: 90%;
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
                transform: translate(-50%, -50%) scale(1);
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
                color: #ff4d4d;
            }

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
                transform: translateY(-2px);
            }

            .btn-primary:active {
                transform: translateY(0);
            }

            .btn-primary:disabled {
                background-color: #6c757d;
                cursor: not-allowed;
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
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);"></div>
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>

            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
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
                                                            <a class="dropdown-item text-dark" href="./admin/dashboard">
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
                                                    <li><a href="../c/staff-reserv" class="sub-menu-item">Reservation</a></li>


                                                </c:if>

                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-menu-item">
                                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li><a href="./service-list" class="sub-menu-item">Services List</a></li>
                                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                                    <li><a href="./myreservation" class="sub-menu-item">My Reservation</a></li>
                                                    <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
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
                                                    <li><a href="./feedbacklist" class="sub-menu-item">Feedback - Management</a></li>
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
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <div>
                                <h5 class="mb-0">Feedback</h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="#">Children Care</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Feedback Management</li>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                        <div class="feedback-container">
                            <h2 class="feedback-title">Feedback Management</h2>

                            <div class="filter-and-add">
                                <form action="${pageContext.request.contextPath}/feedbacklist" method="get" class="feedback-filter-form">
                                    <label>Rating:</label>
                                    <select name="rating">
                                        <option value="" ${rating == null || rating == '' ? 'selected' : ''}>All</option>
                                        <option value="1" ${rating == '1' ? 'selected' : ''}>1 Star</option>
                                        <option value="2" ${rating == '2' ? 'selected' : ''}>2 Stars</option>
                                        <option value="3" ${rating == '3' ? 'selected' : ''}>3 Stars</option>
                                        <option value="4" ${rating == '4' ? 'selected' : ''}>4 Stars</option>
                                        <option value="5" ${rating == '5' ? 'selected' : ''}>5 Stars</option>
                                    </select>

                                    <label>Service:</label>
                                    <select name="serviceName">
                                        <option value="" ${serviceName == null || serviceName == '' ? 'selected' : ''}>All</option>
                                        <c:forEach var="service" items="${serviceList}">
                                            <option value="${service.name}" ${serviceName == service.name ? 'selected' : ''}>${service.name}</option>
                                        </c:forEach>
                                    </select>

                                    <label>Search:</label>
                                    <input type="text" name="search" placeholder="Comment or Service Name" value="${search != null ? search : ''}">

                                    <input type="submit" value="Filter">
                                    <input type="button" value="Reset" onclick="window.location.href = '${pageContext.request.contextPath}/feedbacklist';">
                                </form>
                            </div>

                            <div class="table-container">
                                <c:if test="${empty feedbackList}">
                                    <p>No feedback available.</p>
                                </c:if>
                                <table class="feedback-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 200px;">Service Name</th>
                                            <th style="width: 180px;">Date</th>
                                            <th style="width: 120px;">Rating</th>
                                            <th style="width: 300px;">Comment</th>
                                            <th style="width: 180px;">Image</th>
                                            <th style="width: 200px;">Customer Name</th>
                                            <th style="width: 120px;">Status</th>
                                            <th style="width: 300px;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="feedback" items="${feedbackList}">
                                            <tr>
                                                <td class="text-center">${feedback.reservation.service.name}</td>
                                                <td class="text-center">${feedback.date}</td>
                                                <td class="text-center rating-stars">
                                                    <c:forEach var="i" begin="1" end="5">
                                                        <c:choose>
                                                            <c:when test="${i <= feedback.rating}">
                                                                <span>★</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span>☆</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </td>
                                                <td class="text-center">${feedback.comment}</td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${not empty feedback.img}">
                                                            <img src="${pageContext.request.contextPath}/${feedback.img}" alt="Feedback Image" width="90">
                                                        </c:when>
                                                        <c:otherwise>
                                                            No Image
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">${feedback.reservation.customer.fullname}</td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${feedback.status == 1}">
                                                            <span class="status-visible">Visible</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-hidden">Hidden</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center action-buttons">
                                                    <c:choose>
                                                        <c:when test="${not empty feedback.reply}">
                                                            <a href="#" class="update-btn" data-feedback-id="${feedback.id}" data-reply="${fn:escapeXml(feedback.reply)}">Update</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="#" class="reply-btn" data-feedback-id="${feedback.id}" data-reply="">Reply</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${feedback.status == 1}">
                                                            <a href="#" class="hide-btn" onclick="toggleStatus(${feedback.id}, ${feedback.status});
                                                                    return false;">Hide</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="#" class="show-btn" onclick="toggleStatus(${feedback.id}, ${feedback.status}); return false;">Show</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <c:set var="rowCount" value="${fn:length(feedbackList)}" />
                                        <c:if test="${rowCount < 6}">
                                            <c:forEach var="i" begin="${rowCount + 1}" end="6">
                                                <tr class="empty-row">
                                                    <td colspan="8"></td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                   <!-- Pagination -->
<div class="pagination-container">
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center align-items-center">
                <!-- Previous Button -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/feedbacklist?page=${currentPage - 1}&rating=${rating}&serviceName=${serviceName}&search=${search}" aria-label="Previous">
                        <span aria-hidden="true">Previous</span>
                    </a>
                </li>

                <!-- Page Numbers -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/feedbacklist?page=${i}&rating=${rating}&serviceName=${serviceName}&search=${search}">${i}</a>
                    </li>
                </c:forEach>

                <!-- Next Button -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/feedbacklist?page=${currentPage + 1}&rating=${rating}&serviceName=${serviceName}&search=${search}" aria-label="Next">
                        <span aria-hidden="true">Next</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
                            <!-- Reply Popup -->
                            <div class="overlay" id="replyOverlay"></div>
                            <div class="popup" id="replyPopup">
                                <div class="popup-content">
                                    <span id="closeReplyPopup" class="close">×</span>
                                    <h2 id="popupTitle">Reply to Feedback</h2>
                                    <form id="replyForm">
                                        <textarea id="replyText" name="reply" placeholder="Nhập phản hồi của bạn..." rows="5"></textarea>
                                        <input type="hidden" id="feedbackId" name="feedback_id">
                                        <input type="hidden" id="actionType" name="action">
                                        <button type="submit" class="btn btn-primary" id="submitReplyBtn">Send Reply</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <footer class="bg-footer">
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

                <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
            </main>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
        <script>
                    // Toggle Status
                    function toggleStatus(feedbackId, currentStatus) {
                        const action = currentStatus === 1 ? "hide" : "show";
                        if (confirm("Are you sure you want to " + action + " this feedback?")) {
                            fetch('${pageContext.request.contextPath}/feedback-detail', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'feedback_id=' + feedbackId + '&action=updateStatus&status=' + (currentStatus === 1 ? 0 : 1)
                            })
                                    .then(response => response.text())
                                    .then(data => {
                                        alert("Feedback " + (currentStatus === 1 ? "hidden" : "shown") + " successfully!");
                                        location.reload();
                                    })
                                    .catch(error => {
                                        console.error("Error toggling status: ", error);
                                        alert("An error occurred while trying to " + action + " the feedback.");
                                    });
                        }
                    }

                    // Reply Popup Handling
                    document.addEventListener("DOMContentLoaded", function () {
                        const replyPopup = document.getElementById("replyPopup");
                        const replyOverlay = document.getElementById("replyOverlay");
                        const replyForm = document.getElementById("replyForm");
                        const closeReplyPopupBtn = document.getElementById("closeReplyPopup");
                        const replyText = document.getElementById("replyText");
                        const submitReplyBtn = document.getElementById("submitReplyBtn");
                        const popupTitle = document.getElementById("popupTitle");
                        const actionTypeInput = document.getElementById("actionType");

                        // Open Popup
                        function openReplyPopup(feedbackId, existingReply) {
                            if (!feedbackId) {
                                console.error("Không tìm thấy ID feedback.");
                                alert("ID feedback không hợp lệ!");
                                return;
                            }

                            document.getElementById("feedbackId").value = feedbackId;

                            // Kiểm tra nếu đã có reply
                            if (existingReply) {
                                popupTitle.textContent = "Update Feedback Reply";
                                replyText.value = existingReply;
                                actionTypeInput.value = "updateReply";
                                submitReplyBtn.textContent = "Update";
                            } else {
                                popupTitle.textContent = "Reply to Feedback";
                                replyText.value = "";
                                actionTypeInput.value = "reply";
                                submitReplyBtn.textContent = "Send Reply";
                            }

                            replyPopup.style.display = "block";
                            replyOverlay.style.display = "block";

                            setTimeout(() => {
                                replyPopup.classList.add("show");
                                replyOverlay.classList.add("show");
                                document.body.classList.add("no-scroll");
                            }, 10);
                        }

                        // Close Popup
                        function closeReplyPopup() {
                            replyPopup.classList.remove("show");
                            replyOverlay.classList.remove("show");
                            document.body.classList.remove("no-scroll");

                            setTimeout(() => {
                                replyPopup.style.display = "none";
                                replyOverlay.style.display = "none";
                                replyForm.reset();
                            }, 300);
                        }

                        // Attach event to Reply and Update buttons
                        document.querySelectorAll(".reply-btn, .update-btn").forEach(button => {
                            button.addEventListener("click", function (e) {
                                e.preventDefault();
                                const feedbackId = this.getAttribute("data-feedback-id");
                                const existingReply = this.getAttribute("data-reply");
                                openReplyPopup(feedbackId, existingReply);
                            });
                        });

                        // Close Popup Events
                        if (closeReplyPopupBtn)
                            closeReplyPopupBtn.addEventListener("click", closeReplyPopup);
                        replyOverlay.addEventListener("click", closeReplyPopup);

                        // Submit Reply Form
                        replyForm.addEventListener("submit", function (event) {
                            event.preventDefault();

                            const action = actionTypeInput.value;
                            const actionText = action === "reply" ? "gửi phản hồi" : "cập nhật phản hồi";
                            if (!confirm("Bạn có chắc chắn muốn " + actionText + " này?"))
                                return;

                            submitReplyBtn.disabled = true;
                            submitReplyBtn.textContent = action === "reply" ? "Đang gửi..." : "Đang cập nhật...";

                            const feedbackId = document.getElementById("feedbackId").value;
                            const replyContent = replyText.value.trim();

                            if (!replyContent) {
                                alert("Vui lòng nhập nội dung phản hồi!");
                                submitReplyBtn.disabled = false;
                                submitReplyBtn.textContent = action === "reply" ? "Send Reply" : "Update";
                                return;
                            }

                            fetch("${pageContext.request.contextPath}/feedbacklist", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/x-www-form-urlencoded",
                                },
                                body: "feedback_id=" + feedbackId + "&action=" + action + "&reply=" + encodeURIComponent(replyContent)
                            })
                                    .then(response => response.text())
                                    .then(data => {
                                        // Phân tích chuỗi phản hồi
                                        const params = new URLSearchParams(data);
                                        const success = params.get("success") === "true";
                                        const message = params.get("message");

                                        if (success) {
                                            alert("Phản hồi đã được " + (action === "reply" ? "gửi" : "cập nhật") + " thành công!");
                                            closeReplyPopup();
                                            location.reload();
                                        } else {
                                            alert((action === "reply" ? "Gửi" : "Cập nhật") + " phản hồi thất bại: " + (message || "Lỗi không xác định"));
                                        }
                                    })
                                    .catch(error => {
                                        console.error("Lỗi khi " + actionText + ":", error);
                                        alert((action === "reply" ? "Gửi" : "Cập nhật") + " phản hồi thất bại: " + error.message);
                                    })
                                    .finally(() => {
                                        submitReplyBtn.disabled = false;
                                        submitReplyBtn.textContent = action === "reply" ? "Send Reply" : "Update";
                                    });
                        });
                    });
        </script>
    </body>

</html>