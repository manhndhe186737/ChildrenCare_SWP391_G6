package model;

/**
 *
 * @author vucon
 */
public class Appointment {
    private int staffId;
    private int reservId;
    private String dateBook;
    private int customerId;
    private int serviceId;
    private String startTime;
    private String endTime;
    private String customerName;
    private String customerAddress;
    private int paymentId;
    private double amount;
    private String paymentMethod;
    private String paymentStatus;
    private String avatar; // Thêm avatar
    private User customer;
    private Service service;
    private String status;

    public Appointment() {
    }

    public Appointment(int staffId, int reservId, String dateBook, int customerId, int serviceId, String startTime, String endTime, String customerName, String customerAddress, int paymentId, double amount, String paymentMethod, String paymentStatus, String avatar, User customer, Service service, String status) {
        this.staffId = staffId;
        this.reservId = reservId;
        this.dateBook = dateBook;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.customerName = customerName;
        this.customerAddress = customerAddress;
        this.paymentId = paymentId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.avatar = avatar;
        this.customer = customer;
        this.service = service;
        this.status = status;
    }

   

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getReservId() {
        return reservId;
    }

    public void setReservId(int reservId) {
        this.reservId = reservId;
    }

    public String getDateBook() {
        return dateBook;
    }

    public void setDateBook(String dateBook) {
        this.dateBook = dateBook;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
