package com.yycy.dao.impl;

import com.yycy.dao.IProductDao;
import com.yycy.entity.Product;
import com.yycy.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

/**
 * 产品数据访问对象实现类
 * IProductDao 接口的 Java数据库连接（JDBC） 实现类。
 * 负责商品表（products）的具体数据库操作。
 */
public class ProductDaoImpl implements IProductDao {

    @Override
    public List<Product> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT id, name, description, price, image_url, sales_volume, created_at, updated_at FROM products ORDER BY id ASC";
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to obtain database connection.");
            }
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setSalesVolume(rs.getInt("sales_volume"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                product.setUpdatedAt(rs.getTimestamp("updated_at"));
                productList.add(product);
            }
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return productList;
    }

    @Override
    public Product findById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Product product = null;
        String sql = "SELECT id, name, description, price, image_url, sales_volume, created_at, updated_at FROM products WHERE id = ?";
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to obtain database connection.");
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setSalesVolume(rs.getInt("sales_volume"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                product.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return product;
    }

    @Override
    public List<Product> findByNameContaining(String nameKeyword) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT id, name, description, price, image_url, sales_volume, created_at, updated_at FROM products WHERE name LIKE ? ORDER BY id ASC";
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to obtain database connection.");
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + nameKeyword + "%");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setSalesVolume(rs.getInt("sales_volume"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                product.setUpdatedAt(rs.getTimestamp("updated_at"));
                productList.add(product);
            }
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return productList;
    }
}
