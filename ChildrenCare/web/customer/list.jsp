<%-- 
    Document   : customerlist
    Created on : Jan 28, 2025, 9:25:51 PM
    Author     : FPTSHOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1px">
            <tr>
                <td>Name</td>
                <td>Gender</td>
                <td>Email</td>
                <td>Address</td>
                <td>Phone</td>
                <td>Dob</td>
                <td></td>
            </tr>

            <c:forEach var="c" items="${requestScope.customers}">
                <tr>
                    <td>${c.fullname}</td>
                    <td>X</td>
                    <td>${c.account.email}</td>
                    <td>${c.address}</td>
                    <td>${c.phone}</td>
                    <td>${c.dob}</td>
                    <td>
                        <a href="#">Add</a> &nbsp;
                        <a href="#">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
