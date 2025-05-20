package com.yycy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 数据库工具类，提供获取和关闭数据库连接的方法。
 */
public class DBUtil {
    // 数据库连接参数（生产环境建议使用配置文件或环境变量）
    private static final String URL = "jdbc:mysql://localhost:3306/pinxixi_shop?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    /**
     * 获取数据库连接
     * 
     * @return Connection对象，获取失败时返回null
     */
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("数据库驱动加载失败: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("数据库连接失败: " + e.getMessage());
        }
        return null;
    }

    /**
     * 关闭数据库资源（Connection, Statement, ResultSet）
     */
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println("关闭ResultSet失败: " + e.getMessage());
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                System.err.println("关闭Statement失败: " + e.getMessage());
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("关闭Connection失败: " + e.getMessage());
            }
        }
    }

    /**
     * 关闭数据库资源（Connection, Statement）
     */
    public static void close(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }
}
