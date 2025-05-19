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
        // this.productService = new ProductServiceImpl();
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
        if (this.productService == null) {
            throw new IllegalStateException("ProductService is not initialized in CartServiceImpl.");
        }
        throw new UnsupportedOperationException("addProductToCart not implemented yet.");
    }

    @Override
    public void removeProductFromCart(HttpSession session, int productId) {
        throw new UnsupportedOperationException("removeProductFromCart not implemented yet.");
    }

    @Override
    public void updateProductQuantityInCart(HttpSession session, int productId, int newQuantity) {
        throw new UnsupportedOperationException("updateProductQuantityInCart not implemented yet.");
    }

    @Override
    public void clearCart(HttpSession session) {
        throw new UnsupportedOperationException("clearCart not implemented yet.");
    }
}
