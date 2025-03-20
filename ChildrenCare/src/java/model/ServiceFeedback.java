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
public class ServiceFeedback {
    private int feedId;
    private Date date;
    private int rating;
    private String comment;
    private String commentImg;
    private boolean status;
    private String reply;
    private int user_id;
    private String fullname;
    private String avatar;

    public ServiceFeedback() {
    }

    public ServiceFeedback(int feedId, Date date, int rating, String comment, String commentImg, boolean status, String reply, int user_id, String fullname, String avatar) {
        this.feedId = feedId;
        this.date = date;
        this.rating = rating;
        this.comment = comment;
        this.commentImg = commentImg;
        this.status = status;
        this.reply = reply;
        this.user_id = user_id;
        this.fullname = fullname;
        this.avatar = avatar;
    }

    public int getFeedId() {
        return feedId;
    }

    public void setFeedId(int feedId) {
        this.feedId = feedId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommentImg() {
        return commentImg;
    }

    public void setCommentImg(String commentImg) {
        this.commentImg = commentImg;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    
}
