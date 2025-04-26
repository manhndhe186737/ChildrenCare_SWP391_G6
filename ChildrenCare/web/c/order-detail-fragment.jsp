<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- Thiết lập Locale để định dạng số cho đúng (ví dụ: US) --%>
<fmt:setLocale value="en_US"/>

<%--
    File này CHỈ tạo ra các thẻ <tr> cho bảng chi tiết đơn hàng trong modal.
    Nó nhận danh sách 'detailsForFragment' hoặc 'errorMessage' từ OrderDetailFragmentServlet.
--%>

<c:choose>
    <%-- Trường hợp 1: Có lỗi từ Servlet --%>
    <c:when test="${not empty errorMessage}">
        <tr>
            <td colspan="5" class="text-center text-danger p-3">
                <i class="uil uil-exclamation-triangle me-1"></i> ${errorMessage}
            </td>
        </tr>
    </c:when>

    <%-- Trường hợp 2: Có dữ liệu chi tiết (không có lỗi) --%>
    <c:when test="${not empty detailsForFragment}">
        <%-- Lặp qua danh sách chi tiết đơn hàng --%>
        <c:forEach var="item" items="${detailsForFragment}">
            <%--
                Thêm data-quantity và data-price để JavaScript có thể đọc và tính tổng.
                Giả sử model OrderDetail có các trường:
                - productId
                - productName (lấy từ JOIN)
                - quantity
                - unitPrice (lấy từ JOIN hoặc từ order_detail)
            --%>
            <tr data-quantity="${item.quantity}" data-price="${item.unitPrice}">
                <td>${item.productId}</td>
                <td><c:out value="${item.productName}"/></td> <%-- Dùng c:out để tránh XSS --%>
                <td class="text-center">${item.quantity}</td>
                <td class="text-end">
                    <%-- Định dạng giá đơn vị --%>
                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="$"/>
                </td>
                <td class="text-end">
                    <%-- Tính và định dạng tổng tiền cho dòng này --%>
                    <fmt:formatNumber value="${item.quantity * item.unitPrice}" type="currency" currencySymbol="$"/>
                </td>
            </tr>
        </c:forEach>
    </c:when>

    <%-- Trường hợp 3: Không có lỗi nhưng không có chi tiết nào được tìm thấy --%>
    <c:otherwise>
        <tr>
            <td colspan="5" class="text-center p-3">No details found for this order.</td>
        </tr>
    </c:otherwise>
</c:choose>