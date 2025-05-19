package com.yycy.entity;

import java.sql.Timestamp;

/**
 * User.java
 * 作用：本类是用户实体类（POJO），用于封装和表示用户表（数据库）中的一条用户数据。
 * 主要包含用户的基本信息（如id、用户名、密码、昵称、邮箱、手机号、性别、头像路径、创建时间、更新时间）。
 * 该类用于在程序中传递和操作用户数据，通常配合DAO层进行数据库的增删改查操作。
 */

public class User {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private String phone;
    private String gender;
    private String avatarPath;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 无参构造函数
    public User() {}

    // 全参构造函数
    public User(int id, String username, String password, String nickname, 
                String email, String phone, String gender, String avatarPath,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.nickname = nickname;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.avatarPath = avatarPath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter和Setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAvatarPath() { return avatarPath; }
    public void setAvatarPath(String avatarPath) { this.avatarPath = avatarPath; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", nickname='" + nickname + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", gender='" + gender + '\'' +
                '}';
    }
}