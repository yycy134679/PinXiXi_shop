package com.yycy.controller;

import com.yycy.entity.Address;
import com.yycy.entity.User;
import com.yycy.service.IAddressService;
import com.yycy.service.IUserService;
import com.yycy.service.impl.AddressServiceImpl;
import com.yycy.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

/**
 * ProfileServlet.java
 * 个人中心控制器，处理用户个人信息管理、密码修改、头像上传、地址管理等功能
 */

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProfileServlet extends HttpServlet {

    private IUserService userService = new UserServiceImpl();
    private IAddressService addressService = new AddressServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 检查用户是否登录
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        try {
            switch (action) {
                case "view":
                default:
                    // 获取最新的用户信息和地址信息
                    User userDetails = userService.getUserById(loggedInUser.getId());
                    Address userAddress = addressService.getAddressByUserId(loggedInUser.getId());

                    request.setAttribute("userDetails", userDetails);
                    request.setAttribute("userAddress", userAddress);

                    request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "系统错误，请稍后重试");
            request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 检查用户是否登录
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        try {
            switch (action) {
                case "updateInfo":
                    handleUpdateInfo(request, response, loggedInUser);
                    break;
                case "changePassword":
                    handleChangePassword(request, response, loggedInUser);
                    break;
                case "uploadAvatar":
                    handleUploadAvatar(request, response, loggedInUser);
                    break;
                case "saveAddress":
                    handleSaveAddress(request, response, loggedInUser);
                    break;
                case "checkEmailAvailability":
                    handleCheckEmailAvailability(request, response, loggedInUser);
                    break;
                case "checkPhoneAvailability":
                    handleCheckPhoneAvailability(request, response, loggedInUser);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/profile");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "系统错误，请稍后重试");
            doGet(request, response);
        }
    }

    /**
     * 处理个人信息更新
     */
    private void handleUpdateInfo(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {

        String nickname = request.getParameter("nickname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");

        // 创建用户对象进行更新
        User userToUpdate = new User();
        userToUpdate.setId(loggedInUser.getId());
        userToUpdate.setUsername(loggedInUser.getUsername());
        userToUpdate.setNickname(nickname);
        userToUpdate.setPhone(phone);
        userToUpdate.setEmail(email);
        userToUpdate.setGender(gender);
        userToUpdate.setAvatarPath(loggedInUser.getAvatarPath());

        // 检查邮箱是否被其他用户使用
        if (email != null && !email.trim().isEmpty()) {
            User existingUser = userService.getUserById(loggedInUser.getId());
            if (!email.equals(existingUser.getEmail()) && !userService.isEmailAvailable(email)) {
                request.setAttribute("errorMessage", "该邮箱已被其他用户使用");
                doGet(request, response);
                return;
            }
        }

        // 检查手机号是否被其他用户使用
        if (phone != null && !phone.trim().isEmpty()) {
            // 验证手机号格式（11位数字）
            if (!phone.matches("^\\d{11}$")) {
                request.setAttribute("errorMessage", "请输入11位手机号码");
                doGet(request, response);
                return;
            }

            User existingUser = userService.getUserById(loggedInUser.getId());
            if (!phone.equals(existingUser.getPhone()) && !userService.isPhoneAvailable(phone)) {
                request.setAttribute("errorMessage", "该手机号已被其他用户使用");
                doGet(request, response);
                return;
            }
        }

        boolean success = userService.updateUserProfile(userToUpdate);

        if (success) {
            // 更新Session中的用户信息
            HttpSession session = request.getSession();
            loggedInUser.setNickname(nickname);
            loggedInUser.setPhone(phone);
            loggedInUser.setEmail(email);
            loggedInUser.setGender(gender);
            session.setAttribute("loggedInUser", loggedInUser);

            request.setAttribute("successMessage", "个人信息更新成功！");
        } else {
            request.setAttribute("errorMessage", "个人信息更新失败，请重试");
        }

        response.sendRedirect(request.getContextPath() + "/profile?tab=info&msg=" +
                (success ? "success" : "error"));
    }

    /**
     * 处理密码修改
     */
    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 验证输入
        if (oldPassword == null || newPassword == null || confirmPassword == null ||
                oldPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "请填写完整的密码信息");
            response.sendRedirect(request.getContextPath() + "/profile?tab=password&msg=error");
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "新密码长度不能少于6位");
            response.sendRedirect(request.getContextPath() + "/profile?tab=password&msg=error");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "两次输入的新密码不一致");
            response.sendRedirect(request.getContextPath() + "/profile?tab=password&msg=error");
            return;
        }

        boolean success = userService.changePassword(loggedInUser.getId(), oldPassword, newPassword);

        if (success) {
            request.setAttribute("successMessage", "密码修改成功！");
        } else {
            request.setAttribute("errorMessage", "旧密码错误或修改失败");
        }

        response.sendRedirect(request.getContextPath() + "/profile?tab=password&msg=" +
                (success ? "success" : "error"));
    }

    /**
     * 处理头像上传
     */
    private void handleUploadAvatar(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {

        Part filePart = request.getPart("avatarFile");

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "请选择要上传的头像文件");
            response.sendRedirect(request.getContextPath() + "/profile?tab=avatar&msg=error");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // 检查文件类型
        if (!isValidImageFile(fileName)) {
            request.setAttribute("errorMessage", "只支持JPG、PNG格式的图片文件");
            response.sendRedirect(request.getContextPath() + "/profile?tab=avatar&msg=error");
            return;
        }

        try {
            // 生成新的文件名
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = "user_" + loggedInUser.getId() + "_" + System.currentTimeMillis() + fileExtension;

            // 确保上传目录存在
            String uploadPath = getServletContext().getRealPath("/") + "images" + File.separator + "tou_xiang";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 保存文件
            String filePath = uploadPath + File.separator + newFileName;
            filePart.write(filePath);

            // 保存相对路径到数据库
            String relativePath = "images/tou_xiang/" + newFileName;
            boolean success = userService.updateUserAvatar(loggedInUser.getId(), relativePath);

            if (success) {
                // 更新Session中的用户头像信息
                loggedInUser.setAvatarPath(relativePath);
                request.getSession().setAttribute("loggedInUser", loggedInUser);

                request.setAttribute("successMessage", "头像上传成功！");
            } else {
                request.setAttribute("errorMessage", "头像上传失败，请重试");
            }

            response.sendRedirect(request.getContextPath() + "/profile?tab=avatar&msg=" +
                    (success ? "success" : "error"));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "头像上传失败：" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/profile?tab=avatar&msg=error");
        }
    }

    /**
     * 处理地址保存
     */
    private void handleSaveAddress(HttpServletRequest request, HttpServletResponse response, User loggedInUser)
            throws ServletException, IOException {

        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String detailAddress = request.getParameter("detailAddress");

        // 验证输入
        if (province == null || city == null || district == null || detailAddress == null ||
                province.trim().isEmpty() || city.trim().isEmpty() ||
                district.trim().isEmpty() || detailAddress.trim().isEmpty()) {
            request.setAttribute("errorMessage", "请填写完整的地址信息");
            response.sendRedirect(request.getContextPath() + "/profile?tab=address&msg=error");
            return;
        }

        Address address = new Address();
        address.setUserId(loggedInUser.getId());
        address.setProvince(province.trim());
        address.setCity(city.trim());
        address.setDistrict(district.trim());
        address.setDetailAddress(detailAddress.trim());

        boolean success = addressService.saveOrUpdateAddress(address);

        if (success) {
            request.setAttribute("successMessage", "地址保存成功！");
        } else {
            request.setAttribute("errorMessage", "地址保存失败，请重试");
        }

        response.sendRedirect(request.getContextPath() + "/profile?tab=address&msg=" +
                (success ? "success" : "error"));
    }

    /**
     * 处理邮箱可用性检查（AJAX请求）
     */
    private void handleCheckEmailAvailability(HttpServletRequest request, HttpServletResponse response,
            User loggedInUser)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("{\"available\": false, \"message\": \"邮箱不能为空\"}");
            return;
        }

        // 获取当前用户的邮箱
        User currentUser = userService.getUserById(loggedInUser.getId());

        // 如果邮箱没有变化，则认为可用
        if (email.equals(currentUser.getEmail())) {
            response.getWriter().write("{\"available\": true, \"message\": \"邮箱可用\"}");
            return;
        }

        boolean available = userService.isEmailAvailable(email);
        String message = available ? "邮箱可用" : "该邮箱已被使用";

        response.getWriter().write("{\"available\": " + available + ", \"message\": \"" + message + "\"}");
    }

    /**
     * 处理手机号可用性检查（AJAX请求）
     */
    private void handleCheckPhoneAvailability(HttpServletRequest request, HttpServletResponse response,
            User loggedInUser)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String phone = request.getParameter("phone");

        if (phone == null || phone.trim().isEmpty()) {
            response.getWriter().write("{\"available\": false, \"message\": \"手机号不能为空\"}");
            return;
        }

        // 验证手机号格式（11位数字）
        if (!phone.matches("^\\d{11}$")) {
            response.getWriter().write("{\"available\": false, \"message\": \"请输入11位手机号码\"}");
            return;
        }

        // 获取当前用户的手机号
        User currentUser = userService.getUserById(loggedInUser.getId());

        // 如果手机号没有变化，则认为可用
        if (phone.equals(currentUser.getPhone())) {
            response.getWriter().write("{\"available\": true, \"message\": \"手机号可用\"}");
            return;
        }

        boolean available = userService.isPhoneAvailable(phone);
        String message = available ? "手机号可用" : "该手机号已被使用";

        response.getWriter().write("{\"available\": " + available + ", \"message\": \"" + message + "\"}");
    }

    /**
     * 检查是否为有效的图片文件
     */
    private boolean isValidImageFile(String fileName) {
        if (fileName == null)
            return false;
        String lowerCaseFileName = fileName.toLowerCase();
        return lowerCaseFileName.endsWith(".jpg") ||
                lowerCaseFileName.endsWith(".jpeg") ||
                lowerCaseFileName.endsWith(".png");
    }
}