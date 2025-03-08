<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Result - Cash on Delivery</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header text-center">
                <h3>Payment Result - Cash on Delivery</h3>
            </div>
            <div class="card-body">
                <!-- Check if payment is successful or not -->
                <c:choose>
                    <c:when test="${reservation != null}">
                        <div class="alert alert-success text-center" role="alert">
                            <strong>Payment successful!</strong> Your reservation has been confirmed.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger text-center" role="alert">
                            <strong>Payment failed!</strong> Please try again.
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Reservation Details -->
                <h5>Reservation Details:</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Customer Name:</strong> ${reservation.customerName}</li>
                    <li class="list-group-item"><strong>Service Name:</strong> ${reservation.service.name}</li>
                    <li class="list-group-item"><strong>Service Date:</strong> ${reservation.bookdate}</li>
                    <li class="list-group-item"><strong>Start Time:</strong> ${reservation.start}</li>
                    <li class="list-group-item"><strong>End Time:</strong> ${reservation.end}</li>
                    <li class="list-group-item"><strong>Note:</strong> ${reservation.note}</li>
                    <li class="list-group-item"><strong>Staff Assigned:</strong> ${reservation.staff.fullname}</li>
                </ul>

                <!-- Customer Information -->
                <h5 class="mt-3">Customer Information:</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Customer Address:</strong> ${reservation.customerAddress}</li>
                    <li class="list-group-item"><strong>Phone:</strong> ${sessionScope.user.phone}</li>
                    <li class="list-group-item"><strong>Email:</strong> ${sessionScope.account.email}</li>
                </ul>

                <!-- Payment Information -->
                <h5 class="mt-3">Payment Information:</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Total Amount (VND):</strong> ${amount}</li>
                    <li class="list-group-item"><strong>Amount (USD):</strong> ${reservation.service.price}</li>
                </ul>

                <!-- Back to Home Button -->
                <div class="text-center mt-4">
                    <a href="home" class="btn btn-primary">Return to Home</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
