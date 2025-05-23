package com.yycy.service.impl;

import com.yycy.dao.IUserDao;
import com.yycy.entity.User;
import com.yycy.service.IUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceImplTest {

    @Mock
    private IUserDao mockUserDao;

    @InjectMocks
    private UserServiceImpl userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1);
        testUser.setUsername("testuser");
        testUser.setPassword("password123");
        testUser.setNickname("测试用户");
        testUser.setEmail("test@example.com");
        testUser.setPhone("13800138000");
        testUser.setGender("男");
        testUser.setAvatarPath("images/tou_xiang/test.jpg");
    }

    // ==================== 登录测试 ====================
    @Test
    void login_shouldReturnUser_whenUsernameAndPasswordAreCorrect() throws Exception {
        String username = "testuser";
        String password = "password123";
        User expectedUser = new User();
        expectedUser.setId(1);
        expectedUser.setUsername(username);
        expectedUser.setPassword(password);
        when(mockUserDao.findByUsername(username)).thenReturn(expectedUser);

        User actualUser = userService.login(username, password);

        assertNotNull(actualUser);
        assertEquals(expectedUser.getId(), actualUser.getId());
        assertEquals(expectedUser.getUsername(), actualUser.getUsername());
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void login_shouldReturnNull_whenPasswordIsIncorrect() throws Exception {
        String username = "testuser";
        String correctPassword = "correctpassword";
        String wrongPassword = "wrongpassword";
        User userFromDao = new User();
        userFromDao.setUsername(username);
        userFromDao.setPassword(correctPassword);
        when(mockUserDao.findByUsername(username)).thenReturn(userFromDao);

        User actualUser = userService.login(username, wrongPassword);

        assertNull(actualUser);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void login_shouldReturnNull_whenUserNotFound() throws Exception {
        String username = "nonexistentuser";
        String password = "anypassword";
        when(mockUserDao.findByUsername(username)).thenReturn(null);

        User actualUser = userService.login(username, password);

        assertNull(actualUser);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void login_shouldReturnNull_whenDaoThrowsSqlException() throws Exception {
        String username = "testuser";
        String password = "password123";
        when(mockUserDao.findByUsername(username)).thenThrow(new SQLException("Database error"));

        User actualUser = userService.login(username, password);

        assertNull(actualUser);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    // ==================== 注册测试 ====================
    @Test
    void register_shouldReturnTrue_whenAllValidationsPass() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("validpassword");
        newUser.setPhone("13900139000");

        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        when(mockUserDao.findByPhone(newUser.getPhone())).thenReturn(null);

        boolean result = userService.register(newUser);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByUsername(newUser.getUsername());
        verify(mockUserDao, times(1)).findByPhone(newUser.getPhone());
        verify(mockUserDao, times(1)).save(newUser);
    }

    @Test
    void register_shouldReturnFalse_whenUsernameAlreadyExists() throws Exception {
        User existingUser = new User();
        existingUser.setUsername("existinguser");
        existingUser.setPassword("anypassword");
        existingUser.setPhone("13900139000");

        User userFromDao = new User();
        userFromDao.setUsername("existinguser");
        when(mockUserDao.findByUsername(existingUser.getUsername())).thenReturn(userFromDao);

        boolean result = userService.register(existingUser);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(existingUser.getUsername());
        verify(mockUserDao, never()).save(any(User.class));
    }

    @Test
    void register_shouldReturnFalse_whenPhoneAlreadyExists() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("validpassword");
        newUser.setPhone("13900139000");

        User existingPhoneUser = new User();
        existingPhoneUser.setPhone("13900139000");

        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        when(mockUserDao.findByPhone(newUser.getPhone())).thenReturn(existingPhoneUser);

        boolean result = userService.register(newUser);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(newUser.getUsername());
        verify(mockUserDao, times(1)).findByPhone(newUser.getPhone());
        verify(mockUserDao, never()).save(any(User.class));
    }

    @Test
    void register_shouldReturnFalse_whenPasswordTooShort() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("123"); // 少于6位
        newUser.setPhone("13900139000");

        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        when(mockUserDao.findByPhone(newUser.getPhone())).thenReturn(null);

        boolean result = userService.register(newUser);

        assertFalse(result);
        verify(mockUserDao, never()).save(any(User.class));
    }

    @Test
    void register_shouldReturnFalse_whenUserIsNull() throws Exception {
        boolean result = userService.register(null);

        assertFalse(result);
        verify(mockUserDao, never()).save(any(User.class));
    }

    @Test
    void register_shouldReturnFalse_whenDaoSaveThrowsSqlException() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("validpassword");
        newUser.setPhone("13900139000");

        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        when(mockUserDao.findByPhone(newUser.getPhone())).thenReturn(null);
        doThrow(new SQLException("Database save error")).when(mockUserDao).save(newUser);

        boolean result = userService.register(newUser);

        assertFalse(result);
        verify(mockUserDao, times(1)).save(newUser);
    }

    // ==================== 获取用户信息测试 ====================
    @Test
    void getUserById_shouldReturnUser_whenUserExists() throws Exception {
        int userId = 1;
        when(mockUserDao.findById(userId)).thenReturn(testUser);

        User result = userService.getUserById(userId);

        assertNotNull(result);
        assertEquals(testUser.getId(), result.getId());
        assertEquals(testUser.getUsername(), result.getUsername());
        verify(mockUserDao, times(1)).findById(userId);
    }

    @Test
    void getUserById_shouldReturnNull_whenUserNotExists() throws Exception {
        int userId = 999;
        when(mockUserDao.findById(userId)).thenReturn(null);

        User result = userService.getUserById(userId);

        assertNull(result);
        verify(mockUserDao, times(1)).findById(userId);
    }

    @Test
    void getUserById_shouldReturnNull_whenDaoThrowsException() throws Exception {
        int userId = 1;
        when(mockUserDao.findById(userId)).thenThrow(new SQLException("Database error"));

        User result = userService.getUserById(userId);

        assertNull(result);
        verify(mockUserDao, times(1)).findById(userId);
    }

    // ==================== 更新用户资料测试 ====================
    @Test
    void updateUserProfile_shouldReturnTrue_whenUpdateSuccessful() throws Exception {
        User userToUpdate = new User();
        userToUpdate.setId(1);
        userToUpdate.setNickname("新昵称");
        userToUpdate.setEmail("new@example.com");
        userToUpdate.setPhone("13900139001");
        userToUpdate.setGender("女");

        boolean result = userService.updateUserProfile(userToUpdate);

        assertTrue(result);
        verify(mockUserDao, times(1)).update(userToUpdate);
    }

    @Test
    void updateUserProfile_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        User userToUpdate = new User();
        userToUpdate.setId(1);

        doThrow(new SQLException("Update failed")).when(mockUserDao).update(userToUpdate);

        boolean result = userService.updateUserProfile(userToUpdate);

        assertFalse(result);
        verify(mockUserDao, times(1)).update(userToUpdate);
    }

    // ==================== 修改密码测试 ====================
    @Test
    void changePassword_shouldReturnTrue_whenOldPasswordCorrectAndNewPasswordValid() throws Exception {
        int userId = 1;
        String oldPassword = "oldpass123";
        String newPassword = "newpass123";

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setPassword(oldPassword);

        when(mockUserDao.findById(userId)).thenReturn(existingUser);

        boolean result = userService.changePassword(userId, oldPassword, newPassword);

        assertTrue(result);
        verify(mockUserDao, times(1)).findById(userId);
        verify(mockUserDao, times(1)).updatePassword(userId, newPassword);
    }

    @Test
    void changePassword_shouldReturnFalse_whenOldPasswordIncorrect() throws Exception {
        int userId = 1;
        String oldPassword = "wrongpass";
        String newPassword = "newpass123";

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setPassword("correctpass");

        when(mockUserDao.findById(userId)).thenReturn(existingUser);

        boolean result = userService.changePassword(userId, oldPassword, newPassword);

        assertFalse(result);
        verify(mockUserDao, times(1)).findById(userId);
        verify(mockUserDao, never()).updatePassword(anyInt(), anyString());
    }

    @Test
    void changePassword_shouldReturnFalse_whenNewPasswordTooShort() throws Exception {
        int userId = 1;
        String oldPassword = "oldpass123";
        String newPassword = "123"; // 少于6位

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setPassword(oldPassword);

        when(mockUserDao.findById(userId)).thenReturn(existingUser);

        boolean result = userService.changePassword(userId, oldPassword, newPassword);

        assertFalse(result);
        verify(mockUserDao, times(1)).findById(userId);
        verify(mockUserDao, never()).updatePassword(anyInt(), anyString());
    }

    @Test
    void changePassword_shouldReturnFalse_whenUserNotFound() throws Exception {
        int userId = 999;
        String oldPassword = "oldpass123";
        String newPassword = "newpass123";

        when(mockUserDao.findById(userId)).thenReturn(null);

        boolean result = userService.changePassword(userId, oldPassword, newPassword);

        assertFalse(result);
        verify(mockUserDao, times(1)).findById(userId);
        verify(mockUserDao, never()).updatePassword(anyInt(), anyString());
    }

    @Test
    void changePassword_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        int userId = 1;
        String oldPassword = "oldpass123";
        String newPassword = "newpass123";

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setPassword(oldPassword);

        when(mockUserDao.findById(userId)).thenReturn(existingUser);
        doThrow(new SQLException("Update failed")).when(mockUserDao).updatePassword(userId, newPassword);

        boolean result = userService.changePassword(userId, oldPassword, newPassword);

        assertFalse(result);
        verify(mockUserDao, times(1)).updatePassword(userId, newPassword);
    }

    // ==================== 更新头像测试 ====================
    @Test
    void updateUserAvatar_shouldReturnTrue_whenUpdateSuccessful() throws Exception {
        int userId = 1;
        String avatarPath = "images/tou_xiang/new_avatar.jpg";

        boolean result = userService.updateUserAvatar(userId, avatarPath);

        assertTrue(result);
        verify(mockUserDao, times(1)).updateAvatar(userId, avatarPath);
    }

    @Test
    void updateUserAvatar_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        int userId = 1;
        String avatarPath = "images/tou_xiang/new_avatar.jpg";

        doThrow(new SQLException("Update failed")).when(mockUserDao).updateAvatar(userId, avatarPath);

        boolean result = userService.updateUserAvatar(userId, avatarPath);

        assertFalse(result);
        verify(mockUserDao, times(1)).updateAvatar(userId, avatarPath);
    }

    // ==================== 可用性检查测试 ====================
    @Test
    void isUsernameAvailable_shouldReturnTrue_whenUsernameNotExists() throws Exception {
        String username = "newuser";
        when(mockUserDao.findByUsername(username)).thenReturn(null);

        boolean result = userService.isUsernameAvailable(username);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void isUsernameAvailable_shouldReturnFalse_whenUsernameExists() throws Exception {
        String username = "existinguser";
        when(mockUserDao.findByUsername(username)).thenReturn(testUser);

        boolean result = userService.isUsernameAvailable(username);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void isUsernameAvailable_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        String username = "testuser";
        when(mockUserDao.findByUsername(username)).thenThrow(new SQLException("Database error"));

        boolean result = userService.isUsernameAvailable(username);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void isPhoneAvailable_shouldReturnTrue_whenPhoneNotExists() throws Exception {
        String phone = "13900139999";
        when(mockUserDao.findByPhone(phone)).thenReturn(null);

        boolean result = userService.isPhoneAvailable(phone);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByPhone(phone);
    }

    @Test
    void isPhoneAvailable_shouldReturnFalse_whenPhoneExists() throws Exception {
        String phone = "13800138000";
        when(mockUserDao.findByPhone(phone)).thenReturn(testUser);

        boolean result = userService.isPhoneAvailable(phone);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByPhone(phone);
    }

    @Test
    void isPhoneAvailable_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        String phone = "13800138000";
        when(mockUserDao.findByPhone(phone)).thenThrow(new SQLException("Database error"));

        boolean result = userService.isPhoneAvailable(phone);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByPhone(phone);
    }

    @Test
    void isEmailAvailable_shouldReturnTrue_whenEmailNotExists() throws Exception {
        String email = "new@example.com";
        when(mockUserDao.findByEmail(email)).thenReturn(null);

        boolean result = userService.isEmailAvailable(email);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByEmail(email);
    }

    @Test
    void isEmailAvailable_shouldReturnFalse_whenEmailExists() throws Exception {
        String email = "test@example.com";
        when(mockUserDao.findByEmail(email)).thenReturn(testUser);

        boolean result = userService.isEmailAvailable(email);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByEmail(email);
    }

    @Test
    void isEmailAvailable_shouldReturnFalse_whenDaoThrowsException() throws Exception {
        String email = "test@example.com";
        when(mockUserDao.findByEmail(email)).thenThrow(new SQLException("Database error"));

        boolean result = userService.isEmailAvailable(email);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByEmail(email);
    }

    // ==================== 辅助方法测试 ====================
    @Test
    void checkUsernameExists_shouldReturnTrue_whenUsernameExists() throws Exception {
        String username = "existinguser";
        when(mockUserDao.findByUsername(username)).thenReturn(testUser);

        boolean result = userService.checkUsernameExists(username);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void checkUsernameExists_shouldReturnFalse_whenUsernameNotExists() throws Exception {
        String username = "newuser";
        when(mockUserDao.findByUsername(username)).thenReturn(null);

        boolean result = userService.checkUsernameExists(username);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(username);
    }

    @Test
    void checkPhoneExists_shouldReturnTrue_whenPhoneExists() throws Exception {
        String phone = "13800138000";
        when(mockUserDao.findByPhone(phone)).thenReturn(testUser);

        boolean result = userService.checkPhoneExists(phone);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByPhone(phone);
    }

    @Test
    void checkPhoneExists_shouldReturnFalse_whenPhoneNotExists() throws Exception {
        String phone = "13900139999";
        when(mockUserDao.findByPhone(phone)).thenReturn(null);

        boolean result = userService.checkPhoneExists(phone);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByPhone(phone);
    }

    @Test
    void checkEmailExists_shouldReturnTrue_whenEmailExists() throws Exception {
        String email = "test@example.com";
        when(mockUserDao.findByEmail(email)).thenReturn(testUser);

        boolean result = userService.checkEmailExists(email);

        assertTrue(result);
        verify(mockUserDao, times(1)).findByEmail(email);
    }

    @Test
    void checkEmailExists_shouldReturnFalse_whenEmailNotExists() throws Exception {
        String email = "new@example.com";
        when(mockUserDao.findByEmail(email)).thenReturn(null);

        boolean result = userService.checkEmailExists(email);

        assertFalse(result);
        verify(mockUserDao, times(1)).findByEmail(email);
    }
}
