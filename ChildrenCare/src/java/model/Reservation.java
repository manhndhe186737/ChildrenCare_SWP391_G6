/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
/**
 *
 * @author FPTSHOP
 */
public class Reservation {
    private int id;
    private Date bookdate;
    private String status;
    private Date updatedate;
    private Date createdate;
    private String note;
    private Time start;
    private Time end;
    private String customerName;
    private String customerAddress;
    private User customer;
    private User staff;
    private Service service;
    private ArrayList<Feedback> feedbacks;
    private ArrayList<Payment> payments;
    private ArrayList<Schedule> schedules;

    public Reservation() {
    }

    public Reservation(int id, Date bookdate, String status, Date updatedate, Date createdate, String note, Time start, Time end, String customerName, String customerAddress, User customer, User staff, Service service, ArrayList<Feedback> feedbacks, ArrayList<Payment> payments, ArrayList<Schedule> schedules) {
        this.id = id;
        this.bookdate = bookdate;
        this.status = status;
        this.updatedate = updatedate;
        this.createdate = createdate;
        this.note = note;
        this.start = start;
        this.end = end;
        this.customerName = customerName;
        this.customerAddress = customerAddress;
        this.customer = customer;
        this.staff = staff;
        this.service = service;
        this.feedbacks = feedbacks;
        this.payments = payments;
        this.schedules = schedules;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBookdate() {
        return bookdate;
    }

    public void setBookdate(Date bookdate) {
        this.bookdate = bookdate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Time getStart() {
        return start;
    }

    public void setStart(Time start) {
        this.start = start;
    }

    public Time getEnd() {
        return end;
    }

    public void setEnd(Time end) {
        this.end = end;
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

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getStaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public ArrayList<Feedback> getFeedbacks() {
        return feedbacks;
    }

    public void setFeedbacks(ArrayList<Feedback> feedbacks) {
        this.feedbacks = feedbacks;
    }

    public ArrayList<Payment> getPayments() {
        return payments;
    }

    public void setPayments(ArrayList<Payment> payments) {
        this.payments = payments;
    }

    public ArrayList<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(ArrayList<Schedule> schedules) {
        this.schedules = schedules;
    }

   
}
