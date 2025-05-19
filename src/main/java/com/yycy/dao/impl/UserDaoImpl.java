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
 * IUserDao 接口的 JDBC 实现类。
 * 负责用户表（users）的具体数据库操作。
 */
public class UserDaoImpl implements IUserDao {

    @Override
    public User findByUsername(String username) throws SQLException {
        throw new UnsupportedOperationException("findByUsername not implemented yet.");
    }

    @Override
    public User findById(int id) throws SQLException {
        throw new UnsupportedOperationException("findById not implemented yet.");
    }

    @Override
    public void save(User user) throws SQLException {
        throw new UnsupportedOperationException("save not implemented yet.");
    }

    @Override
    public void update(User user) throws SQLException {
        throw new UnsupportedOperationException("update not implemented yet.");
    }
}
