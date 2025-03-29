<%--
    Document   : blogs
    Created on : Feb 8, 2025, 10:03:12 AM
    Author     : dell
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Children Care - Blogs & News</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Explore the latest blogs and news about children healthcare services." />
    <meta name="keywords" content="Children Care, Blogs, News, Healthcare" />
    <meta name="author" content="Shreethemes" />
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/blog.css">
    <style>
        /* Blog item styling */
        .blog-item { 
            display: flex; 
            flex-direction: column; 
            transition: transform 0.3s ease;
        }
        .blog-item:hover {
            transform: translateY(-5px);
        }
        .card.blog { 
            height: 100%; 
            display: flex; 
            flex-direction: column; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border: none;
        }
        .card-body { 
            flex-grow: 1; 
            display: flex; 
            flex-direction: column; 
            justify-content: space-between; 
            padding: 1rem;
        }
        .card-body p { 
            flex-grow: 1; 
            font-size: 12px;
            color: #555;
            margin-bottom: 0.75rem;
        }
        .card img { 
            width: 100%; 
            height: 150px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }
        .card .title { 
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }
        .pagination-container { 
            margin-top: 2rem;
        }
        
        /* Main layout */
        .blog-page-container {
            display: flex;
            gap: 1.5rem;
            margin-top: 2rem;
            margin-left: -1rem;
        }
        
        /* Filter panel */
        .filter-panel {
            width: 200px;
            flex-shrink: 0;
            position: sticky;
            top: 100px;
            align-self: flex-start;
            background: #fff;
            border-radius: 8px;
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .filter-form {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .filter-form label {
            font-weight: 600;
            font-size: 12px;
            margin-bottom: 0.4rem;
            color: #444;
        }
        
        .filter-form input,
        .filter-form select {
            width: 100%;
            padding: 0.4rem 0.6rem;
            font-size: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s;
        }
        
        .filter-form input:focus,
        .filter-form select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.1);
        }
        
        .search-container {
            display: flex;
            gap: 0.4rem;
        }
        
        .search-container input {
            flex: 1;
        }
        
        .search-container button {
            padding: 0 0.8rem;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .search-container button:hover {
            background: #0056b3;
        }
        
        .filter-form .filter-button {
            width: 100%;
            padding: 0.6rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 500;
            transition: background 0.3s;
        }

        .filter-form .apply-button {
            background: #007bff;
            color: white;
        }

        .filter-form .apply-button:hover {
            background: #0056b3;
        }

        .filter-form .reset-button {
            background: #dc3545;
            color: white;
        }

        .filter-form .reset-button:hover {
            background: #c82333;
        }

        .filter-buttons-container {
            display: flex;
            gap: 0.4rem;
        }

        .filter-buttons-container .filter-button {
            flex: 1;
        }
        
        /* Blog content area */
        .blog-content {
            flex: 1;
            min-width: 0;
        }
        
        .blog-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
        }
        
        .post-meta {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
            font-size: 11px;
            color: #666;
        }
        
        .post-meta i {
            margin-right: 0.2rem;
            color: #007bff;
        }
        
        /* Sort options */
        .sort-options {
            display: flex;
            gap: 0.75rem;
            margin-bottom: 1rem;
            align-items: center;
        }
        
        .sort-options label {
            font-weight: 600;
            font-size: 12px;
        }
        
        .sort-options select {
            padding: 0.4rem;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 12px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .blog-page-container {
                flex-direction: column;
                margin-left: 0;
            }
            
            .filter-panel {
                width: 100%;
                position: static;
                margin-bottom: 1.5rem;
            }
            
            .blog-list {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 576px) {
            .blog-list {
                grid-template-columns: 1fr;
            }
            
            .sort-options {
                flex-direction: column;
                align-items: flex-start;
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

    <!-- Navbar Start -->
    <header id="topnav" class="defaultscroll sticky">
        <div class="container">
            <a class="logo" href="${pageContext.request.contextPath}/c/home">
                <span class="logo-light-mode">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                </span>
                <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
            </a>

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
                <c:if test="${sessionScope.role.contains('Customer')}">
                    <li class="list-inline-item mb-0">
                        <a href="${pageContext.request.contextPath}/c/Cart">
                            <div class="btn btn-icon btn-pills btn-primary"><i data-feather="heart" class="fea icon-sm"></i></div>
                        </a>
                    </li>
                </c:if>
                <li class="list-inline-item mb-0 ms-1">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown">
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
                                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                        </a>
                                    </c:if>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/profile">
                                        <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                    </a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/logout">
                                        <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                    </a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-soft-primary btn-sm">
                                <i class="uil uil-user-circle align-middle h5 me-1"></i> Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>

            <div id="navigation">
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <c:if test="${sessionScope.role.contains('Staffs')}">
                                <li><a href="${pageContext.request.contextPath}/c/staff-reserv" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="${pageContext.request.contextPath}/service-list" class="sub-menu-item">Services List</a></li>
                            <c:if test="${sessionScope.role.contains('Customer')}">
                                <li><a href="${pageContext.request.contextPath}/myreservation" class="sub-menu-item">My Reservation</a></li>
                                <li><a href="${pageContext.request.contextPath}/c/BookingStaff" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="${pageContext.request.contextPath}/blog" class="sub-menu-item">Blogs</a></li>
                            <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                <li><a href="${pageContext.request.contextPath}/post-list" class="sub-menu-item">Posts - Management</a></li>
                                <li><a href="${pageContext.request.contextPath}/slider" class="sub-menu-item">Sliders - Management</a></li>
                                <li><a href="${pageContext.request.contextPath}/feedbacklist" class="sub-menu-item">Feedback - Management</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <c:if test="${sessionScope.role.contains('Admin')}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </header>
    <!-- Navbar End -->

    <!-- Start Hero -->
    <section class="bg-half-170 d-table w-100" style="background: url('${pageContext.request.contextPath}/assets/images/bg/childcare.jpg') center center;">
        <div class="bg-overlay bg-overlay-dark"></div>
        <div class="container">
            <div class="row mt-5 justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center">
                        <h3 class="sub-title mb-4 text-white title-dark">Blogs & News</h3>
                        <p class="para-desc mx-auto text-white-50">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                        <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                            <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Children Care</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Blogs</li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="position-relative">
        <div class="shape overflow-hidden text-white">
            <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
            </svg>
        </div>
    </div>
    <!-- End Hero -->

    <!-- Start Blog Section -->
    <section class="container mt-5">
        <h2 class="text-center mb-4">Latest Blogs</h2>

        <div class="blog-page-container">
            <!-- Filter Panel (Left) -->
            <div class="filter-panel">
                <form action="${pageContext.request.contextPath}/blog" method="get" class="filter-form" id="filterForm">
                    <input type="hidden" name="sortBy" value="${param.sortBy}">
                    <input type="hidden" name="sortOrder" value="${param.sortOrder}">
                    <div class="search-container">
                        <input type="text" name="search" placeholder="Search posts..." value="${param.search}">
                        <button type="submit"><i class="uil uil-search"></i></button>
                    </div>
                    <div>
                        <label>Category</label>
                        <select name="category">
                            <option value="">All Categories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${param.category eq cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label>From Date</label>
                        <input type="date" name="fromDate" value="${param.fromDate}" 
                               max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                               onchange="validateDate(this)">
                    </div>
                    <div>
                        <label>To Date</label>
                        <input type="date" name="toDate" value="${param.toDate}" 
                               max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                               onchange="validateDate(this)">
                    </div>
                    <div class="filter-buttons-container">
                        <input type="submit" value="Apply Filters" class="filter-button apply-button">
                        <input type="button" value="Reset" onclick="resetFilters()" class="filter-button reset-button">
                    </div>
                </form>
            </div>

            <!-- Blog Content (Right) -->
            <div class="blog-content">
                <!-- Sort Options -->
                <div class="sort-options">
                    <label>Sort by Date:</label>
                    <select id="sortOrder" name="sortOrder" onchange="updateSort()">
                        <option value="desc" ${param.sortOrder eq 'desc' || empty param.sortOrder ? 'selected' : ''}>Newest First</option>
                        <option value="asc" ${param.sortOrder eq 'asc' ? 'selected' : ''}>Oldest First</option>
                    </select>
                </div>

                <!-- Blog List -->
                <div class="blog-list">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach var="post" items="${posts}">
                                <div class="blog-item">
                                    <div class="card blog">
                                        <c:choose>
                                            <c:when test="${not empty post.img}">
                                                <img src="${pageContext.request.contextPath}/${post.img}" class="card-img-top" alt="${post.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/default-blog.jpg" class="card-img-top" alt="Default Image">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body">
                                            <div class="post-meta">
                                                <span><i class="uil uil-calendar-alt"></i>
                                                    <fmt:formatDate value="${post.createdate}" pattern="MMM dd, yyyy" />
                                                </span>
                                                <span><i class="uil uil-bookmark"></i> ${post.categoryName}</span>
                                            </div>
                                            <h5 class="title">${post.title}</h5>
<!--                                            <p>${fn:substring(post.content, 0, 100)}...</p>-->
                                            <p>${post.shortContent}</p>
                                            <a href="${pageContext.request.contextPath}/blog-detail?id=${post.id}" class="btn btn-primary btn-sm">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1 / -1;">
                                <div class="text-center">No posts available matching your criteria.</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages >= 1}">
                    <div class="row text-center mt-4">
                        <div class="col-12">
                            <ul class="pagination justify-content-center mb-0">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${currentPage - 1}&search=${param.search}&category=${param.category}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <li class="page-item ${page eq currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${page}&search=${param.search}&category=${param.category}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">${page}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${currentPage + 1}&search=${param.search}&category=${param.category}&fromDate=${param.fromDate}&toDate=${param.toDate}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>
    <!-- End Blog Section -->
    
    &nbsp;

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
                                    <span class="text-foot ms-2">Find us on the map</span>
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
    <!-- End Footer -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>

    <!-- javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        function validateDate(input) {
            const today = new Date();
            const selectedDate = new Date(input.value);
            today.setHours(0, 0, 0, 0);
            if (selectedDate > today) {
                alert("Cannot select a future date!");
                input.value = today.toISOString().split('T')[0];
            }
        }

        function updateSort() {
            const sortOrder = document.getElementById('sortOrder').value;
            const form = document.getElementById('filterForm');
            form.querySelector('input[name="sortBy"]').value = 'date';
            form.querySelector('input[name="sortOrder"]').value = sortOrder;
            form.submit();
        }

        function resetFilters() {
            const form = document.getElementById('filterForm');
            form.querySelector('input[name="search"]').value = '';
            form.querySelector('select[name="category"]').value = '';
            form.querySelector('input[name="fromDate"]').value = '';
            form.querySelector('input[name="toDate"]').value = '';
            form.querySelector('input[name="sortBy"]').value = '';
            form.querySelector('input[name="sortOrder"]').value = '';
            form.submit();
        }
    </script>
</body>
</html>