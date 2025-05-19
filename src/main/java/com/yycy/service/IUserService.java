package com.yycy.service;

import com.yycy.entity.User;

/**
 * 作用：定义用户相关业务逻辑的服务接口。
 * 包含用户认证（登录、注册）、个人信息管理等业务方法声明。
 */
public interface IUserService {

    /**
     * 用户登录。
     * 
     * @param username 用户名
     * @param password 密码
     * @return 登录成功返回 User 对象，失败返回 null。
     */
    User login(String username, String password);

    /**
     * 用户注册。
     * 
     * @param user 要注册的 User 对象 (通常包含用户名和密码)
     * @return 注册成功返回 true，失败（如用户名已存在）返回 false。
     */
    boolean register(User user);

    /**
     * 根据用户ID获取用户信息。
     * 
     * @param id 用户ID
     * @return 如果找到用户，返回 User 对象；否则返回 null。
     */
    User getUserById(int id);

    /**
     * 更新用户个人资料（昵称、邮箱、手机号、性别）。
     * 
     * @param user 包含更新信息的 User 对象 (必须设置用户ID)
     * @return 更新成功返回 true，失败返回 false。
     */
    boolean updateUserProfile(User user);

    /**
     * 修改用户密码。
     * 
     * @param userId      用户ID
     * @param oldPassword 旧密码 (明文)
     * @param newPassword 新密码 (明文)
     * @return 修改成功返回 true，失败（如旧密码错误）返回 false。
     */
    boolean changePassword(int userId, String oldPassword, String newPassword);

    /**
     * 更新用户头像路径。
     * 
     * @param userId     用户ID
     * @param avatarPath 新的头像文件路径
     * @return 更新成功返回 true，失败返回 false。
     */
    boolean updateUserAvatar(int userId, String avatarPath);

    // 登出通常在 Servlet 中直接操作 Session，不需要 Service 方法
}
