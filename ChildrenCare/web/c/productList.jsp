<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, model.Product, model.ServiceCategory"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Children Care - Product List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link rel="stylesheet" href="./assets/css/tiny-slider.css"/>
    <!-- Css -->
    <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .container-fluid {
            max-width: 1200px;
            margin: 0 auto;
            padding-left: 15px;
            padding-right: 15px;
        }

        .sidebar {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            min-height: 100vh;
            margin-top: 20px;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            justify-content: flex-start;
            margin-top: 20px;
        }

        .product-card {
            width: calc(50% - 15px);
            padding: 20px;
            border-radius: 12px;
            background: #ffffff;
            transition: transform 0.3s ease-in-out;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            overflow: hidden;
        }

        .product-container .product-card:only-child {
            width: 30%;
            margin-left: 0;
        }

        .product-card:hover {
            transform: scale(1.03);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .product-card h5 {
            font-size: 1.3rem;
            font-weight: bold;
            color: #0056b3;
        }

        .product-card h6 {
            font-size: 1.2rem;
            font-weight: bold;
            color: #28a745;
        }

        .product-actions {
            display: none;
        }

        .product-card:hover .product-actions {
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        .btn-info, .btn-success, .btn-danger {
            padding: 8px 12px;
            border-radius: 6px;
            transition: all 0.3s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .btn-info:hover, .btn-success:hover, .btn-danger:hover {
            color: white;
        }

        .btn-info::before, .btn-success::before, .btn-danger::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            transition: left 0.3s ease-in-out;
        }

        .btn-info:hover::before, .btn-success:hover::before, .btn-danger:hover::before {
            left: 100%;
        }

        .btn-info:hover {
            background-color: #17a2b8;
            box-shadow: 0px 4px 10px rgba(23, 162, 184, 0.4);
        }

        .btn-success:hover {
            background-color: #28a745;
            box-shadow: 0px 4px 10px rgba(40, 167, 69, 0.4);
        }

        .btn-danger:hover {
            background-color: #dc3545;
            box-shadow: 0px 4px 10px rgba(220, 53, 69, 0.4);
        }

        .pagination {
            padding: 20px;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
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
                <ul class="navigation-menu nav-left nav-light">
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <c:if test="${sessionScope.role.contains('Staffs')}">
                                <li><a href="c/staff-reserv" class="sub-menu-item">Reservation</a></li>
                            </c:if>
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

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Products</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="./productlist" class="sub-menu-item">Product List</a></li>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                        <ul class="submenu">
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
    <!-- Navbar End -->

    <!-- Start Hero -->
    <section class="home-slider position-relative">
        <div id="carouselExampleInterval" class="carousel slide carousel-fade" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="bg-half-170 d-table align-items-center w-100" style="background:url('./assets/images/posts/massage.jpg') center center;">
                        <div class="bg-overlay bg-overlay-dark"></div>
                        <div class="container">
                            <div class="row mt-5">
                                <div class="col-lg-12">
                                    <div class="heading-title">
                                        <h1 class="fw-bold mb-4">Professional & Safe <br> Child Care Products</h1>
                                        <p class="para-desc mb-0">Explore our range of high-quality products designed to support your child's health, safety, and development.</p>
                                        <div class="mt-4 pt-2">
                                            <a href="#" class="btn btn-primary">Learn More</a>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div><!--end container-->
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="bg-half-170 d-table align-items-center w-100" style="background:url('./assets/images/posts/newmassage.jpg') center center;">
                        <div class="bg-overlay bg-overlay-dark"></div>
                        <div class="container">
                            <div class="row mt-5">
                                <div class="col-lg-12">
                                    <div class="heading-title">
                                        <h1 class="fw-bold mb-4">Trusted Products <br> for Your Child</h1>
                                        <p class="para-desc mb-0">Our products are carefully selected to ensure safety, comfort, and happiness for your little ones.</p>
                                        <div class="mt-4 pt-2">
                                            <a href="#" class="btn btn-primary">Shop Now</a>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div><!--end container-->
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="bg-half-170 d-table align-items-center w-100" style="background:url('./assets/images/posts/teaching.jpg') center center;">
                        <div class="bg-overlay bg-overlay-dark"></div>
                        <div class="container">
                            <div class="row mt-5">
                                <div class="col-lg-12">
                                    <div class="heading-title">
                                        <h1 class="fw-bold mb-4">Support Your Child's <br> Growth & Development</h1>
                                        <p class="para-desc mb-0">Discover products that nurture your child's growth, curiosity, and well-being in a safe environment.</p>
                                        <div class="mt-4 pt-2">
                                            <a href="#" class="btn btn-primary">Explore Products</a>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div><!--end container-->
                    </div>
                </div>
            </div>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
        </div>
    </section><!--end section-->
    <!-- End Hero -->

    <div class="container-fluid full-height">
        <div class="row full-height">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar">
                <form action="productlist" method="GET">
                    <input type="text" name="search" class="form-control mb-3" placeholder="Search products..."
                           value="${searchQuery != null ? searchQuery : ''}">
                    <h5>Filter by Category</h5>
                    <div class="form-group">
                        <c:forEach var="category" items="${categories}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="category" value="${category.id}"
                                       ${selectedCategory != null && selectedCategory == category.id ? 'checked' : ''}>
                                <label class="form-check-label">${category.categoryname}</label>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="form-group">
                        <label for="minPrice">Min Price</label>
                        <input type="number" name="minPrice" id="minPrice" class="form-control mb-3" placeholder="Min Price"
                               value="${minPrice != null ? minPrice : ''}">
                    </div>
                    <div class="form-group">
                        <label for="maxPrice">Max Price</label>
                        <input type="number" name="maxPrice" id="maxPrice" class="form-control mb-3" placeholder="Max Price"
                               value="${maxPrice != null ? maxPrice : ''}">
                    </div>
                    <button type="submit" class="btn btn-primary mt-3 w-100">Apply Filters</button>
                </form>
            </div>

            <!-- Product List -->
            <div class="col-md-9">
                <div class="product-container">
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach var="p" items="${productList}">
                                <div class="card product-card shadow-sm">
                                    <div class="card-body">
                                        <div class="slider slider-for">
                                            <div><img src="${pageContext.request.contextPath}/${p.img}" class="img-fluid rounded" alt="${p.productName}"></div>
                                        </div>
                                        <h5 class="card-title">${p.productName}</h5>
                                        <p class="card-text text-muted">${p.description}</p>
                                        <h6>$${p.price}</h6>
                                        <div class="mt-3 product-actions">
                                            <a href="product-detail?id=${p.productId}" class="btn btn-info">Details</a>
                                            <c:if test="${sessionScope.role.contains('Customer')}">
                                                <form id="fcart_${p.productId}" action="AddProductToCart" method="post">
                                                    <input type="hidden" name="productId" value="${p.productId}"/>
                                                    <input type="hidden" name="quantity" value="1"/>
                                                    <c:choose>
                                                        <c:when test="${p.stock > 0}">
                                                            <button type="submit" class="btn btn-danger">Add to Cart</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-danger disabled" disabled>Add to Cart (Out of Stock)</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center">
                                <p class="text-muted">No products available.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <div class="container text-center mt-4">
        <c:if test="${totalPages >= 1}">
            <nav>
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="productlist?page=${i}&search=${searchQuery}&category=${selectedCategory}&minPrice=${minPrice}&maxPrice=${maxPrice}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Start Footer -->
    <footer class="bg-footer">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                    <a class="logo-footer"></a>
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
                            <h5 class="text-light title-dark footer-head">Healthcare Products</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li>Massage Oil for Kids</li>
                                <li>Hydrating Face Cream</li>
                                <li>Kids Shampoo</li>
                                <li>Sunscreen SPF 50</li>
                                <li>Aroma Candle Set</li>
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
    <!-- End Footer -->

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
                            <h4>Search now...</h4>
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
                <img src="./assets/images/logo-dark.png" height="24" class="light-version" alt="">
                <img src="./assets/images/logo-light.png" height="24" class="dark-version" alt="">
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
                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="./assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="./assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                <li class="d-grid"><a href="./admin/index.html" target="_blank" class="mt-4"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
                <li class="list-inline-item mb-0"><a href="./index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
            </ul><!--end icon-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- javascript -->
    <script src="./assets/js/bootstrap.bundle.min.js"></script>
    <!-- SLIDER -->
    <script src="./assets/js/tiny-slider.js"></script>
    <script src="./assets/js/tiny-slider-init.js"></script>
    <!-- Icons -->
    <script src="./assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="./assets/js/app.js"></script>

    <!-- Thư viện SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        // Lấy thông báo từ session
        var alertMessage = '<%= session.getAttribute("cartMessage") != null ? session.getAttribute("cartMessage") : "" %>';
        var alertType = '<%= session.getAttribute("cartAlertType") != null ? session.getAttribute("cartAlertType") : "" %>';

        // Kiểm tra nếu có thông báo thì hiển thị Swal.fire
        if (alertMessage.trim() !== "" && alertType.trim() !== "") {
            Swal.fire({
                icon: alertType, // success, error, warning
                title: alertMessage,
                showConfirmButton: false,
                timer: 3000
            });
        }

        // Xóa thông báo khỏi session sau khi hiển thị
        <%
            session.removeAttribute("cartMessage");
            session.removeAttribute("cartAlertType");
        %>
    </script>
</body>
</html>