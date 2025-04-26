package model;

public class ProductCart {
    private int pcartId;
    private int productId;
    private int userId;
    private int quantity;

    // Constructor mặc định
    public ProductCart() {
    }

    // Constructor đầy đủ
    public ProductCart(int pcartId, int productId, int userId, int quantity) {
        this.pcartId = pcartId;
        this.productId = productId;
        this.userId = userId;
        this.quantity = quantity;
    }

    // Getter và Setter
    public int getPcartId() {
        return pcartId;
    }

    public void setPcartId(int pcartId) {
        this.pcartId = pcartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Optional: toString() để debug
    @Override
    public String toString() {
        return "ProductCart{" +
                "pcartId=" + pcartId +
                ", productId=" + productId +
                ", userId=" + userId +
                ", quantity=" + quantity +
                '}';
    }
}
