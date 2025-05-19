package com.yycy.service.impl;

import com.yycy.dao.IUserDao;
import com.yycy.dao.impl.UserDaoImpl;
import com.yycy.entity.User;
import com.yycy.service.IUserService;

/**
 * UserServiceImpl.java
 * IUserService 接口的实现类。
 * 处理用户登录、注册等业务逻辑。
 */
public class UserServiceImpl implements IUserService {

    // 依赖 IUserDao
    private IUserDao userDao = new UserDaoImpl(); // 简单实例化

    @Override
    public User login(String username, String password) {
        throw new UnsupportedOperationException("login not implemented yet.");
    }

    @Override
    public boolean register(User user) {
        throw new UnsupportedOperationException("register not implemented yet.");
    }

    @Override
    public User getUserById(int id) {
        throw new UnsupportedOperationException("getUserById not implemented yet.");
    }

    @Override
    public boolean updateUserProfile(User user) {
        throw new UnsupportedOperationException("updateUserProfile not implemented yet.");
    }

    @Override
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        throw new UnsupportedOperationException("changePassword not implemented yet.");
    }

    @Override
    public boolean updateUserAvatar(int userId, String avatarPath) {
        throw new UnsupportedOperationException("updateUserAvatar not implemented yet.");
    }
}
