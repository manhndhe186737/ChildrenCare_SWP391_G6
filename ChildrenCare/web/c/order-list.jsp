<%--
    Document   : order-list.jsp (Complete Version)
    Author     : YourName
    Description: Displays a paginated, searchable, filterable, and sortable list of orders
                 with functionality to update order status, view details, and show phone number.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Order List - Children Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Manage and view customer orders with filters and sorting." />
    <meta name="keywords" content="Order, List, Admin, Management, Sort, Filter, Update Status, Children Care" />
    <meta name="author" content="YourName" />
    <meta name="Version" content="v1.3" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Theme Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <!-- Custom Styles -->
    <style>
        body { background-color: #f8f9fa; }
        .table-responsive { min-height: 400px; max-height: 650px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 0.25rem; }
        .table { margin-bottom: 0; }
        .table th { white-space: nowrap; background-color: #f8f9fa; }
        .table tbody tr { height: 55px; vertical-align: middle; }
        .table tbody tr:hover { background-color: #e9ecef; }
        .pagination-container { min-height: 60px; margin-top: 20px; }
        .sortable { cursor: pointer; }
        .sortable a { color: inherit !important; text-decoration: none !important; display: inline-block; }
        .sortable a:hover { color: inherit !important; }
        .sortable i { margin-left: 5px; color: #aaa; font-size: 0.8em; vertical-align: middle; }
        .sortable .uil-arrow-up, .sortable .uil-arrow-down { color: #333; }
        #orderDetailModal .table th, #orderDetailModal .table td { padding: 0.5rem; font-size: 0.9em; vertical-align: middle; }
        .modal-body .table-responsive { max-height: 350px; min-height: auto; border: none; }
        #modalTotalAmount { font-weight: bold; }
        .filter-form { border: 1px solid #dee2e6; }
        .filter-form label { font-size: 0.9em; margin-right: 5px; margin-bottom: 2px; display: block; }
        .filter-form .form-control-sm, .filter-form .form-select-sm { padding: 0.3rem 0.6rem; font-size: 0.9em; height: auto; width: 100%; margin-bottom: 5px; }
        .filter-form .col-lg-1 button { height: 31px; }
        .status-form { display: flex; align-items: center; justify-content: center; }
        .status-form select { flex-grow: 1; margin-right: 5px; padding: 0.25rem 0.5rem; font-size: 0.875rem; line-height: 1.5; border-radius: 0.2rem; max-width: 140px; height: calc(1.5em + 0.5rem + 2px); }
        .status-form button { flex-shrink: 0; padding: 0.25rem 0.5rem; font-size: 0.875rem; line-height: 1.5; }
        .sticky-bar { position: sticky; top: 80px; }
        .invalid-feedback { font-size: 0.8em; display: none; width: 100%; margin-top: 0.25rem; }
        .form-control.is-invalid ~ .invalid-feedback,
        .form-select.is-invalid ~ .invalid-feedback { display: block; }
    </style>
</head>
<body>
    <!-- Loader -->
    <div id="preloader"><div id="status"><div class="spinner"><div class="double-bounce1"></div><div class="double-bounce2"></div></div></div></div>

    <!-- Navbar Start -->
    <header id="topnav" class="defaultscroll sticky bg-white shadow">
        <div class="container">
            <!-- Logo -->
            <div><a class="logo" href="${pageContext.request.contextPath}/c/home"><img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" height="24" alt="Logo"></a></div>
            <!-- Mobile Toggle -->
            <div class="menu-extras"><div class="menu-item"><a class="navbar-toggle" id="isToggle" onclick="toggleMenu()"><div class="lines"><span></span><span></span><span></span></div></a></div></div>
            <!-- Icons Dropdown (Cart, User Profile/Login) -->
            <ul class="dropdowns list-inline mb-0">
                <c:if test="${sessionScope.role eq 'Customer'}">
                    <li class="list-inline-item mb-0"><a href="${pageContext.request.contextPath}/Cart" title="Cart"><div class="btn btn-icon btn-pills btn-primary"><i data-feather="shopping-cart" class="fea icon-sm"></i></div></a></li>
                </c:if>
                <li class="list-inline-item mb-0 ms-1">
                    <c:choose>
                        <c:when test="${sessionScope.user ne null}">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="Avatar"></button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark" href="${pageContext.request.contextPath}/profile"><img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow me-2" alt=""><div class="flex-grow-1"><span class="d-block mb-0 fw-medium">${sessionScope.user.fullname}</span><small class="text-muted">${sessionScope.role}</small></div></a>
                                    <c:if test="${sessionScope.role eq 'Admin'}"><a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/admin/dashboard"><i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard</a></c:if>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/profile"><i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings</a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/logout"><i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise><a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm"><i class="uil uil-user-circle align-middle h5 me-1"></i> Login</a></c:otherwise>
                    </c:choose>
                </li>
            </ul>
            <!-- Navigation Menu -->
            <div id="navigation">
                <ul class="navigation-menu nav-left">
                    <li class="has-submenu parent-menu-item"><a href="javascript:void(0)">Orders</a><span class="menu-arrow"></span><ul class="submenu"><li class="active"><a href="${pageContext.request.contextPath}/order-list" class="sub-menu-item">Order List</a></li></ul></li>
                    <li><a href="${pageContext.request.contextPath}/productlist" class="sub-menu-item">Products</a></li>
                </ul>
            </div>
        </div>
    </header>
    <!-- Navbar End -->

    <!-- Start Main Content -->
    <section class="bg-dashboard mt-4 pt-4">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar Start -->
                <div class="col-xl-3 col-lg-4 col-md-5 col-12 mb-4">
                    <div class="rounded shadow-sm overflow-hidden sticky-bar bg-white">
                        <div class="text-center avatar-profile position-relative p-4 border-bottom">
                            <c:if test="${sessionScope.user ne null}">
                                <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="Avatar">
                                <h5 class="mt-3 mb-1">${sessionScope.user.fullname}</h5>
                                <p class="text-muted mb-0">${sessionScope.role}</p>
                            </c:if>
                            <c:if test="${sessionScope.user eq null}"><p class="text-muted">Please log in</p></c:if>
                        </div>
                        <ul class="list-unstyled sidebar-nav mb-0 p-3">
                            <li class="navbar-item active mb-2"><a href="${pageContext.request.contextPath}/order-list" class="navbar-link d-flex align-items-center px-3 py-2 rounded"><i class="ri-list-ordered align-middle h5 mb-0 me-2"></i> Order List</a></li>
                            
                        </ul>
                    </div>
                </div>
                <!-- Sidebar End -->

                <!-- Main Content Area Start -->
                <div class="col-xl-9 col-lg-8 col-md-7 col-12">
                    <div class="rounded shadow-sm bg-white p-4">
                        <h5 class="mb-4">Order List Management</h5>

                        <!-- Form Filter và Search -->
                        <form action="${pageContext.request.contextPath}/order-list" method="GET" class="bg-light p-3 rounded border mb-4 filter-form" id="filterForm">
                            <div class="row g-2 align-items-start">
                                <div class="col-lg-3 col-md-6">
                                    <label for="searchKeywordInput" class="form-label fw-medium">Keyword:</label>
                                    <input type="text" class="form-control form-control-sm" id="searchKeywordInput" name="searchKeyword" placeholder="ID/Customer/Status" value="${searchKeyword}">
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <label for="barcodeInput" class="form-label fw-medium">Barcode:</label>
                                    <input type="text" class="form-control form-control-sm" id="barcodeInput" name="barcode" placeholder="Scan barcode..." value="${barcode}">
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <label for="dateMinInput" class="form-label fw-medium">From Date:</label>
                                    <input type="date" class="form-control form-control-sm" id="dateMinInput" name="dateMin" value="${currentDateMin}">
                                    <div class="invalid-feedback" id="dateMinError"></div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <label for="dateMaxInput" class="form-label fw-medium">To Date:</label>
                                    <input type="date" class="form-control form-control-sm" id="dateMaxInput" name="dateMax" value="${currentDateMax}">
                                    <div class="invalid-feedback" id="dateMaxError"></div>
                                </div>
                                <div class="col-lg-2 col-md-6">
                                    <label for="filterStatusSelect" class="form-label fw-medium">Status:</label>
                                    <select class="form-select form-select-sm" id="filterStatusSelect" name="filterStatus">
                                        <option value="" ${empty currentFilterStatus ? 'selected' : ''}>All</option>
                                        <option value="Pending" ${currentFilterStatus eq 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Processing" ${currentFilterStatus eq 'Processing' ? 'selected' : ''}>Processing</option>
                                        <option value="Completed" ${currentFilterStatus eq 'Completed' ? 'selected' : ''}>Completed</option>
                                        <option value="Cancelled" ${currentFilterStatus eq 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                </div>
                                <div class="col-lg-1 col-md-12 d-flex align-items-end">
                                    <input type="hidden" name="sortField" value="${currentSortField}">
                                    <input type="hidden" name="sortDir" value="${currentSortDir}">
                                    <button type="submit" class="btn btn-primary btn-sm w-100">Filter</button>
                                </div>
                            </div>
                        </form>

                        <!-- Table -->
                        <div class="table-responsive rounded">
                            <table class="table mb-0 table-center table-hover table-bordered" id="ordersTable">
                                <thead class="table-light">
                                    <tr>
                                        <th class="border-bottom p-3 sortable">
                                            <c:url var="sortByIdUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="order_id"/><c:param name="sortDir" value="${currentSortField eq 'order_id' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByIdUrl}">ID <i class="uil ${currentSortField eq 'order_id' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 sortable">
                                            <c:url var="sortByCustomerUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="customer_name"/><c:param name="sortDir" value="${currentSortField eq 'customer_name' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByCustomerUrl}">Customer <i class="uil ${currentSortField eq 'customer_name' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3">Phone</th>
                                        <th class="border-bottom p-3 sortable">
                                            <c:url var="sortByDateUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="date"/><c:param name="sortDir" value="${currentSortField eq 'date' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByDateUrl}">Date <i class="uil ${currentSortField eq 'date' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 sortable text-end">
                                            <c:url var="sortByAmountUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="amount"/><c:param name="sortDir" value="${currentSortField eq 'amount' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByAmountUrl}">Amount <i class="uil ${currentSortField eq 'amount' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 sortable">
                                            <c:url var="sortByPayMethodUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="payment_method"/><c:param name="sortDir" value="${currentSortField eq 'payment_method' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByPayMethodUrl}">Pay Method <i class="uil ${currentSortField eq 'payment_method' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 text-center sortable">
                                            <c:url var="sortByPayStatusUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="payment_status"/><c:param name="sortDir" value="${currentSortField eq 'payment_status' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByPayStatusUrl}">Pay Status <i class="uil ${currentSortField eq 'payment_status' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 text-center sortable">
                                            <c:url var="sortByStatusUrl" value="/order-list"><c:param name="searchKeyword" value="${searchKeyword}"/><c:param name="barcode" value="${barcode}"/><c:param name="dateMin" value="${currentDateMin}"/><c:param name="dateMax" value="${currentDateMax}"/><c:param name="filterStatus" value="${currentFilterStatus}"/><c:param name="page" value="1"/><c:param name="sortField" value="status"/><c:param name="sortDir" value="${currentSortField eq 'status' && currentSortDir eq 'asc' ? 'desc' : 'asc'}"/></c:url>
                                            <a href="${sortByStatusUrl}">Status <i class="uil ${currentSortField eq 'status' ? (currentSortDir eq 'asc' ? 'uil-arrow-up' : 'uil-arrow-down') : 'uil-sort'}"></i></a>
                                        </th>
                                        <th class="border-bottom p-3 text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${ordersList}">
                                        <tr>
                                            <td class="p-3"><b>#${order.orderId}</b></td>
                                            <td class="p-3">${order.customerName}</td>
                                            <td class="p-3">${empty order.phoneNumber ? 'N/A' : order.phoneNumber}</td>
                                            <td class="p-3"><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, HH:mm"/></td>
                                            <td class="p-3 text-end"><fmt:setLocale value="en_US"/><fmt:formatNumber value="${order.amount}" type="currency" currencySymbol="$"/></td>
                                            <td class="p-3">${order.paymentMethod}</td>
                                            <td class="p-3 text-center"><span class="badge rounded-pill bg-soft-${order.paymentStatus eq 'Paid' ? 'success' : (order.paymentStatus eq 'Unpaid' ? 'warning' : 'secondary')}">${order.paymentStatus}</span></td>
                                            <td class="p-3 text-center">
                                                <c:choose>
                                                    <c:when test="${order.status eq 'Completed' or order.status eq 'Cancelled'}">
                                                        <span class="badge rounded-pill bg-${order.status eq 'Completed' ? 'success' : 'danger'}">${order.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/updateOrderStatus" method="post" class="status-form">
                                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                                            <input type="hidden" name="currentPage" value="${currentPage}">
                                                            <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                                                            <input type="hidden" name="barcode" value="${barcode}">
                                                            <input type="hidden" name="dateMin" value="${currentDateMin}">
                                                            <input type="hidden" name="dateMax" value="${currentDateMax}">
                                                            <input type="hidden" name="filterStatus" value="${currentFilterStatus}">
                                                            <input type="hidden" name="sortField" value="${currentSortField}">
                                                            <input type="hidden" name="sortDir" value="${currentSortDir}">
                                                            <select name="newStatus" class="form-select form-select-sm" onchange="this.form.submit()">
                                                                <option value="Pending" ${order.status eq 'Pending' ? 'selected' : ''} ${order.status eq 'Processing' ? 'disabled' : ''}>Pending</option>
                                                                <option value="Processing" ${order.status eq 'Processing' ? 'selected' : ''}>Processing</option>
                                                                <option value="Completed" ${order.status eq 'Completed' ? 'selected' : ''}>Completed</option>
                                                                <option value="Cancelled" ${order.status eq 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                                            </select>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center p-3">
                                                <button type="button" class="btn btn-icon btn-sm btn-soft-primary view-details-btn" data-bs-toggle="modal" data-bs-target="#orderDetailModal" data-order-id="${order.orderId}" title="View Details"><i class="uil uil-eye"></i></button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty ordersList}">
                                        <tr><td colspan="9" class="text-center p-4 text-muted"><i>No orders found matching your criteria.</i></td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="row">
                                <div class="col-12 pagination-container">
                                    <nav aria-label="Page navigation">
                                        <form method="GET" action="${pageContext.request.contextPath}/order-list">
                                            <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                                            <input type="hidden" name="barcode" value="${barcode}">
                                            <input type="hidden" name="dateMin" value="${currentDateMin}">
                                            <input type="hidden" name="dateMax" value="${currentDateMax}">
                                            <input type="hidden" name="filterStatus" value="${currentFilterStatus}">
                                            <input type="hidden" name="sortField" value="${currentSortField}">
                                            <input type="hidden" name="sortDir" value="${currentSortDir}">
                                            <ul class="pagination justify-content-center mb-0">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <button class="page-link" type="submit" name="page" value="${currentPage - 1}">«</button>
                                                </li>
                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <button class="page-link" type="submit" name="page" value="${i}">${i}</button>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <button class="page-link" type="submit" name="page" value="${currentPage + 1}">»</button>
                                                </li>
                                            </ul>
                                        </form>
                                    </nav>
                                </div>
                            </div>
                        </c:if>

                    </div>
                </div>
                <!-- End Main Content Col -->
            </div>
            <!-- End Row -->
        </div>
        <!-- End Container Fluid -->
    </section>
    <!-- End Main Content -->

    <!-- Order Detail Modal -->
    <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title" id="orderDetailModalLabel">Order Details - Order ID: <span id="modalOrderId" class="fw-bold"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h6>Products in Order:</h6>
                    <div class="table-responsive">
                        <table class="table table-sm table-striped table-bordered mb-0">
                            <thead class="table-secondary">
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Total Price</th>
                                </tr>
                            </thead>
                            <tbody id="modalOrderDetailTableBody">
                                <tr><td colspan="5" class="text-center p-4">Loading details...</td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-end mt-3 border-top pt-2">
                        <strong>Total Order Amount:</strong> <span id="modalTotalAmount" class="fs-5 text-primary">$0.00</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Order Detail Modal End -->

    <!-- Footer Start -->
    <footer class="bg-footer border-top mt-5">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-4 pb-2">
                    <a href="#" class="logo-footer d-inline-block">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-icon-child.png" height="24" alt="" class="me-1"> <span class="h5 text-dark">Children Care</span>
                    </a>
                    <p class="mt-4 me-xl-5 text-secondary">Providing the best services for your children's health and happiness.</p>
                </div>
                <div class="col-xl-7 col-lg-8">
                    <div class="row">
                        <div class="col-md-4 col-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-dark footer-head">Company</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-secondary"><i class="uil uil-angle-right-b me-1"></i> About us</a></li>
                                <li><a href="#" class="text-secondary"><i class="uil uil-angle-right-b me-1"></i> Services</a></li>
                                <li><a href="#" class="text-secondary"><i class="uil uil-angle-right-b me-1"></i> Team</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4 col-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-dark footer-head">Useful Links</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-secondary"><i class="uil uil-angle-right-b me-1"></i> Terms of Services</a></li>
                                <li><a href="#" class="text-secondary"><i class="uil uil-angle-right-b me-1"></i> Privacy Policy</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-dark footer-head">Contact Us</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li class="d-flex align-items-center"><i data-feather="mail" class="fea icon-sm text-secondary align-middle me-2"></i><a href="mailto:contact@cc.com" class="text-secondary">contact@cc.com</a></li>
                                <li class="d-flex align-items-center mt-2"><i data-feather="phone" class="fea icon-sm text-secondary align-middle me-2"></i><a href="tel:+123456789" class="text-secondary">+123 456 789</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-4">
            <div class="py-4 footer-bar border-top">
                <div class="row align-items-center">
                    <div class="col-sm-6"><div class="text-sm-start text-center"><p class="mb-0 text-secondary">© <script>document.write(new Date().getFullYear())</script> Children Care. All Rights Reserved.</p></div></div>
                    <div class="col-sm-6 mt-4 mt-sm-0"></div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer End -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction(); return false;" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top shadow"><i data-feather="arrow-up" class="icons"></i></a>

    <!-- JS Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // SweetAlert for notifications
        var alertMessage = '<c:out value="${sessionScope.alertMessage}"/>';
        var alertType = '<c:out value="${sessionScope.alertType}"/>' || 'info';
        if (alertMessage) {
            Swal.fire({ icon: alertType, title: alertMessage, showConfirmButton: false, timer: 3000, timerProgressBar: true });
            <% session.removeAttribute("alertMessage"); session.removeAttribute("alertType"); %>
        }

        // Modal AJAX for order details
        const orderDetailModal = document.getElementById('orderDetailModal');
        if (orderDetailModal) {
            orderDetailModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const orderId = button.getAttribute('data-order-id');
                const modalTitle = orderDetailModal.querySelector('#modalOrderId');
                const modalTableBody = orderDetailModal.querySelector('#modalOrderDetailTableBody');
                const modalTotalAmountSpan = orderDetailModal.querySelector('#modalTotalAmount');
                modalTitle.textContent = orderId || 'N/A';
                modalTableBody.innerHTML = '<tr><td colspan="5" class="text-center p-4"><div class="spinner-border spinner-border-sm text-primary" role="status"><span class="visually-hidden">Loading...</span></div> Loading details...</td></tr>';
                modalTotalAmountSpan.textContent = 'Calculating...';
                if (!orderId) {
                    modalTableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger p-4">Error: Order ID not found.</td></tr>';
                    modalTotalAmountSpan.textContent = 'Error';
                    return;
                }
                const detailUrl = '${pageContext.request.contextPath}/getOrderDetailHtml?orderId=' + orderId;
                fetch(detailUrl)
                    .then(response => {
                        if (!response.ok) {
                            return response.text().then(text => { throw new Error('Resp not ok: ' + response.status + ". " + (text || 'Server error')) });
                        }
                        return response.text();
                    })
                    .then(htmlFragment => {
                        modalTableBody.innerHTML = htmlFragment;
                        let calculatedTotal = 0;
                        const rows = modalTableBody.querySelectorAll('tr[data-quantity][data-price]');
                        rows.forEach(row => {
                            const q = parseFloat(row.getAttribute('data-quantity'));
                            const p = parseFloat(row.getAttribute('data-price'));
                            if (!isNaN(q) && !isNaN(p)) {
                                calculatedTotal += q * p;
                            }
                        });
                        const formatter = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' });
                        modalTotalAmountSpan.textContent = formatter.format(calculatedTotal);
                    })
                    .catch(error => {
                        console.error('Error fetch details:', error);
                        let displayError = `Error loading details. ${error.message || ''}`;
                        modalTableBody.innerHTML = `<tr><td colspan="5" class="text-center text-danger p-4">${displayError}</td></tr>`;
                        modalTotalAmountSpan.textContent = 'Error';
                    });
            });
        }

        // Date Validation
        document.addEventListener('DOMContentLoaded', function() {
            const dateMinInput = document.getElementById('dateMinInput');
            const dateMaxInput = document.getElementById('dateMaxInput');
            const filterForm = document.getElementById('filterForm');
            const dateMinError = document.getElementById('dateMinError');
            const dateMaxError = document.getElementById('dateMaxError');

            const today = new Date();
            today.setHours(0,0,0,0);
            const todayString = today.toISOString().split('T')[0];

            dateMinInput.max = todayString;

            function validateDates() {
                let isValid = true;
                dateMinError.textContent = '';
                dateMaxError.textContent = '';
                dateMinInput.classList.remove('is-invalid');
                dateMaxInput.classList.remove('is-invalid');

                const dateMinStr = dateMinInput.value;
                const dateMaxStr = dateMaxInput.value;
                let dateMin = null;
                let dateMax = null;

                if (dateMinStr) dateMin = new Date(dateMinStr);
                if (dateMaxStr) dateMax = new Date(dateMaxStr);

                if (dateMin) dateMin.setMinutes(dateMin.getMinutes() + dateMin.getTimezoneOffset());
                if (dateMax) dateMax.setMinutes(dateMax.getMinutes() + dateMax.getTimezoneOffset());

                if (dateMin && dateMin >   dateMin > today) {
                    dateMinError.textContent = 'From Date cannot be in the future.';
                    dateMinInput.classList.add('is-invalid');
                    isValid = false;
                }

                if (dateMin && dateMax && dateMax < dateMin) {
                    dateMaxError.textContent = 'To Date cannot be earlier than From Date.';
                    dateMaxInput.classList.add('is-invalid');
                    isValid = false;
                }

                return isValid;
            }

            if (filterForm) {
                filterForm.addEventListener('submit', function(event) {
                    if (!validateDates()) {
                        event.preventDefault();
                        console.log("Date validation failed. Form submission prevented.");
                        if (dateMinInput.classList.contains('is-invalid')) {
                            dateMinInput.focus();
                        } else if (dateMaxInput.classList.contains('is-invalid')) {
                            dateMaxInput.focus();
                        }
                    }
                });
            }

            dateMinInput.addEventListener('change', validateDates);
            dateMaxInput.addEventListener('change', validateDates);
            validateDates();
        });

        // Back to top function
        function topFunction() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
    </script>
</body>
</html>