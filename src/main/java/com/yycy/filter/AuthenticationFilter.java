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
        System.out.println("--- AuthenticationFilter init START ---");
        // 初始化受保护路径 (示例，需要根据实际情况调整)
        protectedPaths = new HashSet<>(Arrays.asList(
                "/profile",
                "/cart",
                "/checkout",
                "/submitOrder"));
        System.out.println("AuthenticationFilter - protectedPaths initialized: " + protectedPaths);
        // 初始化公共路径 (示例)
        publicPaths = new HashSet<>(Arrays.asList(
                "/", // 根路径
                "/index.jsp", // 欢迎文件
                "/home", // 首页Servlet
                "/login",
                "/register",
                "/logout",
                "/productDetail",
                "/validate",
                "/favicon.ico")); // 添加favicon.ico到公共路径
        System.out.println("AuthenticationFilter - publicPaths initialized: " + publicPaths);
        // 初始化静态资源路径前缀 (示例)
        staticResourcePrefixes = new HashSet<>(Arrays.asList(
                "/css/",
                "/js/",
                "/images/",
                "/fonts/"));
        System.out.println("AuthenticationFilter - staticResourcePrefixes initialized: " + staticResourcePrefixes);
        // Filter.super.init(filterConfig); // 不需要
        System.out.println("AuthenticationFilter initialized.");
        System.out.println("--- AuthenticationFilter init END ---");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String servletPath = req.getServletPath();

        // 记录当前请求路径（调试用）
        System.out.println("AuthenticationFilter processing request for: " + servletPath);

        // 1. 静态资源直接放行
        for (String prefix : staticResourcePrefixes) {
            if (servletPath.startsWith(prefix)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // 2. 公共路径直接放行
        if (publicPaths.contains(servletPath)) {
            chain.doFilter(request, response);
            return;
        }

        // 3. 检查受保护路径的访问
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (protectedPaths.contains(servletPath)) {
            if (loggedInUser == null) {
                session = req.getSession();
                String query = req.getQueryString();
                String originalURL = req.getRequestURI() + (query != null ? ("?" + query) : "");
                session.setAttribute("redirectUrlAfterLogin", originalURL);
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // 4. 处理未明确定义的路径 (默认策略：也视为受保护)
        if (loggedInUser == null) {
            session = req.getSession();
            String query = req.getQueryString();
            String originalURL = req.getRequestURI() + (query != null ? ("?" + query) : "");
            session.setAttribute("redirectUrlAfterLogin", originalURL);
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        // 用户已登录，放行
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
        System.out.println("AuthenticationFilter destroyed.");
    }
}
