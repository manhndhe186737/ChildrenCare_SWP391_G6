/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author FPTSHOP
 */
public class Profile {
    private int id;
    private String experience;
    private String certification;
    private String specialties;
    private User staff;
    private String exp_start;
    private String exp_end;

    public Profile() {
    }

    public Profile(int id, String experience, String certification, String specialties, User staff, String exp_start, String exp_end) {
        this.id = id;
        this.experience = experience;
        this.certification = certification;
        this.specialties = specialties;
        this.staff = staff;
        this.exp_start = exp_start;
        this.exp_end = exp_end;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getCertification() {
        return certification;
    }

    public void setCertification(String certification) {
        this.certification = certification;
    }

    public String getSpecialties() {
        return specialties;
    }

    public void setSpecialties(String specialties) {
        this.specialties = specialties;
    }

    public User getStaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public String getExp_start() {
        return exp_start;
    }

    public void setExp_start(String exp_start) {
        this.exp_start = exp_start;
    }

    public String getExp_end() {
        return exp_end;
    }

    public void setExp_end(String exp_end) {
        this.exp_end = exp_end;
    }

    
}
