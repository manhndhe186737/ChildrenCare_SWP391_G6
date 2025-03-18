<%-- 
    Document   : feedback-management
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
    <meta name="website" content="../../../index.html" />
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

        .feedback-filter-form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
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

        .feedback-filter-form input[type="submit"] {
            background: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }

        .feedback-filter-form input[type="submit"]:hover {
            background: #0056b3;
        }

        .table-container {
            /* Không giới hạn chiều cao, tự động mở rộng */
        }

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

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-direction: row;
            align-items: center;
            width: 100%;
        }

        .action-buttons a {
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            display: inline-block;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .action-buttons .view-btn {
            background: #28a745;
            color: #fff;
        }

        .action-buttons .delete-btn {
            background: #dc3545;
            color: #fff;
        }

        .action-buttons .hide-btn,
        .action-buttons .show-btn {
            background: #ffc107;
            color: #fff;
        }

        .action-buttons .view-btn:hover {
            background: #218838;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .action-buttons .delete-btn:hover {
            background: #c82333;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .action-buttons .hide-btn:hover,
        .action-buttons .show-btn:hover {
            background: #ff9800;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .pagination-container {
            margin-top: 30px;
            text-align: center;
        }

        .pagination a {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            transition: background 0.3s;
        }

        .pagination a:hover,
        .pagination a.active {
            background: #007bff;
            color: #fff;
        }

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

        /* Optional: Add color to status for better readability */
        .status-visible {
            color: #28a745; /* Green for Visible */
            font-weight: bold;
        }

        .status-hidden {
            color: #dc3545; /* Red for Hidden */
            font-weight: bold;
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

        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <div class="top-header">
                <div class="header-bar d-flex justify-content-between border-bottom">
                    <header id="topnav" class="defaultscroll sticky">
                        <div class="container">
                            <div>
                                <a class="logo" href="${pageContext.request.contextPath}/c/home">
                                    <span class="logo-light-mode">
                                        <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                                        <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                                    </span>
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
                                </a>
                            </div>

                            <div class="menu-extras">
                                <div class="menu-item">
                                    <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                                        <div class="lines">
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                        </div>
                                    </a>
                                </div>
                            </div>

                            <ul class="dropdowns list-inline mb-0">
                                <li class="list-inline-item mb-0 ms-1">
                                    <div class="dropdown dropdown-primary">
                                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" class="avatar avatar-ex-small rounded-circle" alt="">
                                        </button>
                                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                            <a class="dropdown-item d-flex align-items-center text-dark">
                                                <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-2">
                                                    <span class="d-block mb-1">User Name</span>
                                                </div>
                                            </a>
                                            <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/profile">
                                                <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                            </a>
                                            <div class="dropdown-divider border-top"></div>
                                            <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/logout">
                                                <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                            </a>
                                        </div>
                                    </div>
                                </li>
                            </ul>

                            <div id="navigation">
                                <ul class="navigation-menu nav-left nav-dark">
                                    <li class="has-submenu parent-parent-menu-item">
                                        <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                                        <ul class="submenu">
                                            <li><a href="#" class="sub-menu-item">Staff List</a></li>
                                        </ul>
                                    </li>
                                    <li class="has-submenu parent-menu-item">
                                        <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                                        <ul class="submenu">
                                            <li><a href="${pageContext.request.contextPath}/service-list" class="sub-menu-item">Services List</a></li>
                                        </ul>
                                    </li>
                                    <li class="has-submenu parent-parent-menu-item">
                                        <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                                        <ul class="submenu">
                                            <li><a href="${pageContext.request.contextPath}/blog" class="sub-menu-item">Blogs</a></li>
                                            <li><a href="${pageContext.request.contextPath}/feedbacklist" class="sub-menu-item">Feedback Management</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </header>
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
                                <label>Search:</label>
                                <input type="text" name="search" placeholder="Enter comment" value="${search != null ? search : ''}">
                                <input type="submit" value="Filter">
                            </form>
                        </div>

                        <div class="table-container">
                            <c:if test="${empty feedbackList}">
                                <p>No feedback available.</p>
                            </c:if>
                            <table class="feedback-table">
                                <thead>
                                    <tr>
                                        <th style="width: 120px;">ID</th>
                                        <th style="width: 180px;">Date</th>
                                        <th style="width: 120px;">Rating</th>
                                        <th style="width: 300px;">Comment</th>
                                        <th style="width: 180px;">Image</th>
                                        <th style="width: 100px;">Reservation ID</th>
                                        <th style="width: 120px;">Status</th>
                                        <th style="width: 300px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="feedback" items="${feedbackList}">
                                        <tr>
                                            <td class="text-center">${feedback.id}</td>
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
                                            <td class="text-center">${feedback.reservation.id}</td>
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
                                               <a href="${pageContext.request.contextPath}/admin/feedback-detail.jsp?id=${feedback.id}" class="view-btn">View</a>

                                                <a href="#" class="delete-btn" onclick="confirmDelete(${feedback.id}); return false;">Delete</a>
                                                <c:choose>
                                                    <c:when test="${feedback.status == 1}">
                                                        <a href="#" class="hide-btn" onclick="toggleStatus(${feedback.id}, ${feedback.status}); return false;">Hide</a>
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
                                <c:if test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/feedbacklist?page=${currentPage - 1}&rating=${rating}&search=${search}" class="btn btn-secondary">Previous</a>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <c:if test="${i == currentPage}">
                                        <span class="btn btn-primary">${i}</span>
                                    </c:if>
                                    <c:if test="${i != currentPage}">
                                        <a href="${pageContext.request.contextPath}/feedbacklist?page=${i}&rating=${rating}&search=${search}" class="btn btn-outline-primary">${i}</a>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/feedbacklist?page=${currentPage + 1}&rating=${rating}&search=${search}" class="btn btn-secondary">Next</a>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer Start -->
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
            <!-- Footer End -->

            <!-- Back to top -->
            <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        </main>
    </div>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        function confirmDelete(feedbackId) {
            console.log("Attempting to delete feedback with ID: " + feedbackId); // Debugging
            if (confirm("Are you sure you want to delete this feedback?")) {
                try {
                    window.location.href = "${pageContext.request.contextPath}/deletefeedback?id=" + feedbackId;
                } catch (error) {
                    console.error("Error redirecting to delete endpoint: ", error);
                    alert("An error occurred while trying to delete the feedback. Please try again.");
                }
            }
        }

        function toggleStatus(feedbackId, currentStatus) {
            console.log("Attempting to toggle status for feedback ID: " + feedbackId + " with current status: " + currentStatus);
            const action = currentStatus === 1 ? "hide" : "show";
            if (confirm("Are you sure you want to " + action + " this feedback?")) {
                try {
                    // Send an AJAX request to update the status
                    fetch('${pageContext.request.contextPath}/feedback', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'id=' + feedbackId + '&status=' + (currentStatus === 1 ? 0 : 1)
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert("Feedback " + (currentStatus === 1 ? "hidden" : "shown") + " successfully!");
                            // Reload the page to reflect the updated status
                            location.reload();
                        } else {
                            alert("Failed to " + action + " feedback: " + data.message);
                        }
                    })
                    .catch(error => {
                        console.error("Error toggling status: ", error);
                        alert("An error occurred while trying to " + action + " the feedback. Please try again.");
                    });
                } catch (error) {
                    console.error("Error in toggleStatus: ", error);
                    alert("An error occurred while trying to " + action + " the feedback. Please try again.");
                }
            }
        }
    </script>
</body>

</html>