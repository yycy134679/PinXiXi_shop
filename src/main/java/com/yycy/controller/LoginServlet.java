package com.yycy.controller;

import com.yycy.entity.User;
import com.yycy.service.IUserService;
import com.yycy.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 登录控制器 LoginServlet
 * 负责处理用户登录请求，包括：
 * 1. 展示登录页面 (GET请求)
 * 2. 处理登录操作 (POST请求)
 */

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("LoginServlet: 处理登录请求 - 用户名: " + username);

        // 后端校验
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "用户名和密码不能为空");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return;
        }

        User loggedInUser = userService.login(username, password);
        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", loggedInUser);

            // 登录后重定向
            String redirectUrl = (String) session.getAttribute("redirectUrlAfterLogin");
            System.out.println("LoginServlet: 登录成功 - 用户: " + username + ", 重定向URL: " + redirectUrl);

            // 检查重定向URL是否是favicon.ico，如果是则直接跳转到首页
            if (redirectUrl != null && redirectUrl.contains("favicon.ico")) {
                System.out.println("LoginServlet: 检测到favicon.ico请求，忽略并重定向到首页");
                redirectUrl = null;
            }

            if (redirectUrl != null) {
                session.removeAttribute("redirectUrlAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("errorMessage", "用户名或密码错误");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
}
