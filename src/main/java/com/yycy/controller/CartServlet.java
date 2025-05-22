package com.yycy.controller;

import com.yycy.entity.Cart;
import com.yycy.service.ICartService;
import com.yycy.service.impl.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 购物车控制器 CartServlet
 * 负责处理购物车相关的请求，包括：
 * 1. 查看购物车 (action=view 或无 action)
 * 2. 添加商品到购物车 (action=add)
 * 3. 从购物车移除商品 (action=remove)
 * 4. 更新购物车中商品数量 (action=update)
 * 5. 清空购物车 (action=clear)
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // 注入 ICartService
    private ICartService cartService = new CartServiceImpl();

    /**
     * 处理 GET 请求
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== CartServlet doGet START ===");

        // 获取 action 参数，默认为 "view"
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }
        System.out.println("CartServlet - Action: " + action);

        // 获取 HttpSession
        HttpSession session = request.getSession();

        // 根据 action 参数分别处理不同的购物车操作
        switch (action) {
            case "add":
                addToCart(request, response, session);
                break;
            case "remove":
                removeFromCart(request, response, session);
                break;
            case "update":
                updateCart(request, response, session);
                break;
            case "clear":
                clearCart(request, response, session);
                break;
            case "view":
            default:
                viewCart(request, response, session);
                break;
        }

        System.out.println("=== CartServlet doGet END ===");
    }

    /**
     * 处理 POST 请求，同 GET 请求处理
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * 添加商品到购物车
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        System.out.println("CartServlet - Add to cart operation");

        // 获取商品ID和数量参数
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // 确保数量大于0
            if (quantity <= 0) {
                quantity = 1;
            }

            System.out.println("CartServlet - Adding product ID: " + productId + " with quantity: " + quantity);

            // 添加商品到购物车
            cartService.addProductToCart(session, productId, quantity);

            // 添加成功消息
            session.setAttribute("cartMessage", "商品已成功加入购物车！");

            // 重定向回来源页面，如果没有则重定向到首页
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } catch (NumberFormatException e) {
            System.out.println(
                    "CartServlet - Invalid parameters: productId=" + productIdStr + ", quantity=" + quantityStr);
            e.printStackTrace();
            // 重定向到购物车页面
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    /**
     * 从购物车中移除商品
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        System.out.println("CartServlet - Remove from cart operation");

        // 获取商品ID参数
        String productIdStr = request.getParameter("productId");

        try {
            int productId = Integer.parseInt(productIdStr);
            System.out.println("CartServlet - Removing product ID: " + productId);

            // 从购物车移除商品
            cartService.removeProductFromCart(session, productId);

            // 添加成功消息
            session.setAttribute("cartMessage", "商品已从购物车移除！");

        } catch (NumberFormatException e) {
            System.out.println("CartServlet - Invalid productId: " + productIdStr);
            e.printStackTrace();
        }

        // 重定向到购物车页面
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    /**
     * 更新购物车中商品数量
     */
    private void updateCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        System.out.println("CartServlet - Update cart operation");

        // 获取商品ID和新数量参数
        String productIdStr = request.getParameter("productId");
        String newQuantityStr = request.getParameter("newQuantity");

        try {
            int productId = Integer.parseInt(productIdStr);
            int newQuantity = Integer.parseInt(newQuantityStr);

            System.out.println("CartServlet - Updating product ID: " + productId + " to quantity: " + newQuantity);

            // 更新购物车中商品数量
            cartService.updateProductQuantityInCart(session, productId, newQuantity);

            // 添加成功消息
            session.setAttribute("cartMessage", "购物车已更新！");

        } catch (NumberFormatException e) {
            System.out.println(
                    "CartServlet - Invalid parameters: productId=" + productIdStr + ", newQuantity=" + newQuantityStr);
            e.printStackTrace();
        }

        // 重定向到购物车页面
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    /**
     * 清空购物车
     */
    private void clearCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        System.out.println("CartServlet - Clear cart operation");

        // 清空购物车
        cartService.clearCart(session);

        // 添加成功消息
        session.setAttribute("cartMessage", "购物车已清空！");

        // 重定向到购物车页面
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    /**
     * 查看购物车
     */
    private void viewCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        System.out.println("CartServlet - View cart operation");

        // 获取购物车
        Cart cart = cartService.getCart(session);
        System.out.println("CartServlet - Cart items count: " + cart.getItems().size());

        // 将购物车对象存入 request 属性
        request.setAttribute("cart", cart);

        // 转发到购物车页面
        request.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(request, response);
    }
}