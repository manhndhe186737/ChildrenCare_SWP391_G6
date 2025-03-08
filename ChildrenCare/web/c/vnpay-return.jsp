<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VNPay Payment Result</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header text-center">
                <h3>Payment Result</h3>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${param.vnp_ResponseCode == '00'}">
                        <div class="alert alert-success text-center" role="alert">
                            <strong>Payment successful!</strong>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger text-center" role="alert">
                            <strong>Payment failed!</strong>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <h5>Transaction Details:</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Transaction ID:</strong> ${param.vnp_TxnRef}</li>
                    <li class="list-group-item"><strong>Order Info:</strong> ${param.vnp_OrderInfo}</li>
                    <li class="list-group-item"><strong>Amount:</strong> <fmt:formatNumber value="${param.vnp_Amount / 100}" type="currency" currencyCode="VND"/></li>
                    <li class="list-group-item"><strong>Payment Date:</strong> ${param.vnp_PayDate}</li>
                    <li class="list-group-item"><strong>Bank Code:</strong> ${param.vnp_BankCode}</li>
                    <li class="list-group-item"><strong>Response Code:</strong> ${param.vnp_ResponseCode}</li>
                    <li class="list-group-item"><strong>Transaction Status:</strong> <c:choose>
                        <c:when test="${param.vnp_ResponseCode == '00'}">Success</c:when>
                        <c:otherwise>Failed</c:otherwise>
                    </c:choose></li>
                </ul>
                
                <div class="text-center mt-3">
                    <a href="c/home" class="btn btn-primary">Return to Home</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>