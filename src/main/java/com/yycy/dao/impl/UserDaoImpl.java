package com.yycy.dao.impl;

import com.yycy.dao.IUserDao;
import com.yycy.entity.User;
import com.yycy.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * UserDaoImpl.java
 * IUserDao 接口的Java数据库连接（JDBC）实现类。
 * 负责用户表（users）的具体数据库操作。
 */
public class UserDaoImpl implements IUserDao {

    @Override
    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
    }

    @Override
    public User findById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
    }

    @Override
    public void save(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password, phone, created_at, updated_at) VALUES (?, ?, ?, NOW(), NOW())";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getPhone());
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    @Override
    public void update(User user) throws SQLException {
        String sql = "UPDATE users SET nickname=?, email=?, phone=?, gender=?, avatar_path=?, updated_at=NOW() WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getNickname());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getAvatarPath());
            stmt.setInt(6, user.getId());
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    @Override
    public User findByPhone(String phone) throws SQLException {
        String sql = "SELECT * FROM users WHERE phone = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
    }

    @Override
    public void updatePassword(int userId, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    @Override
    public void updateAvatar(int userId, String avatarPath) throws SQLException {
        String sql = "UPDATE users SET avatar_path = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, avatarPath);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    @Override
    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
    }

    // 辅助方法：从ResultSet中提取User对象
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setNickname(rs.getString("nickname"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setGender(rs.getString("gender"));
        user.setAvatarPath(rs.getString("avatar_path"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}
