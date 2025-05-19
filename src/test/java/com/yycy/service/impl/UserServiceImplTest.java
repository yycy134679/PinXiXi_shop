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

    @Test
    void register_shouldReturnTrueAndSaveUser_whenUsernameIsAvailable() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("newpass");
        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        boolean result = userService.register(newUser);
        assertTrue(result);
        verify(mockUserDao, times(1)).findByUsername(newUser.getUsername());
        verify(mockUserDao, times(1)).save(newUser);
    }

    @Test
    void register_shouldReturnFalse_whenUsernameAlreadyExists() throws Exception {
        User existingUser = new User();
        existingUser.setUsername("existinguser");
        existingUser.setPassword("anypassword");
        User userFromDao = new User();
        userFromDao.setUsername("existinguser");
        when(mockUserDao.findByUsername(existingUser.getUsername())).thenReturn(userFromDao);
        boolean result = userService.register(existingUser);
        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(existingUser.getUsername());
        verify(mockUserDao, never()).save(any(User.class));
    }

    @Test
    void register_shouldReturnFalse_whenDaoSaveThrowsSqlException() throws Exception {
        User newUser = new User();
        newUser.setUsername("newuser");
        newUser.setPassword("validpassword");
        when(mockUserDao.findByUsername(newUser.getUsername())).thenReturn(null);
        doThrow(new SQLException("Database save error")).when(mockUserDao).save(newUser);
        boolean result = userService.register(newUser);
        assertFalse(result);
        verify(mockUserDao, times(1)).findByUsername(newUser.getUsername());
        verify(mockUserDao, times(1)).save(newUser);
    }
}
