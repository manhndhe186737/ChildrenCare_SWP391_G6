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
        <!-- favicon -->
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

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

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="c/home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('./assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Recover Account</h4>  
                                <form action="login?service=resetPasswordSubmit" method="POST" class="login-form mt-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p class="text-muted">Please input your new password</p>
                                            <input type="hidden" name="token" value="${token}" />
                                            <div class="mb-3">
                                                <label class="form-label">New Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Enter Your New Password" name="newPassword" required="">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Confirm New Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Enter Your New Password Again" name="confirmPassword" required="">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-primary">Send</button>
                                            </div>
                                        </div>
                                        <div class="mx-auto">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Remember your password ?</small> <a href="login?service=login" class="text-dark h6 mb-0">Sign in</a></p>
                                        </div>
                                    </div>
                                    <!-- Hiển thị thông báo lỗi -->
                                    <% if (request.getAttribute("error") != null) { %>
                                    <div class="alert alert-danger mt-3">
                                        <i class="fas fa-exclamation-circle"></i> 
                                        <%= request.getAttribute("error") %>
                                    </div>
                                    <% } %>

                                    <!-- Hiển thị thông báo thành công -->
                                    <% if (request.getAttribute("message") != null) { %>
                                    <div class="alert alert-success mt-3">
                                        <i class="fas fa-check-circle"></i> 
                                        <%= request.getAttribute("message") %>
                                    </div>
                                    <% } %>
                                </form>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <!-- javascript -->
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="./assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="./assets/js/app.js"></script>

        <!-- Thêm jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $("form").submit(function (event) {
                    var password = $("input[name='newPassword']").val();
                    var confirmPassword = $("input[name='confirmPassword']").val();
                    var passwordError = false;

                    // Kiểm tra password không được bỏ trống
                    if (password === "") {
                        alert("Password cannot be empty.");
                        passwordError = true;
                    }

                    // Kiểm tra password và confirm password khớp nhau
                    if (password !== confirmPassword) {
                        alert("Passwords do not match.");
                        passwordError = true;
                    }

                    // Kiểm tra định dạng của password (gọi hàm checkPassword)
                    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?=\S+$).{8,64}$/;
                    if (!regex.test(password)) {
                        alert("Password must contain at least one lowercase letter, one uppercase letter, one digit, one special character, and be between 8 and 64 characters long.");
                        passwordError = true;
                    }

                    // Nếu có lỗi, ngừng submit form
                    if (passwordError) {
                        event.preventDefault();  // Ngừng việc submit form
                    }
                });
            });
        </script>


    </body>

</html>


