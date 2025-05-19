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
        throw new UnsupportedOperationException("findByUserId not implemented yet.");
    }

    @Override
    public void save(Address address) throws SQLException {
        throw new UnsupportedOperationException("save not implemented yet.");
    }

    @Override
    public void update(Address address) throws SQLException {
        throw new UnsupportedOperationException("update not implemented yet.");
    }
}
