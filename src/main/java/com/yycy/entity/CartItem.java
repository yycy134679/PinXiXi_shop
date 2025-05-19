package com.yycy.entity;

import java.math.BigDecimal;

/**
 * CartItem.java
 * 作用：表示购物车中的一个商品项。
 * 包含具体的商品对象和该商品在购物车中的数量。
 * 还提供了计算该商品项小计金额的方法。
 * 这个类是非持久化的，其数据通常存储在用户的 Session 中。
 */
public class CartItem {

    private Product product; // 商品对象
    private int quantity; // 商品数量

    // 构造函数
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getter 和 Setter 方法
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * 计算当前商品项的小计金额 (商品单价 * 数量)
     * 
     * @return BigDecimal 小计金额
     */
    public BigDecimal getSubtotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(new BigDecimal(this.quantity));
        }
        return BigDecimal.ZERO; // 或者抛出异常，根据业务逻辑决定
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "product=" + (product != null ? product.getName() : "null") +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
