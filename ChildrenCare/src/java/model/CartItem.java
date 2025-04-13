package model;

public class CartItem {
    private int cartId; // ID của chính mục trong giỏ hàng (pcart_id)
    private Product product; // Đối tượng Product chi tiết
    private int quantity; // Số lượng sản phẩm này trong giỏ

    // Constructors
    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public CartItem(int cartId, Product product, int quantity) {
        this.cartId = cartId;
        this.product = product;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Optional: Tính tổng giá cho mục này
    public float getTotalPrice() {
        if (product != null) {
            return product.getPrice() * quantity;
        }
        return 0;
    }

    @Override
    public String toString() {
        return "CartItem{" +
               "cartId=" + cartId +
               ", product=" + (product != null ? product.getProductName() : "null") + // Tránh NullPointerException
               ", quantity=" + quantity +
               '}';
    }
}