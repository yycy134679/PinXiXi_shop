package com.yycy.controller;

import com.yycy.entity.Product;
import com.yycy.service.IProductService;
import com.yycy.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 商品详情控制器 ProductDetailServlet
 * 负责处理商品详情页面的请求
 * 该Servlet会根据请求参数中的商品ID查询商品详情，并将结果转发到商品详情页面
 * 如果商品ID无效或商品不存在，则转发到商品未找到页面
 */

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== ProductDetailServlet doGet START ===");
        System.out.println("Servlet - Request URI: " + request.getRequestURI());
        System.out.println("Servlet - Received id parameter: " + request.getParameter("id"));
        String productIdStr = request.getParameter("id");
        System.out.println("Servlet - Processing product ID: " + productIdStr);
        int productId = -1;
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            System.out.println("Servlet - productIdStr is null or empty. Forwarding to productNotFound.jsp");
            request.getRequestDispatcher("/WEB-INF/jsp/productNotFound.jsp").forward(request, response);
            return;
        }
        try {
            productId = Integer.parseInt(productIdStr);
            System.out.println("Servlet - Parsed productId: " + productId);
        } catch (NumberFormatException e) {
            System.out.println("Servlet - NumberFormatException for productIdStr: '" + productIdStr
                    + "'. Forwarding to productNotFound.jsp");
            e.printStackTrace();
            request.setAttribute("productId", productIdStr);
            request.getRequestDispatcher("/WEB-INF/jsp/productNotFound.jsp").forward(request, response);
            return;
        }
        if (productId <= 0) {
            System.out.println(
                    "Servlet - productId is not positive: " + productId + ". Forwarding to productNotFound.jsp");
            request.setAttribute("productId", productIdStr);
            request.getRequestDispatcher("/WEB-INF/jsp/productNotFound.jsp").forward(request, response);
            return;
        }
        System.out.println("Servlet - Calling productService.getProductById with id: " + productId);
        Product product = productService.getProductById(productId);
        System.out.println("Servlet - Product from service: " + (product != null ? product.getName() : "NULL"));
        if (product == null) {
            System.out.println(
                    "Servlet - Product not found for id: " + productId + ". Forwarding to productNotFound.jsp");
            request.setAttribute("productId", productId);
            request.getRequestDispatcher("/WEB-INF/jsp/productNotFound.jsp").forward(request, response);
            return;
        }
        request.setAttribute("product", product);
        System.out.println("Servlet - Setting product attribute: " + (product != null ? product.getName() : "NULL"));

        System.out.println("Servlet - Calling productService.getAllProducts()");
        List<Product> allProducts = productService.getAllProducts();
        System.out.println("Servlet - allProductsForNav size: " + (allProducts != null ? allProducts.size() : "NULL"));
        request.setAttribute("allProductsForNav", allProducts);

        System.out.println("Servlet - Forwarding to productDetail.jsp with product: "
                + (product != null ? product.getName() : "NULL")
                + " and allProductsForNav size: " + (allProducts != null ? allProducts.size() : "NULL"));
        request.getRequestDispatcher("/WEB-INF/jsp/productDetail.jsp").forward(request, response);
        System.out.println("=== ProductDetailServlet doGet END ===");
    }
}
