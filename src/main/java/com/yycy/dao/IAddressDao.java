package com.yycy.dao;

import com.yycy.entity.Address;
import java.sql.SQLException;

/**
 * IAddressDao.java
 * 作用：定义地址数据访问操作的接口。
 * 包含对地址表（address）进行查询、保存、更新等操作的方法声明。
 */
public interface IAddressDao {

    /**
     * 根据用户ID查找地址（单一地址管理）。
     * 
     * @param userId 用户ID
     * @return Address对象，未找到返回null
     * @throws SQLException 数据库异常
     */
    Address findByUserId(int userId) throws SQLException;

    /**
     * 保存新地址。
     * 
     * @param address 地址对象
     * @throws SQLException 数据库异常
     */
    void save(Address address) throws SQLException;

    /**
     * 更新地址。
     * 
     * @param address 地址对象
     * @throws SQLException 数据库异常
     */
    void update(Address address) throws SQLException;

    // 可扩展：如需删除功能，可添加 void deleteByUserId(int userId) throws SQLException;
}
