<%-- 
    Document   : home
    Created on : Feb 8, 2025, 12:43:38 PM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Children Service Booking System</title>
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
        <!-- SLIDER -->
        <link rel="stylesheet" href="../assets/css/tiny-slider.css"/>
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- Post btn -->
        <!-- Thêm Font Awesome từ CDN -->
        <!-- Thêm Font Awesome từ CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

        <style>
            /* Cập nhật cho nút Prev và Next */
            .tns-prev, .tns-next {
                background-color: rgba(0, 0, 0, 0.5);  /* Nền mờ */
                color: white;
                border: none;
                border-radius: 50%;
                font-size: 24px;
                padding: 10px;
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                z-index: 10;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .tns-prev {
                left: 10px;
            }

            .tns-next {
                right: 10px;
            }

            /* Thêm hiệu ứng hover */
            .tns-prev:hover, .tns-next:hover {
                background-color: rgba(0, 0, 0, 0.7);
            }

            /* Cập nhật icon mũi tên từ Font Awesome */
            .tns-prev:before {
                content: "\f104";  /* Mũi tên trái FontAwesome */
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;  /* Đảm bảo sử dụng icon Bold */
            }

            .tns-next:before {
                content: "\f105";  /* Mũi tên phải FontAwesome */
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;  /* Đảm bảo sử dụng icon Bold */
            }

            /* Cập nhật cho card */
            .card-body {
                height: 300px; /* Cố định chiều cao */
                overflow: hidden; /* Ẩn nội dung tràn ra ngoài */
                display: flex;
                flex-direction: column;
            }

            .card-body img {
                max-height: 150px; /* Giới hạn chiều cao hình ảnh */
                object-fit: cover; /* Đảm bảo hình ảnh không bị bóp méo */
            }

            .card-body .title {
                font-size: 18px;
                font-weight: bold;
                margin-top: 10px;
            }

            .card-body p {
                flex-grow: 1;
                font-size: 14px;
                color: #666;
                overflow: hidden; /* Ẩn phần text bị tràn */
                text-overflow: ellipsis; /* Hiển thị "..." nếu nội dung quá dài */
                white-space: nowrap; /* Ngừng xuống dòng */
            }

            .card-body .link {
                font-size: 14px;
                color: #007bff;
                text-decoration: none;
                margin-top: 10px;
            }

            .card-body .link:hover {
                text-decoration: underline;
            }

            .background-link {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 1; /* Đặt dưới các phần tử khác */
            }

            /* Đảm bảo các input, button, và nội dung không bị chặn */
            #home .container,
            #home form,
            #home input,
            #home button {
                position: relative;
                z-index: 2;
            }

            .my-slider .item {
                margin-right: 15px; /* Thêm khoảng cách giữa các item */
            }

            .my-slider .item:last-child {
                margin-right: 0; /* Loại bỏ khoảng cách sau item cuối cùng */
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
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left nav-light">

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                <c:if test="${sessionScope.role.contains('Staffs')}">
                                    <li><a href="../c/staff-reserv" class="sub-menu-item">Reservation</a></li>
                                </c:if>
                                <c:if test="${sessionScope.role.contains('Shipper')}">
                                    <li><a href="../order-list" class="sub-menu-item">Ship</a></li>
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

                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Products</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="../productlist" class="sub-menu-item">Products List</a></li>
                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                    <li><a href="../myorders" class="sub-menu-item">My Orders</a></li>
                                    </c:if>
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                <li><a href="../blog" class="sub-menu-item">Blogs</a></li>

                                <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                    <li><a href="../post-list" class="sub-menu-item">Posts - Management</a></li>
                                    <li><a href="../slider" class="sub-menu-item">Sliders - Management</a></li>
                                    <li><a href="../feedbacklist" class="sub-menu-item">Feedback - Management</a></li>
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
        <section class="bg-half-170 d-table w-100" id="home">
            <a id="background-link" href="#" class="background-link"></a> 
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row justify-content-center mt-5">
                    <div class="col-xl-10">
                        <div class="heading-title text-center">
                            <img src="../assets/images/logo-icon.png" height="50" alt="">
                            <h4 class="heading fw-bold text-white title-dark mt-3 mb-4">Booking Your Appointments</h4>
                            <p class="para-desc mx-auto text-white-50 mb-0">
                                We are committed to providing the best healthcare services for children, ensuring their overall development and optimal health.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- End Hero -->

        <!-- Start -->
        <section class="section bg-white pb-0">
            <!--Blog-->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Newest Blog</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <c:set var="b" value="${requestScope.blog}"/>

                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-6">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/${b.img}" class="img-fluid" alt="">
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-7 col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="section-title ms-lg-5">
                            <span class="badge badge-pill badge-soft-primary">About Children Care</span>
                            <h4 class="title mt-3 mb-4">${b.title}</h4>
                            <p class="para-desc text-muted" >${requestScope.shortcontent}</p>
                            <div class="mt-4">
                                <a href="../blog-detail?id=${b.id}" class="btn btn-soft-primary">Read More</a>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->


            <!-- Start Post List with Tiny Slider -->
            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Posts</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="tiny-slider">
                    <div class="row">
                        <c:forEach var="p" items="${requestScope.posts}">
                            <div class="col-xl-3 col-md-4 col-12 mt-5">
                                <div class="card features feature-primary bg-transparent border-0">
                                    <div class="card-body p-0 mt-3">
                                        <img src="../${p.img}" class="img-fluid" alt="">
                                        <a href="../blog-detail?id=${p.id}" class="title text-dark h5">${p.title}</a>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->
                </div><!--end tiny-slider-->
            </div><!--end container-->
            <!-- End Post List -->

            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Our Children Care Services</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="tiny-slider">
                    <div class="my-slider">
                        <c:forEach var="s" items="${requestScope.services}">
                            <div class="item">
                                <div class="card features feature-primary bg-transparent border-0">
                                    <div class="card-body p-0 mt-3">
                                        <img src="${pageContext.request.contextPath}/${s.img}" class="img-fluid" alt="">
                                        <a href="../service-detail?id=${s.id}" class="title text-dark h5">${s.name}</a>
                                    </div>
                                </div>
                            </div><!--end item-->
                        </c:forEach>
                    </div><!--end my-slider-->
                </div><!--end tiny-slider-->
            </div><!--end container-->
        </section>

        </br>
        </br>

        <!-- Start -->
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
                                <h4>Search now.....</h4>
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
                    <img src="../assets/images/logo-dark.png" height="24" class="light-version" alt="">
                    <img src="../assets/images/logo-light.png" height="24" class="dark-version" alt="">
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
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="../admin/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
                    <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                </ul><!--end icon-->
            </div>
        </div>
        <!-- Offcanvas End -->

        <!-- MOdal Start -->
        <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content video-modal rounded overflow-hidden">
                    <video class="w-100" controls autoplay muted loop>
                        <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">>
                        <!--Browser does not support <video> tag -->
                    </video>
                </div>
            </div>
        </div>
        <!-- MOdal End -->

        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <script src="../assets/js/easy_background.js"></script>

        <!-- Select2 -->
        <script src="../assets/js/select2.min.js"></script>
        <script src="../assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/flatpickr.min.js"></script>
        <script src="../assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/jquery.timepicker.min.js"></script> 
        <script src="../assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <script>
                                        var sliderImages = [
            <c:forEach var="s" items="${sliders}">
                                            "../${s.getImg()}",
            </c:forEach>
                                        ];

                                        easy_background("#home", {
                                            slide: sliderImages,
                                            delay: [3000, 3000, 3000]
                                        });

        </script>



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>

                                        var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : "" %>';
                                        var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "" %>';

                                        // Kiểm tra nếu alertMessage và alertType không rỗng thì hiển thị Swal.fire
                                        if (alertMessage.trim() !== "" && alertType.trim() !== "") {
                                            Swal.fire({
                                                icon: alertType,
                                                title: alertMessage,
                                                showConfirmButton: false,
                                                timer: 3000
                                            });
                                        }


            <%
            session.removeAttribute("alertMessage");
            session.removeAttribute("alertType");
            %>
        </script>

        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <script>
                                        var slider = tns({
                                            container: '.tiny-slider .row',
                                            items: 4, // Hiển thị 4 bài viết trên mỗi slide
                                            slideBy: 'page',
                                            autoplay: true,
                                            autoplayButtonOutput: false,
                                            controls: false, // Cho phép điều khiển slide
                                            nav: true, // Cho phép navigation
                                            controlsPosition: 'outside', // Đặt nút prev, next bên ngoài slider
                                            responsive: {
                                                '0': {
                                                    items: 1, // 1 item cho các màn hình nhỏ
                                                },
                                                '600': {
                                                    items: 2, // 2 items cho các màn hình trung bình
                                                },
                                                '1024': {
                                                    items: 4, // 4 items cho màn hình lớn
                                                }
                                            }
                                        });
        </script>

        <script>
            var slider = tns({
                container: '.my-slider', // Sử dụng class của slider container
                items: 4, // Hiển thị 4 items trên mỗi slide
                slideBy: 'page',
                autoplay: true,
                autoplayButtonOutput: false,
                controls: false, // Cho phép điều khiển slide
                nav: true, // Cho phép navigation
                controlsPosition: 'outside', // Đặt nút prev, next bên ngoài slider
                responsive: {
                    '0': {
                        items: 1, // 1 item cho các màn hình nhỏ
                    },
                    '600': {
                        items: 2, // 2 items cho các màn hình trung bình
                    },
                    '1024': {
                        items: 4, // 4 items cho màn hình lớn
                    }
                }
            });
        </script>


        <script>
            var sliderImages = [];
            var sliderLinks = [];
            var currentSlideIndex = 0;

            // Lặp qua danh sách sliders từ JSP và thêm vào mảng JavaScript
            <c:forEach var="s" items="${sliders}">
            sliderImages.push("../${s.img}");
            sliderLinks.push("${s.backlink != null ? s.backlink : '#'}");
            </c:forEach>;

            function updateBackgroundAndLink(index) {
                var backgroundLink = document.getElementById("background-link");
                if (backgroundLink) {
                    console.log("Cập nhật backlink:", sliderLinks[index]); // Debug
                    backgroundLink.href = sliderLinks[index];
                }
            }

            // Khởi tạo slider với ảnh nền
            easy_background("#home", {
                slide: sliderImages,
                delay: [3000, 3000, 3000], // Mỗi ảnh hiển thị trong 3 giây
                transition: "fade",
                transitionDuration: 1000,
                onSlideChange: function (index) {
                    console.log("Slide chuyển đến:", index, "Backlink:", sliderLinks[index]);
                    currentSlideIndex = index;
                }
            });

            // Cập nhật backlink mỗi 3 giây để đồng bộ với ảnh
            setInterval(() => {
                currentSlideIndex = (currentSlideIndex + 1) % sliderImages.length;
                updateBackgroundAndLink(currentSlideIndex);
            }, 3000);

            // Cập nhật backlink đầu tiên ngay khi trang load
            setTimeout(() => updateBackgroundAndLink(0), 500);
        </script>



    </body>

</html>

