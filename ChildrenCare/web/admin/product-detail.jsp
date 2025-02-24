<%-- 
    Document   : product-detail
    Created on : Feb 24, 2025, 3:30:32 PM
    Author     : vucon
--%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="./././index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- SLIDER -->
        <link href="../assets/css/tiny-slider.css" rel="stylesheet" />
        <link href="../assets/css/slick.css" rel="stylesheet" /> 
        <link href="../assets/css/slick-theme.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

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

        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <a href="index.html">
                            <img src="./assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                            <img src="./assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                        </a>
                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                        <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Appointment</a></li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="doctors.html">Doctors</a></li>
                                    <li><a href="add-doctor.html">Add Doctor</a></li>
                                    <li><a href="dr-profile.html">Profile</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="patients.html">All Patients</a></li>
                                    <li><a href="add-patient.html">Add Patients</a></li>
                                    <li><a href="patient-profile.html">Profile</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="chat.html">Chat</a></li>
                                    <li><a href="email.html">Email</a></li>
                                    <li><a href="calendar.html">Calendar</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ServiceListServlet">Shop</a></li>
                                    <li><a href="product-detail.html">Shop Detail</a></li>
                                    <li><a href="shopcart.html">Shopcart</a></li>
                                    <li><a href="checkout.html">Checkout</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="blogs.html">Blogs</a></li>
                                    <li><a href="blog-detail.html">Blog Detail</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="faqs.html">FAQs</a></li>
                                    <li><a href="review.html">Reviews</a></li>
                                    <li><a href="invoice-list.html">Invoice List</a></li>
                                    <li><a href="invoice.html">Invoice</a></li>
                                    <li><a href="terms.html">Terms & Policy</a></li>
                                    <li><a href="privacy.html">Privacy Policy</a></li>
                                    <li><a href="error.html">404 !</a></li>
                                    <li><a href="blank-page.html">Blank Page</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="signup.html">Signup</a></li>
                                    <li><a href="forgot-password.html">Forgot Password</a></li>
                                    <li><a href="lock-screen.html">Lock Screen</a></li>
                                    <li><a href="thankyou.html">Thank you...!</a></li>
                                </ul>
                            </div>
                        </li>

                        <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                        <li><a href="./c/index-two.html" target="_blank"><i class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
                    </ul>
                    <!-- sidebar-menu  -->
                </div>
                <!-- sidebar-content  -->
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="./assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="./assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="./assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                            <div class="search-bar p-0 d-none d-lg-block ms-2">
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="get" id="searchform" class="searchform">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item mb-0">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="./assets/images/language/american.png" class="avatar avatar-ex-small rounded-circle p-2" alt=""></button>
                                    <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2" data-simplebar style="height: 175px;">
                                        <a href="javascript:void(0)" class="d-flex align-items-center">
                                            <img src="./assets/images/language/chinese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Chinese</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="./assets/images/language/european.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">European</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="./assets/images/language/indian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Indian</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="./assets/images/language/japanese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Japanese</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="./assets/images/language/russian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Russian</small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                                </a>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="mail" class="fea icon-sm"></i></button>
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">4 <span class="visually-hidden">unread mail</span></span>

                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2" data-simplebar style="height: 320px; width: 300px;">
                                        <a href="#" class="d-flex align-items-center justify-content-between py-2">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Janalia</b> <small class="text-muted fw-normal d-inline-block">1 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/Codepen.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>codepen</b>  <small class="text-muted fw-normal d-inline-block">4 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Cristina</b> <small class="text-muted fw-normal d-inline-block">5 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/dribbble.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Dribbble</b> <small class="text-muted fw-normal d-inline-block">24 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Donald Aghori</b> <small class="text-muted fw-normal d-inline-block">1 day ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="./assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Calvin</b> <small class="text-muted fw-normal d-inline-block">2 day ago</small></small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="./assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                            <img src="./assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">Calvin Carlo</span>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="index.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <a class="dropdown-item text-dark" href="dr-profile.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="lock-screen.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Plastic Medicine Box</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Doctris</a></li>
                                    <li class="breadcrumb-item"><a href="ServiceListServlet">Shop</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Product Detail</li>
                                </ul>
                            </nav>
                        </div>
                        <c:choose>
                            <c:when test="${not empty services}">
                                <c:forEach var="service" items="${services}">
                                    <div class="card border-0 rounded shadow p-4 mt-4">
                                        <div class="row align-items-center">
                                            <div class="col-lg-4 col-md-5">
                                                <div class="slider slider-for">
                                                    <div>
                                                        <img src="${not empty service.img ? service.img : "../assets/images/pharmacy/shop/01.jpg"}" class="img-fluid rounded" alt="Product Image">

                                                    </div>
                                                </div>

                                            </div><!--end col-->

                                            <div class="col-lg-8 col-md-7 mt-4 mt-sm-0">
                                                <div class="ms-md-4">
                                                    <!-- Hi?n th? tên d?ch v? -->
                                                    <h4 class="title">${not empty service.name ? service.name : ""}</h4>

                                                    <!-- Hi?n th? giá d?ch v? -->
                                                    <h5 class="text-muted">$${service.price}</h5>
                                                    <!-- Mô t? s?n ph?m -->
                                                    <h5 class="mt-4 py-2">Product Overview</h5>
                                                    <p class="text-muted">${not empty service.description ? service.description : "Mô t? ?ang c?p nh?t."}</p>
                                                    <!-- Nút hành ??ng -->
                                                    <div class="mt-4 pt-2">
                                                        <!-- Nút Update -->
                                                        <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#add-product" 
                                                           data-id="${service.id}" data-name="${service.name}" data-price="${service.price}" 
                                                           data-description="${service.description}" data-img="${service.img}">Update Product</a>
                                                        <!-- Nút ?? chuy?n tr?ng thái Active/Deactivate -->
                                                        <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#updateStatusModal"
                                                           data-id="${service.id}" data-currentstatus="${service.isActive}">
                                                            ${service.isActive ? "Deactivate" : "Activate"} Product
                                                        </a>

                                                    </div>
                                                </div> 
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>

                                    <div class="row mt-4">
                                        <div class="col-12">
                                            <h5 class="mb-0">Related Products:</h5>
                                        </div><!--end col-->
                                    </div><!--end row-->

                                    <div class="row">
                                        <div class="col-lg-12 mt-4">
                                            <div class="slider-range-four">
                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <ul class="label list-unstyled mb-0">
                                                            <li><a href="javascript:void(0)" class="badge badge-pill badge-success">Featured</a></li>
                                                        </ul>
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="../assets/images/pharmacy/shop/thermometer.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Thermometer</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="../assets/images/pharmacy/shop/stethoscope.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Stethoscope</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/pulse-oximeter.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Pulse oximeter</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/medicine.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Medicine pills</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/smoking-habit.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Smokill smoking habit</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/sanitizer.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Sanitizer</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/nicotex.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Nicotex</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="tiny-slide">
                                                    <div class="card shop-list border-0 overflow-hidden rounded shadow m-1">
                                                        <div class="shop-image position-relative overflow-hidden">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html"><img src="./assets/images/pharmacy/shop/medigrip.jpg" class="img-fluid" alt=""></a>
                                                            <ul class="list-unstyled shop-icons">
                                                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                            </ul>                                

                                                            <div class="qty-icons">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body content pt-4 border-top">
                                                            <a href="https://shreethemes.in/doctris/layouts/admin/pharmacy-product-detail.html" class="text-dark product-name h6">Medigrip</a>
                                                            <div class="d-flex justify-content-between mt-1">
                                                                <h6 class="text-muted small font-italic mb-0 mt-1">$16.00 </h6>
                                                                <ul class="list-unstyled text-warning mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                    </div>
                                    </div><!--end container-->

                                    <!-- Start Modal -->
                                    <!-- Modal Update Product -->
                                    <div class="modal fade" id="add-product" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom p-3">
                                                    <h5 class="modal-title" id="exampleModalLabel">Update Product</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body p-3 pt-4">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="d-grid me-md-4">
                                                                <p class="text-muted">Upload your shop image here, Please click "Upload Image" Button.</p>
                                                                <div class="preview-box d-block justify-content-center rounded shadow overflow-hidden bg-light p-1"></div>
                                                                <input type="file" id="input-file" name="input-file" accept="image/*" onchange="handleChange()" hidden />
                                                                <label class="btn-upload btn btn-primary mt-4" for="input-file">Upload Image</label>
                                                            </div>
                                                        </div><!--end col-->

                                                        <div class="col-md-6 mt-4 mt-sm-0">
                                                            <form action="UpdateProductServlet" method="Post">
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <input type=hidden name="id" value="${requestScope.service.id}"/>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Shop Title <span class="text-danger">*</span></label>
                                                                            <input name="name" id="name" type="text" class="form-control" placeholder="Title :" value="${requestScope.service.name}">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Price: </label>
                                                                            <div class="input-group mb-3">
                                                                                <span class="input-group-text border bg-transparent" id="basic-addon1">$</span>
                                                                                <input type="number" min="0" name="price" class="form-control" placeholder="Price" aria-label="Price" aria-describedby="basic-addon1" value="${requestScope.service.price}">
                                                                            </div>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Label:</label>
                                                                            <select class="form-control">
                                                                                <option value="FE">Featured</option>
                                                                                <option value="NE">New</option>
                                                                                <option value="PO">Popular</option>
                                                                                <option value="RE">Recent</option>
                                                                                <option value="FR">Free</option>
                                                                            </select>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Description : </label>
                                                                            <input name="description" type="text" class="form-control" id="time" value="${requestScope.service.description}">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-12 text-end">
                                                                        <button type="submit" class="btn btn-primary">Update Product</button>
                                                                    </div><!--end col-->
                                                                </div>
                                                            </form>
                                                        </div><!--end col-->
                                                    </div><!--end row-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Modal Confirm Active/Deactivate -->
                                    <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="updateStatusModalLabel">Confirm Status Change</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Are you sure you want to <strong id="status-action"></strong> this product?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <form id="update-status-form" method="POST" action="UpdateStatusServlet">
                                                        <input type="hidden" name="id" id="product-id" value="${requestScope.service.id}">
                                                         <input type="hidden" name="currentStatus" id="current-status" value="${requestScope.service.isActive}">
                                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        // Khi submit form, ng?ng hành ??ng m?c ??nh
                                        $('form').submit(function (e) {
                                            e.preventDefault(); // Ng?ng g?i form m?c ??nh

                                            // L?y thông tin t? các tr??ng input trong form
                                            var name = $('#name').val();
                                            var price = $('#price').val();
                                            var description = $('#description').val();
                                            var img = $('#input-file').val(); // X? lý ?nh n?u có

                                            // Th?c hi?n yêu c?u AJAX ?? c?p nh?t s?n ph?m
                                            $.ajax({
                                                url: 'updateProduct', // ???ng d?n ??n servlet x? lý update
                                                type: 'POST', // Ph??ng th?c g?i yêu c?u
                                                data: {
                                                    id: productId, // ID c?a s?n ph?m c?n c?p nh?t
                                                    name: name,
                                                    price: price,
                                                    description: description,
                                                    img: img
                                                },
                                                success: function (response) {
                                                    // X? lý khi update thành công
                                                    $('#add-product').modal('hide');  // ?óng modal
                                                    alert('Product updated successfully!');  // Thông báo thành công
                                                },
                                                error: function () {
                                                    // X? lý khi có l?i
                                                    alert('Failed to update product!');
                                                }
                                            });
                                        });
                                        $('#updateStatusModal').on('show.bs.modal', function (event) {
                                            var button = $(event.relatedTarget); // L?y thông tin t? nút b?m
                                            var productId = button.data('id');
                                            var currentStatus = button.data('currentstatus');

                                            // C?p nh?t thông tin vào modal
                                            var modal = $(this);
                                            modal.find('#product-id').val(productId);
                                            modal.find('#current-status').val(currentStatus);
                                            modal.find('#status-action').text(currentStatus ? "Deactivate" : "Activate");
                                        });

                                        $('#update-status-form').submit(function (e) {
                                            e.preventDefault(); // Ng?ng g?i form m?c ??nh

                                            var productId = $('#product-id').val(); // L?y ID
                                            var currentStatus = $('#current-status').val(); // Tr?ng thái hi?n t?i
                                            var newStatus = currentStatus === "true" ? false : true; // ??i tr?ng thái ng??c l?i

                                            $.ajax({
                                                url: 'updateStatusServlet', // ??m b?o ???ng d?n ?úng
                                                type: 'POST',
                                                data: {
                                                    id: productId,
                                                    currentStatus: currentStatus  // Truy?n tr?ng thái hi?n t?i
                                                },
                                                success: function (response) {
                                                    if (response === "success") {
                                                        alert("Status updated successfully!");
                                                        location.reload(); // Reload l?i trang ?? tr?ng thái m?i ???c hi?n th?
                                                    } else {
                                                        alert("Failed to update status!");
                                                    }
                                                },
                                                error: function () {
                                                    alert("Error while updating!");
                                                }
                                            });
                                        });


                                    </script>

                                    <!-- Footer Start -->
                                    <footer class="bg-white shadow py-3">
                                        <div class="container-fluid">
                                            <div class="row align-items-center">
                                                <div class="col">
                                                    <div class="text-sm-start text-center">
                                                        <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="./././index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                                    </div>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </div><!--end container-->
                                    </footer><!--end footer-->
                                    <!-- End -->
                                    </main>
                                    <!--End page-content" -->
                                    </div>
                                    <!-- page-wrapper -->

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
                                                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="./assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="./assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="./assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="./assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                                <li class="d-grid"><a href="./c/index.html" target="_blank" class="mt-4"><img src="./assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
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
                                                <li class="list-inline-item mb-0"><a href="./././index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                                            </ul><!--end icon-->
                                        </div>
                                    </div>
                                    <!-- Offcanvas End -->

                                    <!-- javascript -->
                                    <script src="../assets/js/jquery.min.js"></script>
                                    <script src="../assets/js/bootstrap.bundle.min.js"></script>
                                    <!-- simplebar -->
                                    <script src="../assets/js/simplebar.min.js"></script>
                                    <!-- SLIDER -->
                                    <script src="../assets/js/tiny-slider.js"></script>
                                    <script src="../assets/js/tiny-slider-init.js"></script>
                                    <script src="../assets/js/slick.min.js"></script>
                                    <script src="../assets/js/slick.init.js"></script>
                                    <!-- Icons -->
                                    <script src="../assets/js/feather.min.js"></script>
                                    <!-- Main Js -->
                                    <script src="../assets/js/app.js"></script>

                                    </body>

                                    </html>
