<%-- 
    Document   : patients
    Created on : Feb 4, 2025, 8:23:49 PM
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
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
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
                        <li><a href="../admin/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>


                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Staff</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="../admin/staff">Staff</a></li>
                                    <li><a href="../admin/add-staff">Add Staff</a></li>
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
                                    <li><a href="settings-servicecategory">Service Category</a></li>
                                    <li><a href="settings-postcategory">Post Category</a></li>                                </ul>
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
                            <h5 class="mb-0">Customers List</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a>Children Care</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Customers</li>
                                </ul>
                            </nav>
                        </div>
                        
                        <div class="row">
                            <form action="../admin/customers" method="get" class="d-flex align-items-center">
                                <!-- Search Box -->
                                <input type="text" class="form-control form-control-sm me-2" name="s" value="${requestScope.searchName}" placeholder="Search by Name/Email/Phone" />

                                <!-- Sort Dropdown -->
                                <label class="me-2" style="white-space: nowrap;">Sort by:</label>
                                <select class="form-select form-select-sm me-2" name="sortBy" onchange="this.form.submit()">
                                    <option value="" ${empty requestScope.sortBy ? 'selected' : ''}>None</option>
                                    <option value="name" ${requestScope.sortBy eq 'name' ? 'selected' : ''}>Name</option>
                                    <option value="dob" ${requestScope.sortBy eq 'dob' ? 'selected' : ''}>Date of Birth</option>
                                    <option value="email" ${requestScope.sortBy eq 'email' ? 'selected' : ''}>Email</option>
                                    <option value="name_desc" ${requestScope.sortBy eq 'name_desc' ? 'selected' : ''}>Name (Descending)</option>
                                    <option value="dob_desc" ${requestScope.sortBy eq 'dob_desc' ? 'selected' : ''}>Date of Birth (Descending)</option>
                                </select>

                                <!-- Filter: Active or Verified -->
                                <label class="me-2" style="white-space: nowrap;">Filter by:</label>
                                <select class="form-select form-select-sm me-2" name="filterBy" onchange="this.form.submit()">
                                    <option value="" ${empty requestScope.filterBy ? 'selected' : ''}>All</option>
                                    <option value="active" ${requestScope.filterBy eq 'active' ? 'selected' : ''}>Active</option>
                                    <option value="inactive" ${requestScope.filterBy eq 'inactive' ? 'selected' : ''}>Inactive</option>
                                </select>

                                <!-- Filter Button -->
                                <button type="submit" class="btn btn-primary btn-sm ms-2" name="filter" value="true">Filter</button>

                                <!-- Reset Button -->
                                <button type="submit" class="btn btn-secondary btn-sm ms-2" name="reset" value="true">Reset</button>
                            </form>
                        </div>

                        <!-- Customers Table -->
                        <div class="row">
                            <div class="col-12 mt-5">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 200px;">Name</th>
                                                <th class="border-bottom p-3" style="min-width: 120px;">Dob</th>
                                                <th class="border-bottom p-3" style="min-width: 100px;">Gender</th>
                                                <th class="border-bottom p-3" style="min-width: 200px;">Address</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Mobile No.</th>
                                                <th class="border-bottom p-3" style="min-width: 120px;">Email</th>
                                                <th class="border-bottom p-3" style="min-width: 100px;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="c" items="${requestScope.customers}">
                                                <tr>
                                                    <td class="py-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="${pageContext.request.contextPath}/${c.avatar}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                <span class="ms-2">${c.fullname}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">${c.dob}</td>
                                                    <td class="p-3">${c.gender eq true?'Male':'Female'}</td>
                                                    <td class="p-3">${c.address}</td>
                                                    <td class="p-3">${c.phone}</td>
                                                    <td class="p-3" style="min-width: 120px;">${c.account.email}</td>
                                                    <td class="text-end p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary"
                                                           data-bs-toggle="modal" data-bs-target="#viewprofile"
                                                           onclick="viewProfile('${c.id}', '${c.fullname}', '${c.dob}', '${c.gender}', '${c.address}', '${c.phone}', '${c.account.email}', '${c.avatar}')">
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success"
                                                           data-bs-toggle="modal" data-bs-target="#editprofile"
                                                           onclick="editProfile('${c.id}', '${c.fullname}', '${c.dob}', '${c.gender}', '${c.address}', '${c.phone}', '${c.account.email}', '${c.avatar}')">
                                                            <i class="uil uil-pen"></i>
                                                        </a>

                                                        <c:choose>
                                                            <c:when test="${c.isVerified}">
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-danger"
                                                                   onclick="confirmDelete(${c.id}); return false;">
                                                                    <i class="uil uil-user-times"></i>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-success"
                                                                   onclick="confirmActive(${c.id}); return false;">
                                                                    <i class="uil uil-user-check"></i>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Pagination -->
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Showing ${(currentPage - 1) * 10 + 1} - ${Math.min(currentPage * 10, totalPages * 10)} out of ${totalPages * 10}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?s=${searchName}&sortBy=${sortBy}&filterBy=${filterBy}&page=${currentPage - 1}">Prev</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?s=${searchName}&sortBy=${sortBy}&filterBy=${filterBy}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?s=${searchName}&sortBy=${sortBy}&filterBy=${filterBy}&page=${currentPage + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
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

        <!-- Modal start -->
        <!-- Profile Settings Start -->
        <div class="modal fade" id="editprofile" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title">Edit Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <form action="../admin/editCustomer" method="post" enctype="multipart/form-data">
                            <input type="hidden" id="editId" name="id">

                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-4">
                                    <img id="editProfileImg" src="" class="avatar avatar-md-md rounded-circle shadow mx-auto d-block" style="width: 80%; object-fit: cover;" alt="Preview Image" style="max-width: 100%; height: auto;">
                                </div>
                                <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                    <label class="form-label d-block">Upload Image:</label>
                                </div>
                                <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                    <input type="file" name="imageFile" id="imageFileInput" accept="image/*" class="form-control mb-2" onchange="previewImage(event)">
                                    <input type="hidden" name="oldImage" value="">
                                </div>
                            </div>

                            <!-- Form Fields -->
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input name="fullname" id="editFullName" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Date of Birth</label>
                                        <input name="dob" id="editDob" type="date" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Gender</label>
                                        <select name="gender" id="editGender" class="form-control">
                                            <option value="true">Male</option>
                                            <option value="false">Female</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Phone</label>
                                        <input name="phone" id="editPhone" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <input name="address" id="editAddress" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="mb-3 text-end">
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>


        <!-- Profile Settings End -->

        <!-- Profile Start -->
        <div class="modal fade" id="viewprofile" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title">Customer Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <div class="d-flex align-items-center">
                            <img id="viewProfileImg" src="" class="avatar avatar-small rounded-pill" alt="">
                            <h5 class="mb-0 ms-3" id="profileFullName">---</h5>
                        </div>
                        <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                            <li>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex">
                                        <h6>Id:</h6>
                                        <p class="text-muted ms-2" id="profileId">---</p>
                                    </li>
                                    <li class="d-flex">
                                        <h6>Date of Birth:</h6>
                                        <p class="text-muted ms-2" id="profileDob">---</p>
                                    </li>
                                    <li class="d-flex">
                                        <h6>Gender:</h6>
                                        <p class="text-muted ms-2" id="profileGender">---</p>
                                    </li>
                                    <li class="d-flex">
                                        <h6>Address:</h6>
                                        <p class="text-muted ms-2" id="profileAddress">---</p>
                                    </li>
                                    <li class="d-flex">
                                        <h6>Phone:</h6>
                                        <p class="text-muted ms-2" id="profilePhone">---</p>
                                    </li>
                                    <li class="d-flex">
                                        <h6>Email:</h6>
                                        <p class="text-muted ms-2" id="profileEmail">---</p>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile End -->
        <!-- Modal end -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                        // Lấy thông báo và loại thông báo từ session
                                        var alertMessage = '<%= session.getAttribute("errorMessage") != null ? session.getAttribute("errorMessage") : "" %>';
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
            session.removeAttribute("errorMessage");
            session.removeAttribute("alertType");
            %>
                                        }

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


        <script>
            function viewProfile(id, fullname, dob, gender, address, phone, email, imageUrl) {
                document.getElementById("profileId").innerText = id;
                document.getElementById("profileFullName").innerText = fullname;
                document.getElementById("profileDob").innerText = dob;
                document.getElementById("profileGender").innerText = gender === 'true' ? 'Male' : 'Female';
                document.getElementById("profileAddress").innerText = address;
                document.getElementById("profilePhone").innerText = phone;
                document.getElementById("profileEmail").innerText = email;
                document.getElementById("viewProfileImg").src = "${pageContext.request.contextPath}/" + imageUrl;
            }

            function editProfile(id, fullname, dob, gender, address, phone, email, imageUrl) {
                document.getElementById("editId").value = id;
                document.getElementById("editFullName").value = fullname;
                document.getElementById("editDob").value = dob;
                document.getElementById("editGender").value = gender;
                document.getElementById("editAddress").value = address;
                document.getElementById("editPhone").value = phone;
                document.getElementById("editProfileImg").src = "${pageContext.request.contextPath}/" + imageUrl;

//                document.getElementById("oldImage").value = imageUrl;
//
//                document.getElementById("imagePreview").src = "${pageContext.request.contextPath}/" + imageUrl;
            }



//            function previewProfileImage(event) {
//                let profileImg = document.getElementById("editProfileImg");
//                let file = event.target.files[0];
//
//                if (file) {
//                    let reader = new FileReader();
//                    reader.onload = function (e) {
//                        profileImg.src = e.target.result;
//                    };
//                    reader.readAsDataURL(file);
//                }
//            }

            function confirmDelete(userId) {
                if (confirm("Are you sure you want to deactive this customer?")) {
                    window.location.href = "../admin/removeCustomer?action=deactive&user_id=" + userId;
                }
            }

            function confirmActive(userId) {
                if (confirm("Are you sure you want to active this customer?")) {
                    window.location.href = "../admin/removeCustomer?action=active&user_id=" + userId;
                }
            }

        </script>

    </body>

</html>
