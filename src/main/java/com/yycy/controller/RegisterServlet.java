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
        System.out.println("--- RegisterServlet doPost ---"); // 标记开始
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        System.out.println("Received username: " + username);
        System.out.println("Received phone: " + phone);
        System.out.println("Received password: " + (password != null ? "******" : "null"));
        System.out.println("Received confirmPassword: " + (confirmPassword != null ? "******" : "null"));
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
        System.out.println("Validation errors: " + errors);

        if (!errors.isEmpty()) {
            System.out.println("Validation failed, forwarding back to register.jsp");
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
        System.out.println("Attempting to register user: " + user.getUsername() + ", phone: " + user.getPhone());

        // 进一步后端唯一性校验，细化错误提示
        boolean hasError = false;
        if (userService instanceof com.yycy.service.impl.UserServiceImpl) {
            com.yycy.service.impl.UserServiceImpl impl = (com.yycy.service.impl.UserServiceImpl) userService;
            if (impl.checkUsernameExists(username)) {
                errors.put("username", "用户名已存在，请更换用户名");
                hasError = true;
            }
            if (impl.checkPhoneExists(phone)) {
                errors.put("phone", "该手机号已被注册");
                hasError = true;
            }
        }
        if (hasError) {
            System.out.println("Validation failed, forwarding back to register.jsp");
            System.out.println("Validation errors: " + errors);
            request.setAttribute("errors", errors);
            request.setAttribute("username", username);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        boolean success = userService.register(user);
        System.out.println("userService.register() returned: " + success);
        if (success) {
            System.out.println("Registration successful. Attempting to login and redirect to profile.");
            // 注册成功后自动登录
            User registeredUser = userService.login(username, password);
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", registeredUser);
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            System.out.println("Registration failed. Forwarding back to register.jsp with error message.");
            // 兜底：理论上不会走到这里，除非数据库异常
            errors.put("errorMessage", "注册失败，请稍后再试");
            request.setAttribute("errors", errors);
            request.setAttribute("username", username);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
