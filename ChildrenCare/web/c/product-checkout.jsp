<%-- 
    Document   : product-checkout
    Created on : Apr 12, 2025, 4:56:28 PM
    Author     : dell
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Children Care - Product Checkout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="https://shreethemes.in" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Date picker -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
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
            <div>
                <a class="logo" href="${pageContext.request.contextPath}/c/home">
                    <span class="logo-light-mode">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                    </span>
                    <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
                </a>
            </div>
            <div class="menu-extras">
                <div class="menu-item">
                    <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                </div>
            </div>
            <ul class="dropdowns list-inline mb-0">
                <c:if test="${sessionScope.role.contains('Customer')}">
                    <li class="list-inline-item mb-0">
                        <a href="${pageContext.request.contextPath}/Cart">
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
                                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                        </a>
                                    </c:if>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/profile">
                                        <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                    </a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/logout">
                                        <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                    </a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-soft-primary btn-sm">
                                <i class="uil uil-user-circle align-middle h5 me-1"></i> Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
            <div id="navigation">
                <ul class="navigation-menu nav-left nav-dark">
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Staff</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <c:if test="${sessionScope.role.contains('Staffs')}">
                                <li><a href="${pageContext.request.contextPath}/doctor-appointment.html" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="has-submenu parent-menu-item">
                        <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="${pageContext.request.contextPath}/service-list" class="sub-menu-item">Services List</a></li>
                            <c:if test="${sessionScope.role.contains('Customer')}">
                                <li><a href="${pageContext.request.contextPath}/myreservation" class="sub-menu-item">My Reservation</a></li>
                                <li><a href="${pageContext.request.contextPath}/myorders" class="sub-menu-item">My Orders</a></li>
                                <li><a href="${pageContext.request.contextPath}/BookingStaff" class="sub-menu-item">Reservation</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="has-submenu parent-parent-menu-item">
                        <a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                        <ul class="submenu">
                            <li><a href="${pageContext.request.contextPath}/blog" class="sub-menu-item">Blogs</a></li>
                            <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                <li><a href="${pageContext.request.contextPath}/post-list" class="sub-menu-item">Posts - Management</a></li>
                                <li><a href="${pageContext.request.contextPath}/slider" class="sub-menu-item">Sliders - Management</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <c:if test="${sessionScope.role.contains('Admin')}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </header>
    <!-- Navbar End -->

    <!-- Start Hero -->
    <div class="position-relative">
        <div class="shape overflow-hidden text-white">
            <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
            </svg>
        </div>
    </div>
    <!-- End Hero -->

    <!-- Start -->
    <section class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card border-0 shadow rounded overflow-hidden">
                        <div class="tab-content p-4">
                            <h4>Order Summary</h4>
                            <c:if test="${not empty requestScope.error}">
                                <div class="alert alert-danger" role="alert">
                                    Error: ${requestScope.error} <br>
                                    Please check your input and try again.
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.user == null}">
                                <div class="alert alert-warning" role="alert">
                                    Please <a href="${pageContext.request.contextPath}/login">log in</a> to proceed with checkout.
                                </div>
                            </c:if>
                            <c:if test="${empty requestScope.cartItems}">
                                <div class="alert alert-danger" role="alert">
                                    Your cart is empty. Please add products to proceed with checkout.
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.user != null && not empty requestScope.cartItems}">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${requestScope.cartItems}">
                                            <tr>
                                                <td>${item.product.productName}</td>
                                                <td>${item.quantity}</td>
                                                <td>$ ${item.product.price}</td>
                                                <td>$ ${item.product.price * item.quantity}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                            <td><strong>$ ${requestScope.totalAmount}</strong></td>
                                        </tr>
                                    </tfoot>
                                </table>

                                <form action="${pageContext.request.contextPath}/resultCod" method="POST" id="checkout-form">
                                    <div class="row">
                                        <!-- Hidden fields for order data -->
                                        <input type="hidden" name="amount" value="${requestScope.totalAmount}" />
                                        <input type="hidden" name="isFromCart" value="${requestScope.isFromCart}" />
                                        <input type="hidden" name="txt_billing_mobile" value="${sessionScope.user.phone}" />
                                        <input type="hidden" name="txt_billing_email" value="${sessionScope.account.email}" />
                                        <input type="hidden" name="txt_billing_fullname" value="${sessionScope.user.fullname}" />
                                        <input type="hidden" name="txt_inv_addr1" value="${sessionScope.user.address}" />
                                        <input type="hidden" name="txt_bill_city" value="Hanoi" />
                                        <input type="hidden" name="txt_bill_country" value="Vietnam" />
                                        <c:forEach var="item" items="${requestScope.cartItems}">
                                            <input type="hidden" name="cartIds" value="${item.cartId}"/>
                                            <input type="hidden" name="productIds" value="${item.product.productId}"/>
                                            <input type="hidden" name="quantities" value="${item.quantity}"/>
                                        </c:forEach>

                                        <!-- Customer Information -->
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Customer Name <span class="text-danger">*</span></label>
                                                <input name="customer_name" id="customer_name" type="text" value="${sessionScope.user.fullname}" class="form-control" placeholder="Customer Name">
                                                <input name="cus_id" type="hidden" value="${sessionScope.user.id}"/>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input name="email" id="email" type="email" value="${sessionScope.account.email}" class="form-control" placeholder="Your email">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Your Phone <span class="text-danger">*</span></label>
                                                <input name="phone" id="phone" type="tel" value="${sessionScope.user.phone}" class="form-control" placeholder="Your Phone">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Address <span class="text-danger">*</span></label>
                                                <input name="address" id="address" type="text" value="${sessionScope.user.address}" class="form-control" placeholder="Address">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Amount</label>
                                                <input name="amount_display" id="amount_display" type="text" value="$ ${requestScope.totalAmount}" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Payment Method <span class="text-danger">*</span></label>
                                                <select name="payment_method" id="payment_method" class="form-control">
                                                    <option value="cod" selected>Cash on Delivery</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Payment Status</label>
                                                <input name="payment_status" id="payment_status" type="text" value="Unpaid" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Date</label>
                                                <input name="date" id="date" type="text" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Status</label>
                                                <input name="status" id="status" type="text" value="Pending" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-between">
                                                <button type="button" class="btn btn-outline-secondary" onclick="history.back();">Back</button>
                                                <button type="submit" class="btn btn-primary">Confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End -->

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
    <!-- Footer End -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/select2.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flatpickr.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flatpickr.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.timepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/timepicker.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function () {
            $("#checkout-form").submit(function (e) {
                e.preventDefault();
                let isValid = true;
                $(".text-danger").remove();

                let customerName = $("#customer_name").val().trim();
                if (customerName === "") {
                    $("#customer_name").after('<small class="text-danger">Customer Name is required.</small>');
                    isValid = false;
                }

                let email = $("#email").val().trim();
                let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email === "" || !emailPattern.test(email)) {
                    $("#email").after('<small class="text-danger">Enter a valid email address.</small>');
                    isValid = false;
                }

                let phone = $("#phone").val().trim();
                let phonePattern = /^[0-9]{10,11}$/;
                if (phone === "" || !phonePattern.test(phone)) {
                    $("#phone").after('<small class="text-danger">Enter a valid phone number (10-11 digits).</small>');
                    isValid = false;
                }

                let address = $("#address").val().trim();
                if (address === "") {
                    $("#address").after('<small class="text-danger">Address is required.</small>');
                    isValid = false;
                }

                let cartIds = $("input[name='cartIds']").length;
                if (cartIds === 0) {
                    $("#checkout-form").prepend('<small class="text-danger">No items in cart.</small>');
                    isValid = false;
                }

                if (!isValid) {
                    Swal.fire({
                        icon: "error",
                        title: "Validation Error",
                        text: "Please correct the errors in the form before submitting."
                    });
                } else {
                    console.log("Submitting form to: " + this.action);
                    this.submit();
                }
            });
        });

        // Lắng nghe sự thay đổi trong select payment_method
        document.getElementById('payment_method').addEventListener('change', function () {
            var form = document.getElementById('checkout-form');
            var paymentMethod = this.value;
            console.log("Payment method changed to: " + paymentMethod);
            if (paymentMethod === 'bank') {
                form.action = '${pageContext.request.contextPath}/vn-pay';
            } else {
                form.action = '${pageContext.request.contextPath}/resultCod';
            }
        });
    </script>
</body>
</html>