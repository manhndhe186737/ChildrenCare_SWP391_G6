<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Order Details - Children Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Children Service Booking System" />
    <meta name="keywords" content="Appointment, Booking, System, Health" />
    <meta name="author" content="Shreethemes" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .badge {
            padding: 0.4em 0.6em;
            border-radius: 0.25rem;
            color: white;
        }
        .badge-completed { background-color: #28a745; }
        .badge-success { background-color: #28a745; }
        .badge-info { background-color: #17a2b8; }
        .badge-warning { background-color: #ffc107; color: black; }
        .badge-danger { background-color: #dc3545; }
        .table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .table th, .table td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            vertical-align: middle;
            overflow-wrap: break-word;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .col-product { width: 50%; text-align: left; }
        .col-price { width: 25%; text-align: right; }
        .col-quantity { width: 25%; text-align: center; }
    </style>
</head>
<body>
    <!-- Navigation -->
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
                        <a href="${pageContext.request.contextPath}/c/Cart">
                            <div class="btn btn-icon btn-pills btn-primary"><i data-feather="heart" class="fea icon-sm"></i></div>
                        </a>
                    </li>
                </c:if>
                <!-- User Dropdown -->
            </ul>
            <div id="navigation">
                <ul class="navigation-menu nav-left nav-dark">
                    <c:if test="${sessionScope.role.contains('Customer')}">
                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="${pageContext.request.contextPath}/service-list" class="sub-menu-item">Services List</a></li>
                                <li><a href="${pageContext.request.contextPath}/myreservation" class="sub-menu-item">My Reservation</a></li>
                                <li><a href="${pageContext.request.contextPath}/myorders" class="sub-menu-item">My Orders</a></li>
                                <li><a href="${pageContext.request.contextPath}/c/BookingStaff" class="sub-menu-item">Reservation</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <!-- Other navigation items -->
                </ul>
            </div>
        </div>
    </header>
    <!-- Order Details -->
    <section class="section">
        <div class="container">
            <h2>Order Details</h2>
            <c:choose>
                <c:when test="${empty order}">
                    <div class="alert alert-warning" role="alert">
                        Order not found. Please check the order ID or contact support.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="bg-white shadow rounded p-4">
                                <h4>Order Information</h4>
                                <p><strong>Order ID:</strong> ${fn:escapeXml(order.orderId)}</p>
                                <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></p>
                                <p><strong>Status:</strong>
                                    <span class="badge ${order.status == 'Delivered' ? 'badge-success' : order.status == 'Completed' ? 'badge-completed' : order.status == 'Shipped' ? 'badge-info' : order.status == 'Pending' ? 'badge-warning' : 'badge-danger'}">
                                        ${fn:escapeXml(order.status)}
                                    </span>
                                </p>
                                <p><strong>Payment Method:</strong> ${fn:escapeXml(order.paymentMethod)}</p>
                                <p><strong>Payment Status:</strong> ${fn:escapeXml(order.paymentStatus)}</p>
                                <p><strong>Address:</strong> ${fn:escapeXml(order.address)}</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive bg-white shadow rounded">
                                <table class="table table-center table-padding mb-0">
                                    <thead>
                                        <tr>
                                            <th class="border-bottom p-3 col-product">Product Name</th>
                                            <th class="border-bottom p-3 col-price">Unit Price</th>
                                            <th class="border-bottom p-3 col-quantity">Quantity</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty orderDetails}">
                                                <tr>
                                                    <td colspan="3" class="p-3 text-center">No details available for this order.</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="totalSum" value="0" />
                                                <c:forEach var="detail" items="${orderDetails}">
                                                    <tr>
                                                        <td class="p-3">${fn:escapeXml(detail.productName)}</td>
                                                        <td class="p-3">$<fmt:formatNumber value="${detail.unitPrice}" pattern="#,##0.00"/></td>
                                                        <td class="p-3">${detail.quantity}</td>
                                                    </tr>
                                                    <c:set var="totalSum" value="${totalSum + (detail.quantity * detail.unitPrice)}" />
                                                </c:forEach>
                                                <tr>
                                                    <td colspan="2" class="p-3 text-right"><strong>Total:</strong></td>
                                                    <td class="p-3 text-right"><strong>$<fmt:formatNumber value="${totalSum}" pattern="#,##0.00"/></strong></td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/myorders" class="btn btn-primary">Back to My Orders</a>
                        <c:if test="${order.status == 'Pending'}">
                            <a href="${pageContext.request.contextPath}/cancel-order?oid=${order.orderId}"
                               class="btn btn-danger ms-2"
                               onclick="return confirm('Are you sure you want to cancel this order?');">
                                Cancel Order
                            </a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    <!-- Footer -->
    <footer class="bg-footer footer-spacing">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                    <a href="${pageContext.request.contextPath}/c/home" class="logo-footer">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-light-child.png" height="24" alt=""> ChildrenCare
                    </a>
                    <p class="mt-4 me-xl-5">
                        We are committed to providing the best healthcare services for children, ensuring their overall development and optimal health.
                    </p>
                </div>
                <!-- Footer content -->
            </div>
        </div>
        <div class="container mt-5">
            <div class="pt-4 footer-bar">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="text-sm-start text-center">
                            <p class="text-foot mb-0">© ${fn:substring(pageContext.request.serverTime, 0, 4)} Children Care. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="https://shreethemes.in/" target="_blank" class="text-reset">Shreethemes</a>.</p>
                        </div>
                    </div>
                    <!-- Footer links -->
                </div>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        feather.replace();
    </script>
</body>
</html>