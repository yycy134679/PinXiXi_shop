package com.yycy.controller;

import com.yycy.service.IUserService;
import com.yycy.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 用户注册信息校验控制器 ValidationServlet
 * 负责处理用户注册时的校验请求
 * 该Servlet会根据请求参数中的校验类型（用户名或手机号）进行相应的校验，并返回结果
 */

@WebServlet("/validate")
public class ValidationServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String json;
        if ("username".equals(type)) {
            boolean available = userService.isUsernameAvailable(value);
            if (available) {
                json = "{\"available\":true}";
            } else {
                json = "{\"available\":false,\"message\":\"用户名已被占用\"}";
            }
        } else if ("phone".equals(type)) {
            boolean available = userService.isPhoneAvailable(value);
            if (available) {
                json = "{\"available\":true}";
            } else {
                json = "{\"available\":false,\"message\":\"手机号已被注册\"}";
            }
        } else {
            json = "{\"available\":false,\"message\":\"未知校验类型\"}";
        }
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
