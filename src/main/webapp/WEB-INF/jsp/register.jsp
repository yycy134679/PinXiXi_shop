<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="zh-CN">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>用户注册 - 拼夕夕 电商平台</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                    <style type="text/css">
                        body {
                            background-color: #ffffff;
                            /* 修改背景为白色 */
                            min-height: 100vh;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            padding: 20px 0;
                            /* 给上下一些padding */
                        }

                        .register-card {
                            border: none;
                            border-radius: 0.75rem;
                            box-shadow: 0 6px 30px 0 rgba(0, 0, 0, 0.1);
                            /* 调整阴影以适应白色背景 */
                            max-width: 550px;
                            /* 加大表单宽度 */
                            margin: 20px auto;
                            /* 调整外边距 */
                        }

                        .form-label {
                            font-weight: 500;
                        }

                        .invalid-feedback {
                            display: block;
                        }

                        .form-text {
                            color: #888;
                            font-size: 0.95em;
                        }

                        .register-title {
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

                        .register-link {
                            color: #1890ff;
                            text-decoration: none;
                        }

                        .register-link:hover {
                            text-decoration: underline;
                        }
                    </style>
                </head>

                <body>
                    <!-- 注册表单主体 -->
                    <div class="container">
                        <div class="d-flex align-items-center justify-content-center"
                            style="min-height: calc(100vh - 40px);"> <!-- 调整高度以适应padding -->
                            <div class="card register-card w-100">
                                <div class="card-body p-4">
                                    <div class="register-title">注册页面</div>
                                    <!-- 全局错误提示 -->
                                    <c:if test="${not empty requestScope.errorMessage}">
                                        <div class="alert alert-danger" role="alert">
                                            ${requestScope.errorMessage}
                                        </div>
                                    </c:if>
                                    <!-- 字段级错误提示 -->
                                    <c:if test="${not empty requestScope.errors}">
                                        <div class="alert alert-danger">
                                            <ul class="mb-0">
                                                <c:forEach var="errorMsg" items="${requestScope.errors.values()}">
                                                    <li>${errorMsg}</li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <form method="post" action="${pageContext.request.contextPath}/register"
                                        id="registerForm" novalidate>
                                        <div class="mb-3">
                                            <label for="username" class="form-label">账号<span
                                                    class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="username" name="username"
                                                required maxlength="20" autocomplete="username"
                                                aria-describedby="usernameHelpBlock usernameErrorBlock usernameFeedback">
                                            <div id="usernameHelpBlock" class="form-text">用户名最多20个字符</div>
                                            <div id="usernameFeedback" class="invalid-feedback"></div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="password" class="form-label">密码<span
                                                    class="text-danger">*</span></label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                required minlength="6" maxlength="20" autocomplete="new-password"
                                                aria-describedby="passwordErrorBlock passwordFeedback">
                                            <div id="passwordFeedback" class="invalid-feedback"></div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="confirmPassword" class="form-label">确认密码<span
                                                    class="text-danger">*</span></label>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                name="confirmPassword" required minlength="6" maxlength="20"
                                                autocomplete="new-password"
                                                aria-describedby="confirmPasswordErrorBlock confirmPasswordFeedback">
                                            <div id="confirmPasswordFeedback" class="invalid-feedback"></div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">手机号<span
                                                    class="text-danger">*</span></label>
                                            <input type="tel"
                                                class="form-control <c:if test='${not empty errors.phone}'>is-invalid</c:if>'"
                                                id="phone" name="phone" required pattern="^1[3-9]\\d{9}$" maxlength="11"
                                                autocomplete="tel" value="${phone != null ? phone : ''}"
                                                aria-describedby="phoneErrorBlock phoneFeedback">
                                            <div id="phoneFeedback" class="invalid-feedback">
                                                <c:if test="${not empty errors.phone}">${errors.phone}</c:if>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100 mt-3">注册</button>
                                    </form>
                                    <p class="mt-3 text-center">已有账号？ <a class="register-link"
                                            href="${pageContext.request.contextPath}/login">去登录</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
                    <script>
                        $(function () {
                            // 用户名实时校验
                            $('#username').on('input blur', function () {
                                var val = this.value.trim();
                                var $input = $(this);
                                var $feedback = $('#usernameFeedback');
                                if (!val) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('用户名不能为空');
                                    return;
                                }
                                if (val.length > 20) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('用户名不能超过20字符');
                                    return;
                                }
                                // 异步校验
                                $.get('${pageContext.request.contextPath}/validate', { type: 'username', value: val }, function (res) {
                                    if (res.available) {
                                        $input.removeClass('is-invalid').addClass('is-valid');
                                        $feedback.text('用户名可用').removeClass('invalid-feedback').addClass('valid-feedback');
                                    } else {
                                        $input.removeClass('is-valid').addClass('is-invalid');
                                        $feedback.text(res.message || '用户名已被占用').removeClass('valid-feedback').addClass('invalid-feedback');
                                    }
                                }, 'json');
                            });
                            // 手机号实时校验
                            $('#phone').on('input blur', function () {
                                var val = this.value.trim();
                                var $input = $(this);
                                var $feedback = $('#phoneFeedback');
                                var phoneReg = /^1[3-9]\d{9}$/;
                                if (!val) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('手机号不能为空');
                                    return;
                                }
                                if (!phoneReg.test(val)) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('手机号格式不正确');
                                    return;
                                }
                                // 异步校验
                                $.get('${pageContext.request.contextPath}/validate', { type: 'phone', value: val }, function (res) {
                                    if (res.available) {
                                        $input.removeClass('is-invalid').addClass('is-valid');
                                        $feedback.text('手机号可用').removeClass('invalid-feedback').addClass('valid-feedback');
                                    } else {
                                        $input.removeClass('is-valid').addClass('is-invalid');
                                        $feedback.text(res.message || '手机号已被注册').removeClass('valid-feedback').addClass('invalid-feedback');
                                    }
                                }, 'json');
                            });
                            // 密码确认实时校验
                            $('#confirmPassword, #password').on('input blur', function () {
                                var pwd = $('#password').val();
                                var cpwd = $('#confirmPassword').val();
                                var $input = $('#confirmPassword');
                                var $feedback = $('#confirmPasswordFeedback');
                                if (!cpwd) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('请确认密码');
                                    return;
                                }
                                if (pwd !== cpwd) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('两次输入的密码不一致');
                                } else if (pwd.length < 6) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('密码长度不能少于6位');
                                } else {
                                    $input.removeClass('is-invalid').addClass('is-valid');
                                    $feedback.text('密码一致').removeClass('invalid-feedback').addClass('valid-feedback');
                                }
                            });
                            // 表单提交前校验
                            $('#registerForm').on('submit', function (e) {
                                var valid = true;
                                $('#registerForm input').each(function () {
                                    if (!this.checkValidity() || $(this).hasClass('is-invalid')) {
                                        $(this).addClass('is-invalid');
                                        valid = false;
                                    }
                                });
                                if (!valid) {
                                    e.preventDefault();
                                }
                            });
                        });
                    </script>
                </body>

                </html>