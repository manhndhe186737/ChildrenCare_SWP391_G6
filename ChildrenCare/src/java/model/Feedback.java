/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author FPTSHOP
 */
public class Feedback {
    private int id;
    private Date date;
    private String rating;
    private String comment;
    private String img;
    private Reservation reservation;
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
      public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public Feedback(int id, Date date, String rating, String comment, String img  , Reservation reservation ,int status) {
        this.id = id;
        this.date = date;
        this.rating = rating;
        this.comment = comment;
        this.img = img;  
        this.reservation = reservation;
        this.status = status;
    }

    public Feedback() {
    }
}
