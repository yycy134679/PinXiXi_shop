package com.yycy.util;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * DBUtilTest.java
 * 作用：测试 DBUtil 类中的数据库连接功能。
 */
class DBUtilTest {

    private Connection connection;

    @BeforeEach
    void setUp() {
        // 在每个测试方法执行前，尝试获取连接
        // 这样如果连接失败，测试会立即失败，而不是在断言处
        try {
            connection = DBUtil.getConnection();
        } catch (Exception e) { // DBUtil.getConnection() 内部处理了 SQLException 并返回 null
            // 但这里我们捕获任何可能的运行时异常，以防万一
            connection = null; // 确保 connection 为 null 以便后续断言
            System.err.println("Setup failed to get connection: " + e.getMessage());
        }
    }

    @AfterEach
    void tearDown() {
        // 在每个测试方法执行后，确保关闭连接
        if (connection != null) {
            // 使用 DBUtil 的 close 方法关闭连接
            // 由于我们只有 Connection 对象，Statement 和 ResultSet 传入 null
            DBUtil.close(connection, null, null);
            System.out.println("Connection closed after test.");
        }
    }

    @Test
    void testGetConnection_ShouldReturnNonNullAndValidConnection() {
        // 断言连接不为 null
        assertNotNull(connection, "DBUtil.getConnection() should return a non-null connection.");

        // 如果连接不为 null，进一步检查连接是否有效
        if (connection != null) {
            try {
                assertTrue(connection.isValid(1), "Database connection should be valid.");
                System.out.println("Successfully obtained a valid database connection!");
            } catch (SQLException e) {
                fail("SQLException occurred while checking connection validity: " + e.getMessage());
            }
        }
    }

    @Test
    void testGetConnection_WhenCalledMultipleTimes_ShouldWork() {
        // 第一个连接已在 setUp 中获取并会在 tearDown 中关闭
        assertNotNull(connection, "First connection attempt should succeed.");

        Connection secondConnection = null;
        try {
            secondConnection = DBUtil.getConnection();
            assertNotNull(secondConnection, "Second connection attempt should also succeed.");
            // 简单验证第二个连接
            if (secondConnection != null) {
                assertTrue(secondConnection.isValid(1), "Second connection should be valid.");
            }
        } catch (SQLException e) {
            fail("SQLException on second connection attempt: " + e.getMessage());
        } finally {
            if (secondConnection != null) {
                DBUtil.close(secondConnection, null, null);
                System.out.println("Second connection closed.");
            }
        }
    }
}

