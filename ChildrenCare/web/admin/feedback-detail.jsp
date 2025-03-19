<%-- 
    Document   : feedback-detail
    Created on : Mar 17, 2025, 10:12:01 AM
    Author     : dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Children Care - Feedback Detail</title>
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
        .feedback-detail-container {
            margin-left: auto;
            margin-right: auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
            width: 100%;
        }

        .feedback-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: 500;
            color: #666;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-direction: row;
            align-items: center;
            width: 100%;
        }

        .action-buttons button {
            padding: 10px 25px;
            border-radius: 8px;
            font-size: 16px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
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
            border: none;
            cursor: pointer;
        }

        .action-buttons .update-status-btn {
            background: #28a745;
            color: #fff;
        }

        .action-buttons .update-reply-btn {
            background: #17a2b8;
            color: #fff;
        }

        .action-buttons .back-btn {
            background: #007bff;
            color: #fff;
        }

        .action-buttons .update-status-btn:hover {
            background: #218838;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .action-buttons .update-reply-btn:hover {
            background: #138496;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .action-buttons .back-btn:hover {
            background: #0056b3;
            transform: scale(1.05);
            filter: brightness(0.9);
        }

        .image-preview {
            max-width: 200px;
            border-radius: 5px;
            margin-top: 10px;
        }

        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        @media (max-width: 768px) {
            .feedback-detail-container {
                padding: 10px;
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
                                    <li class="breadcrumb-item active" aria-current="page">Feedback Detail</li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <div class="feedback-detail-container">
                        <h2 class="feedback-title">Feedback Detail</h2>
                        <!-- Hiển thị thông báo thành công -->
                        <c:if test="${param.success == 'StatusUpdated'}">
                            <div class="alert alert-success" role="alert">
                                Status updated successfully!
                            </div>
                        </c:if>
                        <c:if test="${param.success == 'ReplyUpdated'}">
                            <div class="alert alert-success" role="alert">
                                Reply updated successfully!
                            </div>
                        </c:if>
                        <c:if test="${feedback != null}">
                            <!-- Form cập nhật status -->
                            <form action="${pageContext.request.contextPath}/feedback-detail" method="post">
                                <input type="hidden" name="feedback_id" value="${feedback.id}">
                                <input type="hidden" name="action" value="updateStatus">
                                <div class="form-group">
                                    <label>Rating:</label>
                                    <input type="text" name="rating" value="${feedback.rating}" readonly disabled>
                                </div>
                                <div class="form-group">
                                    <label>Feedback Comment:</label>
                                    <textarea name="comment" readonly disabled>${feedback.comment}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Image:</label>
                                    <c:if test="${not empty feedback.img}">
                                        <img src="${pageContext.request.contextPath}/${feedback.img}" alt="Feedback Image" class="image-preview">
                                    </c:if>
                                    <c:if test="${empty feedback.img}">
                                        <p>No Image</p>
                                    </c:if>
                                    <input type="hidden" name="img" value="${feedback.img}">
                                </div>
                                <div class="form-group">
                                    <label>Status:</label>
                                    <select name="status">
                                        <option value="1" ${feedback.status == 1 ? 'selected' : ''}>Visible</option>
                                        <option value="0" ${feedback.status == 0 ? 'selected' : ''}>Hidden</option>
                                    </select>
                                </div>
                                <div class="action-buttons">
                                    <button type="submit" class="update-status-btn">Update Status</button>
                                </div>
                            </form>

                            <!-- Form cập nhật reply -->
                            <form action="${pageContext.request.contextPath}/feedback-detail" method="post" style="margin-top: 20px;">
                                <input type="hidden" name="feedback_id" value="${feedback.id}">
                                <input type="hidden" name="action" value="updateReply">
                                <div class="form-group">
                                    <label>Reply:</label>
                                    <textarea name="reply">${feedback.reply}</textarea>
                                </div>
                                <div class="action-buttons">
                                    <button type="submit" class="update-reply-btn">Update Reply</button>
                                    <a href="${pageContext.request.contextPath}/feedbacklist" class="back-btn">Back to Feedback List</a>
                                </div>
                            </form>
                        </c:if>
                        <c:if test="${feedback == null}">
                            <p>Feedback not found.</p>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/feedbacklist" class="back-btn">Back to Feedback List</a>
                            </div>
                        </c:if>
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
</body>
</html>