<%@ page import="model.Service" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Children Service Booking System Booking System</title>
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
        <style>
            /* Căn chỉnh bố cục Add Product Form */
            #add-product-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            /* Thiết lập vùng preview ảnh */
            .preview-box {
                width: 100%;
                max-width: 250px;
                height: 250px;
                border: 2px dashed #ddd;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f8f9fa;
                overflow: hidden;
                margin: auto;
            }

            .preview-content {
                max-width: 100%;
                max-height: 100%;
                object-fit: contain;
            }

            .pharpachy-categories {
                min-height: 80px; /* Tăng chiều cao tối thiểu */
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                padding: 10px;
            }

            .category-title {
                white-space: normal; /* Để văn bản xuống dòng nếu quá dài */
                overflow: visible;
                font-size: 16px; /* Điều chỉnh font nếu cần */
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
                            <div class="search-bar p-0 d-none d-lg-block ms-2">
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="get" action="ServiceListServlet" id="searchform" class="searchform">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="search" id="s" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
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
                            <div>
                                <h5 class="mb-0">Services</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="index.html">Children Care</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Services</li>
                                    </ul>
                                </nav>
                            </div>

                            <div class="mt-4 mt-sm-0">
                                <a href="AddServiceServlet" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#add-product">Add Services</a>
                            </div>
                        </div>

                        <h6 class="mt-4 mb-0">Services List</h6>
                        <div class="row row-cols-md-2 row-cols-lg-5">
                            <c:choose>
                                <c:when test="${not empty services}">
                                    <c:forEach var="service" items="${services}">
                                        <div class="col mt-4">
                                            <div class="card shop-list border-0 overflow-hidden rounded shadow">
                                                <ul class="label list-unstyled mb-0">
                                                    <li>
                                                        <!-- Kiểm tra giá trị của isActive và hiển thị Active/Inactive -->
                                                        <a href="javascript:void(0)" class="badge badge-pill badge-success">
                                                            <c:choose>
                                                                <c:when test="${service.isActive}">
                                                                    Active
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Deactive
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </li>
                                                </ul>
                                                <div class="shop-image position-relative overflow-hidden">
                                                    <a href="serviceDetails?id=${service.id}">
                                                        <img src="${pageContext.request.contextPath}/${service.img}" class="img-fluid" alt="Service Image">
                                                    </a>
                                                </div>
                                                <div class="card-body content p-4 border-top">
                                                    <a href="${pageContext.request.contextPath}/admin/serviceDetails?id=${service.id}" class="text-dark product-name h6">
                                                        ${not empty service.name ? service.name : "Tên dịch vụ"}
                                                    </a>

                                                    <div class="d-flex justify-content-between mt-1">
                                                        <h6 class="text-muted small font-italic mb-0 mt-1">
                                                            $${service.price}
                                                        </h6>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!--end col-->
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12">
                                        <p class="text-center text-danger font-weight-bold">Không có dịch vụ nào</p>
                                    </div>
                                </c:otherwise>
                            </c:choose> 
                        </div><!--end row-->

                        <h6 class="mt-4 mb-0">Categories</h6>

                        <div class="row row-cols-md-2 row-cols-lg-5">
                            <c:forEach var="category" items="${categories}">
                                <div class="col mt-4 pt-2">
                                    <a href="ServiceListServlet?categoryId=${category.id}" class="card pharpachy-categories border-0 rounded d-flex align-items-center justify-content-center p-3">
                                        <div class="category-title text-center">
                                            <span class="text-dark title-white"><span class="h5">${category.categoryname}</span></span>
                                        </div>
                                    </a>
                                </div><!--end col-->
                            </c:forEach>
                        </div><!--end row-->

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

        <!-- Start Modal -->
        <!-- Start Modal -->
        <div class="modal fade" id="add-product" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel">Add Shop Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body p-4">
                        <div class="row">
                            <!-- Form Inputs -->
                            <div class="col-md-6">
                                <form id="add-product-form" method="POST" action="AddServiceServlet" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label class="form-label">Service Name <span class="text-danger">*</span></label>
                                        <input name="name" type="text" class="form-control" placeholder="Enter Service Name" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Price:</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" name="price" min="0" class="form-control" placeholder="Enter Price" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Category:</label>
                                        <select class="form-control" name="category">
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.id}">${category.categoryname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description:</label>
                                        <textarea name="description" class="form-control" rows="3" placeholder="Enter Description"></textarea>
                                    </div>

                                    <!-- Upload Image -->
                                    <div class="mb-3">
                                        <label class="form-label">Upload Image:</label>
                                        <input type="file" name="imageFile" accept="image/*" class="form-control" onchange="previewImage(event)" required>
                                    </div>

                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">Add Product</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Image Preview -->
                            <div class="col-md-6 text-center">
                                <div class="preview-box">
                                    <img id="preview-image" class="preview-content" src="../assets/images/placeholder.jpg" alt="Preview Image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        <!-- End modal -->

        <!-- End modal -->


        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <script>
                                            const handleChange = () => {
                                                const fileUploader = document.querySelector('#input-file');
                                                const getFile = fileUploader.files
                                                if (getFile.length !== 0) {
                                                    const uploadedFile = getFile[0];
                                                    readFile(uploadedFile);
                                                }
                                            };

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
                const input = event.target;
                const reader = new FileReader();
                reader.onload = function () {
                    const imgElement = document.getElementById("preview-image");
                    imgElement.src = reader.result;
                };
                reader.readAsDataURL(input.files[0]);
            }

        </script>
    </body>

</html>