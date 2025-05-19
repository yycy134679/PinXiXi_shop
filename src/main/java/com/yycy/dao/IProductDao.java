package com.yycy.dao;

import com.yycy.entity.Product;
import java.sql.SQLException;
import java.util.List;

/**
 * IProductDao.java
 * 作用：定义商品数据访问操作的接口。
 * 包含对商品表（products）进行查询等操作的方法声明。
 */
public interface IProductDao {

    /**
     * 获取所有商品列表。
     *
     * @return 包含所有 Product 对象的 List，如果数据库中没有商品则返回空 List。
     * @throws SQLException 如果数据库访问出错
     */
    List<Product> findAll() throws SQLException;

    /**
     * 根据商品ID查找商品。
     *
     * @param id 要查找的商品ID
     * @return 如果找到商品，则返回 Product 对象；否则返回 null。
     * @throws SQLException 如果数据库访问出错
     */
    Product findById(int id) throws SQLException;

    /**
     * 根据商品名称进行模糊搜索。
     *
     * @param nameKeyword 搜索关键词
     * @return 包含匹配 Product 对象的 List，如果未找到匹配商品则返回空 List。
     * @throws SQLException 如果数据库访问出错
     */
    List<Product> findByNameContaining(String nameKeyword) throws SQLException;

    // 可扩展：如需添加、修改、删除商品功能，可在此添加方法声明
}
