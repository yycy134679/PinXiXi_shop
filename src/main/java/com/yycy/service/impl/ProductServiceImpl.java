package com.yycy.service.impl;

import com.yycy.dao.IProductDao;
import com.yycy.dao.impl.ProductDaoImpl;
import com.yycy.entity.Product;
import com.yycy.service.IProductService;
import java.util.List;
import java.util.ArrayList;

/**
 * ProductServiceImpl.java
 * IProductService 接口的实现类。
 * 处理商品查询等业务逻辑。
 */
public class ProductServiceImpl implements IProductService {

    // 依赖 IProductDao
    private IProductDao productDao = new ProductDaoImpl(); // 简单实例化

    @Override
    public List<Product> getAllProducts() {
        throw new UnsupportedOperationException("getAllProducts not implemented yet.");
    }

    @Override
    public Product getProductById(int id) {
        throw new UnsupportedOperationException("getProductById not implemented yet.");
    }

    @Override
    public List<Product> searchProductsByName(String nameKeyword) {
        throw new UnsupportedOperationException("searchProductsByName not implemented yet.");
    }
}
