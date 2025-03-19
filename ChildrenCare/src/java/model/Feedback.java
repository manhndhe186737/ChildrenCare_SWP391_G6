package model;

import java.sql.Date;

public class Feedback {
    private int id;
    private Date date;
    private String rating;
    private String comment;
    private String img;
    private Reservation reservation;
    private int status;
    private String reply;

    public Feedback() {
    }

    public Feedback(int id, Date date, String rating, String comment, String img, Reservation reservation, int status, String reply) {
        this.id = id;
        this.date = date;
        this.rating = rating;
        this.comment = comment;
        this.img = img;
        this.reservation = reservation;
        this.status = status;
        this.reply = reply;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }
}
