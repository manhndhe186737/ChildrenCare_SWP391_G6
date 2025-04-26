package model;

public enum OrderStatus {
    PENDING("1", "Pending"),
    SHIPPED("2", "Shipped"),
    DELIVERED("3", "Delivered"),
    CANCELLED("4", "Cancelled"),
    UNKNOWN("0", "Unknown");

    private final String numericValue;
    private final String displayValue;

    OrderStatus(String numericValue, String displayValue) {
        this.numericValue = numericValue;
        this.displayValue = displayValue;
    }

    public String getNumericValue() {
        return numericValue;
    }

    public String getDisplayValue() {
        return displayValue;
    }

    public static OrderStatus fromNumericValue(String numericValue) {
        for (OrderStatus status : values()) {
            if (status.numericValue.equals(numericValue)) {
                return status;
            }
        }
        return UNKNOWN;
    }

    public static OrderStatus fromDisplayValue(String displayValue) {
        for (OrderStatus status : values()) {
            if (status.displayValue.equalsIgnoreCase(displayValue)) {
                return status;
            }
        }
        return UNKNOWN;
    }
}