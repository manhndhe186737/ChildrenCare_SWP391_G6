<%-- 
    Document   : staff-profile
    Created on : Feb 8, 2025, 9:03:03 AM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- SLIDER -->
        <link href="../assets/css/tiny-slider.css" rel="stylesheet" />
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
                        <a href="../c/home">
                            <!--<a href="index.html">-->
                            <img src="../assets/images/logo-icon-child.png" height="24" class="logo-light-mode" alt="">
                            <img src="../assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
                        </a>
                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li class=""><a href="../admin/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>


                        <li class="sidebar-dropdown active">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Staff</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="../admin/staff">Staff</a></li>
                                    <!--                                    <li><a href="../admin/add-staff">Add Staff</a></li>-->
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Customers</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="../admin/customers">All Customers</a></li>
                                </ul>
                            </div>
                        </li>


                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Services</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ServiceListServlet">Services List</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authorization</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="authorization">Access Granting</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Setting</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="settings">Category</a></li>
                                </ul>
                            </div>
                        </li>
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
                                <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                        </div>

                        <ul class="list-unstyled mb-0">

                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${pageContext.request.contextPath}//${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${sessionScope.user.fullname}</span>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="../admin/dashboard"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <a class="dropdown-item text-dark" href="../profile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="../logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Staff Profile & Settings</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Children Care</a></li>
                                    <li class="breadcrumb-item"><a href="doctors.html">Staff</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Profile</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                            <div class="p-5 bg-primary bg-gradient"></div>
                            <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">
                                <img src="${pageContext.request.contextPath}/${requestScope.staff.avatar}" class="rounded-circle shadow-md avatar avatar-medium" alt="">
                                <div class="mt-4 ms-3 pt-3">
                                    <h5 class="mt-3 mb-1">${requestScope.staff.fullname}</h5>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-4">
                                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded shadow overflow-hidden bg-light" id="pills-tab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill" href="#pills-overview" role="tab" aria-controls="pills-overview" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title fw-normal mb-0">Overview</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded-0" id="experience-tab" data-bs-toggle="pill" href="#pills-experience" role="tab" aria-controls="pills-experience" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title fw-normal mb-0">Experience</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded-0" id="review-tab" data-bs-toggle="pill" href="#pills-review" role="tab" aria-controls="pills-review" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title fw-normal mb-0">Reviews</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded-0" id="timetable-tab" data-bs-toggle="pill" href="#pills-timetable" role="tab" aria-controls="pills-timetable" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title fw-normal mb-0">Time Table</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded-0" id="settings-tab" data-bs-toggle="pill" href="#pills-settings" role="tab" aria-controls="pills-settings" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title fw-normal mb-0">Settings</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->
                                        </ul><!--end nav pills-->

                                        <div class="tab-content mt-2" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="overview-tab">
                                                <p class="text-muted">${requestScope.staff.bio}</p>

                                                <h6 class="mb-0">Specialties: </h6>

                                                <ul class="list-unstyled mt-4">
                                                    <c:forEach var="p" items="${requestScope.staff.profiles}">
                                                        <li class="mt-1"><i class="uil uil-arrow-right text-primary"></i>${p.specialties}</li>
                                                        </c:forEach>
                                                </ul>
                                            </div><!--end teb pane-->

                                            <div class="tab-pane fade" id="pills-experience" role="tabpanel" aria-labelledby="experience-tab">
                                                <h5 class="mb-1">Experience:</h5>

                                                <p class="text-muted mt-4">The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century. Lorem Ipsum is composed in a pseudo-Latin language which more or less corresponds to 'proper' Latin. It contains a series of real Latin words. This ancient dummy text is also incomprehensible, but it imitates the rhythm of most European languages in Latin script. The advantage of its Latin origin and the relative meaninglessness of Lorum Ipsum is that the text does not attract attention to itself or distract the viewer's attention from the layout.</p>

                                                <h6 class="mb-0">Professional Experience:</h6>

                                                <div class="row">
                                                    <div class="col-12 mt-4">
                                                        <div class="col-md-12">
                                                            <div class="slider-range-four tiny-timeline">
                                                                <c:forEach var="p" items="${requestScope.staff.profiles}">
                                                                    <div class="tiny-slide text-center">
                                                                        <div class="card border-0 p-4 item-box mb-2 shadow rounded">
                                                                            <p class="text-muted mb-0">${p.exp_start} - ${p.exp_end}</p>
                                                                            <h6 class="mt-1">${p.experience}</h6>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div><!--end col-->
                                                </div><!--end row-->
                                            </div><!--end teb pane-->

                                            <div class="tab-pane fade" id="pills-review" role="tabpanel" aria-labelledby="review-tab">
                                                <div class="row justify-content-center">
                                                    <div class="col-lg-8 text-center">
                                                        <div class="client-review-slider">
                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century. "</p>
                                                                <img src="../assets/images/client/01.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Thomas Israel <small class="text-muted">C.E.O</small></h6>
                                                            </div><!--end customer testi-->

                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" The advantage of its Latin origin and the relative meaninglessness of Lorum Ipsum is that the text does not attract attention to itself or distract the viewer's attention from the layout. "</p>
                                                                <img src="../assets/images/client/02.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Carl Oliver <small class="text-muted">P.A</small></h6>
                                                            </div><!--end customer testi-->

                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" There is now an abundance of readable dummy texts. These are usually used when a text is required purely to fill a space. These alternatives to the classic Lorem Ipsum texts are often amusing and tell short, funny or nonsensical stories. "</p>
                                                                <img src="../assets/images/client/03.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Barbara McIntosh <small class="text-muted">M.D</small></h6>
                                                            </div><!--end customer testi-->

                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" According to most sources, Lorum Ipsum can be traced back to a text composed by Cicero in 45 BC. Allegedly, a Latin scholar established the origin of the text by compiling all the instances of the unusual word 'consectetur' he could find "</p>
                                                                <img src="../assets/images/client/04.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Christa Smith <small class="text-muted">Manager</small></h6>
                                                            </div><!--end customer testi-->

                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century. "</p>
                                                                <img src="../assets/images/client/05.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Dean Tolle <small class="text-muted">Developer</small></h6>
                                                            </div><!--end customer testi-->

                                                            <div class="tiny-slide text-center">
                                                                <p class="text-muted h6 fw-normal fst-italic">" It seems that only fragments of the original text remain in the Lorem Ipsum texts used today. One may speculate that over the course of time certain letters were added or deleted at various positions within the text. "</p>
                                                                <img src="../assets/images/client/06.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                                <ul class="list-unstyled mb-0">
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                                </ul>
                                                                <h6 class="text-primary">- Jill Webb <small class="text-muted">Designer</small></h6>
                                                            </div><!--end customer testi-->
                                                        </div><!--end carousel-->
                                                    </div><!--end col-->
                                                </div><!--end row-->

                                                <div class="row justify-content-center">
                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->

                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/google.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->

                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->

                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->

                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/shopify.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->

                                                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                                                        <img src="../assets/images/client/spotify.png" class="avatar avatar-client" alt="">
                                                    </div><!--end col-->
                                                </div><!--end row-->
                                            </div><!--end teb pane-->

                                            <div class="tab-pane fade" id="pills-timetable" role="tabpanel" aria-labelledby="timetable-tab">
                                                <div class="row">
                                                    <div class="col-lg-4 col-md-12">
                                                        <div class="card border-0 p-3 rounded shadow">
                                                            <ul class="list-unstyled mb-0">
                                                                <c:forEach var="r" items="${requestScope.staff.reservations}">
                                                                    <li class="d-flex justify-content-between">
                                                                        <p class="text-muted mb-0 flex-grow-1">
                                                                            <i class="ri-time-fill text-primary align-middle h5 mb-0"></i> ${r.bookdate}
                                                                        </p>
                                                                        <p class="text-primary mb-0 flex-grow-1">
                                                                            <span class="text-dark">Time:</span> ${r.start} - ${r.end}
                                                                        </p>
                                                                    </li>
                                                                </c:forEach>

                                                            </ul>
                                                        </div>
                                                    </div><!--end col-->

                                                    <div class="col-lg-4 col-md-6 mt-4 mt-lg-0 pt-2 pt-lg-0">
                                                        <div class="card border-0 text-center features feature-primary">
                                                            <div class="icon text-center mx-auto rounded-md">
                                                                <i class="uil uil-phone h3 mb-0"></i>
                                                            </div>

                                                            <div class="card-body p-0 mt-4">
                                                                <h5 class="title fw-bold">Phone</h5>
                                                                <p class="text-muted">Great staff if you need your family member to get effective immediate assistance</p>
                                                                <a href="tel:+152534-468-854" class="link">+${requestScope.staff.phone}</a>
                                                            </div>
                                                        </div>
                                                    </div><!--end col-->

                                                    <div class="col-lg-4 col-md-6 mt-4 mt-lg-0 pt-2 pt-lg-0">
                                                        <div class="card border-0 text-center features feature-primary">
                                                            <div class="icon text-center mx-auto rounded-md">
                                                                <i class="uil uil-envelope h3 mb-0"></i>
                                                            </div>

                                                            <div class="card-body p-0 mt-4">
                                                                <h5 class="title fw-bold">Email</h5>
                                                                <p class="text-muted">Great doctor if you need your family member to get effective immediate assistance</p>
                                                                <a href="mailto:contact@example.com" class="link">${staff.account.email}</a>
                                                            </div>
                                                        </div>
                                                    </div><!--end col-->
                                                </div><!--end row-->
                                            </div><!--end teb pane-->

                                            <div class="tab-pane fade" id="pills-settings" role="tabpanel" aria-labelledby="settings-tab">
                                                <h5 class="mb-1">Settings</h5>
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="rounded shadow mt-4">
                                                            <div class="p-4 border-bottom">
                                                                <h6 class="mb-0">Personal Information :</h6>
                                                            </div>

                                                            <div class="p-4">
                                                                <form class="mt-4" action="../admin/update-staff" method="post" enctype="multipart/form-data">
                                                                    <div class="row align-items-center" style="margin-bottom: 20px">
                                                                        <div class="col-lg-2 col-md-4">
                                                                            <img id="editProfileImg" src="${pageContext.request.contextPath}/${staff.avatar}" class="avatar avatar-md-md rounded-circle shadow mx-auto d-block" alt="Preview Image"/>
                                                                        </div>
                                                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                                            <label class="form-label d-block">Upload Image:</label>
                                                                        </div>
                                                                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                                            <input type="file" name="imageFile" id="imageFileInput" accept="image/*" class="form-control mb-2" onchange="previewImage(event)">
                                                                            <input type="hidden" name="oldImage" value="">
                                                                        </div>
                                                                    </div>

                                                                    <!-- Hidden input lưu URL ảnh -->
                                                                    <input type="hidden" name="avatar_url" id="avatar_url" value="${staff.avatar}">

                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Full Name</label>
                                                                                <input type="hidden" name="id" value="${requestScope.staff.id}">
                                                                                <input type="hidden" name="old_email" value="${requestScope.staff.account.email}">
                                                                                <input name="name" id="name" type="text" class="form-control" placeholder="Full Name :" value="${requestScope.staff.fullname}">
                                                                                <small id="nameError" class="text-danger" style="display: none;">Full Name is required.</small>
                                                                            </div>
                                                                        </div><!--end col-->

                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Date of birth</label>
                                                                                <input name="dob" id="dob" type="date" class="form-control" value="${requestScope.staff.dob}">
                                                                                <small id="dobError" class="text-danger" style="display: none;">Date of Birth is required.</small>
                                                                            </div>
                                                                        </div><!--end col-->

                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Address</label>
                                                                                <input name="address" id="address" type="text" class="form-control" placeholder="Address :" value="${requestScope.staff.address}">
                                                                                <small id="addressError" class="text-danger" style="display: none;">Address is required.</small>
                                                                            </div> 
                                                                        </div><!--end col-->

                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Phone no.</label>
                                                                                <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone no. :" value="${requestScope.staff.phone}">
                                                                                <small id="phoneError" class="text-danger" style="display: none;">Phone number is invalid. It should be 10 digits.</small>
                                                                            </div>                                                                               
                                                                        </div><!--end col-->

                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Bio</label>
                                                                                <textarea name="bio" id="bio" rows="4" class="form-control" placeholder="Bio :">${requestScope.staff.bio}</textarea>
                                                                                <small id="bioError" class="text-danger" style="display: none;">Bio is required.</small>
                                                                            </div>
                                                                        </div>
                                                                    </div><!--end row-->

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <input type="submit" id="submit" name="send" class="btn btn-primary" value="Save changes">
                                                                        </div><!--end col-->
                                                                    </div><!--end row-->
                                                                </form><!--end form-->
                                                            </div>

                                                        </div>
                                                    </div><!--end row-->

                                                    <div class="col-lg-6">
                                                        <div class="rounded shadow mt-4">
                                                            <div class="p-4 border-bottom">
                                                                <h6 class="mb-0">General Notifications :</h6>
                                                            </div>

                                                            <div class="p-4">
                                                                <div class="p-4 border-bottom">
                                                                    <c:choose>
                                                                        <c:when test="${requestScope.staff.isVerified eq true}">
                                                                            <h5 class="mb-0 text-danger">Deactive Staff :</h5>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <h5 class="mb-0 text-success">Active Staff :</h5>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>

                                                                <div class="p-4">
                                                                    <c:choose>
                                                                        <c:when test="${requestScope.staff.isVerified eq true}">
                                                                            <h6 class="mb-0 fw-normal">Do you want to Deactive this staff? Please press below "Deactive" button</h6>
                                                                            <div class="mt-4">
                                                                                <a href="../admin/delete-staff?action=deactive&id=${requestScope.staff.id}" class="btn btn-danger text-white text-decoration-none">Deactive Staff</a>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <h6 class="mb-0 fw-normal">Do you want to Active this staff? Please press below "Active" button</h6>
                                                                            <div class="mt-4">
                                                                                <a href="../admin/delete-staff?action=active&id=${requestScope.staff.id}" class="btn btn-success text-white text-decoration-none">Active Staff</a>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div><!--end col-->
                                                </div><!--end teb pane-->
                                            </div><!--end tab content-->
                                        </div>
                                    </div><!--end col-->

                                </div><!--end row-->
                            </div>
                        </div>
                    </div><!--end container-->

                    <!-- Footer Start -->
                    <footer class="bg-white shadow py-3">
                        <div class="container-fluid">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="text-sm-start text-center">

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
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="../c/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
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

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                        // Lấy thông báo và loại thông báo từ session
                                        var alertMessage = '<%= session.getAttribute("error") != null ? session.getAttribute("error") : "" %>';
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
            session.removeAttribute("error");
            session.removeAttribute("alertType");
            %>
                                        }
        </script>

        <script>
            // Lấy thông báo và loại thông báo từ session
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

            document.querySelector('form').addEventListener('submit', function (event) {
                let isValid = true;

                // Clear previous error messages
                document.querySelectorAll('.text-danger').forEach(function (errorMsg) {
                    errorMsg.style.display = 'none';
                });

                // Validate Full Name
                const name = document.getElementById('name').value.trim();
                if (name === "") {
                    document.getElementById('nameError').style.display = 'block';
                    isValid = false;
                }

                // Validate Date of Birth
                const dob = document.getElementById('dob').value.trim();
                if (dob === "") {
                    document.getElementById('dobError').style.display = 'block';
                    isValid = false;
                } else {
                    const dobDate = new Date(dob);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);  // Set time to midnight to avoid time comparison issues
                    if (dobDate > today) {
                        document.getElementById('dobError').innerHTML = "Date of Birth cannot be in the future.";
                        document.getElementById('dobError').style.display = 'block';
                        isValid = false;
                    }
                }

                // Validate Address
                const address = document.getElementById('address').value.trim();
                if (address === "") {
                    document.getElementById('addressError').style.display = 'block';
                    isValid = false;
                }

                // Validate Phone Number
                const phone = document.getElementById('phone').value.trim();
                const phoneRegex = /^[0-9]{10}$/; // Example regex for a 10-digit phone number
                if (!phone.match(phoneRegex)) {
                    document.getElementById('phoneError').style.display = 'block';
                    isValid = false;
                }


                // If any validation fails, prevent form submission
                if (!isValid) {
                    event.preventDefault();
                }
            });

        </script>


        <script>
            document.getElementById("avatarInput").addEventListener("change", function (event) {
                let file = event.target.files[0]; // Lấy file từ input
                if (file) {
                    document.getElementById("previewImage").src = URL.createObjectURL(file); // Hiển thị ảnh xem trước
                    document.getElementById("avatar_url").value = file.name;
                }
            });
        </script>

        <script>
            const handleChange = () => {
                const fileUploader = document.querySelector('#input-file');
                const getFile = fileUploader.files
                if (getFile.length !== 0) {
                    const uploadedFile = getFile[0];
                    readFile(uploadedFile);
                }
            }

            const readFile = (uploadedFile) => {
                if (uploadedFile) {
                    const reader = new FileReader();
                    reader.onload = () => {
                        const parent = document.querySelector('.preview-box');
                        parent.innerHTML = `<img class="preview-content" src=${reader.result} />`;
                    };
                    reader.readAsDataURL(uploadedFile);
                }
            };
        </script>

        <script>
            function previewImage(event) {
                var file = event.target.files[0];
                var output = document.getElementById("editProfileImg"); // Đúng ID của ảnh xem trước

                if (file) {
                    var reader = new FileReader();
                    reader.onload = function () {
                        output.src = reader.result; // Hiển thị ảnh mới khi chọn
                    };
                    reader.readAsDataURL(file);
                } else {
                    // Nếu không chọn ảnh mới, giữ ảnh cũ
                    var oldImage = document.querySelector("input[name='oldImage']").value;
                    output.src = oldImage ? "${pageContext.request.contextPath}/" + oldImage : "";
                }
            }
        </script>
    </body>

</html>
