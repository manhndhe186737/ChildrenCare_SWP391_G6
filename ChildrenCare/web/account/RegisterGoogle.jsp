<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            #alertMessage, #errorMessage {
                position: relative;
                z-index: 1050; /* Ensure alert is on top of other content */
            }

        </style>

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
            <a href="index.html" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <section class="bg-half-150 d-table w-100 bg-light" style="background: url('./assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">

                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign Up</h4>  
                                <form action="registergoogle" class="login-form mt-4" method="POST">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">                                                
                                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Full Name" value="${name}" name="fullname" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">                                                
                                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                <input type="hidden" class="form-control" placeholder="Full Name" value="${picture}" name="fullname" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                                <input type="date" class="form-control" name="dob" id="dob" required>
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
                                                <input type="password" class="form-control" placeholder="Password" name="password" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mobile <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Mobile Number" name="mobile" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Address <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Address" name="address" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Register</button>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-12">
                                                <c:if test="${not empty alertMessage}">
                                                    <div class="alert alert-${alertType} alert-dismissible fade show ms-2" role="alert" id="alertMessage">
                                                        <i class="fas fa-info-circle"></i> ${alertMessage}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                                </c:if>

                                                <c:if test="${not empty errors}">
                                                    <div class="alert alert-danger alert-dismissible fade show ms-2" role="alert" id="errorMessage">
                                                        <i class="fas fa-exclamation-circle"></i> 
                                                        <ul>
                                                            <c:forEach items="${errors}" var="error">
                                                                <li>${error}</li>
                                                                </c:forEach>
                                                        </ul>
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="mx-auto">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account?</small> <a href="account?service=login" class="text-dark fw-bold">Sign in</a></p>
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
            document.getElementById("dob").addEventListener("input", function (event) {
                var today = new Date().toISOString().split('T')[0];  // Get today's date in YYYY-MM-DD format
                var dob = event.target.value;  // Get the selected date value

                if (dob > today) {
                    alert("Date of Birth cannot be in the future.");
                    event.target.setCustomValidity("Date of Birth cannot be in the future.");
                } else {
                    event.target.setCustomValidity("");  // Reset the custom validity if date is valid
                }
            });
        </script>
    </body>

</html>
