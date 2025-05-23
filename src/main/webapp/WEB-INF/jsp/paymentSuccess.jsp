<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="zh-CN">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>支付成功 - 拼夕夕商城</title>
                <!-- 防止浏览器请求默认favicon.ico -->
                <link rel="icon" href="data:,">
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icons -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

                <style>
                    body {
                        background: #f8f9fa;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .success-container {
                        background: #fff;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        padding: 3rem;
                        margin-top: 3rem;
                        margin-bottom: 3rem;
                        flex: 1;
                        text-align: center;
                        max-width: 600px;
                        margin-left: auto;
                        margin-right: auto;
                    }

                    .success-icon {
                        font-size: 5rem;
                        color: #28a745;
                        margin-bottom: 1.5rem;
                        animation: bounce 1s ease-in-out;
                    }

                    @keyframes bounce {

                        0%,
                        20%,
                        50%,
                        80%,
                        100% {
                            transform: translateY(0);
                        }

                        40% {
                            transform: translateY(-10px);
                        }

                        60% {
                            transform: translateY(-5px);
                        }
                    }

                    .success-title {
                        color: #28a745;
                        font-size: 2.5rem;
                        font-weight: 700;
                        margin-bottom: 1rem;
                    }

                    .success-message {
                        font-size: 1.2rem;
                        color: #666;
                        margin-bottom: 2rem;
                        line-height: 1.6;
                    }

                    .action-buttons {
                        margin-top: 2rem;
                    }

                    .btn-home {
                        font-size: 1.1rem;
                        padding: 12px 30px;
                        border-radius: 8px;
                        margin: 0 10px;
                    }

                    /* 导航栏样式 */
                    .navbar-brand-text {
                        font-size: 2rem;
                        font-weight: bold;
                        vertical-align: middle;
                        font-family: 'KaiTi', 'SimSun', sans-serif;
                        color: #D23F31;
                        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
                    }

                    .navbar {
                        padding-top: 0.8rem;
                        padding-bottom: 0.8rem;
                    }

                    .navbar-brand img {
                        margin-top: -0.25rem;
                    }

                    .navbar-nav .nav-link {
                        font-size: 1.35rem;
                        font-weight: 600;
                        padding-left: 1.2rem;
                        padding-right: 1.2rem;
                        color: #444 !important;
                        letter-spacing: 0.03em;
                        transition: color 0.2s;
                    }

                    .navbar-nav .nav-link:hover,
                    .navbar-nav .nav-link:focus {
                        color: #ff4d4f !important;
                        text-shadow: 0 1px 0 #fff2f0;
                    }

                    .navbar-nav .nav-item .bi {
                        font-size: 1.5em;
                        vertical-align: -0.2em;
                        margin-right: 0.2em;
                    }

                    .navbar-nav .badge {
                        font-size: 1em;
                        padding: 0.4em 0.7em;
                    }

                    /* 页脚样式 */
                    .custom-footer {
                        background: #f8f9fb;
                        border-top: 1px solid #eee;
                        margin-top: auto;
                    }

                    .footer-icon {
                        font-size: 2.2rem;
                    }

                    .footer-text {
                        font-size: 1.08rem;
                        color: #333;
                        font-weight: 500;
                        letter-spacing: 0.01em;
                    }

                    .success-details {
                        background: #f8f9fa;
                        border-radius: 8px;
                        padding: 1.5rem;
                        margin: 2rem 0;
                        border-left: 4px solid #28a745;
                    }

                    .detail-item {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 0.5rem;
                    }

                    .detail-item:last-child {
                        margin-bottom: 0;
                    }

                    .detail-label {
                        font-weight: 600;
                        color: #666;
                    }

                    .detail-value {
                        color: #333;
                    }
                </style>
            </head>

            <body>
                <!-- 导航栏 -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                            <span class="navbar-brand-text"
                                style="color: #ff7c7c; font-size: 2.8rem; font-weight: 900; letter-spacing: 0.08em; font-family: 'Arial Black', 'FZYaoti', 'FZCuHeiSongS-B-GB', 'FZShuTi', 'STHeiti', 'SimHei', sans-serif;">拼夕夕商城</span>
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNavDropdown">
                            <form class="d-flex mx-auto my-2 my-lg-0" style="width: 60%; max-width: 600px;"
                                action="${pageContext.request.contextPath}/home" method="GET">
                                <input class="form-control me-2" type="search" name="searchKeyword"
                                    placeholder="搜索商品..." aria-label="Search" value="${param.searchKeyword}">
                                <button class="btn btn-outline-success" type="submit">搜索</button>
                            </form>
                            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                                <c:choose>
                                    <c:when test="${empty sessionScope.loggedInUser}">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/login">登录</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link"
                                                href="${pageContext.request.contextPath}/register">注册</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/login"
                                                onclick="alert('请先登录后查看购物车'); return true;"><i class="bi bi-cart"></i>
                                                购物车</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarUserDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.loggedInUser.avatarPath}">
                                                        <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.avatarPath}"
                                                            alt="User Avatar" width="24" height="24"
                                                            class="rounded-circle me-1">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-person-circle me-1"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:out
                                                    value="${not empty sessionScope.loggedInUser.nickname ? sessionScope.loggedInUser.nickname : sessionScope.loggedInUser.username}" />
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end"
                                                aria-labelledby="navbarUserDropdown">
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/profile">个人中心</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/logout">退出登录</a></li>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                                <i class="bi bi-cart-fill"></i> 购物车
                                                <c:if
                                                    test="${not empty sessionScope.cart && sessionScope.cart.totalItemsCount > 0}">
                                                    <span
                                                        class="badge bg-danger ms-1">${sessionScope.cart.totalItemsCount}</span>
                                                </c:if>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </nav>

                <!-- 主要内容 -->
                <div class="container">
                    <div class="success-container">
                        <!-- 成功图标 -->
                        <div class="success-icon">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>

                        <!-- 成功标题 -->
                        <h1 class="success-title">支付成功！</h1>

                        <!-- 成功消息 -->
                        <div class="success-message">
                            <c:choose>
                                <c:when test="${not empty sessionScope.paymentSuccessMessage}">
                                    ${sessionScope.paymentSuccessMessage}
                                    <c:remove var="paymentSuccessMessage" scope="session" />
                                </c:when>
                                <c:otherwise>
                                    恭喜您，订单支付成功！感谢您的购买！
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 支付详情 -->
                        <div class="success-details">
                            <div class="detail-item">
                                <span class="detail-label">支付时间：</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss" />
                                </span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">支付状态：</span>
                                <span class="detail-value text-success fw-bold">支付成功</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">订单编号：</span>
                                <span class="detail-value">
                                    PXX
                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyyMMddHHmmss" />
                                </span>
                            </div>
                        </div>

                        <!-- 温馨提示 -->
                        <div class="alert alert-info" role="alert">
                            <i class="bi bi-info-circle me-2"></i>
                            <strong>温馨提示：</strong>您的订单正在处理中，我们会尽快为您安排发货。
                        </div>

                        <!-- 操作按钮 -->
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-home">
                                <i class="bi bi-house-fill"></i> 返回首页
                            </a>
                            <a href="${pageContext.request.contextPath}/cart"
                                class="btn btn-outline-secondary btn-home">
                                <i class="bi bi-cart"></i> 查看购物车
                            </a>
                        </div>

                        <!-- 继续购物提示 -->
                        <div class="mt-4">
                            <p class="text-muted mb-0">
                                <i class="bi bi-heart-fill text-danger me-1"></i>
                                继续逛逛，发现更多好物！
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 页脚 -->
                <footer class="custom-footer py-4">
                    <div class="container">
                        <div class="row justify-content-center text-center">
                            <div class="col-6 col-md-3 mb-3 mb-md-0">
                                <div class="footer-icon text-danger mb-2"><i class="bi bi-layers"></i></div>
                                <div class="footer-text">品类齐全，轻松购物</div>
                            </div>
                            <div class="col-6 col-md-3 mb-3 mb-md-0">
                                <div class="footer-icon text-danger mb-2"><i class="bi bi-lightning-charge"></i></div>
                                <div class="footer-text">多仓直发，极速配送</div>
                            </div>
                            <div class="col-6 col-md-3 mb-3 mb-md-0">
                                <div class="footer-icon text-danger mb-2"><i class="bi bi-patch-check"></i></div>
                                <div class="footer-text">正品行货，精致服务</div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="footer-icon text-danger mb-2"><i class="bi bi-cash-coin"></i></div>
                                <div class="footer-text">天天低价，畅选无忧</div>
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                <!-- 页面功能 JS -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // 3秒后自动显示返回首页提示
                        setTimeout(function () {
                            var homeButton = document.querySelector('.btn-primary');
                            if (homeButton) {
                                homeButton.classList.add('pulse');
                            }
                        }, 3000);

                        // 添加脉冲动画样式
                        var style = document.createElement('style');
                        style.textContent = `
                .pulse {
                    animation: pulse 2s infinite;
                }
                @keyframes pulse {
                    0% { transform: scale(1); }
                    50% { transform: scale(1.05); }
                    100% { transform: scale(1); }
                }
            `;
                        document.head.appendChild(style);
                    });
                </script>
            </body>

            </html>