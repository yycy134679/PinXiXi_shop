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
        try {
            User user = userDao.findByUsername(username);
            if (user == null) {
                return null;
            }
            if (user.getPassword() != null && user.getPassword().equals(password)) {
                return user;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean register(User user) {
        try {
            // 1. 检查用户名是否已存在
            if (user == null || user.getUsername() == null || user.getPassword() == null || user.getPhone() == null) {
                return false;
            }
            User exist = userDao.findByUsername(user.getUsername());
            if (exist != null) {
                return false;
            }
            // 2. 检查手机号是否已存在
            User existPhone = userDao.findByPhone(user.getPhone());
            if (existPhone != null) {
                return false;
            }
            // 3. 校验密码长度
            if (user.getPassword().length() < 6) {
                return false;
            }
            // 4. 保存用户
            userDao.save(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User getUserById(int id) {
        try {
            return userDao.findById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean updateUserProfile(User user) {
        try {
            userDao.update(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        try {
            User user = userDao.findById(userId);
            if (user == null || user.getPassword() == null || !user.getPassword().equals(oldPassword)) {
                return false;
            }
            if (newPassword == null || newPassword.length() < 6) {
                return false;
            }
            // 使用专门的updatePassword方法
            userDao.updatePassword(userId, newPassword);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateUserAvatar(int userId, String avatarPath) {
        try {
            // 使用专门的updateAvatar方法
            userDao.updateAvatar(userId, avatarPath);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isUsernameAvailable(String username) {
        try {
            return userDao.findByUsername(username) == null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isPhoneAvailable(String phone) {
        try {
            return userDao.findByPhone(phone) == null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isEmailAvailable(String email) {
        try {
            return userDao.findByEmail(email) == null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 新增：用户名是否存在
    public boolean checkUsernameExists(String username) {
        try {
            return userDao.findByUsername(username) != null;
        } catch (Exception e) {
            return false;
        }
    }

    // 新增：手机号是否存在
    public boolean checkPhoneExists(String phone) {
        try {
            return userDao.findByPhone(phone) != null;
        } catch (Exception e) {
            return false;
        }
    }

    // 新增：邮箱是否存在
    public boolean checkEmailExists(String email) {
        try {
            return userDao.findByEmail(email) != null;
        } catch (Exception e) {
            return false;
        }
    }
}
