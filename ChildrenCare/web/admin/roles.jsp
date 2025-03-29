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
        <style>
            /* Custom styles for the table */
            table th, table td {
                text-align: center;
                vertical-align: middle;
            }


            /* Fixed width for the columns */
            table th {
                width: 33%;
            }


            table td {
                word-wrap: break-word;
            }


            /* Style for the buttons */
            .role-btn {
                margin: 0 5px;
            }


            .role-btn:focus {
                box-shadow: none;
            }


            .custom-btn-size {
                width: 100px;  /* Đặt chiều rộng cố định */
                height: 40px;  /* Đặt chiều cao cố định */
                font-size: 10px;  /* Điều chỉnh kích thước chữ */
                text-overflow: ellipsis;  /* Cắt bớt văn bản nếu quá dài */
                white-space: nowrap;  /* Ngăn chặn việc xuống dòng */
                overflow: hidden;  /* Ẩn văn bản vượt quá kích thước nút */
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
                                    <form role="search" action="../admin/customers" method="get" id="searchform" class="searchform">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
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
                            <h5 class="mb-0">Authorization</h5>
                        </div>


                        <!-- Center buttons -->
                        <div class="d-flex justify-content-center mb-3">
                            <div class="btn-group" role="group" aria-label="Roles">
                                <c:forEach var="r" items="${requestScope.roles}">
                                    <button type="button" class="btn btn-outline-primary role-btn mx-2" data-role="${r.rname}" onclick="toggleTable('${r.rname}', this)">${r.rname}</button>
                                </c:forEach>
                            </div>
                        </div>


                        <div class="d-flex justify-content-left mb-3">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFeatureModal">
                                + Add Feature
                            </button>
                        </div>


                        <!-- Tables -->
                        <form>
                            <c:forEach var="r" items="${requestScope.roles}">
                                <div id="table-${r.rname}" class="role-table" style="${r.rname == requestScope.roles[0].rname ? 'display: block;' : 'display: none;'}">
                                    <table class="table table-bordered table-hover" style="border-collapse: collapse;">
                                        <thead style="background-color: #f1f1f1;">
                                            <tr>
                                                <th style="text-align: left; width: 10%;"></th>
                                                <th style="text-align: left; width: 35%;">Feature</th>
                                                <th style="text-align: left; width: 35%;">Url</th>
                                                <th style="text-align: left; width: 10%;">Status</th>
                                                <!--                                                <th style="text-align: left; width: 10%;">Action</th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="f" items="${r.features}">
                                                <tr style="border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;">
                                                    <td style="text-align: left; border-left: none; border-right: none; font-weight: bold;">
                                                        <input type="hidden" name="roleId" value="${r.rid}"/>
                                                        <input type="hidden" name="featureId" value="${f.fid}"/>
                                                        ${f.fid}
                                                    </td>
                                            <input type="hidden" name="featureStatus" value="${f.status}"/>
                                            <td style="text-align: left; border-left: none; border-right: none;">${f.fname}</td>
                                            <td style="text-align: left; border-left: none; border-right: none;">${f.url}</td>
                                            <td style="text-align: left; border-left: none; border-right: none;">
                                                <button type="button"
                                                        class="btn ${f.status == 'active' ? 'btn-danger' : 'btn-success'} custom-btn-size"
                                                        onclick="submitFeature('${r.rid}', '${f.fid}', '${f.fname}', '${f.url}', '${f.status}')"
                                                        ${r.rname == 'Admin' ? 'disabled' : ''}>
                                                    ${f.status == 'active' ? 'Inactive' : 'Active'}
                                                </button>
                                            </td>
                                            <!--                                            <td style="text-align: left; border-left: none; border-right: none;">
                                                                                            <input type="hidden" name="roleId" value="${r.rid}"/>
                                                                                            <input type="hidden" name="featureId" value="${f.fid}"/>
                                                                                            <button type="button" style="border-radius: 5px" class="btn-primary custom-btn-size" data-bs-toggle="modal" data-bs-target="#updateFeatureModal" onclick="setUpdateData('${r.rid}', '${f.fid}', '${f.fname}', '${f.url}')">Update</button>
                                                                                        </td>-->
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:forEach>
                        </form>
                    </div>
                </div>


                <!-- Modal for Add Feature -->
                <div class="modal fade" id="addFeatureModal" tabindex="-1" aria-labelledby="addFeatureModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addFeatureModalLabel">Add New Feature</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="addFeatureForm" action="AddFeature" method="post">
                                    <div class="mb-3">
                                        <label for="roleId" class="form-label">Role Id</label>
                                        <select class="form-control" id="roleId" name="roleId" required>
                                            <option value="" disabled selected>Select a Role</option>
                                            <c:forEach var="r" items="${requestScope.roles}">
                                                <option value="${r.rid}">${r.rname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>


                                    <div class="mb-3">
                                        <label for="featureName" class="form-label">Feature Name</label>
                                        <input type="text" class="form-control" id="featureName" name="featureName" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="featureUrl" class="form-label">Feature Url</label>
                                        <input type="text" class="form-control" id="featureUrl" name="featureUrl" required>
                                    </div>
                                    <div class="mb-3">
                                        <input type="submit" class="btn btn-primary" value="Submit"/>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- page-wrapper -->


                <!-- Modal update -->
                <div class="modal fade" id="updateFeatureModal" tabindex="-1" aria-labelledby="updateFeatureModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateFeatureModalLabel">Update Feature</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateFeatureForm" action="UpdateFeature" method="post">
                                    <div class="mb-3">
                                        <label for="roleId" class="form-label">Role Id</label>
                                        <input type="text" class="form-control" id="roleUpdateId" name="rid" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="fid" class="form-label">Feature Id</label>
                                        <input type="text" class="form-control" id="fid" name="fid" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="featureName" class="form-label">Feature Name</label>
                                        <input type="text" class="form-control" id="featureUpdateName" name="fname" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="featureUrl" class="form-label">Feature Url</label>
                                        <input type="text" class="form-control" id="featureUpdateUrl" name="furl" required>
                                    </div>
                                    <div class="mb-3">
                                        <input type="submit" class="btn btn-primary" value="Update"/>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>




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


                                                var alertMessage = '<%= session.getAttribute("fsuccess") != null ? session.getAttribute("fsuccess") : "" %>';
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
                        session.removeAttribute("fsuccess");
                        session.removeAttribute("alertType");
                    %>
                                                }


                </script>


                <script>
                    // JavaScript function to toggle the visibility of the feature table
                    function toggleTable(roleName, button) {
                        var table = document.getElementById("table-" + roleName);
                        var allTables = document.querySelectorAll(".role-table");


                        // Hide all tables first
                        allTables.forEach(function (t) {
                            t.style.display = "none";
                        });


                        // Show the clicked role's table
                        table.style.display = table.style.display === "none" ? "block" : "none";


                        // Change the button style to active and reset others
                        var buttons = document.querySelectorAll(".role-btn");
                        buttons.forEach(function (btn) {
                            btn.classList.remove("btn-primary");
                            btn.classList.add("btn-outline-primary");
                        });


                        button.classList.remove("btn-outline-primary");
                        button.classList.add("btn-primary");
                    }


// Initialize the page by making the first role button active by default
                    document.addEventListener("DOMContentLoaded", function () {
                        var firstRoleButton = document.querySelector(".role-btn");
                        if (firstRoleButton) {
                            firstRoleButton.classList.remove("btn-outline-primary");
                            firstRoleButton.classList.add("btn-primary");


                            // Show the first role's table by default
                            var firstRoleName = firstRoleButton.getAttribute("data-role");
                            var firstTable = document.getElementById("table-" + firstRoleName);
                            if (firstTable) {
                                firstTable.style.display = "block";
                            }
                        }
                    });


                    function setUpdateData(roleId, featureId, featureName, url) {
                        // Hiển thị alert với thông tin roleId và featureId
                        alert("Role ID: " + roleId + "\nFeature ID: " + featureId);


                        // Cập nhật các trường dữ liệu trong form modal
                        document.getElementById("roleUpdateId").value = roleId;
                        document.getElementById("fid").value = featureId;
                        document.getElementById("featureUpdateName").value = featureName; // Đây cần phải là tên của tính năng, không phải featureId
                        document.getElementById("featureUpdateUrl").value = url;  // Tương tự, bạn cần lấy URL tính năng thực tế
                    }




                </script>


                <script>


                    function submitFeature(roleId, featureId, featureName, featureUrl, featureStatus) {
                        // Hiển thị SweetAlert để xác nhận
                        Swal.fire({
                            title: 'Are you sure?',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonText: 'Yes',
                            cancelButtonText: 'No',
                        }).then((result) => {
                            // Nếu người dùng nhấn "Yes, submit it!"
                            if (result.isConfirmed) {
                                // Thêm dữ liệu vào form trước khi submit
                                const form = document.querySelector('form');


                                const roleIdInput = document.createElement('input');
                                roleIdInput.type = 'hidden';
                                roleIdInput.name = 'roleId';
                                roleIdInput.value = roleId;
                                form.appendChild(roleIdInput);


                                const featureIdInput = document.createElement('input');
                                featureIdInput.type = 'hidden';
                                featureIdInput.name = 'featureId';
                                featureIdInput.value = featureId;
                                form.appendChild(featureIdInput);


                                const featureNameInput = document.createElement('input');
                                featureNameInput.type = 'hidden';
                                featureNameInput.name = 'featureName';
                                featureNameInput.value = featureName;
                                form.appendChild(featureNameInput);


                                const featureUrlInput = document.createElement('input');
                                featureUrlInput.type = 'hidden';
                                featureUrlInput.name = 'featureUrl';
                                featureUrlInput.value = featureUrl;
                                form.appendChild(featureUrlInput);


                                const featureStatusInput = document.createElement('input');
                                featureStatusInput.type = 'hidden';
                                featureStatusInput.name = 'featureStatus';
                                featureStatusInput.value = featureStatus;
                                form.appendChild(featureStatusInput);


                                form.action = 'authorization';
                                form.method = 'POST';
                                // Submit form
                                form.submit();
                            }
                        });
                    }




                </script>


                </body>


                </html>



