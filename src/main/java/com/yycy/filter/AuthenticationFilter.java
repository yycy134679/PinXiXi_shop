package com.yycy.filter;

import com.yycy.entity.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * AuthenticationFilter.java
 * 作用：认证过滤器，用于检查用户是否登录，并保护需要登录才能访问的资源。
 */
public class AuthenticationFilter implements Filter {

    // 需要保护的路径列表 (后续根据实际 Servlet 路径和操作进行精确定义)
    private Set<String> protectedPaths;
    // 公共路径或不需要认证的路径 (例如登录页、注册页、静态资源等)
    private Set<String> publicPaths;
    // 静态资源路径前缀
    private Set<String> staticResourcePrefixes;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化受保护路径 (示例，需要根据实际情况调整)
        protectedPaths = new HashSet<>(Arrays.asList(
                "/profile",
                "/cart",
                "/checkout",
                "/submitOrder"));

        // 初始化公共路径 (示例)
        publicPaths = new HashSet<>(Arrays.asList(
                "/login",
                "/register",
                "/logout",
                "/home",
                "/index",
                "/index.jsp",
                "/productDetail"));

        // 初始化静态资源路径前缀 (示例)
        staticResourcePrefixes = new HashSet<>(Arrays.asList(
                "/css/",
                "/js/",
                "/images/"));

        Filter.super.init(filterConfig);
        System.out.println("AuthenticationFilter initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 这里只做骨架，直接放行
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
        System.out.println("AuthenticationFilter destroyed.");
    }
}
