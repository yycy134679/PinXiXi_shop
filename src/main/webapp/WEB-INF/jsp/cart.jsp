<%@ page errorPage="error.jsp" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <!-- 设置页面标题 -->
                    <c:set var="pageTitle" value="购物车 - PinXiXi 商城" scope="request" />
                    <!DOCTYPE html>
                    <html lang="zh-cn">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <title>${pageTitle}</title>
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
                                display: flex;
                                flex-direction: column;
                                min-height: 100vh;
                            }

                            .cart-container {
                                background: #fff;
                                border-radius: 8px;
                                box-shadow: 0 2px 8px #0001;
                                padding: 2rem;
                                margin-top: 2rem;
                                margin-bottom: 2rem;
                                flex: 1;
                            }

                            .cart-item {
                                border-bottom: 1px solid #eee;
                                padding: 15px 0;
                            }

                            .cart-item:last-child {
                                border-bottom: none;
                            }

                            .cart-item-img {
                                width: 100px;
                                height: 100px;
                                object-fit: contain;
                                background: #f6f6f6;
                                border-radius: 4px;
                            }

                            .cart-item-name {
                                font-weight: 500;
                                color: #333;
                                text-decoration: none;
                            }

                            .cart-item-name:hover {
                                color: #ff4d4f;
                            }

                            .cart-item-price {
                                color: #ff4d4f;
                                font-weight: 600;
                            }

                            .cart-item-subtotal {
                                color: #ff4d4f;
                                font-weight: 700;
                                font-size: 1.1rem;
                            }

                            .quantity-selector {
                                width: 120px;
                                display: flex;
                                align-items: center;
                            }

                            .quantity-selector button {
                                width: 35px;
                                height: 35px;
                                padding: 0;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .quantity-selector input {
                                width: 50px;
                                text-align: center;
                                border-left: 0;
                                border-right: 0;
                                height: 35px;
                            }

                            .cart-actions {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                padding-top: 20px;
                                border-top: 1px solid #eee;
                            }

                            .cart-total {
                                font-size: 1.5rem;
                                font-weight: 700;
                                color: #ff4d4f;
                            }

                            .empty-cart {
                                text-align: center;
                                padding: 50px 0;
                            }

                            .empty-cart-icon {
                                font-size: 5rem;
                                color: #ddd;
                                margin-bottom: 20px;
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

                            /* 提示消息样式 */
                            .cart-message {
                                margin-bottom: 20px;
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
                        <div class="container cart-container">
                            <h2 class="mb-4"><i class="bi bi-cart3"></i> 我的购物车</h2>

                            <!-- 提示消息 -->
                            <c:if test="${not empty sessionScope.cartMessage}">
                                <div class="alert alert-success cart-message" role="alert">
                                    ${sessionScope.cartMessage}
                                    <c:remove var="cartMessage" scope="session" />
                                </div>
                            </c:if>

                            <!-- 购物车内容 -->
                            <c:choose>
                                <c:when test="${empty cart || empty cart.items}">
                                    <!-- 空购物车提示 -->
                                    <div class="empty-cart">
                                        <div class="empty-cart-icon">
                                            <i class="bi bi-cart-x"></i>
                                        </div>
                                        <h3 class="mb-3">您的购物车还是空的</h3>
                                        <p class="text-muted mb-4">快去挑选喜爱的商品吧！</p>
                                        <a href="${pageContext.request.contextPath}/home"
                                            class="btn btn-primary btn-lg">去逛逛</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- 购物车商品列表 -->
                                    <div class="table-responsive">
                                        <table class="table align-middle">
                                            <thead>
                                                <tr>
                                                    <th scope="col" width="15%">图片</th>
                                                    <th scope="col" width="30%">商品名称</th>
                                                    <th scope="col" width="15%">单价</th>
                                                    <th scope="col" width="15%">数量</th>
                                                    <th scope="col" width="15%">小计</th>
                                                    <th scope="col" width="10%">操作</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="entry" items="${cart.items}">
                                                    <c:set var="cartItem" value="${entry.value}" />
                                                    <c:set var="product" value="${cartItem.product}" />
                                                    <c:set var="quantity" value="${cartItem.quantity}" />
                                                    <tr class="cart-item">
                                                        <td>
                                                            <a
                                                                href="${pageContext.request.contextPath}/productDetail?id=${product.id}">
                                                                <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                                    alt="${product.name}" class="cart-item-img">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/productDetail?id=${product.id}"
                                                                class="cart-item-name">${product.name}</a>
                                                        </td>
                                                        <td class="cart-item-price">¥
                                                            <fmt:formatNumber value="${product.price}" type="number"
                                                                minFractionDigits="2" maxFractionDigits="2" />
                                                        </td>
                                                        <td>
                                                            <!-- 数量选择器 -->
                                                            <div class="quantity-selector">
                                                                <button class="btn btn-outline-secondary decrease-qty"
                                                                    type="button" data-product-id="${product.id}"
                                                                    ${quantity <=1 ? 'disabled' : '' }>-</button>
                                                                <input type="number" class="form-control cart-item-qty"
                                                                    value="${quantity}" min="1" max="99"
                                                                    data-product-id="${product.id}">
                                                                <button class="btn btn-outline-secondary increase-qty"
                                                                    type="button"
                                                                    data-product-id="${product.id}">+</button>
                                                            </div>
                                                        </td>
                                                        <td class="cart-item-subtotal">¥
                                                            <fmt:formatNumber value="${cartItem.subtotal}" type="number"
                                                                minFractionDigits="2" maxFractionDigits="2" />
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${product.id}"
                                                                class="btn btn-danger btn-sm remove-item"
                                                                data-product-id="${product.id}">
                                                                <i class="bi bi-trash"></i> 删除
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- 购物车底部 (结算区) -->
                                    <div class="cart-actions">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/cart?action=clear"
                                                class="btn btn-outline-danger clear-cart">
                                                <i class="bi bi-trash"></i> 清空购物车
                                            </a>
                                            <a href="${pageContext.request.contextPath}/home"
                                                class="btn btn-outline-secondary ms-2">
                                                <i class="bi bi-arrow-left"></i> 继续购物
                                            </a>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                商品总数: <span class="fw-bold">${cart.totalItemsCount}</span> 件
                                            </div>
                                            <div class="me-4">
                                                <span class="cart-total">总计: ¥
                                                    <fmt:formatNumber value="${cart.totalPrice}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/checkout"
                                                class="btn btn-success btn-lg">
                                                <i class="bi bi-credit-card"></i> 去结算
                                            </a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 页脚 -->
                        <footer class="custom-footer py-4">
                            <div class="container">
                                <div class="row justify-content-center text-center">
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2"><i class="bi bi-layers"></i>
                                        </div>
                                        <div class="footer-text">品类齐全，轻松购物</div>
                                    </div>
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2"><i class="bi bi-lightning-charge"></i>
                                        </div>
                                        <div class="footer-text">多仓直发，极速配送</div>
                                    </div>
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2"><i class="bi bi-patch-check"></i>
                                        </div>
                                        <div class="footer-text">正品行货，精致服务</div>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <div class="footer-icon text-danger mb-2"><i class="bi bi-cash-coin"></i>
                                        </div>
                                        <div class="footer-text">天天低价，畅选无忧</div>
                                    </div>
                                </div>
                            </div>
                        </footer>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                        <!-- 购物车功能 JS -->
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                // 数量减少按钮
                                document.querySelectorAll('.decrease-qty').forEach(function (button) {
                                    button.addEventListener('click', function () {
                                        var productId = this.getAttribute('data-product-id');
                                        var inputElement = document.querySelector('.cart-item-qty[data-product-id="' + productId + '"]');
                                        var currentValue = parseInt(inputElement.value) || 1;

                                        if (currentValue > 1) {
                                            inputElement.value = currentValue - 1;
                                            updateCartItem(productId, currentValue - 1);

                                            // 禁用减号按钮如果数量为1
                                            if (currentValue - 1 === 1) {
                                                this.disabled = true;
                                            }
                                        }
                                    });
                                });

                                // 数量增加按钮
                                document.querySelectorAll('.increase-qty').forEach(function (button) {
                                    button.addEventListener('click', function () {
                                        var productId = this.getAttribute('data-product-id');
                                        var inputElement = document.querySelector('.cart-item-qty[data-product-id="' + productId + '"]');
                                        var currentValue = parseInt(inputElement.value) || 1;

                                        if (currentValue < 99) {
                                            inputElement.value = currentValue + 1;
                                            updateCartItem(productId, currentValue + 1);

                                            // 启用减号按钮
                                            var decreaseButton = document.querySelector('.decrease-qty[data-product-id="' + productId + '"]');
                                            decreaseButton.disabled = false;
                                        }
                                    });
                                });

                                // 输入框数量变化
                                document.querySelectorAll('.cart-item-qty').forEach(function (input) {
                                    input.addEventListener('change', function () {
                                        var productId = this.getAttribute('data-product-id');
                                        var newValue = parseInt(this.value) || 1;

                                        // 确保数量在1-99之间
                                        if (newValue < 1) {
                                            newValue = 1;
                                            this.value = 1;
                                        } else if (newValue > 99) {
                                            newValue = 99;
                                            this.value = 99;
                                        }

                                        updateCartItem(productId, newValue);

                                        // 更新减号按钮状态
                                        var decreaseButton = document.querySelector('.decrease-qty[data-product-id="' + productId + '"]');
                                        decreaseButton.disabled = (newValue <= 1);
                                    });
                                });

                                // 删除商品确认
                                document.querySelectorAll('.remove-item').forEach(function (button) {
                                    button.addEventListener('click', function (event) {
                                        if (!confirm('确定要删除这个商品吗？')) {
                                            event.preventDefault();
                                        }
                                    });
                                });

                                // 清空购物车确认
                                var clearCartButton = document.querySelector('.clear-cart');
                                if (clearCartButton) {
                                    clearCartButton.addEventListener('click', function (event) {
                                        if (!confirm('确定要清空购物车吗？')) {
                                            event.preventDefault();
                                        }
                                    });
                                }

                                // 更新购物车商品数量的函数
                                function updateCartItem(productId, newQuantity) {
                                    // 跳转到更新操作的URL
                                    window.location.href = '${pageContext.request.contextPath}/cart?action=update&productId=' + productId + '&newQuantity=' + newQuantity;
                                }
                            });
                        </script>
                    </body>

                    </html>