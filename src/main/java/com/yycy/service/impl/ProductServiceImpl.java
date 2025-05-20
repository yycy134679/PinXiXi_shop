package com.yycy.service.impl;

import com.yycy.dao.IProductDao;
import com.yycy.dao.impl.ProductDaoImpl;
import com.yycy.entity.Product;
import com.yycy.service.IProductService;
import java.util.List;
import java.util.ArrayList;

/**
 * 产品服务实现类
 * IProductService 接口的实现类。
 * 处理商品查询等业务逻辑。
 */
public class ProductServiceImpl implements IProductService {

    // 依赖 IProductDao
    private IProductDao productDao = new ProductDaoImpl(); // 简单实例化

    @Override
    public List<Product> getAllProducts() {
        try {
            return productDao.findAll();
        } catch (Exception e) {
            System.err.println("[ProductServiceImpl] getAllProducts 数据库异常: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public Product getProductById(int id) {
        try {
            return productDao.findById(id);
        } catch (Exception e) {
            System.err.println("[ProductServiceImpl] getProductById 数据库异常: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Product> searchProductsByName(String nameKeyword) {
        if (nameKeyword == null || nameKeyword.trim().isEmpty()) {
            return getAllProducts();
        }
        try {
            return productDao.findByNameContaining(nameKeyword);
        } catch (Exception e) {
            System.err.println("[ProductServiceImpl] searchProductsByName 数据库异常: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
