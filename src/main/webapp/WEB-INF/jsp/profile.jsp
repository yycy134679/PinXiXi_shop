<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-CN">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>个人中心 - 拼夕夕</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                    font-family: 'Microsoft YaHei', sans-serif;
                }

                .navbar {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .navbar-brand {
                    font-weight: bold;
                    font-size: 1.5rem;
                }

                .profile-container {
                    margin-top: 30px;
                    margin-bottom: 50px;
                }

                .profile-sidebar {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    padding: 0;
                    overflow: hidden;
                }

                .profile-header {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 30px 20px;
                    text-align: center;
                }

                .profile-avatar {
                    width: 80px;
                    height: 80px;
                    border-radius: 50%;
                    border: 4px solid white;
                    margin-bottom: 15px;
                    object-fit: cover;
                }

                .profile-nav {
                    padding: 0;
                }

                .profile-nav .nav-link {
                    color: #495057;
                    padding: 15px 25px;
                    border-bottom: 1px solid #e9ecef;
                    transition: all 0.3s ease;
                    display: flex;
                    align-items: center;
                }

                .profile-nav .nav-link:hover,
                .profile-nav .nav-link.active {
                    background-color: #f8f9fa;
                    color: #667eea;
                    border-left: 4px solid #667eea;
                }

                .profile-nav .nav-link i {
                    margin-right: 10px;
                    width: 20px;
                }

                .profile-content {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    padding: 30px;
                }

                .content-title {
                    color: #495057;
                    margin-bottom: 30px;
                    padding-bottom: 15px;
                    border-bottom: 2px solid #e9ecef;
                }

                .form-control:focus {
                    border-color: #667eea;
                    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                }

                .btn-primary {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border: none;
                    padding: 10px 30px;
                    border-radius: 25px;
                    transition: all 0.3s ease;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                }

                .alert {
                    border-radius: 10px;
                    border: none;
                }

                .avatar-preview {
                    width: 150px;
                    height: 150px;
                    border-radius: 50%;
                    border: 3px solid #e9ecef;
                    object-fit: cover;
                    margin-bottom: 20px;
                }

                .file-input-wrapper {
                    position: relative;
                    overflow: hidden;
                    display: inline-block;
                }

                .file-input-wrapper input[type=file] {
                    position: absolute;
                    left: -9999px;
                }

                .file-input-label {
                    background: #6c757d;
                    color: white;
                    padding: 8px 20px;
                    border-radius: 20px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }

                .file-input-label:hover {
                    background: #5a6268;
                }

                .email-feedback {
                    font-size: 0.875rem;
                    margin-top: 5px;
                }

                .email-feedback.text-success {
                    color: #28a745 !important;
                }

                .email-feedback.text-danger {
                    color: #dc3545 !important;
                }

                .tab-content {
                    display: none;
                }

                .tab-content.active {
                    display: block;
                }
            </style>
        </head>

        <body>
            <!-- 导航栏 -->
            <nav class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-shopping-cart me-2"></i>拼夕夕
                    </a>
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i>首页
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart me-1"></i>购物车
                        </a>
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <img src="${pageContext.request.contextPath}/${loggedInUser.avatarPath != null ? loggedInUser.avatarPath : 'images/tou_xiang/懒羊羊.jpg'}"
                                    alt="头像" style="width: 25px; height: 25px; border-radius: 50%; margin-right: 5px;">
                                ${loggedInUser.nickname != null ? loggedInUser.nickname : loggedInUser.username}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">个人中心</a>
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">退出登录</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="container profile-container">
                <div class="row">
                    <!-- 左侧导航 -->
                    <div class="col-md-3">
                        <div class="profile-sidebar">
                            <div class="profile-header">
                                <img src="${pageContext.request.contextPath}/${userDetails.avatarPath != null ? userDetails.avatarPath : 'images/tou_xiang/懒羊羊.jpg'}"
                                    alt="头像" class="profile-avatar">
                                <h5>${userDetails.nickname != null ? userDetails.nickname : userDetails.username}</h5>
                                <small>用户ID: ${userDetails.id}</small>
                            </div>
                            <ul class="nav nav-pills flex-column profile-nav">
                                <li class="nav-item">
                                    <a class="nav-link tab-link ${empty param.tab or param.tab == 'info' ? 'active' : ''}"
                                        href="#" data-tab="info">
                                        <i class="fas fa-user"></i>个人信息
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link tab-link ${param.tab == 'password' ? 'active' : ''}" href="#"
                                        data-tab="password">
                                        <i class="fas fa-lock"></i>修改密码
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link tab-link ${param.tab == 'avatar' ? 'active' : ''}" href="#"
                                        data-tab="avatar">
                                        <i class="fas fa-image"></i>上传头像
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link tab-link ${param.tab == 'address' ? 'active' : ''}" href="#"
                                        data-tab="address">
                                        <i class="fas fa-map-marker-alt"></i>管理地址
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- 右侧内容 -->
                    <div class="col-md-9">
                        <div class="profile-content">
                            <!-- 消息提示 -->
                            <c:if test="${param.msg == 'success'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>操作成功！
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${param.msg == 'error'}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>操作失败，请重试！
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- 个人信息标签页 -->
                            <div id="info-tab"
                                class="tab-content ${empty param.tab or param.tab == 'info' ? 'active' : ''}">
                                <h3 class="content-title">
                                    <i class="fas fa-user me-2"></i>个人信息
                                </h3>
                                <form method="post"
                                    action="${pageContext.request.contextPath}/profile?action=updateInfo">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="username" class="form-label">用户名</label>
                                                <input type="text" class="form-control" id="username"
                                                    value="${userDetails.username}" readonly>
                                                <div class="form-text">用户名不可修改</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="nickname" class="form-label">昵称</label>
                                                <input type="text" class="form-control" id="nickname" name="nickname"
                                                    value="${userDetails.nickname}" placeholder="请输入昵称">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">手机号</label>
                                                <input type="text" class="form-control" id="phone" name="phone"
                                                    value="${userDetails.phone}" placeholder="请输入手机号">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="email" class="form-label">邮箱</label>
                                                <input type="email" class="form-control" id="email" name="email"
                                                    value="${userDetails.email}" placeholder="请输入邮箱">
                                                <div id="email-feedback" class="email-feedback"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">性别</label>
                                        <div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="male"
                                                    value="男" ${userDetails.gender=='男' ? 'checked' : '' }>
                                                <label class="form-check-label" for="male">男</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="female"
                                                    value="女" ${userDetails.gender=='女' ? 'checked' : '' }>
                                                <label class="form-check-label" for="female">女</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="secret"
                                                    value="保密" ${userDetails.gender=='保密' or empty userDetails.gender
                                                    ? 'checked' : '' }>
                                                <label class="form-check-label" for="secret">保密</label>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>保存修改
                                    </button>
                                </form>
                            </div>

                            <!-- 修改密码标签页 -->
                            <div id="password-tab" class="tab-content ${param.tab == 'password' ? 'active' : ''}">
                                <h3 class="content-title">
                                    <i class="fas fa-lock me-2"></i>修改密码
                                </h3>
                                <form method="post"
                                    action="${pageContext.request.contextPath}/profile?action=changePassword"
                                    onsubmit="return validatePasswordForm()">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="mb-3">
                                                <label for="oldPassword" class="form-label">旧密码</label>
                                                <input type="password" class="form-control" id="oldPassword"
                                                    name="oldPassword" required placeholder="请输入当前密码">
                                            </div>
                                            <div class="mb-3">
                                                <label for="newPassword" class="form-label">新密码</label>
                                                <input type="password" class="form-control" id="newPassword"
                                                    name="newPassword" required placeholder="请输入新密码（至少6位）">
                                                <div class="form-text">密码长度至少6位</div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="confirmPassword" class="form-label">确认新密码</label>
                                                <input type="password" class="form-control" id="confirmPassword"
                                                    name="confirmPassword" required placeholder="请再次输入新密码">
                                            </div>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-key me-2"></i>确认修改
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- 上传头像标签页 -->
                            <div id="avatar-tab" class="tab-content ${param.tab == 'avatar' ? 'active' : ''}">
                                <h3 class="content-title">
                                    <i class="fas fa-image me-2"></i>上传头像
                                </h3>
                                <div class="text-center mb-4">
                                    <img id="avatar-preview"
                                        src="${pageContext.request.contextPath}/${userDetails.avatarPath != null ? userDetails.avatarPath : 'images/tou_xiang/懒羊羊.jpg'}"
                                        alt="当前头像" class="avatar-preview">
                                </div>
                                <form method="post"
                                    action="${pageContext.request.contextPath}/profile?action=uploadAvatar"
                                    enctype="multipart/form-data" onsubmit="return validateAvatarForm()">
                                    <div class="text-center">
                                        <div class="file-input-wrapper mb-3">
                                            <input type="file" id="avatarFile" name="avatarFile" accept="image/*"
                                                onchange="previewAvatar(this)">
                                            <label for="avatarFile" class="file-input-label">
                                                <i class="fas fa-upload me-2"></i>选择图片
                                            </label>
                                        </div>
                                        <div class="form-text mb-3">支持JPG、PNG格式，文件大小不超过10MB</div>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>保存头像
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- 管理地址标签页 -->
                            <div id="address-tab" class="tab-content ${param.tab == 'address' ? 'active' : ''}">
                                <h3 class="content-title">
                                    <i class="fas fa-map-marker-alt me-2"></i>管理地址
                                </h3>
                                <form method="post"
                                    action="${pageContext.request.contextPath}/profile?action=saveAddress">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="province" class="form-label">省</label>
                                                <input type="text" class="form-control" id="province" name="province"
                                                    value="${userAddress.province}" required placeholder="请输入省份">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="city" class="form-label">市</label>
                                                <input type="text" class="form-control" id="city" name="city"
                                                    value="${userAddress.city}" required placeholder="请输入城市">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="district" class="form-label">区</label>
                                                <input type="text" class="form-control" id="district" name="district"
                                                    value="${userAddress.district}" required placeholder="请输入区县">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="detailAddress" class="form-label">详细地址</label>
                                        <textarea class="form-control" id="detailAddress" name="detailAddress" rows="3"
                                            required
                                            placeholder="请输入详细地址（街道、门牌号等）">${userAddress.detailAddress}</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>保存地址
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // 标签页切换
                document.querySelectorAll('.tab-link').forEach(link => {
                    link.addEventListener('click', function (e) {
                        e.preventDefault();

                        // 移除所有active类
                        document.querySelectorAll('.tab-link').forEach(l => l.classList.remove('active'));
                        document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));

                        // 添加active类
                        this.classList.add('active');
                        const tabId = this.getAttribute('data-tab') + '-tab';
                        document.getElementById(tabId).classList.add('active');

                        // 更新URL
                        const url = new URL(window.location);
                        url.searchParams.set('tab', this.getAttribute('data-tab'));
                        window.history.pushState({}, '', url);
                    });
                });

                // 邮箱可用性检查
                let emailCheckTimeout;
                document.getElementById('email').addEventListener('input', function () {
                    clearTimeout(emailCheckTimeout);
                    const email = this.value.trim();
                    const feedback = document.getElementById('email-feedback');

                    if (email === '') {
                        feedback.textContent = '';
                        feedback.className = 'email-feedback';
                        return;
                    }

                    emailCheckTimeout = setTimeout(() => {
                        fetch('${pageContext.request.contextPath}/profile?action=checkEmailAvailability', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'email=' + encodeURIComponent(email)
                        })
                            .then(response => response.json())
                            .then(data => {
                                feedback.textContent = data.message;
                                feedback.className = 'email-feedback ' + (data.available ? 'text-success' : 'text-danger');
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                feedback.textContent = '检查失败';
                                feedback.className = 'email-feedback text-danger';
                            });
                    }, 500);
                });

                // 头像预览
                function previewAvatar(input) {
                    if (input.files && input.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            document.getElementById('avatar-preview').src = e.target.result;
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }

                // 表单验证
                function validatePasswordForm() {
                    const newPassword = document.getElementById('newPassword').value;
                    const confirmPassword = document.getElementById('confirmPassword').value;

                    if (newPassword.length < 6) {
                        alert('新密码长度不能少于6位');
                        return false;
                    }

                    if (newPassword !== confirmPassword) {
                        alert('两次输入的新密码不一致');
                        return false;
                    }

                    return true;
                }

                function validateAvatarForm() {
                    const fileInput = document.getElementById('avatarFile');
                    if (!fileInput.files || fileInput.files.length === 0) {
                        alert('请选择要上传的头像文件');
                        return false;
                    }

                    const file = fileInput.files[0];
                    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];

                    if (!allowedTypes.includes(file.type)) {
                        alert('只支持JPG、PNG格式的图片文件');
                        return false;
                    }

                    if (file.size > 10 * 1024 * 1024) {
                        alert('文件大小不能超过10MB');
                        return false;
                    }

                    return true;
                }

                // 页面加载完成后的初始化
                document.addEventListener('DOMContentLoaded', function () {
                    // 如果URL中有消息参数，3秒后自动隐藏
                    if (new URLSearchParams(window.location.search).get('msg')) {
                        setTimeout(() => {
                            const alerts = document.querySelectorAll('.alert');
                            alerts.forEach(alert => {
                                const bsAlert = new bootstrap.Alert(alert);
                                bsAlert.close();
                            });
                        }, 3000);
                    }
                });
            </script>
        </body>

        </html>