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
    private String author; 
    private String authorAvatar;
    private String shortContent;
    
    private int categoryId;
    private PostCategory postCategory;
    private String categoryName;

    public Post(int id, String title, String content, Date updatedate, Date createdate, String status, String img, String category, String author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.updatedate = updatedate;
        this.createdate = createdate;
        this.status = status;
        this.img = img;
        this.categoryName = category;
        this.author = author;
    }

    public Post(int id, String title, String content, Date updatedate, Date createdate, String status, String img, String author, String authorAvatar, String shortContent, int categoryId, PostCategory postCategory, String categoryName) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.updatedate = updatedate;
        this.createdate = createdate;
        this.status = status;
        this.img = img;
        this.author = author;
        this.authorAvatar = authorAvatar;
        this.shortContent = shortContent;
        this.categoryId = categoryId;
        this.postCategory = postCategory;
        this.categoryName = categoryName;
    }

    public Post() {
    }

    public String getShortContent() {
        return shortContent;
    }

    public void setShortContent(String shortContent) {
        this.shortContent = shortContent;
    }
    
    // Existing getters and setters
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
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getAuthorAvatar() {
        return authorAvatar;
    }
    
    public void setAuthorAvatar(String authorAvatar) {
        this.authorAvatar = authorAvatar;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public PostCategory getPostCategory() {
        return postCategory;
    }
    
    public void setPostCategory(PostCategory postCategory) {
        this.postCategory = postCategory;
        if (postCategory != null) {
            this.categoryId = postCategory.getId();
            this.categoryName = postCategory.getName();
        }
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
 
    public boolean isStatusActive() {
        return "1".equals(status) || "true".equals(status.toLowerCase());
    }
    
    public void setStatusBoolean(boolean active) {
        this.status = active ? "1" : "0";
    }
    
    public int getAuthorId() {
        try {
            return Integer.parseInt(author);
        } catch (NumberFormatException e) {
            return 0; 
        }
    }
    
    public void setAuthorId(int authorId) {
        this.author = String.valueOf(authorId);
    }
}