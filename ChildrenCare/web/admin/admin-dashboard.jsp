<%-- 
    Document   : admin-dashboard
    Created on : Feb 8, 2025, 5:06:38 PM
    Author     : FPTSHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link href="../assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- ApexCharts -->
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <style>
            .row.mt-4 {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .card.features {
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                min-height: 120px;
                display: flex;
                align-items: center;
            }

            .card.features:hover {
                transform: translateY(-5px);
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            }

            .row.mt-4 .col-xl-2 {
                display: flex;
                flex-grow: 1;
                justify-content: center;
                min-width: 200px;
            }

           
            .layout-specing {
                padding: 20px;
            }

            .btn-primary {
                transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            .btn-primary:hover {
                transform: scale(1.05);
            }

            #reservationTrendChart {
                min-height: 350px;
            }
            /* 🌟 Căn chỉnh form Filter */
.form-inline {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    gap: 15px;
    padding: 15px 0;
    background: #f8f9fa;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.form-inline .form-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.form-inline label {
    font-weight: 500;
    color: #495057;
}

.form-inline input {
    width: 160px;
    padding: 6px 10px;
    border-radius: 5px;
    border: 1px solid #ced4da;
}

.form-inline .btn-primary {
    padding: 8px 15px;
    font-weight: 600;
    transition: all 0.3s ease-in-out;
}

.form-inline .btn-primary:hover {
    background-color: #007bff;
    color: #fff;
    transform: scale(1.05);
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
                        <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Appointment</a></li>

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
                        <h5 class="mb-0">Dashboard</h5>

                        <!-- Form chọn ngày -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <form action="<%=request.getContextPath()%>/admin/dashboard" method="get" class="form-inline">
                                    <div class="form-group mx-2">
                                        <label for="startDate">Start Date:</label>
                                        <input type="date" id="startDate" name="startDate" value="${startDate}" class="form-control">
                                    </div>
                                    <div class="form-group mx-2">
                                        <label for="endDate">End Date:</label>
                                        <input type="date" id="endDate" name="endDate" value="${endDate}" class="form-control">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </form>
                            </div>
                        </div>

                        <!-- Thẻ thông tin nhanh -->
                        <div class="row mt-4">
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-check-circle h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${successReservations}</h5>
                                            <p class="text-muted mb-0">Success Reservations</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-times-circle h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${cancelledReservations}</h5>
                                            <p class="text-muted mb-0">Cancelled Reservations</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-upload h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${submittedReservations}</h5>
                                            <p class="text-muted mb-0">Scheduled Reservations</p>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-calendar-alt h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${newlyReservedCustomers}</h5>
                                            <p class="text-muted mb-0">Total Reservations</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-usd-circle h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">$${totalRevenue}</h5>
                                            <p class="text-muted mb-0">Total Revenue</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Bảng doanh thu và phản hồi -->
                        <div class="row mt-4">
                            <div class="col-xl-6 col-lg-6">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <h6 class="mb-0">Revenue by Service Categories</h6>
                                    </div>
                                    <div class="p-4">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Service</th>
                                                    <th>Revenue ($)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="entry" items="${revenueByService}">
                                                    <tr>
                                                        <td>${entry.key}</td>
                                                        <td>${entry.value}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <h6 class="mb-0">Feedbacks (Average Star: ${avgStarTotal})</h6>
                                    </div>
                                    <div class="p-4">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Service</th>
                                                    <th>Avg Star</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="entry" items="${avgStarByService}">
                                                    <tr>
                                                        <td>${entry.key}</td>
                                                        <td>${entry.value}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Biểu đồ xu hướng đặt lịch -->
                        <div class="row mt-4">
                            <div class="col-xl-12">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <h6 class="mb-0">Reservation Counts Trend</h6>
                                    </div>
                                    <div class="p-4">
                                        <div id="reservationTrendChart" class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row-->

                    </div><!--end layout-specing-->
                </div><!--end container-->

                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <!-- Footer content -->
                                </div>
                            </div>
                        </div>
                    </div>
                </footer><!--end footer-->
            </main>
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
        <!-- Offcanvas End -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <!-- ApexCharts Script -->
        <script>
                                        var trendData = [
            <c:forEach var="trend" items="${reservationTrend}">
                                            {date: '${trend.date}', completed: ${trend.completed}, total: ${trend.total}},
            </c:forEach>
                                        ];

                                        var options = {
                                            chart: {type: 'line', height: 350},
                                            series: [
                                                {
                                                    name: 'Completed',
                                                    data: trendData.map(item => item.completed)
                                                },
                                                {
                                                    name: 'Total',
                                                    data: trendData.map(item => item.total)
                                                }
                                            ],
                                            xaxis: {
                                                categories: trendData.map(item => item.date)
                                            },
                                            stroke: {curve: 'smooth'},
                                            colors: ['#34c38f', '#556ee6'],
                                            dataLabels: {enabled: false},
                                            title: {text: 'Reservation Trend', align: 'left'}
                                        };
                                        var chart = new ApexCharts(document.querySelector("#reservationTrendChart"), options);
                                        chart.render();
        </script>

    </body>
</html>