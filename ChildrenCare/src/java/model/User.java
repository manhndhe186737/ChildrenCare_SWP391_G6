/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author FPTSHOP
 */
public class User {
    private int id;
    private String fullname;
    private String address;
    private Date dob;
    private String phone;
    private String avatar;
    private Account account;
    private ArrayList<Post> posts;
    private ArrayList<Slider> sliders;
    private Profile profile;
    private ArrayList<Reservation> reservations;
    private ArrayList<Schedule> schedules;

    public User() {
    }

    public User(int id, String fullname, String address, Date dob, String phone, String avatar, Account account, ArrayList<Post> posts, ArrayList<Slider> sliders, Profile profile, ArrayList<Reservation> reservations, ArrayList<Schedule> schedules) {
        this.id = id;
        this.fullname = fullname;
        this.address = address;
        this.dob = dob;
        this.phone = phone;
        this.avatar = avatar;
        this.account = account;
        this.posts = posts;
        this.sliders = sliders;
        this.profile = profile;
        this.reservations = reservations;
        this.schedules = schedules;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public ArrayList<Post> getPosts() {
        return posts;
    }

    public void setPosts(ArrayList<Post> posts) {
        this.posts = posts;
    }

    public ArrayList<Slider> getSliders() {
        return sliders;
    }

    public void setSliders(ArrayList<Slider> sliders) {
        this.sliders = sliders;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public ArrayList<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(ArrayList<Reservation> reservations) {
        this.reservations = reservations;
    }

    public ArrayList<Schedule> getSchedules() {
        return schedules;
    }

    public void setSchedules(ArrayList<Schedule> schedules) {
        this.schedules = schedules;
    }
    
}
