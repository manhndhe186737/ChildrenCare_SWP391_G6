<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Children Care - Product Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Product Detail Page" />
    <meta name="keywords" content="Product, Detail, Shopping" />
    <meta name="author" content="Shreethemes" />
    <!-- favicon -->
    <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- SLIDER -->
    <link rel="stylesheet" href="./assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="./assets/css/slick.css"/> 
    <link rel="stylesheet" href="./assets/css/slick-theme.css"/>
    <!-- Icons -->
    <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        /* Bố cục tổng quát */
        .section {
            padding: 0px !important;
        }
        .content-section {
            padding-top: 80px;
        }

        /* Thông tin tồn kho */
        .stock-info {
            margin-top: 10px;
            font-size: 16px;
        }
        .out-of-stock {
            color: red;
            font-weight: bold;
        }

        /* Hình ảnh sản phẩm */
        .product-img-container {
            width: 100%;
            overflow: hidden;
            border-radius: 8px;
        }
        .product-img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        /* Slider cho sản phẩm */
        .slider-for .product-img {
            max-height: 400px;
            object-fit: cover;
        }
        .slider-nav .product-img {
            max-height: 100px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 5px;
        }

        /* Sản phẩm liên quan */
        .related-product-img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
        }

        /* Nút Add to Cart */
        .btn-add-cart {
            font-size: 16px;
            padding: 10px 20px;
        }

        /* Căn chỉnh flex */
        .d-flex {
            display: flex;
            align-items: center;
        }
        .ms-3 {
            margin-left: 1rem;
        }

        /* Chuẩn bị cho bình luận (nếu có) */
        .comment {
            margin-bottom: 20px;
        }
        .comment p.text-muted {
            font-size: 12px;
            color: #6c757d;
        }
        .reply-container {
            background-color: #f1f1f1;
            margin-left: 20px;
            border-radius: 5px;
            padding: 10px;
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
                                            <span class="d-block mb-1">${fn:escapeXml(sessionScope.user.fullname)}</span>
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
                                            <a href="./about" class="btn btn-primary">Learn More</a>
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
                                            <a href="./productlist" class="btn btn-primary">Shop Now</a>
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
                                            <a href="./productlist" class="btn btn-primary">Explore Products</a>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div><!--end container-->
                    </div>
                </div>
            </div>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Child Care Products"></button>
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="1" aria-label="Trusted Products"></button>
                <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="2" aria-label="Child Growth"></button>
            </div>
        </div>
    </section><!--end section-->
    <!-- End Hero -->

    <div class="position-relative">
        <div class="shape overflow-hidden text-white">
            <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
            </svg>
        </div>
    </div>

    <div class="content-section">
        <!-- Main Content Section -->
        <section class="section">
            <div class="container">
                <div class="row align-items-center">
                    <!-- Slider / Image Section -->
                    <div class="col-md-5">
                        <div class="slider slider-for">
                            <div class="product-img-container">
                                <c:choose>
                                    <c:when test="${not empty product.img}">
                                        <img src="${pageContext.request.contextPath}/${product.img}" class="product-img" alt="${fn:escapeXml(product.productName)}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" class="product-img" alt="No Image" loading="lazy">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="slider slider-nav">
                            <div>
                                <c:choose>
                                    <c:when test="${not empty product.img}">
                                        <img src="${pageContext.request.contextPath}/${product.img}" class="product-img" alt="${fn:escapeXml(product.productName)}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" class="product-img" alt="No Image" loading="lazy">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${not empty product.img}">
                                        <img src="${pageContext.request.contextPath}/${product.img}" class="product-img" alt="${fn:escapeXml(product.productName)}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" class="product-img" alt="No Image" loading="lazy">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${not empty product.img}">
                                        <img src="${pageContext.request.contextPath}/${product.img}" class="product-img" alt="${fn:escapeXml(product.productName)}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" class="product-img" alt="No Image" loading="lazy">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div><!--end col-->

                    <!-- Product Detail Section -->
                    <div class="col-md-7 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="section-title ms-md-4">
                            <!-- Tên sản phẩm -->
                            <h4 class="title">${fn:escapeXml(product.productName)}</h4>
                            <!-- Giá sản phẩm -->
                            <h5 class="text-muted"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" /></h5>
                            <!-- Hiển thị số lượng tồn kho -->
                            <div class="stock-info">
                                <span>Stock: </span>
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <span>${product.stock} items available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="out-of-stock">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <h5 class="mt-4 py-2">Overview:</h5>
                            <!-- Mô tả sản phẩm -->
                            <p class="text-muted">${fn:escapeXml(product.description)}</p>

                            <div class="mt-4 pt-2">
                                <c:if test="${sessionScope.role.contains('Customer')}">
                                    <div class="d-flex align-items-center">
                                        <!-- Add to Cart Button -->
                                        <form id="fcart" action="AddToCart" method="post">
                                            <input type="hidden" name="product_id" value="${product.productId}"/>
                                            <input type="hidden" name="user_id" value="${sessionScope.user.id}"/>
                                            <input type="number" name="quantity" value="1" min="1" max="${product.stock}" class="form-control d-inline-block w-25 me-2" required />
                                         
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section>
    </div>

    <!-- Related Products Section -->
    <section class="section">
        <div class="container mt-100 mt-60">
            <div class="row">
                <div class="col-12">
                    <h5 class="mb-0">Related Products:</h5>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row">
                <div class="col-lg-12 mt-4 pt-2">
                    <div class="slider-range-four">
                        <c:forEach var="rel" items="${relatedProducts}">
                            <div class="tiny-slide">
                                <div class="card shop-list border-0">
                                    <ul class="label list-unstyled mb-0">
                                        <li><a href="javascript:void(0)" class="badge badge-pill badge-success">Featured</a></li>
                                    </ul>
                                    <div class="shop-image position-relative overflow-hidden">
                                        <c:choose>
                                            <c:when test="${not empty rel.img}">
                                                <img src="${pageContext.request.contextPath}/${rel.img}" class="related-product-img" alt="${fn:escapeXml(rel.productName)}" loading="lazy">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" class="related-product-img" alt="No Image" loading="lazy">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-body content pt-4 p-2">
                                        <a href="product-detail?id=${rel.productId}" class="text-dark product-name h6">${fn:escapeXml(rel.productName)}</a>
                                        <div class="d-flex justify-content-between mt-1">
                                            <h6 class="text-muted small font-italic mb-0 mt-1"><fmt:formatNumber value="${rel.price}" type="currency" currencySymbol="$" /></h6>
                                            <c:choose>
                                                <c:when test="${rel.stock > 0}">
                                                    <span class="text-muted small mb-0 mt-1">Stock: ${rel.stock}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small mb-0 mt-1 out-of-stock">Out of Stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section>

    <!-- Footer Start -->
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
    <!-- Footer End -->

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
    <script src="./assets/js/jquery.min.js"></script>
    <script src="./assets/js/bootstrap.bundle.min.js"></script>
    <!-- SLIDER -->
    <script src="./assets/js/slick.min.js"></script>
    <script src="./assets/js/slick.init.js"></script>
    <!-- Icons -->
    <script src="./assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="./assets/js/app.js"></script>
</body>
</html>