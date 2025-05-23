package com.yycy.dao;

import com.yycy.entity.User;
import java.sql.SQLException;

/**
 * 作用：定义用户数据访问操作的接口。
 * 包含对用户表（users）进行增删改查等操作的方法声明。
 */
public interface IUserDao {
    /**
     * 根据用户名查找用户
     * 
     * @param username 用户名
     * @return User对象，未找到返回null
     * @throws SQLException 数据库异常
     */
    User findByUsername(String username) throws SQLException;

    /**
     * 根据用户ID查找用户
     * 
     * @param id 用户ID
     * @return User对象，未找到返回null
     * @throws SQLException 数据库异常
     */
    User findById(int id) throws SQLException;

    /**
     * 保存新用户（注册）
     * 
     * @param user 用户对象
     * @throws SQLException 数据库异常
     */
    void save(User user) throws SQLException;

    /**
     * 更新用户信息（个人信息、密码、头像等）
     * 
     * @param user 用户对象
     * @throws SQLException 数据库异常
     */
    void update(User user) throws SQLException;

    /**
     * 更新用户密码
     * 
     * @param userId      用户ID
     * @param newPassword 新密码
     * @throws SQLException 数据库异常
     */
    void updatePassword(int userId, String newPassword) throws SQLException;

    /**
     * 更新用户头像路径
     * 
     * @param userId     用户ID
     * @param avatarPath 头像路径
     * @throws SQLException 数据库异常
     */
    void updateAvatar(int userId, String avatarPath) throws SQLException;

    /**
     * 根据手机号查找用户
     * 
     * @param phone 手机号
     * @return User对象，未找到返回null
     * @throws SQLException 数据库异常
     */
    User findByPhone(String phone) throws SQLException;

    /**
     * 根据邮箱查找用户
     * 
     * @param email 邮箱
     * @return User对象，未找到返回null
     * @throws SQLException 数据库异常
     */
    User findByEmail(String email) throws SQLException;
}
