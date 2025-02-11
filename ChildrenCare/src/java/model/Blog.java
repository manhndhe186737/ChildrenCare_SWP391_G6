package model;

import java.sql.Timestamp;

public class Blog {
    private int blogId; // Matches blog_id in the database
    private String title;
    private String content;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int authorId;
    private byte status; // Use byte for tinyint
    private String featuredImage;
    private String slug;
    private String metaDescription;
    private String metaKeywords;

    // Constructor (optional, but good practice):
    public Blog() {} // No-argument constructor

    public Blog(int blogId, String title, String content, Timestamp createdAt, Timestamp updatedAt, int authorId, byte status, String featuredImage, String slug, String metaDescription, String metaKeywords) {
        this.blogId = blogId;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.authorId = authorId;
        this.status = status;
        this.featuredImage = featuredImage;
        this.slug = slug;
        this.metaDescription = metaDescription;
        this.metaKeywords = metaKeywords;
    }


    // Getters and Setters (for all fields)

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public String getFeaturedImage() {
        return featuredImage;
    }

    public void setFeaturedImage(String featuredImage) {
        this.featuredImage = featuredImage;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getMetaDescription() {
        return metaDescription;
    }

    public void setMetaDescription(String metaDescription) {
        this.metaDescription = metaDescription;
    }

    public String getMetaKeywords() {
        return metaKeywords;
    }

    public void setMetaKeywords(String metaKeywords) {
        this.metaKeywords = metaKeywords;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "blogId=" + blogId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", authorId=" + authorId +
                ", status=" + status +
                ", featuredImage='" + featuredImage + '\'' +
                ", slug='" + slug + '\'' +
                ", metaDescription='" + metaDescription + '\'' +
                ", metaKeywords='" + metaKeywords + '\'' +
                '}';
    }
}