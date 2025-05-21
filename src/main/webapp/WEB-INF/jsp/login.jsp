<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-CN">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>用户登录 - 拼夕夕 电商平台</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
            <style type="text/css">
                body {
                    background-color: #ffffff;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px 0;
                }

                .login-card {
                    border: none;
                    border-radius: 0.75rem;
                    box-shadow: 0 6px 30px 0 rgba(0, 0, 0, 0.1);
                    max-width: 450px;
                    margin: 20px auto;
                }

                .form-label {
                    font-weight: 500;
                }

                .invalid-feedback {
                    display: block;
                }

                .login-title {
                    font-size: 2rem;
                    font-weight: 600;
                    text-align: center;
                    margin-bottom: 2rem;
                    color: #222;
                }

                .btn-primary {
                    background: #1890ff;
                    border: none;
                }

                .btn-primary:hover {
                    background: #40a9ff;
                }

                .login-link {
                    color: #1890ff;
                    text-decoration: none;
                }

                .login-link:hover {
                    text-decoration: underline;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="d-flex align-items-center justify-content-center" style="min-height: calc(100vh - 40px);">
                    <div class="card login-card w-100">
                        <div class="card-body p-4">
                            <div class="login-title">登录页面</div>
                            <!-- 全局错误提示 -->
                            <c:if test="${not empty requestScope.errorMessage}">
                                <div class="alert alert-danger" role="alert">
                                    ${requestScope.errorMessage}
                                </div>
                            </c:if>
                            <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm"
                                novalidate>
                                <div class="mb-3">
                                    <label for="username" class="form-label">账号</label>
                                    <input type="text" class="form-control" id="username" name="username" required
                                        maxlength="20" autocomplete="username">
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">密码</label>
                                    <input type="password" class="form-control" id="password" name="password" required
                                        minlength="6" maxlength="20" autocomplete="current-password">
                                </div>
                                <button type="submit" class="btn btn-primary w-100 mt-3">登录</button>
                            </form>
                            <p class="mt-3 text-center">还没有账号？ <a class="login-link"
                                    href="${pageContext.request.contextPath}/register">立即注册</a></p>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>