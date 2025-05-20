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
 * 首页控制器 HomeServlet
 * 负责处理首页商品展示和搜索请求
 */
public class HomeServlet extends HttpServlet {
    private IProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchKeyword = request.getParameter("searchKeyword");
        List<Product> products;
        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            products = productService.getAllProducts();
        } else {
            products = productService.searchProductsByName(searchKeyword.trim());
            if (products == null || products.isEmpty()) {
                request.setAttribute("noResultsMessage", "抱歉，没有找到相关商品");
            }
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
