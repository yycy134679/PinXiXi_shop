package com.yycy.entity;

import java.sql.Timestamp;

/**
 * Address.java
 * 作用：本类是地址实体类（POJO），用于封装和表示地址表（数据库）中的一条地址数据。
 * 主要包含地址的基本信息（如id、用户id、所在省、市、区、详细地址、创建时间、更新时间）。
 * 该类用于在程序中传递和操作用户地址数据。
 */
public class Address {
    private int id;
    private int userId;
    private String province;
    private String city;
    private String district;
    private String detailAddress;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 无参构造函数
    public Address() {
    }

    // 全参构造函数
    public Address(int id, int userId, String province, String city, String district, String detailAddress,
            Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.userId = userId;
        this.province = province;
        this.city = city;
        this.district = district;
        this.detailAddress = detailAddress;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
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

    // toString() 方法
    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", userId=" + userId +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", district='" + district + '\'' +
                ", detailAddress='" + detailAddress + '\'' +
                '}';
    }
}
