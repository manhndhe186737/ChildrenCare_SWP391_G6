<%@ page import="model.ServiceCategory" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Settings - Service Categories</title>
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>


            .sidebar-wrapper {
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                width: 250px;
                z-index: 999;
            }

            .page-content {
                margin-top: 70px;
                min-height: calc(100vh - 80px);
                padding: 20px;
                background-color: #f8f9fa;
            }

            /* Container chính */
            .container.mt-4 {
                margin-top: 20px;
                padding-bottom: 20px;
                min-height: auto;
            }

            footer.bg-footer {
                position: relative;
                width: 100%;
                padding: 10px 0;
                background-color: #343a40;
                color: white;
                text-align: center;
            }

            /* Toggle switch styling (giữ nguyên nhưng đảm bảo không ảnh hưởng bố cục) */
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

            /* Đảm bảo các nút không bị lệch */
            .d-flex {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .btn-primary {
                background-color: #3498db;
                border-color: #3498db;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            /* Modal căn giữa */
            .modal-content {
                margin-top: 100px; /* Giảm từ 200px xuống để không quá thấp */
            }

            /* Đảm bảo bảng không bị tràn */
            .table {
                margin-top: 20px;
                width: 100%;
            }

            /* Pagination căn giữa */
            .pagination {
                margin-top: 20px;
            }
            .page-wrapper .page-content .layout-specing{
                padding-top:0px !important;
            }
            /* Enhanced Settings Page Styling */

            /* Main Content Container */
            .container-fluid .layout-specing {
                padding: 25px 30px;
                background-color: #f8f9fc;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.03);
            }

            /* Page Title */
            .layout-specing h2 {
                color: #3c4858;
                font-weight: 700;
                margin-bottom: 25px;
                font-size: 24px;
                position: relative;
                padding-bottom: 10px;
            }

            .layout-specing h2:after {
                content: '';
                position: absolute;
                width: 50px;
                height: 3px;
                background: #754FFE;
                bottom: 0;
                left: 0;
                border-radius: 3px;
            }

            /* Search and Filter Bar */
            .d-flex.justify-content-between.mb-3 {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 25px !important;
            }

            .d-flex.justify-content-between.mb-3 form.d-flex {
                flex: 1;
                gap: 10px;
            }

            .d-flex.justify-content-between.mb-3 input.form-control,
            .d-flex.justify-content-between.mb-3 select.form-select {
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                padding: 10px 15px;
                transition: all 0.3s ease;
                box-shadow: none;
            }

            .d-flex.justify-content-between.mb-3 input.form-control:focus,
            .d-flex.justify-content-between.mb-3 select.form-select:focus {
                border-color: #754FFE;
                box-shadow: 0 0 0 3px rgba(117, 79, 254, 0.15);
            }

            .d-flex.justify-content-between.mb-3 .btn-primary {
                background-color: #754FFE;
                border-color: #754FFE;
                border-radius: 8px;
                font-weight: 600;
                padding: 10px 20px;
                transition: all 0.3s ease;
            }

            .d-flex.justify-content-between.mb-3 .btn-primary:hover {
                background-color: #6039e5;
                box-shadow: 0 4px 12px rgba(117, 79, 254, 0.2);
                transform: translateY(-2px);
            }

            /* Add New Category Button */
            .d-flex.justify-content-between.mb-3 .btn-primary.ms-3 {
                background-color: #754FFE;
                border-color: #754FFE;
                padding: 10px 20px;
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(117, 79, 254, 0.2);
            }

            .d-flex.justify-content-between.mb-3 .btn-primary.ms-3:hover {
                background-color: #6039e5;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(117, 79, 254, 0.3);
            }

            .d-flex.justify-content-between.mb-3 .btn-primary.ms-3:before {
                content: "+";
                font-size: 18px;
                margin-right: 8px;
                line-height: 1;
            }

            /* Categories Table */
            .table {
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
                margin-bottom: 25px;
                border: none;
            }

            .table thead.thead-dark {
                background-color: #f8f9fa;
            }

            .table thead th {
                font-weight: 600;
                color: #495057;
                text-transform: uppercase;
                font-size: 12px;
                letter-spacing: 0.5px;
                padding: 15px 20px;
                border-bottom: 2px solid #f0f0f0;
                background-color: #f8f9fa;
            }

            .table tbody tr {
                transition: all 0.2s ease;
            }

            .table tbody tr:hover {
                background-color: #f8f9ff;
            }

            .table tbody td {
                padding: 15px 20px;
                vertical-align: middle;
                color: #495057;
                font-size: 14px;
                border-bottom: 1px solid #f0f0f0;
            }

            /* Status Toggle Switch */
            .toggle {
                position: relative;
                display: inline-block;
                width: 52px;
                height: 26px;
                margin: 0;
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
                background-color: #e9ecef;
                transition: 0.4s;
                border-radius: 34px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: 0.4s;
                border-radius: 50%;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            input:checked + .toggle-slider {
                background-color: #10b981;
            }

            input:checked + .toggle-slider:before {
                transform: translateX(26px);
            }

            .toggle-slider:after {
                content: "OFF";
                position: absolute;
                right: 6px;
                bottom: 3px;
                color: #495057;
                font-size: 10px;
                font-weight: 600;
                opacity: 1;
                transition: 0.4s;
            }

            input:checked + .toggle-slider:after {
                content: "ON";
                right: auto;
                left: 6px;
                color: white;
                opacity: 1;
            }

            /* Action Buttons */
            .btn-warning.btn-sm {
                background-color: #f59e0b;
                border-color: #f59e0b;
                color: white;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 13px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-warning.btn-sm:hover {
                background-color: #d97706;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(245, 158, 11, 0.3);
            }

            .btn-warning.btn-sm i {
                margin-right: 4px;
            }

            /* Pagination */
            .pagination {
                justify-content: center;
                margin-top: 30px;
                margin-bottom: 20px;
            }

            .pagination .page-item .page-link {
                color: #495057;
                background-color: white;
                border: 1px solid #e9ecef;
                padding: 8px 16px;
                font-size: 14px;
                margin: 0 3px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .pagination .page-item .page-link:hover {
                background-color: #f8f9fa;
                border-color: #e9ecef;
                color: #754FFE;
            }

            .pagination .page-item.active .page-link {
                background-color: #754FFE;
                border-color: #754FFE;
                color: white;
                box-shadow: 0 2px 5px rgba(117, 79, 254, 0.3);
            }

            /* Modal Styling */
            .modal-content {
                border-radius: 15px;
                overflow: hidden;
                border: none;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                background: linear-gradient(to right, #754FFE, #8E67FE);
                color: white;
                padding: 15px 20px;
                border-bottom: none;
            }

            .modal-header h5 {
                font-weight: 600;
                font-size: 18px;
            }

            .modal-body {
                padding: 20px;
            }

            .modal-body .form-group label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .modal-body .form-control,
            .modal-body .form-select {
                padding: 10px 15px;
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .modal-body .form-control:focus,
            .modal-body .form-select:focus {
                border-color: #754FFE;
                box-shadow: 0 0 0 3px rgba(117, 79, 254, 0.15);
            }

            .modal-body textarea.form-control {
                min-height: 100px;
            }

            .modal-body .btn-primary {
                background-color: #754FFE;
                border-color: #754FFE;
                font-weight: 600;
                padding: 10px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .modal-body .btn-primary:hover {
                background-color: #6039e5;
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(117, 79, 254, 0.2);
            }

            /* Close button in modal */
            .modal .btn-close,
            .modal .close {
                color: white;
                opacity: 1;
                text-shadow: none;
            }

            /* Add icon for Edit button */
            .btn-warning.btn-sm:before {
                content: "✏️";
                margin-right: 5px;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .d-flex.justify-content-between.mb-3 {
                    flex-direction: column;
                    gap: 15px;
                }

                .d-flex.justify-content-between.mb-3 form.d-flex {
                    flex-direction: column;
                    width: 100%;
                }

                .d-flex.justify-content-between.mb-3 .btn-primary.ms-3 {
                    margin-left: 0 !important;
                    width: 100%;
                    justify-content: center;
                }

                .table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
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

        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <a href="../c/home">
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
                </div>
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>

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
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                    </button>
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


                        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="settings" method="POST" id="addCategoryForm">
                                            <input type="hidden" name="action" value="add">
                                            <div class="form-group mb-3">
                                                <label for="categoryName">Category Name</label>
                                                <input type="text" class="form-control" id="categoryName" name="name" required>
                                            </div>
                                            <div class="form-group mb-3">
                                                <label for="categoryStatus">Status</label>
                                                <div class="toggle-wrapper">
                                                    <label class="toggle">
                                                        <input type="checkbox" id="categoryStatus" name="status" checked class="form-check-input">
                                                        <span class="toggle-slider"></span>
                                                    </label>
                                                    <span class="toggle-label">Active</span>
                                                </div>
                                            </div>
                                            <div class="form-group mb-3">
                                                <label for="categoryDescription">Description</label>
                                                <textarea class="form-control" id="categoryDescription" name="description" rows="3"></textarea>
                                            </div>
                                            <div class="text-end">
                                                <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-primary">Add Category</button>
                                            </div>
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
                <!-- Scripts -->
                <script src="../assets/js/bootstrap.bundle.min.js"></script>
                <script src="../assets/js/jquery.min.js"></script>

                <!-- Icons -->
                <script src="../assets/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="../assets/js/app.js"></script>


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

                    $(document).ready(function () {
                        // Form validation for adding new category
                        $('#addCategoryForm').on('submit', function (event) {
                            var categoryName = $('#categoryName').val().trim();

                            if (categoryName === '') {
                                event.preventDefault();
                                alert('Category name cannot be empty');
                                $('#categoryName').addClass('is-invalid').focus();
                                return false;
                            }
                        });

                        // Clear form when modal is shown
                        $('#addCategoryModal').on('show.bs.modal', function () {
                            $('#addCategoryForm')[0].reset();
                            $('#categoryName').removeClass('is-invalid');
                        });

                        // Auto-dismiss success messages
                        if ($('.alert-success').length > 0) {
                            setTimeout(function () {
                                $('.alert-success').fadeOut('slow');
                            }, 3000);
                        }
                    });
                </script>

                </body>
                </html>

