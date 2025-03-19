<%@ page import="model.ServiceCategory" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Settings - Service Categories</title>
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <link href="./assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            /* Toggle switch styling */
            .toggle-wrapper {
                display: flex;
                align-items: center;
            }

            .toggle {
                position: relative;
                width: 60px;
                height: 34px;
            }

            .toggle input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: 0.4s;
                border-radius: 50px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                border-radius: 50px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: 0.4s;
            }

            input:checked + .toggle-slider {
                background-color: #4CAF50;
            }

            input:checked + .toggle-slider:before {
                transform: translateX(26px);
            }

            .toggle-label {
                margin-left: 10px;
                font-weight: bold;
            }
            .container.mt-4 {
                position: relative;
                min-height: 80vh;
                padding-bottom: 20px  !important;
            }


            footer.bg-footer {
                position: relative;
                bottom: 0;
                width: 100%;
            }

            #topnav {
                position: relative;
                z-index: 999;
            }


            /* Ensure Add button has same style as Search button */
            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            /* Optional: To align both buttons on the same line */
            .d-flex {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .modal-content{
                margin-top: 200px;
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
        <div class="container mt-4">
            <h2>Settings</h2>


            <div class="d-flex justify-content-between mb-3">
                <form action="settings" method="GET" class="d-flex">
                    <!-- Search by Name -->
                    <input type="text" name="name" class="form-control me-2" placeholder="Search by Name" value="${param.name}">

                    <!-- Filter by Status -->
                    <select name="status" class="form-select me-2">
                        <option value="">All Status</option>
                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                    </select>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
                <!-- Add New Category Button -->
                <a href="#" class="btn btn-primary ms-3" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    <i class="bi bi-plus-circle"></i> Add New Category
                </a>
            </div>


            <!-- Add Category Modal -->
            <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="settings" method="POST">
                                <input type="hidden" name="action" value="add">
                                <div class="form-group mb-3">
                                    <label for="categoryName">Category Name</label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="categoryStatus">Status</label>
                                    <div class="toggle-wrapper">
                                        <label class="toggle">
                                            <input type="checkbox" name="status" class="form-check-input">
                                            <span class="toggle-slider"></span>
                                        </label>
                                        <span class="toggle-label">Active</span>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="categoryDescription">Description</label>
                                    <textarea class="form-control" name="description"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Add Category</button>
                            </form>


                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Category Modal -->
            <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="settings" method="POST">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${categoryToEdit != null ? categoryToEdit.id : ''}">
                                <div class="form-group mb-3">
                                    <label for="categoryName">Category Name</label>
                                    <input type="text" class="form-control" name="name" value="${categoryToEdit != null ? categoryToEdit.categoryname : ''}" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="categoryStatus">Status</label>
                                    <div class="toggle-wrapper">
                                        <label class="toggle">
                                            <input type="checkbox" name="status" ${categoryToEdit != null && categoryToEdit.status ? 'checked' : ''} class="form-check-input">
                                            <span class="toggle-slider"></span>
                                        </label>
                                        <span class="toggle-label">Active</span>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="categoryDescription">Description</label>
                                    <textarea class="form-control" name="description">${categoryToEdit != null ? categoryToEdit.description : ''}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table for Categories -->
            <table class="table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categories}">
                        <tr>
                            <td>${category.id}</td>
                            <td>${category.categoryname}</td>
                            <td>
                                <label class="toggle">
                                    <input type="checkbox" class="toggle-checkbox" data-id="${category.id}" ${category.status ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                            </td>
                            <td>${category.description}</td>
                            <td>
                                <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editCategoryModal" 
                                        data-id="${category.id}" data-name="${category.categoryname}" data-status="${category.status}" 
                                        data-description="${category.description}">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </button>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="settings?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
        <!-- Footer Start -->
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
            <div class="modal fade" id="forgot-password" tabindex="-1" aria-labelledby="forgotPasswordLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-bottom p-3">
                            <h5 class="modal-title" id="forgotPasswordLabel">Forgot Password</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body p-3 pt-4">
                            <div class="row">
                                <div class="col-md-12">
                                    <form id="forgot-password-form" method="POST" action="ForgotPasswordServlet">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Email Address <span class="text-danger">*</span></label>
                                                    <input name="email" id="email" type="email" class="form-control" placeholder="Enter your email" required>
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">New Password <span class="text-danger">*</span></label>
                                                    <input name="newPassword" id="newPassword" type="password" class="form-control" placeholder="Enter new password" required>
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Confirm New Password <span class="text-danger">*</span></label>
                                                    <input name="confirmPassword" id="confirmPassword" type="password" class="form-control" placeholder="Re-enter new password" required>
                                                </div>
                                            </div>

                                            <div class="col-lg-12 text-end">
                                                <button type="submit" class="btn btn-primary">Reset Password</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>  
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
        <!-- Scripts -->
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/js/jquery.min.js"></script>

        <!-- Icons -->
        <script src="./assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="./assets/js/app.js"></script>


        <script>
                                        // Script to populate the Edit Modal with the correct values
                                        $('#editCategoryModal').on('show.bs.modal', function (event) {
                                            var button = $(event.relatedTarget); // Button that triggered the modal
                                            var categoryId = button.data('id');
                                            var categoryName = button.data('name');
                                            var categoryStatus = button.data('status');  // Get the status of the category
                                            var categoryDescription = button.data('description');

                                            var modal = $(this);
                                            modal.find('input[name="id"]').val(categoryId);
                                            modal.find('input[name="name"]').val(categoryName);
                                            modal.find('textarea[name="description"]').val(categoryDescription);

                                            // Set the checkbox status in the modal
                                            modal.find('input[name="status"]').prop('checked', categoryStatus);  // Set the status toggle in modal
                                        });

        </script>

        <script>
            // Handle toggle switch change and send it to the server
            $(document).ready(function () {
                $('.toggle-checkbox').on('change', function () {
                    var categoryId = $(this).data('id');
                    var newStatus = $(this).prop('checked');

                    $.ajax({
                        url: 'settings', // Adjust the URL if needed
                        type: 'POST',
                        data: {
                            action: 'updateStatus', // Action is to update the status
                            id: categoryId,
                            status: newStatus
                        },
                        success: function (response) {
                            // Optionally, show a success message or refresh the table
                            alert('Status updated successfully!');
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            alert('Failed to update status.');
                        }
                    });
                });
            });

        </script>

    </body>
</html>

