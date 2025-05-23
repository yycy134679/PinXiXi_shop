package com.yycy.controller;

import com.yycy.entity.Cart;
import com.yycy.entity.CartItem;
import com.yycy.entity.User;
import com.yycy.entity.Address;
import com.yycy.entity.Product;
import com.yycy.service.ICartService;
import com.yycy.service.IUserService;
import com.yycy.service.IAddressService;
import com.yycy.service.IProductService;
import com.yycy.service.impl.CartServiceImpl;
import com.yycy.service.impl.UserServiceImpl;
import com.yycy.service.impl.AddressServiceImpl;
import com.yycy.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;

/**
 * 支付结算控制器 CheckoutServlet
 * 负责处理支付相关的请求，包括：
 * 1. 展示结算页面 (GET请求)
 * 2. 处理支付操作 (POST请求)
 * 
 * 支持两种进入方式：
 * - 从购物车"去结算"
 * - 从商品详情页"立即购买"
 */
@WebServlet(urlPatterns = { "/checkout", "/submitOrder", "/paymentSuccess" })
public class CheckoutServlet extends HttpServlet {

    // 注入服务
    private ICartService cartService = new CartServiceImpl();
    private IUserService userService = new UserServiceImpl();
    private IAddressService addressService = new AddressServiceImpl();
    private IProductService productService = new ProductServiceImpl();

    /**
     * 处理 GET 请求 - 展示结算页面
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== CheckoutServlet doGet START ===");

        String requestURI = request.getRequestURI();
        String action = request.getParameter("action");

        // 处理支付成功页面
        if (requestURI.contains("/paymentSuccess") || "success".equals(action)) {
            showPaymentSuccess(request, response);
            return;
        }

        // 获取用户会话
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // 检查用户是否登录
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 获取用户地址信息
            Address userAddress = null;
            try {
                userAddress = addressService.getAddressByUserId(loggedInUser.getId());
            } catch (Exception e) {
                System.out.println("CheckoutServlet - 获取用户地址失败: " + e.getMessage());
                // 地址获取失败不影响结算流程，设置为null即可
            }
            request.setAttribute("userAddress", userAddress);

            // 判断进入路径：立即购买 vs 购物车结算
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            if (productIdStr != null && quantityStr != null) {
                // 从商品详情页"立即购买"进入
                handleBuyNow(request, response, session, productIdStr, quantityStr);
            } else {
                // 从购物车"去结算"进入
                handleCartCheckout(request, response, session);
            }
        } catch (Exception e) {
            System.out.println("CheckoutServlet - 处理结算请求时发生异常: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "系统繁忙，请稍后再试");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
            return;
        }

        System.out.println("=== CheckoutServlet doGet END ===");
    }

    /**
     * 处理立即购买
     */
    private void handleBuyNow(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, String productIdStr, String quantityStr)
            throws ServletException, IOException {
        System.out.println("CheckoutServlet - 处理立即购买");

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // 获取商品信息
            Product product = productService.getProductById(productId);
            if (product == null) {
                request.setAttribute("errorMessage", "商品不存在或已下架");
                request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
                return;
            }

            // 创建临时的购物车项
            CartItem buyNowItem = new CartItem(product, quantity);

            // 设置结算商品列表和总金额
            request.setAttribute("checkoutItems", Collections.singletonList(buyNowItem));
            request.setAttribute("checkoutTotal", buyNowItem.getSubtotal());

            // 在session中标记为立即购买
            session.setAttribute("isBuyNow", true);
            session.setAttribute("buyNowItem", buyNowItem);

            System.out.println("CheckoutServlet - 立即购买商品: " + product.getName() +
                    ", 数量: " + quantity + ", 总金额: " + buyNowItem.getSubtotal());

        } catch (NumberFormatException e) {
            System.out.println("CheckoutServlet - 参数格式错误: productId=" + productIdStr +
                    ", quantity=" + quantityStr);
            request.setAttribute("errorMessage", "参数格式错误");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
            return;
        }

        // 转发到结算页面
        request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
    }

    /**
     * 处理购物车结算
     */
    private void handleCartCheckout(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) throws ServletException, IOException {
        System.out.println("CheckoutServlet - 处理购物车结算");

        // 获取购物车
        Cart cart = cartService.getCart(session);

        // 检查购物车是否为空
        if (cart == null || cart.getItems().isEmpty()) {
            System.out.println("CheckoutServlet - 购物车为空，无法结算");
            session.setAttribute("cartMessage", "购物车为空，无法结算，请先添加商品到购物车");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // 设置结算商品列表和总金额
        request.setAttribute("checkoutItems", new ArrayList<>(cart.getItems().values()));
        request.setAttribute("checkoutTotal", cart.getTotalPrice());

        // 清除立即购买标记
        session.removeAttribute("isBuyNow");
        session.removeAttribute("buyNowItem");

        System.out.println("CheckoutServlet - 购物车结算，商品数量: " + cart.getItems().size() +
                ", 总金额: " + cart.getTotalPrice());

        // 转发到结算页面
        request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
    }

    /**
     * 处理 POST 请求 - 处理支付操作
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== CheckoutServlet doPost START ===");

        // 获取用户会话
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // 检查用户是否登录
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 模拟支付成功
        System.out.println("CheckoutServlet - 模拟支付成功");

        // 检查是否为立即购买
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        if (isBuyNow == null || !isBuyNow) {
            // 从购物车结算，清空购物车
            cartService.clearCart(session);
            System.out.println("CheckoutServlet - 购物车已清空");
        }

        // 清除立即购买相关的session属性
        session.removeAttribute("isBuyNow");
        session.removeAttribute("buyNowItem");

        // 设置支付成功消息
        session.setAttribute("paymentSuccessMessage", "支付成功！感谢您的购买！");

        // 重定向到支付成功页面
        response.sendRedirect(request.getContextPath() + "/paymentSuccess");

        System.out.println("=== CheckoutServlet doPost END ===");
    }

    /**
     * 显示支付成功页面
     */
    private void showPaymentSuccess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("CheckoutServlet - 显示支付成功页面");
        request.getRequestDispatcher("/WEB-INF/jsp/paymentSuccess.jsp").forward(request, response);
    }
}