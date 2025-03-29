<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>

    <body>
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="c/home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <section class="bg-half-150 d-table w-100 bg-light" style="background: url('./assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign Up</h4>  
                                <form action="login?service=register" class="login-form mt-4" method="POST" id="registrationForm">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">                                                
                                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Full Name" value="${fullname}" name="fullname" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                                <input type="date" class="form-control" value="${dob}" name="dob" id="dob" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" value="${email}" name="email" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Password" value="${password}" name="password" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mobile <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Mobile Number" value="${mobile}" name="mobile" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Address <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Address" value="${address}" name="address" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Register</button>
                                            </div>
                                        </div>

                                        <c:if test="${not empty error}">
                                            <div class="mt-3 text-danger alert alert-error" style="margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-right-width: 0px;">
                                                <c:forEach items="${error}" var="e">
                                                    <p>${e}</p>
                                                </c:forEach>
                                            </div>
                                        </c:if>

                                        <div class="mx-auto">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account?</small> <a href="login?service=login" class="text-dark fw-bold">Sign in</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/js/feather.min.js"></script>
        <script src="./assets/js/app.js"></script>

        <script>
            // Lấy ngày hiện tại và thiết lập giá trị max cho input ngày sinh
            const currentDate = new Date().toISOString().split('T')[0]; // Lấy ngày hiện tại dưới định dạng YYYY-MM-DD
            const dobInput = document.getElementById('dob');

            // Thiết lập giá trị max cho trường ngày sinh
            dobInput.setAttribute('max', currentDate);

            // Xử lý sự kiện submit để kiểm tra nếu người dùng chọn ngày tương lai
            const form = document.getElementById('registrationForm');
            form.addEventListener('submit', function (event) {
                const dobValue = dobInput.value;
                if (dobValue > currentDate) {
                    // Ngừng việc submit form nếu ngày sinh lớn hơn ngày hiện tại
                    event.preventDefault();
                    alert('Ngày sinh không thể là ngày trong tương lai!');
                }
            });
        </script>
    </body>

</html>
