package com.yycy.service;

import com.yycy.entity.Product;
import java.util.List;

/**
 * IProductService.java
 * 作用：定义商品相关业务逻辑的服务接口。
 * 包含商品查询、搜索等业务方法声明。
 */
public interface IProductService {

    /**
     * 获取所有商品列表。
     *
     * @return 所有商品的 List 集合。
     */
    List<Product> getAllProducts();

    /**
     * 根据商品ID获取商品详情。
     *
     * @param id 商品ID
     * @return 如果找到商品，返回 Product 对象；否则返回 null。
     */
    Product getProductById(int id);

    /**
     * 根据商品名称进行模糊搜索。
     *
     * @param nameKeyword 搜索关键词
     * @return 匹配关键词的商品 List 集合，如果没有匹配项则返回空 List。
     */
    List<Product> searchProductsByName(String nameKeyword);

    // 根据需要，未来可以添加更多方法，例如：
    // boolean addProduct(Product product); // 如果需要添加商品功能
    // boolean updateProduct(Product product); // 如果需要修改商品功能
    // boolean deleteProduct(int id); // 如果需要删除商品功能
}
