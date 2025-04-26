package model;

/**
 * Represents a product in the system.
 * Includes stock information.
 */
public class Product {
    private int productId;
    private String productName;
    private int categoryId;
    private float price;
    private String description;
    private boolean status;
    private String img;
    private int stock; 

    // Constructor mặc định
    public Product() {
    }

    // Constructor đầy đủ tham số (bao gồm stock)
    public Product(int productId, String productName, int categoryId, float price, String description, boolean status, String img, int stock) { // <-- Thêm stock vào constructor
        this.productId = productId;
        this.productName = productName;
        this.categoryId = categoryId;
        this.price = price;
        this.description = description;
        this.status = status;
        this.img = img;
        this.stock = stock; // <-- Gán giá trị cho stock
    }

    // Getters and Setters

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    // --- Thêm Getter và Setter cho stock ---
    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
    // -------------------------------------

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", categoryId=" + categoryId +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", status=" + status +
                ", img='" + img + '\'' +
                ", stock=" + stock + // <-- Thêm stock vào toString
                '}';
    }
}