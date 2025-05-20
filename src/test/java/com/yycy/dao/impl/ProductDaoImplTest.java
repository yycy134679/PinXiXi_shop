package com.yycy.dao.impl;

import com.yycy.dao.IProductDao;
import com.yycy.entity.Product;
import com.yycy.util.DBUtil;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * ProductDaoImpl 集成测试
 * 依赖数据库 pinxixi_shop 的初始数据（请确保已导入 PinXiXi_shop.sql）
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ProductDaoImplTest {
    private static IProductDao productDao;

    @BeforeAll
    public static void setUp() {
        productDao = new ProductDaoImpl();
    }

    @Test
    @Order(1)
    public void testFindAll() throws SQLException {
        List<Product> products = productDao.findAll();
        assertNotNull(products, "findAll() 返回 null");
        // 查询数据库实际数量
        int dbCount = getProductsCountFromDB();
        assertEquals(dbCount, products.size(), "findAll() 返回的商品数量与数据库不一致");
        // 可选：验证部分属性
        Product first = products.get(0);
        assertNotNull(first.getName());
    }

    @Test
    @Order(2)
    public void testFindById_found() throws SQLException {
        Product product = productDao.findById(1);
        assertNotNull(product, "findById(1) 应该返回商品");
        assertEquals(1, product.getId());
        assertEquals("HUAWEI Mate 70", product.getName());
        // 可选：验证价格等属性
    }

    @Test
    @Order(3)
    public void testFindById_notFound() throws SQLException {
        Product product = productDao.findById(999);
        assertNull(product, "findById(999) 应该返回 null");
    }

    @Test
    @Order(4)
    public void testFindByNameContaining_multi() throws SQLException {
        List<Product> products = productDao.findByNameContaining("手办");
        assertNotNull(products);
        assertEquals(3, products.size(), "包含'手办'的商品应为3个");
        for (Product p : products) {
            assertTrue(p.getName().contains("手办"));
        }
    }

    @Test
    @Order(5)
    public void testFindByNameContaining_single() throws SQLException {
        List<Product> products = productDao.findByNameContaining("HUAWEI Mate 70");
        assertNotNull(products);
        assertEquals(1, products.size());
        assertEquals("HUAWEI Mate 70", products.get(0).getName());
    }

    @Test
    @Order(6)
    public void testFindByNameContaining_none() throws SQLException {
        List<Product> products = productDao.findByNameContaining("一个不存在的商品名XYZ");
        assertNotNull(products);
        assertEquals(0, products.size());
    }

    @Test
    @Order(7)
    public void testFindByNameContaining_caseInsensitive() throws SQLException {
        List<Product> products = productDao.findByNameContaining("iphone");
        assertNotNull(products);
        assertTrue(products.stream().anyMatch(p -> p.getName().equalsIgnoreCase("iPhone 16 Pro Max")));
    }

    // 辅助方法：获取数据库 products 表的实际记录数
    private int getProductsCountFromDB() throws SQLException {
        try (Connection conn = DBUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM products")) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
