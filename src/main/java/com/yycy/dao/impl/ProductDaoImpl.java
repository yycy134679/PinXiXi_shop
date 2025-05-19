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
 * ProductDaoImpl.java
 * IProductDao 接口的 JDBC 实现类。
 * 负责商品表（products）的具体数据库操作。
 */
public class ProductDaoImpl implements IProductDao {

    @Override
    public List<Product> findAll() throws SQLException {
        throw new UnsupportedOperationException("findAll not implemented yet.");
    }

    @Override
    public Product findById(int id) throws SQLException {
        throw new UnsupportedOperationException("findById not implemented yet.");
    }

    @Override
    public List<Product> findByNameContaining(String nameKeyword) throws SQLException {
        throw new UnsupportedOperationException("findByNameContaining not implemented yet.");
    }
}
