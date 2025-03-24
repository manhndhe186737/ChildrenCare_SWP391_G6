<%-- 
    Document   : staff-reserv
    Created on : Mar 12, 2025, 8:49:37 AM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<!DOCTYPE html>

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
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            #pagination {
                display: flex;
                justify-content: center; /* Căn giữa các nút phân trang */
                align-items: center;     /* Căn giữa theo chiều dọc */
                margin-top: 20px;         /* Khoảng cách từ phần tử trên */
            }

            #pagination button {
                background-color: #4CAF50; /* Màu nền nút */
                border: none;
                color: white;
                padding: 5px 10px;  /* Giảm padding để nút nhỏ lại */
                margin: 0 5px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;  /* Giảm kích thước font */
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s;
            }


            #pagination button:hover {
                background-color: #45a049; /* Màu nền khi hover */
            }

            #pagination span {
                font-size: 12px; /* Giảm kích thước font của số trang */
                margin: 0 10px;
                color: #333;
                font-weight: bold;
            }
            .table-responsive {
                min-height: 400px; /* Đặt chiều cao tối thiểu */
                max-height: 600px; /* Hoặc đặt chiều cao cố định */
                overflow-y: auto; /* Nếu danh sách dài, cho phép cuộn */
            }

            .table tbody tr {
                height: 50px; /* Điều chỉnh chiều cao cố định cho mỗi dòng */
            }
            .modal-content {
                min-height: 500px;
            }
            .pagination-container {
                min-height: 60px; /* Đảm bảo chiều cao không thay đổi */
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

        <!-- Navbar STart -->
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
                <!-- End Logo container-->

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
                                <li class="has-submenu parent-menu-item">
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
                                    <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
                                    </c:if>
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
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

        <!-- Start Hero -->
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">

                            <div class="text-center avatar-profile position-relative pb-4 border-bottom mt-3">
<!--                                <img src="<c:out value="${pageContext.request.contextPath}/assets/images/${sessionScope.user.avatar}" />"
                                     class="rounded-circle shadow-md avatar avatar-md-md" 
                                     alt="">-->

                                <c:choose>
                                    <c:when test="${sessionScope.user.avatar.contains('upload')}">
                                        <img id="" src="${pageContext.request.contextPath}/${sessionScope.user.avatar}"
                                             class="rounded-circle shadow-md avatar avatar-md-md" alt="Avatar">
                                    </c:when>

                                    <c:otherwise>
                                        <img id="" src="${pageContext.request.contextPath}/assets/images/${sessionScope.user.avatar}"
                                             class="rounded-circle shadow-md avatar avatar-md-md" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                                <h5 class="mt-3 mb-1">${sessionScope.user.fullname}</h5>

                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item active"><a href="../c/staff-reserv" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Reservation</a></li>
                                <li class="navbar-item"><a href="../c/staff-feedback" class="navbar-link"><i class="ri-device-recover-line align-middle navbar-icon"></i> Feedback</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-9 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="col-md-3">
                            <h5 class="mb-0">Reservation</h5>
                        </div>
                        <div class="row align-items-center">
                            <!-- Bên trái: Today + Appointment -->
                            <form action="staff-reserv" method="POST" class="w-100">
                                <div class="row w-100">
                                    <!-- Date Pickers -->
                                    <!-- Date Pickers -->
                                    <div class="col-md-3 d-flex gap-2">
                                        <input type="date" class="form-control" name="startDate" value="${startDate != null ? startDate : ''}">
                                        <input type="date" class="form-control" name="endDate" value="${endDate != null ? endDate : ''}">
                                    </div>

                                    <!-- Tạo khoảng cách giữa date picker và search box -->
                                    <div class="col-md-1"></div> <!-- Cột trống tạo khoảng cách -->
                                    <!-- Search Box -->
                                    <div class="col-md-5 d-flex justify-content-center">
                                        <input type="text" class="form-control" name="searchKeyword" placeholder="" value="${param.searchKeyword}">
                                    </div>
                                    <!-- Filter and Search Button -->
                                    <div class="col-md-3 d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary w-100">Filter</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Table Section -->
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center" id="appointmentTable">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(0)">ReservID <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(1)">Name <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(2)">Date Book <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(3)">Start Time <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(4)">End Time <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 sortable" onclick="sortTable(5)">Status <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="appointment" items="${appointments}">
                                                <tr>
                                                    <td class="border-bottom p-3">${appointment.reservId}</td>
                                                    <td class="border-bottom p-3">${appointment.customerName}</td>
                                                    <td class="border-bottom p-3">${appointment.dateBook}</td>
                                                    <td class="border-bottom p-3">${appointment.startTime}</td>
                                                    <td class="border-bottom p-3">${appointment.endTime}</td>
                                                    <td class="text-center p-3">
                                                        <span class="badge
                                                              ${appointment.status == 'Completed' ? 'badge-success' : 
                                                                appointment.status == 'Scheduled' ? 'badge-warning' : 'badge-danger'}">
                                                                  ${appointment.status}
                                                              </span>
                                                        </td>
                                                        <td class="text-end p-3">
                                                            <c:if test="${appointment.status == 'Scheduled'}">
                                                                <div class="d-inline-block">
                                                                    <form id="confirmForm" method="POST" action="AcceptReserv">
                                                                        <input type="hidden" name="reservId" value="${appointment.reservId}">
                                                                        <button type="button" class="btn btn-icon btn-soft-success accept-btn" id="confirmBtn">
                                                                            <i class="uil uil-check-circle"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:if>
                                                            <div class="d-inline-block">
                                                                <a href="#" class="btn btn-icon btn-soft-primary" data-bs-toggle="modal" data-bs-target="#viewappointment${appointment.reservId}">
                                                                    <i class="uil uil-eye"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty appointments}">
                                                    <tr>
                                                        <td colspan="8" class="text-center">No appointments available for this staff.</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                                    
                        <!-- Pagination -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <nav aria-label="Page navigation">
                                    <form method="POST" action="staff-reserv">
                                        <ul class="pagination justify-content-center">
                                            <!-- Prev Button -->
                                            <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                <button class="page-link" type="submit" name="page" value="${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </button>
                                            </li>

                                            <!-- Page Number Buttons -->
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item <c:if test="${i == currentPage}">active</c:if>">
                                                    <button class="page-link" type="submit" name="page" value="${i}">${i}</button>
                                                </li>
                                            </c:forEach>

                                            <!-- Next Button -->
                                            <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                <button class="page-link" type="submit" name="page" value="${currentPage + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </button>
                                            </li>
                                        </ul>
                                    </form>
                                </nav>
                            </div>
                        </div>


                    </div><!--end row-->
                </div><!--end container-->
            </section><!--end section-->
            <!-- End Hero ---->


            <!-- View Appintment Start -->
            <c:forEach var="appointment" items="${appointments}">
                <div class="modal fade" id="viewappointment${appointment.reservId}" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content shadow-lg rounded-4">
                            <!-- Tiêu đề Modal -->
                            <div class="modal-header bg-primary text-white border-0 rounded-top">
                                <h5 class="modal-title fw-bold">Appointment Details</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <!-- Nội dung chính -->
                            <div class="modal-body p-4">
                                <!-- Avatar + Tên khách hàng -->
                                <div class="d-flex align-items-center mb-4">
                                    <img src="${pageContext.request.contextPath}/${appointment.customer.avatar}" 
                                         class="rounded-circle border border-3 border-primary" 
                                         alt="Avatar" 
                                         style="width: 90px; height: 90px; object-fit: cover;">
                                    <h5 class="mb-0 ms-3 fw-bold text-dark">${appointment.customer.fullname}</h5>
                                </div>

                                <!-- Row chứa 2 cột Customer + Appointment -->
                                <div class="row g-3">
                                    <div class="col-md-6 d-flex flex-column">
                                        <div class="p-3 border rounded-3 shadow-sm bg-light h-100">
                                            <h6 class="text-primary fw-bold mb-3"><i class="uil uil-user me-2"></i>Customer Info</h6>
                                            <p class="mb-2"><strong class="text-secondary">DOB:</strong> ${appointment.customer.dob}</p>
                                            <p class="mb-2"><strong class="text-secondary">Address:</strong> ${appointment.customer.address}</p>
                                            <p class="mb-0"><strong class="text-secondary">Phone:</strong> ${appointment.customer.phone}</p>
                                        </div>
                                    </div>

                                    <div class="col-md-6 d-flex flex-column">
                                        <div class="p-3 border rounded-3 shadow-sm bg-light h-100">
                                            <h6 class="text-primary fw-bold mb-3"><i class="uil uil-calendar-alt me-2"></i>Appointment Info</h6>
                                            <p class="mb-2"><strong class="text-secondary">Date:</strong> ${appointment.dateBook}</p>
                                            <p class="mb-2"><strong class="text-secondary">Time:</strong> ${appointment.startTime} - ${appointment.endTime}</p>
                                            <p class="mb-2"><strong class="text-secondary">Payment:</strong> ${appointment.paymentStatus} </p>
                                            <p class="mb-0"><strong class="text-secondary">Amount:</strong> ${appointment.amount} </p>
                                        </div>
                                    </div>

                                </div>

                                <!-- Service Details chiếm toàn bộ chiều rộng -->
                                <div class="mt-3">
                                    <div class="p-3 border rounded-3 shadow-sm bg-light">
                                        <h6 class="text-primary fw-bold mb-3"><i class="uil uil-briefcase-alt me-2"></i>Service Details</h6>
                                        <p class="mb-2"><strong class="text-secondary">Service Name:</strong> ${appointment.service.name}</p>
                                        <!-- Ảnh dịch vụ lớn hơn -->
                                        <img src="${pageContext.request.contextPath}/${appointment.service.img}" 
                                             class="rounded-3 border shadow-sm w-100" 
                                             alt="Service Image" 
                                             style="height: 200px; object-fit: cover;">
                                    </div>

                                </div>
                            </div>

                            <!-- Footer Modal -->
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Accept Appointment Start -->
            <div class="modal fade" id="acceptappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body py-5">
                            <div class="text-center">
                                <div class="icon d-flex align-items-center justify-content-center bg-soft-success rounded-circle mx-auto" 
                                     style="height: 95px; width:95px;">
                                    <span class="mb-0"><i class="uil uil-check-circle h1"></i></span>
                                </div>
                                <div class="mt-4">
                                    <h4>Accept Appointment</h4>
                                    <p class="para-desc mx-auto text-muted mb-0">Are you sure you want to accept this appointment?</p>
                                    <div class="mt-4">
                                        <form action="UpdateAppointmentServlet" method="Post">
                                            <input type="hidden" name="rsvid"/>
                                            <button type="submit" class="btn btn-soft-success confirm-accept">Accept</button>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Accept Appointment End -->

            <!-- Cancel Appointment Start -->
            <div class="modal fade" id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body py-5">
                            <div class="text-center">
                                <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                    <span class="mb-0"><i class="uil uil-times-circle h1"></i></span>
                                </div>
                                <div class="mt-4">
                                    <h4>Cancel Appointment</h4>
                                    <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                    <div class="mt-4">
                                        <a href="#" class="btn btn-soft-danger">Cancel</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Cancel Appointment End -->
            <!-- Modal end -->

            <!-- Footer Start -->
            <footer class="bg-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                            <a class="logo-footer">
                            </a>
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

            <!-- Offcanvas Start -->
            <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
                <div class="offcanvas-body d-flex align-items-center align-items-center">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="text-center">
                                    <h4>Search now.....</h4>
                                    <div class="subcribe-form mt-4">
                                        <form>
                                            <div class="mb-0">
                                                <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                                <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </div>
            </div>
            <!-- Offcanvas End -->

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
                                        <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="../assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="../assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="../assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                        <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="../assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                        <li class="d-grid"><a href="../admin/index.html" target="_blank" class="mt-4"><img src="../assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
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
            <script src="../assets/js/jquery.min.js"></script>
            <script src="../assets/js/bootstrap.bundle.min.js"></script>
            <!-- Select2 -->
            <script src="../assets/js/select2.min.js"></script>
            <script src="../assets/js/select2.init.js"></script>
            <!-- Datepicker -->
            <script src="../assets/js/flatpickr.min.js"></script>
            <script src="../assets/js/flatpickr.init.js"></script>
            <!-- Datepicker -->
            <script src="../assets/js/jquery.timepicker.min.js"></script> 
            <script src="../assets/js/timepicker.init.js"></script> 
            <!-- Icons -->
            <script src="../assets/js/feather.min.js"></script>
            <!-- Main Js -->
            <script src="../assets/js/app.js"></script>
            <!-- Thêm SweetAlert2 CDN -->
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
            </script>

            <script>
                document.getElementById('confirmBtn').addEventListener('click', function () {
                    // Hiển thị SweetAlert xác nhận
                    Swal.fire({
                        title: 'Confirm complete this reservation?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Nếu người dùng chọn "Yes", submit form
                            document.getElementById('confirmForm').submit();
                        }
                    });
                });
            </script>
            <script>
                let sortOrder = {}; // Lưu trạng thái sắp xếp của từng cột

                function sortTable(colIndex) {
                    let table = document.getElementById("appointmentTable");
                    let tbody = table.getElementsByTagName("tbody")[0];
                    let rows = Array.from(tbody.getElementsByTagName("tr"));

                    // Kiểm tra trạng thái hiện tại
                    sortOrder[colIndex] = !sortOrder[colIndex];

                    rows.sort((a, b) => {
                        let aText = a.getElementsByTagName("td")[colIndex].textContent.trim();
                        let bText = b.getElementsByTagName("td")[colIndex].textContent.trim();

                        // Xử lý kiểu dữ liệu (số, ngày, chuỗi)
                        if (!isNaN(aText) && !isNaN(bText)) { // Nếu là số
                            return sortOrder[colIndex] ? aText - bText : bText - aText;
                        } else if (Date.parse(aText) && Date.parse(bText)) { // Nếu là ngày
                            return sortOrder[colIndex] ? new Date(aText) - new Date(bText) : new Date(bText) - new Date(aText);
                        } else { // Nếu là chuỗi
                            return sortOrder[colIndex] ? aText.localeCompare(bText) : bText.localeCompare(aText);
                        }
                    });

                    // Cập nhật lại bảng
                    tbody.innerHTML = "";
                    rows.forEach(row => tbody.appendChild(row));

                    // Cập nhật icon mũi tên
                    updateSortIcons(colIndex);
                }

                function updateSortIcons(colIndex) {
                    let headers = document.querySelectorAll(".sortable i");
                    headers.forEach((icon, index) => {
                        if (index === colIndex) {
                            icon.className = sortOrder[colIndex] ? "uil uil-arrow-up" : "uil uil-arrow-down";
                        } else {
                            icon.className = "uil uil-sort";
                        }
                    });
                }

                /////
                document.addEventListener("DOMContentLoaded", function () {
                    let selectedId = null;

                    // Khi click vào nút Accept, lưu ID của appointment
                    document.querySelectorAll(".accept-btn").forEach(button => {
                        button.addEventListener("click", function () {
                            selectedId = this.getAttribute("data-id");
                            document.querySelector(".confirm-accept").setAttribute("data-id", selectedId);
                        });
                    });

                    // Khi xác nhận Accept
                    document.querySelector(".confirm-accept").addEventListener("click", function () {
                        let appointmentId = this.getAttribute("data-id");

                        if (appointmentId) {
                            fetch("/updateAppointment", {
                                method: "POST",
                                headers: {"Content-Type": "application/json"},
                                body: JSON.stringify({
                                    reservId: appointmentId,
                                    status: "Accepted",
                                    payment: "Completed"
                                })
                            })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            // Cập nhật trực tiếp trên giao diện
                                            let row = document.querySelector(`tr[data-id="${appointmentId}"]`);
                                            row.querySelector(".status-cell").textContent = "Accepted";
                                            row.querySelector(".payment-cell").textContent = "Completed";

                                            // Ẩn modal
                                            let modal = new bootstrap.Modal(document.getElementById("acceptappointment"));
                                            modal.hide();
                                        } else {
                                            alert("Failed to update appointment.");
                                        }
                                    })
                                    .catch(error => console.error("Error:", error));
                        }
                    });
                });

                document.addEventListener("DOMContentLoaded", function () {
                    // Lấy tất cả nút Accept
                    let acceptButtons = document.querySelectorAll(".accept-btn");

                    acceptButtons.forEach(button => {
                        button.addEventListener("click", function () {
                            let reservId = this.getAttribute("data-id"); // Lấy reservId từ data-id

                            // Gán giá trị này vào input ẩn trong form
                            document.querySelector("input[name='rsvid']").value = reservId;
                        });
                    });
                });
            </script>
        </body>

    </html>
