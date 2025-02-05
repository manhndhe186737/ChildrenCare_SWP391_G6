package model;

import java.sql.Date;

public class Post {
    private int id;
    private String title;
    private String content;
    private Date updatedate;
    private Date createdate;
    private String status;
    private String img;
    private String category;
    private String author; 

    public Post(int id, String title, String content, Date updatedate, Date createdate, String status, String img, String category, String author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.updatedate = updatedate;
        this.createdate = createdate;
        this.status = status;
        this.img = img;
        this.category = category;
        this.author = author; 
    }

    public Post() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
