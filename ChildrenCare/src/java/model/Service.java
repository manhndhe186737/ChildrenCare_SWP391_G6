/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author FPTSHOP
 */
public class Service {
    private int id;
    private String name;
    private String description;
    private float price;
    private ServiceCategory category;
    private int categoryId;
    public String img;
    public Boolean isActive;

    public Service(int id, String name, String description, float price, ServiceCategory category, int categoryId, String img, Boolean isActive) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.categoryId = categoryId;
        this.img = img;
        this.isActive = isActive;
    }

    public Service(int id, String name, String description, float price, int categoryId, String img, Boolean isActive) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.img = img;
        this.isActive = isActive;
    }

    public Service(String name, String description, float price, int categoryId, String img, Boolean isActive) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.img = img;
        this.isActive = isActive;
    }
    
    

    public Service() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public ServiceCategory getCategory() {
        return category;
    }

    public void setCategory(ServiceCategory category) {
        this.category = category;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    
    
    
    
    @Override
    public String toString() {
        return "Service{id=" + id + ", name='" + name + "', description='" + description + "', price=" + price +
                ", categoryId=" + categoryId + ", img='" + img + "'}";
    }
    
    
    
    
}
