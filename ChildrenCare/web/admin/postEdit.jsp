<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Post, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Children Care - Service Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="./././index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="./assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="./assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="./assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="./assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            /* General Styles */
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8f9fa;
            }
            .search-bar .menu-search form {
                position: relative;
                padding: 0px;
            }
            /* Table Styling */
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            table th, table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            table th {
                background: #556ee6;
                color: #fff;
                font-weight: 600;
            }

            table tr:hover {
                background-color: #eef2ff;
            }

            table img {
                border-radius: 5px;
            }

            /* Form Styling */
            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                background: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: auto;
            }

            form label {
                font-weight: bold;
            }

            form input,
            form select,
            form textarea {
                padding: 10px;
                border: 1px solid #556ee6;
                border-radius: 5px;
                font-size: 14px;
                width: 100%;
            }

            form button {
                background: #556ee6;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
            }

            form button:hover {
                background: #4455c9;
            }

            /* Back Button */
            .back-btn {
                display: block;
                width: max-content;
                margin: 20px auto;
                padding: 10px 15px;
                background: #6c757d;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 14px;
                text-align: center;
                transition: background 0.3s;
            }

            .back-btn:hover {
                background: white;
            }

            /* Post Edit Styling */
            .post-edit-container {
                max-width: 750px;
                margin: auto;
                background: #f8fff4;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
                border: 2px solid #28a745;
            }

            .post-edit-container h2 {
                text-align: center;
                color: #28a745;
                margin-bottom: 20px;
                font-size: 24px;
            }

            .post-edit-container form {
                width: 100%;
            }

            .post-edit-container form textarea {
                min-height: 180px;
                resize: vertical;
            }

            .post-edit-container .form-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 25px;
            }

            .post-edit-container .form-actions button {
                flex: 1;
                margin: 0 8px;
                padding: 12px;
                border-radius: 8px;
                font-size: 16px;
            }

            .post-edit-container .form-actions .cancel-btn {
                background: none;
                border: 2px solid #dc3545;
                color: #dc3545;
                font-weight: bold;
            }

            .post-edit-container .form-actions .cancel-btn:hover {
                background: #dc3545;
                color: white;
            }
            /* Container bọc cả ảnh hiện tại và preview */
            .image-container {
                display: flex;
                gap: 20px;
                align-items: center;
            }

            /* Khung chứa ảnh hiện tại */
            .current-image-container {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 10px;
                background-color: #f4f4f4;
                border-radius: 10px;
                border: 2px dashed #bbb;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                width: 180px;
                height: 180px;
            }

            /* Ẩn khung preview khi chưa có ảnh */
            .preview-container {
                display: none;
                justify-content: center;
                align-items: center;
                padding: 10px;
                background-color: #f4f4f4;
                border-radius: 10px;
                border: 2px dashed #28a745;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                width: 180px;
                height: 180px;
                transition: all 0.3s ease-in-out;
            }

            /* Ảnh trong cả current và preview */
            .current-image-container img,
            .preview-container img {
                max-width: 100%;
                max-height: 160px;
                border-radius: 8px;
                transition: transform 0.3s ease-in-out;
            }

            /* Hiệu ứng hover làm ảnh to nhẹ lên */
            .preview-container img:hover,
            .current-image-container img:hover {
                transform: scale(1.05);
            }

            /* Nút upload ảnh */
            .btn-upload {
                display: inline-block;
                padding: 12px 18px;
                background-color: #ff7f50; /* Màu cam nhạt */
                color: white;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease-in-out;
                text-align: center;
                font-size: 14px;
            }

            /* Hover vào nút upload sẽ đậm hơn */
            .btn-upload:hover {
                background-color: #e66a38;
            }

            /* Ẩn input file mặc định */
            input[type="file"] {
                display: none;
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

        <div class="page-wrapper doctris-theme">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                </div>
                <!-- sidebar-content  -->
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
                        <header id="topnav" class="defaultscroll sticky">
                            <div class="container">
                                <!-- Logo container-->
                                <div>
                                    <a class="logo" href="./c/home">
                                        <span class="logo-light-mode">
                                            <img src="./assets/images/logo-icon-child.png" class="l-dark" height="24" alt="">
                                            <img src="./assets/images/logo-icon-child.png" class="l-light" height="24" alt="">
                                        </span>
                                        <img src="./assets/images/logo-icon-child.png" height="24" class="logo-dark-mode" alt="">
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
                                    <li class="list-inline-item mb-0 ms-1">
                                        <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                                            <i class="uil uil-search"></i>
                                        </a>
                                    </li>

                                    <li class="list-inline-item mb-0 ms-1">
                                        <c:choose>
                                            <c:when test="${sessionScope.user ne null}">
                                                <div class="dropdown dropdown-primary">
                                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <img src="./assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                                    </button>
                                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                        <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                                            <img src="./assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                            <div class="flex-1 ms-2">
                                                                <span class="d-block mb-1">${sessionScope.user.fullname}</span>
                                                            </div>
                                                        </a>
                                                        <c:if test="${sessionScope.role.contains('Admin')}">
                                                            <a class="dropdown-item text-dark" href="doctor-dashboard.html">
                                                                <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                                            </a>
                                                        </c:if>
                                                        <a class="dropdown-item text-dark" href="./profile">
                                                            <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                                        </a>
                                                        <div class="dropdown-divider border-top"></div>
                                                        <a class="dropdown-item text-dark" href="./logout">
                                                            <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="./login" class="btn btn-soft-primary btn-sm">
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
                                                    <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                                    <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                                    </c:if>
                                                <li><a href="doctor-dashboard.html" class="sub-menu-item">Staff List</a></li>
                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-menu-item">
                                            <a href="javascript:void(0)">Services</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li><a href="./service-list" class="sub-menu-item">Services List</a></li>
                                                    <c:if test="${sessionScope.role.contains('Customer')}">
                                                    <li><a href="./myreservation" class="sub-menu-item">My Reservation</a></li>
                                                    <li><a href="BookingStaff" class="sub-menu-item">Reservation</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>

                                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                                            <ul class="submenu">
                                                <li class="has-submenu parent-menu-item">
                                                <li><a href="./blog" class="sub-menu-item">Blogs</a></li>

                                                <c:if test="${sessionScope.role.contains('Marketing Staff')}">
                                                    <li><a href="./post-list" class="sub-menu-item">Posts - Management</a></li>
                                                    <li><a href="./slider" class="sub-menu-item">Sliders - Management</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>
                                        <c:if test="${sessionScope.role.contains('Admin')}">
                                            <li><a href="./admin/dashboard" class="sub-menu-item" target="_blank">Admin</a></li>
                                            </c:if>

                                    </ul><!--end navigation menu-->
                                </div><!--end navigation-->
                            </div><!--end container-->
                        </header><!--end header-->
                    </div>
                </div>

                <div class="container">
                    <h2>Edit Post</h2>

                    <% Post post = (Post) request.getAttribute("post"); 
                       List<String> categories = (List<String>) request.getAttribute("categories"); 
                    %>

                    <form method="POST" action="post-edit" enctype="multipart/form-data">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">

                        <label>Title:</label>
                        <input type="text" name="title" value="<%= post.getTitle() %>" required>

                        <label>Content:</label>
                        <textarea id="content-editor" name="content"><%= post.getContent() %></textarea>


                        <label>Category:</label>
                        <select name="category">
                            <% for (String category : categories) { %>
                            <option value="<%= category %>" <%= category.equals(post.getCategory()) ? "selected" : "" %>><%= category %></option>
                            <% } %>
                        </select>

                        <label>Status:</label>
                        <select name="status">
                            <option value="1" <%= post.getStatus().equals("1") ? "selected" : "" %>>Active</option>
                            <option value="0" <%= post.getStatus().equals("0") ? "selected" : "" %>>Hidden</option>
                        </select>
                        <input type="hidden" name="currentImage" value="<%= post.getImg() %>">
                        <div class="image-container">
                            <!-- Ảnh hiện tại -->
                            <div class="current-image-container">
                                <img id="currentImage" src="<%= post.getImg() %>" alt="Current Image">
                            </div>

                            <!-- Khu vực Preview (Ẩn ban đầu) -->
                            <div class="preview-container" id="preview-container">
                                <img id="preview-image" src="" alt="Preview Image">
                            </div>
                        </div>

                        <!-- Nút Upload -->
                        <label for="imageFile" class="btn-upload">📸 Upload</label>
                        <input type="file" name="imageFile" accept="image/*" onchange="previewImage(event)" id="imageFile">







                        <% 
List<String[]> authors = (List<String[]>) request.getAttribute("authors");
String currentAuthorId = (String) request.getAttribute("currentAuthorId");

if (authors == null) authors = new ArrayList<>();
if (currentAuthorId == null) currentAuthorId = "";
                        %>

                        <label>Author:</label>
                        <select name="author">
                            <% for (String[] author : authors) { %>
                            <option value="<%= author[0] %>" <%= author[0].equals(currentAuthorId) ? "selected" : "" %>>
                                <%= author[1] %>
                            </option>
                            <% } %>
                        </select>


                        <% String error = request.getParameter("error"); %>
                        <% if (error != null) { %>
                        <p style="color: red;">
                            <% if ("missing_author".equals(error)) { %>
                            Please select an author.
                            <% } else if ("invalid_author".equals(error)) { %>
                            Invalid author selection.
                            <% } %>
                        </p>
                        <% } %>

                        <button type="submit">Save Changes</button>
                    </form>

                    <a href="post-list" class="back-btn">Back to Post List</a>
                </div>

                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">

                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </footer><!--end footer-->
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="./assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="./assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="./assets/js/app.js"></script>

        <script>
                                        const handleChange = () => {
                                            const fileUploader = document.querySelector('#input-file');
                                            const getFile = fileUploader.files
                                            if (getFile.length !== 0) {
                                                const uploadedFile = getFile[0];
                                                readFile(uploadedFile);
                                            }
                                        }

                                        const readFile = (uploadedFile) => {
                                            if (uploadedFile) {
                                                const reader = new FileReader();
                                                reader.onload = () => {
                                                    const parent = document.querySelector('.preview-box');
                                                    parent.innerHTML = `<img class="preview-content" src=${reader.result} />`;
                                                };

                                                reader.readAsDataURL(uploadedFile);
                                            }
                                        };
        </script>
        <!-- TinyMCE - Rich Text Editor -->
        <script src="https://cdn.jsdelivr.net/npm/tinymce/tinymce.min.js"></script>

        <script>
                                        tinymce.init({
                                            selector: 'textarea#content-editor', // ID của textarea
                                            height: 300, // Độ cao của ô nhập liệu
                                            menubar: false, // Ẩn menu trên cùng
                                            plugins: 'advlist autolink lists link image charmap preview anchor searchreplace visualblocks code fullscreen insertdatetime media table paste help',
                                            toolbar: 'undo redo | formatselect | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                                            content_css: 'https://www.tiny.cloud/css/codepen.min.css'
                                        });
        </script>
        <script>
            function previewImage(event) {
                const input = event.target;
                const reader = new FileReader();
                const previewContainer = document.getElementById("preview-container");
                const previewImage = document.getElementById("preview-image");
                const currentImage = document.getElementById("currentImage");
                const currentImageContainer = document.querySelector(".current-image-container");

                reader.onload = function () {
                    previewImage.src = reader.result;
                    previewContainer.style.display = "flex"; // Hiển thị preview khi có ảnh mới
                    currentImageContainer.style.display = "none"; // Ẩn ảnh hiện tại
                };

                if (input.files && input.files[0]) {
                    reader.readAsDataURL(input.files[0]);
                } else {
                    previewContainer.style.display = "none"; // Ẩn preview nếu không có ảnh mới
                    currentImageContainer.style.display = "flex"; // Hiển thị lại ảnh hiện tại
                }
            }


        </script>

    </body>

</html>
