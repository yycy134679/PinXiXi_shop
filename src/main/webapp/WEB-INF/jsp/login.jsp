<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-CN">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>用户登录 - 拼夕夕 电商平台</title>
            <!-- 防止浏览器请求默认favicon.ico -->
            <link rel="icon" href="data:,">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <style type="text/css">
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                    position: relative;
                    overflow-x: hidden;
                }

                body::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.15"/><circle cx="20" cy="80" r="0.5" fill="white" opacity="0.15"/><circle cx="90" cy="30" r="0.5" fill="white" opacity="0.15"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                    pointer-events: none;
                }

                .login-container {
                    position: relative;
                    z-index: 1;
                    width: 100%;
                    max-width: 420px;
                }

                .login-card {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(20px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 24px;
                    box-shadow:
                        0 20px 40px rgba(0, 0, 0, 0.1),
                        0 8px 32px rgba(0, 0, 0, 0.08),
                        inset 0 1px 0 rgba(255, 255, 255, 0.6);
                    padding: 48px 40px;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    animation: slideUp 0.6s ease-out;
                }

                .login-card:hover {
                    transform: translateY(-4px);
                    box-shadow:
                        0 32px 64px rgba(0, 0, 0, 0.15),
                        0 16px 48px rgba(0, 0, 0, 0.1),
                        inset 0 1px 0 rgba(255, 255, 255, 0.6);
                }

                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .login-header {
                    text-align: center;
                    margin-bottom: 40px;
                }

                .login-title {
                    font-size: 2.25rem;
                    font-weight: 700;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                    margin-bottom: 8px;
                    letter-spacing: -0.02em;
                }

                .login-subtitle {
                    color: #64748b;
                    font-size: 1rem;
                    font-weight: 400;
                }

                .form-group {
                    margin-bottom: 24px;
                    position: relative;
                }

                .form-label {
                    font-weight: 600;
                    color: #374151;
                    margin-bottom: 8px;
                    font-size: 0.875rem;
                    letter-spacing: 0.025em;
                }

                .form-control {
                    background: rgba(255, 255, 255, 0.8);
                    border: 2px solid #e5e7eb;
                    border-radius: 12px;
                    padding: 16px 20px;
                    font-size: 1rem;
                    transition: all 0.2s ease;
                    backdrop-filter: blur(10px);
                }

                .form-control:focus {
                    background: rgba(255, 255, 255, 0.95);
                    border-color: #667eea;
                    box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
                    outline: none;
                    transform: translateY(-1px);
                }

                .form-control::placeholder {
                    color: #9ca3af;
                }

                .input-icon {
                    position: absolute;
                    left: 20px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #9ca3af;
                    font-size: 1.125rem;
                    pointer-events: none;
                    transition: color 0.2s ease;
                }

                .form-control:focus+.input-icon {
                    color: #667eea;
                }

                .has-icon .form-control {
                    padding-left: 52px;
                }

                .btn-login {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border: none;
                    border-radius: 12px;
                    padding: 16px 32px;
                    font-size: 1rem;
                    font-weight: 600;
                    color: white;
                    width: 100%;
                    transition: all 0.3s ease;
                    position: relative;
                    overflow: hidden;
                    letter-spacing: 0.025em;
                }

                .btn-login::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                    transition: left 0.5s ease;
                }

                .btn-login:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 12px 24px rgba(102, 126, 234, 0.3);
                }

                .btn-login:hover::before {
                    left: 100%;
                }

                .btn-login:active {
                    transform: translateY(0);
                }

                .alert {
                    border: none;
                    border-radius: 12px;
                    padding: 16px 20px;
                    margin-bottom: 24px;
                    font-weight: 500;
                    backdrop-filter: blur(10px);
                }

                .alert-danger {
                    background: rgba(239, 68, 68, 0.1);
                    color: #dc2626;
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .login-footer {
                    text-align: center;
                    margin-top: 32px;
                    padding-top: 24px;
                    border-top: 1px solid rgba(0, 0, 0, 0.1);
                }

                .login-link {
                    color: #667eea;
                    text-decoration: none;
                    font-weight: 600;
                    transition: all 0.2s ease;
                }

                .login-link:hover {
                    color: #764ba2;
                    text-decoration: none;
                    transform: translateY(-1px);
                }

                .footer-text {
                    color: #64748b;
                    font-size: 0.875rem;
                }

                /* 响应式设计 */
                @media (max-width: 480px) {
                    .login-card {
                        padding: 32px 24px;
                        margin: 16px;
                        border-radius: 20px;
                    }

                    .login-title {
                        font-size: 1.875rem;
                    }

                    .form-control {
                        padding: 14px 16px;
                    }

                    .has-icon .form-control {
                        padding-left: 48px;
                    }

                    .input-icon {
                        left: 16px;
                    }
                }

                /* 加载动画 */
                .loading {
                    display: inline-block;
                    width: 20px;
                    height: 20px;
                    border: 2px solid rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    border-top-color: white;
                    animation: spin 1s ease-in-out infinite;
                }

                @keyframes spin {
                    to {
                        transform: rotate(360deg);
                    }
                }
            </style>
        </head>

        <body>
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <h1 class="login-title">欢迎回来</h1>
                        <p class="login-subtitle">登录您的拼夕夕账户</p>
                    </div>

                    <!-- 全局错误提示 -->
                    <c:if test="${not empty requestScope.errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${requestScope.errorMessage}
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm" novalidate>
                        <div class="form-group has-icon">
                            <label for="username" class="form-label">账号</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="请输入您的账号"
                                required maxlength="20" autocomplete="username">
                            <i class="bi bi-person input-icon"></i>
                        </div>

                        <div class="form-group has-icon">
                            <label for="password" class="form-label">密码</label>
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="请输入您的密码" required minlength="6" maxlength="20"
                                autocomplete="current-password">
                            <i class="bi bi-lock input-icon"></i>
                        </div>

                        <button type="submit" class="btn btn-login">
                            <span class="btn-text">立即登录</span>
                        </button>
                    </form>

                    <div class="login-footer">
                        <p class="footer-text">还没有账号？
                            <a class="login-link" href="${pageContext.request.contextPath}/register">立即注册</a>
                        </p>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('loginForm');
                    const submitBtn = form.querySelector('.btn-login');
                    const btnText = submitBtn.querySelector('.btn-text');

                    form.addEventListener('submit', function (e) {
                        // 添加加载状态
                        submitBtn.disabled = true;
                        btnText.innerHTML = '<span class="loading"></span> 登录中...';

                        // 如果需要客户端验证，可以在这里添加
                        // 这里暂时允许表单正常提交
                    });

                    // 输入框焦点效果
                    const inputs = document.querySelectorAll('.form-control');
                    inputs.forEach(input => {
                        input.addEventListener('focus', function () {
                            this.parentElement.classList.add('focused');
                        });

                        input.addEventListener('blur', function () {
                            this.parentElement.classList.remove('focused');
                        });
                    });
                });
            </script>
        </body>

        </html>