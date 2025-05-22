package com.yycy.service.impl;

import com.yycy.entity.Cart;
import com.yycy.entity.Product;
import com.yycy.service.ICartService;
import com.yycy.service.IProductService;
import javax.servlet.http.HttpSession;

/**
 * CartServiceImpl.java
 * ICartService 接口的实现类。
 * 处理购物车操作业务，直接操作 HttpSession 中的 Cart 对象。
 */
public class CartServiceImpl implements ICartService {

    // 依赖 IProductService 来获取商品信息
    private IProductService productService;

    // 无参构造函数（可选，后续可直接 new ProductServiceImpl()）
    public CartServiceImpl() {
        this.productService = new ProductServiceImpl();
    }

    // 构造函数注入 ProductService
    public CartServiceImpl(IProductService productService) {
        this.productService = productService;
    }

    private static final String CART_SESSION_KEY = "shoppingCart";

    @Override
    public Cart getCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) {
            cart = new Cart();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        return cart;
    }

    @Override
    public void addProductToCart(HttpSession session, int productId, int quantity) {
        if (quantity <= 0) {
            return; // 不处理数量小于等于0的情况
        }

        // 获取购物车
        Cart cart = getCart(session);

        // 获取商品信息
        Product product = productService.getProductById(productId);

        // 如果商品存在，添加到购物车
        if (product != null) {
            cart.addItem(product, quantity);
        }
    }

    @Override
    public void removeProductFromCart(HttpSession session, int productId) {
        // 获取购物车
        Cart cart = getCart(session);

        // 从购物车中移除指定商品
        cart.removeItem(productId);
    }

    @Override
    public void updateProductQuantityInCart(HttpSession session, int productId, int newQuantity) {
        // 确保数量大于0
        if (newQuantity <= 0) {
            // 数量小于等于0，直接移除商品
            removeProductFromCart(session, productId);
            return;
        }

        // 获取购物车
        Cart cart = getCart(session);

        // 更新购物车中指定商品的数量
        cart.updateItemQuantity(productId, newQuantity);
    }

    @Override
    public void clearCart(HttpSession session) {
        // 获取购物车
        Cart cart = getCart(session);

        // 清空购物车
        cart.clearCart();
    }
}
