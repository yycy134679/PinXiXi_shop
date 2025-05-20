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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        Map<String, String> errors = new HashMap<>();

        // 后端校验
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "用户名不能为空");
        }
        if (password == null || password.length() < 6) {
            errors.put("password", "密码长度不能少于6位");
        }
        if (confirmPassword == null || !confirmPassword.equals(password)) {
            errors.put("confirmPassword", "两次输入的密码不一致");
        }
        if (phone == null || !phone.matches("^1[3-9]\\d{9}$")) {
            errors.put("phone", "请输入有效的11位手机号");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("username", username);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // 注册逻辑
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setPhone(phone);
        boolean success = userService.register(user);
        if (success) {
            // 注册成功后自动登录
            User registeredUser = userService.login(username, password);
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", registeredUser);
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("errorMessage", "用户名已存在，请更换用户名");
            request.setAttribute("username", username);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
