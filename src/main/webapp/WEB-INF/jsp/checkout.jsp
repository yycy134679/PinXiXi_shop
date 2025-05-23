<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="zh-CN">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <title>订单结算 - 拼夕夕商城</title>
                    <!-- 防止浏览器请求默认favicon.ico -->
                    <link rel="icon" href="data:,">
                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
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

                        .checkout-container {
                            background: #fff;
                            border-radius: 8px;
                            box-shadow: 0 2px 8px #0001;
                            padding: 2rem;
                            margin-top: 2rem;
                            margin-bottom: 2rem;
                            flex: 1;
                        }

                        .user-info-section {
                            background: #f8f9fa;
                            border-radius: 8px;
                            padding: 1.5rem;
                            margin-bottom: 2rem;
                            border-left: 4px solid #28a745;
                        }

                        .checkout-item {
                            border-bottom: 1px solid #eee;
                            padding: 15px 0;
                        }

                        .checkout-item:last-child {
                            border-bottom: none;
                        }

                        .checkout-item-img {
                            width: 80px;
                            height: 80px;
                            object-fit: contain;
                            background: #f6f6f6;
                            border-radius: 4px;
                        }

                        .checkout-item-name {
                            font-weight: 500;
                            color: #333;
                            text-decoration: none;
                        }

                        .checkout-item-name:hover {
                            color: #ff4d4f;
                        }

                        .checkout-item-price {
                            color: #ff4d4f;
                            font-weight: 600;
                        }

                        .checkout-total-section {
                            background: #fff9f0;
                            border: 2px solid #ffd591;
                            border-radius: 8px;
                            padding: 1.5rem;
                            margin: 2rem 0;
                        }

                        .checkout-total {
                            font-size: 1.8rem;
                            font-weight: 700;
                            color: #ff4d4f;
                        }

                        .pay-button {
                            font-size: 1.2rem;
                            padding: 12px 40px;
                            border-radius: 8px;
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

                        /* 购物车角标优化样式 */
                        .cart-link {
                            position: relative;
                            display: inline-block;
                        }

                        .cart-badge {
                            position: absolute;
                            top: -8px;
                            right: -8px;
                            background-color: #dc3545;
                            color: white;
                            border-radius: 50%;
                            width: 20px;
                            height: 20px;
                            font-size: 12px;
                            font-weight: bold;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            line-height: 1;
                            min-width: 20px;
                            padding: 0;
                            border: 2px solid white;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                        }

                        .cart-badge.large-number {
                            width: 24px;
                            height: 20px;
                            border-radius: 10px;
                            font-size: 11px;
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

                        .info-item {
                            margin-bottom: 0.5rem;
                        }

                        .info-label {
                            font-weight: 600;
                            color: #666;
                            margin-right: 0.5rem;
                        }

                        .info-value {
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
                                data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                                aria-expanded="false" aria-label="Toggle navigation">
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
                                                <a class="nav-link"
                                                    href="${pageContext.request.contextPath}/login">登录</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link"
                                                    href="${pageContext.request.contextPath}/register">注册</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="${pageContext.request.contextPath}/login"
                                                    onclick="alert('请先登录后查看购物车'); return true;"><i
                                                        class="bi bi-cart"></i>
                                                    购物车</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="#" id="navbarUserDropdown"
                                                    role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <c:choose>
                                                        <c:when
                                                            test="${not empty sessionScope.loggedInUser.avatarPath}">
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
                                                            href="${pageContext.request.contextPath}/profile">个人中心</a>
                                                    </li>
                                                    <li>
                                                        <hr class="dropdown-divider">
                                                    </li>
                                                    <li><a class="dropdown-item"
                                                            href="${pageContext.request.contextPath}/logout">退出登录</a>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link cart-link"
                                                    href="${pageContext.request.contextPath}/cart">
                                                    <i class="bi bi-cart-fill"></i> 购物车
                                                    <c:if
                                                        test="${not empty sessionScope.shoppingCart && sessionScope.shoppingCart.totalItemsCount > 0}">
                                                        <span
                                                            class="cart-badge ${sessionScope.shoppingCart.totalItemsCount > 99 ? 'large-number' : ''}">${sessionScope.shoppingCart.totalItemsCount
                                                            > 99 ? '99+' :
                                                            sessionScope.shoppingCart.totalItemsCount}</span>
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
                    <div class="container checkout-container">
                        <h2 class="mb-4"><i class="bi bi-credit-card"></i> 订单结算</h2>

                        <!-- 用户信息区域 -->
                        <div class="user-info-section">
                            <h5 class="mb-3"><i class="bi bi-person-check"></i> 收货信息</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">收货人：</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.loggedInUser.nickname}">
                                                    ${sessionScope.loggedInUser.nickname}
                                                </c:when>
                                                <c:otherwise>
                                                    ${sessionScope.loggedInUser.username}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">手机号：</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.loggedInUser.phone}">
                                                    ${sessionScope.loggedInUser.phone}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">未设置</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">收货地址：</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty userAddress}">
                                                    ${userAddress.province} ${userAddress.city} ${userAddress.district}
                                                    ${userAddress.detailAddress}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">未设置收货地址</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 商品列表区域 -->
                        <div class="mb-4">
                            <h5 class="mb-3"><i class="bi bi-bag-check"></i> 订单商品</h5>
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" width="15%">图片</th>
                                            <th scope="col" width="40%">商品名称</th>
                                            <th scope="col" width="15%">单价</th>
                                            <th scope="col" width="15%">数量</th>
                                            <th scope="col" width="15%">小计</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${checkoutItems}">
                                            <c:set var="product" value="${item.product}" />
                                            <c:set var="quantity" value="${item.quantity}" />
                                            <tr class="checkout-item">
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                        alt="${product.name}" class="checkout-item-img">
                                                </td>
                                                <td>
                                                    <span class="checkout-item-name">${product.name}</span>
                                                </td>
                                                <td class="checkout-item-price">¥
                                                    <fmt:formatNumber value="${product.price}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </td>
                                                <td>
                                                    <span class="fw-bold">${quantity}</span>
                                                </td>
                                                <td class="checkout-item-price">¥
                                                    <fmt:formatNumber value="${item.subtotal}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- 总金额区域 -->
                        <div class="checkout-total-section">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-0"><i class="bi bi-calculator"></i> 订单总额</h5>
                                    <small class="text-muted">包含所有商品费用</small>
                                </div>
                                <div class="checkout-total">
                                    ¥
                                    <fmt:formatNumber value="${checkoutTotal}" type="number" minFractionDigits="2"
                                        maxFractionDigits="2" />
                                </div>
                            </div>
                        </div>

                        <!-- 支付按钮区域 -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left"></i> 返回购物车
                                </a>
                                <a href="${pageContext.request.contextPath}/home"
                                    class="btn btn-outline-secondary ms-2">
                                    <i class="bi bi-house"></i> 继续购物
                                </a>
                            </div>
                            <div>
                                <form method="post" action="${pageContext.request.contextPath}/submitOrder"
                                    style="display: inline;">
                                    <button type="submit" class="btn btn-success pay-button" id="payButton">
                                        <i class="bi bi-credit-card-2-front"></i> 确认支付
                                    </button>
                                </form>
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
                                    <div class="footer-icon text-danger mb-2"><i class="bi bi-lightning-charge"></i>
                                    </div>
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

                    <!-- 支付功能 JS -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // 支付按钮点击事件
                            var payButton = document.getElementById('payButton');
                            if (payButton) {
                                payButton.addEventListener('click', function (event) {
                                    // 可以在这里添加支付前的确认逻辑
                                    if (!confirm('确认要支付此订单吗？')) {
                                        event.preventDefault();
                                        return false;
                                    }

                                    // 禁用按钮防止重复提交
                                    this.disabled = true;
                                    this.innerHTML = '<i class="bi bi-hourglass-split"></i> 处理中...';

                                    // 提交表单
                                    this.closest('form').submit();
                                });
                            }
                        });
                    </script>
                </body>

                </html>