package com.yycy.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product.java
 * 作用：本类是商品实体类（POJO），用于封装和表示商品表（数据库）中的一条商品数据。
 * 主要包含商品的基本信息（如id、名称、描述、价格、图片URL、销量、创建时间、更新时间）。
 * 该类用于在程序中传递和操作商品数据。
 */
public class Product {

    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private String imageUrl;
    private int salesVolume;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 无参构造函数
    public Product() {
    }

    // 全参构造函数 (可以根据需要调整参数)
    public Product(int id, String name, String description, BigDecimal price,
            String imageUrl, int salesVolume, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.salesVolume = salesVolume;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter 和 Setter 方法
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getSalesVolume() {
        return salesVolume;
    }

    public void setSalesVolume(int salesVolume) {
        this.salesVolume = salesVolume;
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

    // toString() 方法 (方便调试)
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", imageUrl='" + imageUrl + '\'' +
                ", salesVolume=" + salesVolume +
                '}';
    }
}
