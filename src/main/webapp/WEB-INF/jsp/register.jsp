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

                        .register-container {
                            position: relative;
                            z-index: 1;
                            width: 100%;
                            max-width: 480px;
                        }

                        .register-card {
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

                        .register-card:hover {
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

                        .register-header {
                            text-align: center;
                            margin-bottom: 40px;
                        }

                        .register-title {
                            font-size: 2.25rem;
                            font-weight: 700;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                            margin-bottom: 8px;
                            letter-spacing: -0.02em;
                        }

                        .register-subtitle {
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

                        .required {
                            color: #ef4444;
                            margin-left: 2px;
                        }

                        .form-control {
                            background: rgba(255, 255, 255, 0.8);
                            border: 2px solid #e5e7eb;
                            border-radius: 12px;
                            padding: 16px 20px;
                            font-size: 1rem;
                            transition: all 0.2s ease;
                            backdrop-filter: blur(10px);
                            width: 100%;
                        }

                        .form-control:focus {
                            background: rgba(255, 255, 255, 0.95);
                            border-color: #667eea;
                            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
                            outline: none;
                            transform: translateY(-1px);
                        }

                        .form-control.is-valid {
                            border-color: #10b981;
                            background: rgba(240, 253, 244, 0.8);
                        }

                        .form-control.is-invalid {
                            border-color: #ef4444;
                            background: rgba(254, 242, 242, 0.8);
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
                            z-index: 2;
                        }

                        .form-control:focus+.input-icon {
                            color: #667eea;
                        }

                        .has-icon .form-control {
                            padding-left: 52px;
                        }

                        .input-group {
                            position: relative;
                        }

                        .input-group-text {
                            background: rgba(255, 255, 255, 0.8);
                            border: 2px solid #e5e7eb;
                            border-left: none;
                            border-radius: 0 12px 12px 0;
                            padding: 16px 20px;
                            font-size: 0.875rem;
                            font-weight: 500;
                            backdrop-filter: blur(10px);
                            transition: all 0.2s ease;
                        }

                        .input-group .form-control {
                            border-radius: 12px 0 0 12px;
                            border-right: none;
                        }

                        .input-group .form-control:focus+.input-group-text {
                            border-color: #667eea;
                            background: rgba(255, 255, 255, 0.95);
                        }

                        .btn-register {
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

                        .btn-register::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: -100%;
                            width: 100%;
                            height: 100%;
                            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                            transition: left 0.5s ease;
                        }

                        .btn-register:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 12px 24px rgba(102, 126, 234, 0.3);
                        }

                        .btn-register:hover::before {
                            left: 100%;
                        }

                        .btn-register:active {
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

                        .alert ul {
                            margin: 0;
                            padding-left: 20px;
                        }

                        .alert li {
                            margin-bottom: 4px;
                        }

                        .form-text {
                            color: #64748b;
                            font-size: 0.875rem;
                            margin-top: 6px;
                        }

                        .invalid-feedback,
                        .valid-feedback {
                            display: block;
                            font-size: 0.875rem;
                            margin-top: 6px;
                            font-weight: 500;
                        }

                        .invalid-feedback {
                            color: #dc2626;
                        }

                        .valid-feedback {
                            color: #059669;
                        }

                        .register-footer {
                            text-align: center;
                            margin-top: 32px;
                            padding-top: 24px;
                            border-top: 1px solid rgba(0, 0, 0, 0.1);
                        }

                        .register-link {
                            color: #667eea;
                            text-decoration: none;
                            font-weight: 600;
                            transition: all 0.2s ease;
                        }

                        .register-link:hover {
                            color: #764ba2;
                            text-decoration: none;
                            transform: translateY(-1px);
                        }

                        .footer-text {
                            color: #64748b;
                            font-size: 0.875rem;
                        }

                        /* 状态指示器 */
                        .status-indicator {
                            position: absolute;
                            right: 16px;
                            top: 50%;
                            transform: translateY(-50%);
                            font-size: 1.125rem;
                            z-index: 2;
                        }

                        .status-indicator.success {
                            color: #10b981;
                        }

                        .status-indicator.error {
                            color: #ef4444;
                        }

                        /* 响应式设计 */
                        @media (max-width: 480px) {
                            .register-card {
                                padding: 32px 24px;
                                margin: 16px;
                                border-radius: 20px;
                            }

                            .register-title {
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

                            .input-group-text {
                                padding: 14px 16px;
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

                        /* 验证状态动画 */
                        .validation-enter {
                            animation: fadeInUp 0.3s ease-out;
                        }

                        @keyframes fadeInUp {
                            from {
                                opacity: 0;
                                transform: translateY(10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }
                    </style>
                </head>

                <body>
                    <div class="register-container">
                        <div class="register-card">
                            <div class="register-header">
                                <h1 class="register-title">创建账户</h1>
                                <p class="register-subtitle">加入拼夕夕，开启购物新体验</p>
                            </div>

                            <!-- 全局错误提示 -->
                            <c:if test="${not empty requestScope.errorMessage}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    ${requestScope.errorMessage}
                                </div>
                            </c:if>

                            <!-- 字段级错误提示 -->
                            <c:if test="${not empty requestScope.errors}">
                                <div class="alert alert-danger">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <strong>请修正以下错误：</strong>
                                    <ul class="mb-0 mt-2">
                                        <c:forEach var="errorMsg" items="${requestScope.errors.values()}">
                                            <li>${errorMsg}</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>

                            <form method="post" action="${pageContext.request.contextPath}/register" id="registerForm"
                                novalidate>
                                <div class="form-group has-icon">
                                    <label for="username" class="form-label">账号<span class="required">*</span></label>
                                    <input type="text" class="form-control" id="username" name="username"
                                        placeholder="请输入用户名" required maxlength="20" autocomplete="username"
                                        aria-describedby="usernameHelpBlock usernameErrorBlock usernameFeedback">
                                    <i class="bi bi-person input-icon"></i>
                                    <div id="usernameHelpBlock" class="form-text">用户名最多20个字符</div>
                                    <div id="usernameFeedback" class="invalid-feedback"></div>
                                </div>

                                <div class="form-group has-icon">
                                    <label for="password" class="form-label">密码<span class="required">*</span></label>
                                    <input type="password" class="form-control" id="password" name="password"
                                        placeholder="请输入密码（6-20位）" required minlength="6" maxlength="20"
                                        autocomplete="new-password"
                                        aria-describedby="passwordErrorBlock passwordFeedback">
                                    <i class="bi bi-lock input-icon"></i>
                                    <div id="passwordFeedback" class="invalid-feedback"></div>
                                </div>

                                <div class="form-group has-icon">
                                    <label for="confirmPassword" class="form-label">确认密码<span
                                            class="required">*</span></label>
                                    <input type="password" class="form-control" id="confirmPassword"
                                        name="confirmPassword" placeholder="请再次输入密码" required minlength="6"
                                        maxlength="20" autocomplete="new-password"
                                        aria-describedby="confirmPasswordErrorBlock confirmPasswordFeedback">
                                    <i class="bi bi-shield-check input-icon"></i>
                                    <div id="confirmPasswordFeedback" class="invalid-feedback"></div>
                                </div>

                                <div class="form-group">
                                    <label for="phone" class="form-label">手机号<span class="required">*</span></label>
                                    <div class="input-group">
                                        <input type="tel"
                                            class="form-control<c:if test='${not empty errors.phone}'> is-invalid</c:if>"
                                            id="phone" name="phone" placeholder="请输入11位手机号"
                                            value="${not empty requestScope.phone ? requestScope.phone : param.phone}"
                                            required maxlength="11" autocomplete="tel" aria-describedby="phoneFeedback">
                                        <span class="input-group-text" id="phoneAvailabilityStatus"
                                            style="display: none;"></span>
                                    </div>
                                    <div id="phoneFeedback" class="form-text"></div>
                                    <c:if test="${not empty errors.phone}">
                                        <div class="invalid-feedback d-block">${errors.phone}</div>
                                    </c:if>
                                </div>

                                <button type="submit" class="btn btn-register">
                                    <span class="btn-text">立即注册</span>
                                </button>
                            </form>

                            <div class="register-footer">
                                <p class="footer-text">已有账号？
                                    <a class="register-link" href="${pageContext.request.contextPath}/login">去登录</a>
                                </p>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
                    <script>
                        $(function () {
                            // 表单提交处理
                            const form = document.getElementById('registerForm');
                            const submitBtn = form.querySelector('.btn-register');
                            const btnText = submitBtn.querySelector('.btn-text');

                            form.addEventListener('submit', function (e) {
                                // 添加加载状态
                                submitBtn.disabled = true;
                                btnText.innerHTML = '<span class="loading"></span> 注册中...';
                            });

                            // 用户名实时校验
                            $('#username').on('input blur', function () {
                                var val = this.value.trim();
                                var $input = $(this);
                                var $feedback = $('#usernameFeedback');

                                if (!val) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('用户名不能为空').addClass('validation-enter');
                                    return;
                                }
                                if (val.length > 20) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('用户名不能超过20字符').addClass('validation-enter');
                                    return;
                                }

                                // 异步校验
                                $.get('${pageContext.request.contextPath}/validate', { type: 'username', value: val }, function (res) {
                                    if (res.available) {
                                        $input.removeClass('is-invalid').addClass('is-valid');
                                        $feedback.text('用户名可用').removeClass('invalid-feedback').addClass('valid-feedback validation-enter');
                                    } else {
                                        $input.removeClass('is-valid').addClass('is-invalid');
                                        $feedback.text(res.message || '用户名已被占用').removeClass('valid-feedback').addClass('invalid-feedback validation-enter');
                                    }
                                }, 'json');
                            });

                            // 手机号实时校验
                            $('#phone').on('blur', function () {
                                const phone = $(this).val().trim();
                                const phoneFeedback = $('#phoneFeedback');
                                const phoneAvailabilityStatus = $('#phoneAvailabilityStatus');
                                const phoneInput = $(this);

                                // 清除之前的状态
                                phoneFeedback.text('').removeClass('text-danger text-success');
                                phoneAvailabilityStatus.hide().removeClass('bg-success-subtle text-success-emphasis bg-danger-subtle text-danger-emphasis');
                                phoneInput.removeClass('is-invalid is-valid');

                                if (phone.length === 0 && phoneInput.prop('required')) {
                                    phoneFeedback.text('手机号不能为空').addClass('text-danger validation-enter');
                                    phoneInput.addClass('is-invalid');
                                    return;
                                }
                                if (phone.length > 0 && phone.length !== 11) {
                                    phoneFeedback.text('请输入11位手机号码').addClass('text-danger validation-enter');
                                    phoneInput.addClass('is-invalid');
                                }

                                // 只要有输入就发AJAX查唯一性
                                if (phone.length > 0) {
                                    $.ajax({
                                        url: (typeof contextPath !== 'undefined' ? contextPath : '') + '/validate',
                                        type: 'GET',
                                        data: {
                                            type: 'phone',
                                            value: phone
                                        },
                                        success: function (response) {
                                            if (response.available) {
                                                phoneAvailabilityStatus.text('手机号可用').addClass('bg-success-subtle text-success-emphasis validation-enter').show();
                                                phoneInput.addClass('is-valid');
                                                phoneFeedback.text('');
                                            } else {
                                                phoneFeedback.text(response.message || '手机号已被注册').addClass('text-danger validation-enter');
                                                phoneInput.addClass('is-invalid');
                                                phoneAvailabilityStatus.hide();
                                            }
                                        },
                                        error: function () {
                                            phoneFeedback.text('校验手机号时发生错误').addClass('text-danger validation-enter');
                                            phoneInput.addClass('is-invalid');
                                            phoneAvailabilityStatus.hide();
                                        }
                                    });
                                }
                            });

                            // 密码确认实时校验
                            $('#confirmPassword, #password').on('input blur', function () {
                                var pwd = $('#password').val();
                                var cpwd = $('#confirmPassword').val();
                                var $input = $('#confirmPassword');
                                var $feedback = $('#confirmPasswordFeedback');

                                if (!cpwd) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('请确认密码').addClass('validation-enter');
                                    return;
                                }
                                if (pwd !== cpwd) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('两次输入的密码不一致').addClass('validation-enter');
                                } else if (pwd.length < 6) {
                                    $input.removeClass('is-valid').addClass('is-invalid');
                                    $feedback.text('密码长度不能少于6位').addClass('validation-enter');
                                } else {
                                    $input.removeClass('is-invalid').addClass('is-valid');
                                    $feedback.text('密码一致').removeClass('invalid-feedback').addClass('valid-feedback validation-enter');
                                }
                            });

                            // 表单提交前校验
                            $('#registerForm').on('submit', function (e) {
                                var valid = true;
                                $('#registerForm input').each(function () {
                                    if (this.name === 'phone') {
                                        console.log('[ClientValidation] phone input pattern:', this.pattern, 'value:', this.value);
                                    }
                                    if (!this.checkValidity()) {
                                        console.log('[ClientValidation] 字段未通过原生checkValidity:', this.name, this.value);
                                        $(this).addClass('is-invalid');
                                        valid = false;
                                    } else if ($(this).hasClass('is-invalid')) {
                                        console.log('[ClientValidation] 字段有is-invalid类:', this.name, this.value);
                                        valid = false;
                                    }
                                });
                                console.log('[registerForm submit] 校验结果 valid =', valid);
                                if (!valid) {
                                    console.log('[registerForm submit] 阻止表单提交');
                                    e.preventDefault();
                                    // 重置按钮状态
                                    submitBtn.disabled = false;
                                    btnText.innerHTML = '立即注册';
                                } else {
                                    console.log('[registerForm submit] 允许表单提交');
                                }
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