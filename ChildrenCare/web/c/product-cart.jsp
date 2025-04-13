<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Children Care - Product Cart</title>
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
    <!-- Icons -->
    <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .sidebar .nav-link {
            color: #333;
            padding: 10px 20px;
            font-size: 16px;
        }
        .sidebar .nav-link.active {
            background-color: #007bff;
            color: white;
        }
        .sidebar .nav-link:hover {
            background-color: #e9ecef;
        }
        .content-area {
            padding: 20px;
        }
        .qty-btn {
            width: 40px;
            height: 40px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .quantity-input {
            width: 60px;
            text-align: center;
            margin: 0 5px;
        }
        .btn-checkout-all {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-checkout-all:hover {
            background-color: #218838;
            border-color: #1e7e34;
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
                <a class="logo" href="../c/home">
                    <span class="logo-light-mode">
                        <img src="../assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                        <img src="../assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="../assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
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
                <ul class="navigation-menu nav-left nav-dark">
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <c:if test="${sessionScope.role.contains('Staffs')}">
                                <li><a href="doctor-appointment.html" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>

                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="../service-list" class="sub-menu-item">Services List</a></li>
                            <c:if test="${sessionScope.role.contains('Customer')}">
                                <li><a href="../myreservation" class="sub-menu-item">My Reservation</a></li>
                                <li><a href="../myorders" class="sub-menu-item">My Orders</a></li>
                                <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>

                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="../blog" class="sub-menu-item">Blogs</a></li>
                            <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                <li><a href="../post-list" class="sub-menu-item">Posts - Management</a></li>
                                <li><a href="../slider" class="sub-menu-item">Sliders - Management</a></li>
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

    <!-- Hero Start -->
    <div class="position-relative">
        <div class="shape overflow-hidden text-white">
            <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
            </svg>
        </div>
    </div>
    <!-- Hero End -->

    <!-- Start -->
    <section class="section">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2">
                    <div class="sidebar">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link" href="Cart">Reservation Cart</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="ProductCart">Product Cart</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- End Sidebar -->

                <!-- Content -->
                <div class="col-md-10 content-area">
                    <h2>Product Cart</h2>
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive bg-white shadow rounded">
                                <table class="table table-center table-padding mb-0">
                                    <thead>
                                        <tr>
                                            <th class="border-bottom p-3" style="min-width:50px"></th>
                                            <th class="border-bottom p-3" style="min-width: 100px;">Product</th>
                                            <th class="border-bottom text-center p-3" style="min-width: 500px;">Description</th>
                                            <th class="border-bottom text-center p-3" style="min-width: 50px;">Price</th>
                                            <th class="border-bottom text-center p-3" style="min-width: 150px;">Quantity</th>
                                            <th class="border-bottom text-center p-3" style="min-width: 50px;">Subtotal</th>
                                            <th class="border-bottom text-center p-3" style="min-width: 50px;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="totalCartAmount" value="0" />
                                        <c:forEach var="item" items="${requestScope.cartItems}">
                                            <tr>
                                                <td class="h5 p-3 text-center">
                                                    <a href="../deleteProductCart?pcartId=${item.cartId}" class="text-danger">
                                                        <i class="uil uil-times"></i>
                                                    </a>
                                                </td>
                                                <td class="p-3">
                                                    <div class="d-flex align-items-center">
                                                        <img src="${pageContext.request.contextPath}/${item.product.img}" class="img-fluid" alt="Product Image" style="max-width: 100px; max-height: 100px;">
                                                        <h6 class="mb-0 ms-3">${item.product.productName}</h6>
                                                    </div>
                                                </td>
                                                <td class="text-center p-3">${item.product.description}</td>
                                                <td class="text-center shop-list p-3">$ ${item.product.price}</td>
                                                <td class="text-center p-3">
                                                    <form action="../UpdateCartQuantity" method="post" class="d-flex align-items-center justify-content-center">
                                                        <input type="hidden" name="cartId" value="${item.cartId}"/>
                                                        <button type="button" class="btn btn-outline-secondary qty-btn decrease">-</button>
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control quantity-input mx-2" />
                                                        <button type="button" class="btn btn-outline-secondary qty-btn increase">+</button>
                                                        <button type="submit" class="btn btn-primary btn-sm ms-2">Update</button>
                                                    </form>
                                                </td>
                                                <td class="text-center p-3">$ ${item.product.price * item.quantity}</td>
                                                <td>
                                                    <div class="qty-icons">
                                                        <form action="../Checkout" method="post">
                                                            <input type="hidden" name="cartId" value="${item.cartId}"/>
                                                            <input type="hidden" name="quantity" value="${item.quantity}"/>
                                                            <input type="hidden" name="productId" value="${item.product.productId}"/>
                                                            <input type="submit" class="btn btn-primary" value="Checkout"/>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                            <c:set var="totalCartAmount" value="${totalCartAmount + (item.product.price * item.quantity)}" />
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="5" class="text-end p-3"><strong>Total:</strong></td>
                                            <td class="text-center p-3"><strong>$ ${totalCartAmount}</strong></td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                    <div class="row">
                        <div class="col-lg-8 col-md-6 mt-4 pt-2">
                            <a href="../productlist" class="btn btn-primary">Add More Products</a>
                            <c:if test="${not empty requestScope.cartItems}">
                                <form action="../CheckoutAll" method="post" class="d-inline">
                                    <c:forEach var="item" items="${requestScope.cartItems}">
                                        <input type="hidden" name="cartIds" value="${item.cartId}"/>
                                        <input type="hidden" name="quantities" value="${item.quantity}"/>
                                        <input type="hidden" name="productIds" value="${item.product.productId}"/>
                                    </c:forEach>
                                    <button type="submit" class="btn btn-checkout-all ms-2">Proceed to Checkout All</button>
                                </form>
                            </c:if>
                        </div>
                    </div><!--end row-->
                </div><!--end content-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
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

    <!-- Thư viện SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- javascript -->
    <script src="../assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="../assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="../assets/js/app.js"></script>

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

        // Xử lý nút tăng/giảm số lượng
        document.addEventListener('DOMContentLoaded', function () {
            const forms = document.querySelectorAll('form[action="../UpdateCartQuantity"]');
            forms.forEach(form => {
                const input = form.querySelector('input[name="quantity"]');
                const decreaseBtn = form.querySelector('.decrease');
                const increaseBtn = form.querySelector('.increase');

                decreaseBtn.addEventListener('click', function () {
                    let value = parseInt(input.value);
                    if (value > 1) {
                        input.value = value - 1;
                    }
                });

                increaseBtn.addEventListener('click', function () {
                    let value = parseInt(input.value);
                    input.value = value + 1;
                });
            });
        });
    </script>
</body>

</html>