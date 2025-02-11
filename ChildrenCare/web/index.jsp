<%-- 
    Document   : index
    Created on : Feb 8, 2025, 2:09:10 PM
    Author     : vucon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div>TODO write content</div>
        <h1>Đây là trang Home</h1>




        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            window.onload = function () {
                var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : "" %>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "" %>';

                // Kiểm tra nếu alertMessage và alertType không rỗng thì hiển thị Swal.fire
                if (alertMessage.trim() !== "" && alertType.trim() !== "") {
                    Swal.fire({
                        icon: alertType,
                        title: alertMessage,
                        showConfirmButton: false,
                        timer: 3000
                    });
                }
            };
            
            <%
            session.removeAttribute("alertMessage");
            session.removeAttribute("alertType");
    %>
        </script>
    </body>
</html>

