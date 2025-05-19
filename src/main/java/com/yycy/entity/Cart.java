package com.yycy.entity;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Cart.java
 * 作用：表示用户的整个购物车。
 * 包含多个购物车项（CartItem），并提供管理这些项（增删改查）以及计算总价等功能。
 * 这个类是非持久化的，其数据通常存储在用户的 Session 中。
 */
public class Cart {

    // 使用 LinkedHashMap 存储购物车项，key 为商品ID (productId)，value 为 CartItem 对象
    // LinkedHashMap 可以保持商品加入购物车的顺序
    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    /**
     * 添加商品到购物车。
     * 如果商品已存在，则增加数量；否则，添加新的商品项。
     *
     * @param product  要添加的商品对象
     * @param quantity 添加的数量
     */
    public void addItem(Product product, int quantity) {
        if (product == null || quantity <= 0) {
            return; // 不处理无效输入
        }
        CartItem cartItem = items.get(product.getId());
        if (cartItem != null) {
            // 商品已存在，更新数量
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
        } else {
            // 商品不存在，添加新的 CartItem
            items.put(product.getId(), new CartItem(product, quantity));
        }
    }

    /**
     * 从购物车中移除指定商品ID的商品项。
     *
     * @param productId 要移除的商品ID
     */
    public void removeItem(int productId) {
        items.remove(productId);
    }

    /**
     * 更新购物车中指定商品ID的商品数量。
     * 如果数量小于等于0，则移除该商品项。
     *
     * @param productId   要更新的商品ID
     * @param newQuantity 新的数量
     */
    public void updateItemQuantity(int productId, int newQuantity) {
        CartItem cartItem = items.get(productId);
        if (cartItem != null) {
            if (newQuantity > 0) {
                cartItem.setQuantity(newQuantity);
            } else {
                // 如果数量更新为0或负数，则从购物车移除
                items.remove(productId);
            }
        }
    }

    /**
     * 清空购物车中所有的商品项。
     */
    public void clearCart() {
        items.clear();
    }

    /**
     * 计算购物车中所有商品的总金额。
     *
     * @return BigDecimal 总金额
     */
    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items.values()) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }

    /**
     * 获取购物车中所有商品项的Map。
     *
     * @return Map<Integer, CartItem> 商品项Map，键为商品ID
     */
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    /**
     * 获取购物车中商品的总件数（所有商品数量之和）。
     * 用于导航栏角标等。
     *
     * @return int 商品总件数
     */
    public int getTotalItemsCount() {
        int count = 0;
        for (CartItem item : items.values()) {
            count += item.getQuantity();
        }
        return count;
    }

    /**
     * 获取购物车中商品的种类数。
     *
     * @return int 商品种类数
     */
    public int getDistinctItemCount() {
        return items.size();
    }

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                ", totalPrice=" + getTotalPrice() +
                ", totalItemsCount=" + getTotalItemsCount() +
                '}';
    }
}
