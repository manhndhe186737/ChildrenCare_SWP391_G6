<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Children Care - Product Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Manage products for Children Care" />
    <meta name="keywords" content="Product, Manager, Admin" />
    <meta name="author" content="Shreethemes" />
    <!-- favicon -->
    <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
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

        /* Cố định chiều cao card sản phẩm */
        .product-card {
            height: 200px; /* Giảm chiều cao card để nhỏ hơn, giống trong ảnh */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* Cố định kích thước ảnh sản phẩm */
        .shop-image {
            height: 120px; /* Giảm chiều cao ảnh để nhỏ hơn */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .shop-image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Đảm bảo ảnh không bị méo */
        }

        /* Căn chỉnh nội dung chữ */
        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center; /* Căn giữa nội dung */
            padding: 10px; /* Giảm padding để tiết kiệm không gian */
        }

        .product-name {
            display: -webkit-box;
            -webkit-line-clamp: 1; /* Giới hạn tên sản phẩm trong 1 dòng */
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 1.5em; /* Chiều cao cố định cho tên sản phẩm */
            line-height: 1.5em;
            margin-bottom: 5px; /* Khoảng cách với giá */
        }

        .product-price {
            font-size: 0.9em; /* Kích thước chữ nhỏ hơn */
            color: #28a745; /* Màu xanh giống trong ảnh */
            font-weight: bold;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
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
                        <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Products</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="product-manager">Product Manager</a></li>
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
                                <form role="search" method="get" action="product-manager" id="searchform" class="searchform">
                                    <div>
                                        <input type="text" class="form-control border rounded-pill" name="search" id="s" placeholder="Search Products...">
                                        <input type="submit" id="searchsubmit" value="Search">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <ul class="list-unstyled mb-0">
                        <li class="list-inline-item mb-0 ms-1">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                </button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark" href="../profile">
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
                            <h5 class="mb-0">Product Manager</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a>Children Care</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Products</li>
                                </ul>
                            </nav>
                        </div>
                        <div class="mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#add-product">Add Product</a>
                        </div>
                    </div>

                    <!-- Hiển thị thông báo lỗi từ session -->
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger mt-4" role="alert">
                            ${sessionScope.error}
                        </div>
                        <!-- Xóa thông báo lỗi khỏi session sau khi hiển thị -->
                        <c:remove var="error" scope="session"/>
                    </c:if>

                    <h6 class="mt-4 mb-0">Product List</h6>
                    <div class="row row-cols-md-2 row-cols-lg-5">
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="product" items="${products}">
                                    <div class="col mt-4">
                                        <div class="card shop-list border-0 overflow-hidden rounded shadow product-card">
                                            <ul class="label list-unstyled mb-0">
                                                <li>
                                                    <a href="javascript:void(0)" class="badge badge-pill ${product.status ? 'badge-success' : 'badge-danger'}">
                                                        ${product.status ? 'Active' : 'Inactive'}
                                                    </a>
                                                </li>
                                            </ul>
                                            <div class="shop-image position-relative overflow-hidden">
                                                <a href="productDetail1?id=${product.productId}">
                                                    <img src="${pageContext.request.contextPath}/${product.img}" class="img-fluid" alt="${product.productName}">
                                                </a>
                                            </div>
                                            <div class="card-body content p-4 border-top">
                                                <a href="productDetail1?id=${product.productId}" class="text-dark product-name h6">
                                                    ${not empty product.productName ? product.productName : "Unnamed Product"}
                                                </a>
                                                <div class="product-price">
                                                    $${product.price}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <p class="text-center text-danger font-weight-bold">No products found.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div><!--end row-->

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="product-manager?page=${currentPage - 1}&search=${param.search}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="product-manager?page=${i}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="product-manager?page=${currentPage + 1}&search=${param.search}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div><!--end container-->

            <!-- Footer Start -->
            <footer class="bg-white shadow py-3">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="text-sm-start text-center"></div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- End -->
        </main>
        <!--End page-content" -->
    </div>
    <!-- page-wrapper -->

    <!-- Add Product Modal -->
    <div class="modal fade" id="add-product" tabindex="-1" aria-labelledby="addProductLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom p-3">
                    <h5 class="modal-title" id="addProductLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row">
                        <!-- Form Inputs -->
                        <div class="col-md-6">
                            <form id="add-product-form" method="POST" action="product-manager?action=add" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label class="form-label">Product Name <span class="text-danger">*</span></label>
                                    <input name="productName" type="text" class="form-control" placeholder="Enter Product Name" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Price <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" name="price" min="0" step="0.01" class="form-control" placeholder="Enter Price" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                    <select class="form-control" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <c:forEach var="category" items="${categoryList}">
                                            <option value="${category.id}">${category.categoryname}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description <span class="text-danger">*</span></label>
                                    <textarea name="description" class="form-control" rows="3" placeholder="Enter Description" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Status <span class="text-danger">*</span></label>
                                    <select class="form-control" name="status" required>
                                        <option value="true">Active</option>
                                        <option value="false">Inactive</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Upload Image <span class="text-danger">*</span></label>
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
    <!-- End Modal -->

    <!-- javascript -->
    <script src="../assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="../assets/js/simplebar.min.js"></script>
    <!-- Icons -->
    <script src="../assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="../assets/js/app.js"></script>

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