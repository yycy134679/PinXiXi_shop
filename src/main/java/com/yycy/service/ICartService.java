package com.yycy.service;

import com.yycy.entity.Cart;
import javax.servlet.http.HttpSession;

/**
 * ICartService.java
 * 作用：定义购物车相关业务逻辑的服务接口。
 * 包含获取购物车、添加商品、移除商品、更新数量、清空购物车等操作。
 * 注意：此服务的实现将直接操作 HttpSession 中的 Cart 对象。
 */
public interface ICartService {

    /**
     * 从 HttpSession 中获取购物车对象。
     * 如果 Session 中不存在购物车，则创建一个新的 Cart 对象并存入 Session。
     *
     * @param session 用户的 HttpSession 对象
     * @return Cart 对象
     */
    Cart getCart(HttpSession session);

    /**
     * 将指定商品添加到购物车。
     *
     * @param session   用户的 HttpSession 对象
     * @param productId 要添加的商品ID
     * @param quantity  要添加的数量
     */
    void addProductToCart(HttpSession session, int productId, int quantity);

    /**
     * 从购物车中移除指定商品。
     *
     * @param session   用户的 HttpSession 对象
     * @param productId 要移除的商品ID
     */
    void removeProductFromCart(HttpSession session, int productId);

    /**
     * 更新购物车中指定商品的数量。
     *
     * @param session     用户的 HttpSession 对象
     * @param productId   要更新数量的商品ID
     * @param newQuantity 新的数量
     */
    void updateProductQuantityInCart(HttpSession session, int productId, int newQuantity);

    /**
     * 清空购物车。
     *
     * @param session 用户的 HttpSession 对象
     */
    void clearCart(HttpSession session);
}
