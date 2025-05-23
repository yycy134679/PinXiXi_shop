package com.yycy.dao.impl;

import com.yycy.dao.IAddressDao;
import com.yycy.entity.Address;
import com.yycy.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * AddressDaoImpl.java
 * IAddressDao 接口的 JDBC 实现类。
 * 负责地址表（addresses）的具体数据库操作。
 */
public class AddressDaoImpl implements IAddressDao {

    @Override
    public Address findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return extractAddressFromResultSet(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
    }

    @Override
    public void save(Address address) throws SQLException {
        String sql = "INSERT INTO addresses (user_id, province, city, district, detail_address, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, address.getUserId());
            stmt.setString(2, address.getProvince());
            stmt.setString(3, address.getCity());
            stmt.setString(4, address.getDistrict());
            stmt.setString(5, address.getDetailAddress());
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    @Override
    public void update(Address address) throws SQLException {
        String sql = "UPDATE addresses SET province = ?, city = ?, district = ?, detail_address = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, address.getProvince());
            stmt.setString(2, address.getCity());
            stmt.setString(3, address.getDistrict());
            stmt.setString(4, address.getDetailAddress());
            stmt.setInt(5, address.getId());
            stmt.executeUpdate();
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    // 辅助方法：从ResultSet中提取Address对象
    private Address extractAddressFromResultSet(ResultSet rs) throws SQLException {
        Address address = new Address();
        address.setId(rs.getInt("id"));
        address.setUserId(rs.getInt("user_id"));
        address.setProvince(rs.getString("province"));
        address.setCity(rs.getString("city"));
        address.setDistrict(rs.getString("district"));
        address.setDetailAddress(rs.getString("detail_address"));
        address.setCreatedAt(rs.getTimestamp("created_at"));
        address.setUpdatedAt(rs.getTimestamp("updated_at"));
        return address;
    }
}
