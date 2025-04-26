package model;

import java.util.Date;

public class Order {
    private int orderId;
    private String paymentMethod;
    private double amount;
    private String paymentStatus;
    private int userId;
    private Date orderDate;
    private String status;
    private String address;
    private String customerName;
    private String phoneNumber;
    // Constructor mặc định
    public Order() {
    }

    // Constructor đầy đủ (đã bao gồm phoneNumber)
    public Order(int orderId, String paymentMethod, double amount, String paymentStatus, int userId, Date orderDate, String status, String address, String customerName, String phoneNumber) {
        this.orderId = orderId;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.userId = userId;
        this.orderDate = orderDate;
        this.status = status;
        this.address = address;
        this.customerName = customerName;
        this.phoneNumber = phoneNumber; // Gán giá trị phoneNumber
    }

    // Getters và Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    // *** Sửa tên getter/setter cho phoneNumber ***
    public String getPhoneNumber() { // Chữ 'P' viết hoa
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) { // Chữ 'P' viết hoa
        this.phoneNumber = phoneNumber;
    }
    // *** Kết thúc sửa phoneNumber ***

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // *** Chỉ giữ lại một getter cho customerName ***
    public String getCustomerName() {
        return customerName;
    }
    // *** Kết thúc sửa customerName ***

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    // (Tùy chọn) Thêm toString() để dễ debug
    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", amount=" + amount +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", address='" + address + '\'' +
                ", customerName='" + customerName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}