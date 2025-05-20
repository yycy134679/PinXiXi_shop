package com.yycy.dao.impl;

import com.yycy.dao.IUserDao;
import com.yycy.entity.User;
import org.junit.jupiter.api.*;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class UserDaoImplTest {
    private static IUserDao userDao;

    @BeforeAll
    static void setUp() {
        userDao = new UserDaoImpl();
    }

    @Test
    void testFindByUsername_existingUser() throws SQLException {
        User user = userDao.findByUsername("admin");
        assertNotNull(user, "admin 用户应存在");
        assertEquals("admin", user.getUsername());
        // 可根据实际数据库内容断言更多字段
    }

    @Test
    void testFindByUsername_nonexistentUser() throws SQLException {
        User user = userDao.findByUsername("nonexistentuser");
        assertNull(user, "不存在的用户应返回null");
    }

    @Test
    void testSaveAndFindById() throws SQLException {
        String testUsername = "newtestuser";
        String testPassword = "testpass123";
        User newUser = new User();
        newUser.setUsername(testUsername);
        newUser.setPassword(testPassword);
        // 保存新用户
        userDao.save(newUser);
        // 验证 findByUsername
        User saved = userDao.findByUsername(testUsername);
        assertNotNull(saved, "新用户应能查到");
        assertEquals(testUsername, saved.getUsername());
        assertEquals(testPassword, saved.getPassword());
        // 验证 findById
        int id = saved.getId();
        User byId = userDao.findById(id);
        assertNotNull(byId, "通过ID应能查到新用户");
        assertEquals(testUsername, byId.getUsername());
        // 清理（删除测试用户）
        deleteUserById(id);
    }

    @Test
    void testUpdate() throws SQLException {
        // 先查到一个已存在的用户
        User user = userDao.findByUsername("testuser2");
        assertNotNull(user, "testuser2 应存在");
        String oldNickname = user.getNickname();
        String newNickname = "测试昵称" + System.currentTimeMillis();
        user.setNickname(newNickname);
        user.setPhone("12345678900");
        userDao.update(user);
        // 再查一遍，断言已更新
        User updated = userDao.findById(user.getId());
        assertEquals(newNickname, updated.getNickname());
        assertEquals("12345678900", updated.getPhone());
        // 恢复原昵称，避免影响下次测试
        user.setNickname(oldNickname);
        userDao.update(user);
    }

    // 辅助方法：删除测试用户
    private void deleteUserById(int id) throws SQLException {
        java.sql.Connection conn = null;
        java.sql.PreparedStatement stmt = null;
        try {
            conn = com.yycy.util.DBUtil.getConnection();
            stmt = conn.prepareStatement("DELETE FROM users WHERE id = ?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } finally {
            com.yycy.util.DBUtil.close(conn, stmt);
        }
    }
}
