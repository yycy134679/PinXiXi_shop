<%@ page errorPage="error.jsp" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <!-- 设置页面标题 -->
                    <c:set var="pageTitle" value="${not empty product ? product.name : '商品详情'} - PinXiXi 商城"
                        scope="request" />
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
                            }

                            .product-detail-container {
                                background: #fff;
                                border-radius: 8px;
                                box-shadow: 0 2px 8px #0001;
                                padding: 2rem 2rem 1.5rem 2rem;
                                margin-top: 2rem;
                            }

                            .mini-nav-title {
                                margin-top: 1.5rem;
                                margin-bottom: 1rem;
                            }

                            .thumbnail-container {
                                display: flex;
                                margin-top: 10px;
                                justify-content: center;
                            }

                            .thumbnail {
                                width: 80px;
                                height: 80px;
                                object-fit: cover;
                                margin: 0 5px;
                                border: 1px solid #ddd;
                                cursor: pointer;
                                border-radius: 4px;
                            }

                            .thumbnail.active {
                                border: 2px solid #007bff;
                            }

                            /* 加大商品图片展示区域 */
                            .product-main-image {
                                max-height: 450px !important;
                                width: 100%;
                                object-fit: contain;
                                background: #f6f6f6;
                                transition: all 0.3s ease;
                            }

                            /* 商品推荐区域样式优化 */
                            .product-recommend-item {
                                transition: all 0.2s ease;
                                border-radius: 6px;
                                overflow: hidden;
                            }

                            .product-recommend-item:hover {
                                transform: translateY(-3px);
                                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                            }

                            /* 商品推荐区样式 */
                            .recommend-section {
                                margin: 1rem 0;
                                padding: 0.8rem 0;
                                border-top: 1px dashed #ddd;
                                border-bottom: 1px dashed #ddd;
                            }

                            /* 操作区样式 */
                            .action-area {
                                display: flex;
                                align-items: center;
                                flex-wrap: wrap;
                            }

                            .quantity-selector {
                                margin-right: 15px;
                            }

                            @media (max-width: 767px) {
                                .action-area {
                                    flex-direction: column;
                                    align-items: flex-start;
                                }

                                .quantity-selector {
                                    margin-bottom: 15px;
                                }
                            }

                            /* 导航栏样式 - 从home.jsp复制 */
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

                            /* 页脚样式 - 从home.jsp复制 */
                            .custom-footer {
                                background: #f8f9fb;
                                border-top: 1px solid #eee;
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
                        </style>
                    </head>

                    <body>
                        <!-- 导航栏 - 使用与home.jsp相同的样式 -->
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

                        <c:if test="${empty product}">
                            <div class="container alert alert-danger">
                                <h3>商品信息不存在或已下架</h3>
                                <p>请返回首页查看其他商品</p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">返回首页</a>
                            </div>
                        </c:if>

                        <c:if test="${not empty product}">
                            <div class="container-fluid product-detail-container">
                                <div class="row">
                                    <!-- 左侧图片区域 - 主图和缩略图 -->
                                    <div class="col-md-6 mb-4 mb-md-0">
                                        <div class="mb-2 text-center">
                                            <img id="mainImage"
                                                src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                class="img-fluid rounded shadow-sm product-main-image"
                                                alt="${product.name}">
                                        </div>
                                        <!-- 缩略图区域 -->
                                        <div class="thumbnail-container">
                                            <!-- 主图缩略图 -->
                                            <img class="thumbnail active"
                                                src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                alt="${product.name}"
                                                data-src="${pageContext.request.contextPath}/${product.imageUrl}">

                                            <!-- 细节图1缩略图 -->
                                            <c:set var="detailImage1"
                                                value="${fn:replace(product.imageUrl, '.jpg', '_d1.jpg')}" />
                                            <img class="thumbnail"
                                                src="${pageContext.request.contextPath}/${detailImage1}"
                                                alt="${product.name} 细节图1"
                                                data-src="${pageContext.request.contextPath}/${detailImage1}"
                                                onerror="this.style.display='none'">

                                            <!-- 细节图2缩略图 -->
                                            <c:set var="detailImage2"
                                                value="${fn:replace(product.imageUrl, '.jpg', '_d2.jpg')}" />
                                            <img class="thumbnail"
                                                src="${pageContext.request.contextPath}/${detailImage2}"
                                                alt="${product.name} 细节图2"
                                                data-src="${pageContext.request.contextPath}/${detailImage2}"
                                                onerror="this.style.display='none'">

                                            <!-- 细节图3缩略图 -->
                                            <c:set var="detailImage3"
                                                value="${fn:replace(product.imageUrl, '.jpg', '_d3.jpg')}" />
                                            <img class="thumbnail"
                                                src="${pageContext.request.contextPath}/${detailImage3}"
                                                alt="${product.name} 细节图3"
                                                data-src="${pageContext.request.contextPath}/${detailImage3}"
                                                onerror="this.style.display='none'">
                                        </div>
                                    </div>
                                    <!-- 右侧信息区域 -->
                                    <div class="col-md-6">
                                        <h1 class="mb-3">${product.name}</h1>
                                        <div class="mt-2 mb-3" style="font-size: 1.1rem;">
                                            ${product.description}
                                        </div>
                                        <p class="h3 text-danger mb-2">¥
                                            <fmt:formatNumber value="${product.price}" type="number"
                                                minFractionDigits="2" maxFractionDigits="2" />
                                        </p>

                                        <p class="text-muted">销量: ${product.salesVolume}</p>

                                        <!-- 迷你商品导航列表 -->
                                        <c:if test="${not empty allProductsForNav}">
                                            <div class="recommend-section">
                                                <h5 class="mb-3"><i class="bi bi-grid-3x3-gap-fill"></i> 其他商品推荐</h5>
                                                <div class="row">
                                                    <c:forEach var="navProd" items="${allProductsForNav}"
                                                        varStatus="status">
                                                        <c:if test="${not empty navProd && status.index < 6}">
                                                            <div class="col-md-4 col-sm-4 col-6 mb-2">
                                                                <div
                                                                    class="card h-100 text-center product-recommend-item">
                                                                    <a
                                                                        href="${pageContext.request.contextPath}/productDetail?id=${navProd.id}">
                                                                        <c:if test="${not empty navProd.imageUrl}">
                                                                            <img src="${pageContext.request.contextPath}/${navProd.imageUrl}"
                                                                                class="card-img-top p-2"
                                                                                style="height: 80px; object-fit: contain;"
                                                                                alt="${navProd.name}">
                                                                        </c:if>
                                                                    </a>
                                                                    <div class="card-body p-1">
                                                                        <h6 class="card-title small mb-0"
                                                                            style="font-size: 0.8rem;">
                                                                            <a href="${pageContext.request.contextPath}/productDetail?id=${navProd.id}"
                                                                                class="text-decoration-none text-dark stretched-link">${navProd.name}</a>
                                                                        </h6>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:if>

                                        <!-- 用户操作区域 -->
                                        <div class="action-area">
                                            <div class="quantity-selector d-flex align-items-center">
                                                <label for="quantity" class="me-2">数量：</label>
                                                <div class="input-group" style="width: 120px;">
                                                    <button class="btn btn-outline-secondary" type="button"
                                                        id="decreaseQty">-</button>
                                                    <input type="number" class="form-control text-center" id="quantity"
                                                        name="quantity" value="1" min="1" max="99"
                                                        style="max-width: 60px;">
                                                    <button class="btn btn-outline-secondary" type="button"
                                                        id="increaseQty">+</button>
                                                </div>
                                            </div>

                                            <div>
                                                <a href="#" id="addToCartBtn" class="btn btn-primary me-2">
                                                    <i class="bi bi-cart-plus"></i> 加入购物车
                                                </a>
                                                <a href="#" id="buyNowBtn" class="btn btn-success">
                                                    <i class="bi bi-bag-check"></i> 立即购买
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- 页脚 - 使用与home.jsp相同的样式 -->
                        <footer class="custom-footer mt-auto py-4">
                            <div class="container">
                                <div class="row justify-content-center text-center">
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2" style="font-size:2.2rem;"><i
                                                class="bi bi-layers"></i>
                                        </div>
                                        <div class="footer-text">品类齐全，轻松购物</div>
                                    </div>
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2" style="font-size:2.2rem;"><i
                                                class="bi bi-lightning-charge"></i>
                                        </div>
                                        <div class="footer-text">多仓直发，极速配送</div>
                                    </div>
                                    <div class="col-6 col-md-3 mb-3 mb-md-0">
                                        <div class="footer-icon text-danger mb-2" style="font-size:2.2rem;"><i
                                                class="bi bi-patch-check"></i>
                                        </div>
                                        <div class="footer-text">正品行货，精致服务</div>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <div class="footer-icon text-danger mb-2" style="font-size:2.2rem;"><i
                                                class="bi bi-cash-coin"></i>
                                        </div>
                                        <div class="footer-text">天天低价，畅选无忧</div>
                                    </div>
                                </div>
                            </div>
                        </footer>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                            // 全局变量
                            var USER_IS_LOGGED_IN = '${sessionScope.loggedInUser != null ? "true" : "false"}' === 'true';
                            var APP_CONTEXT_PATH = '${pageContext.request.contextPath}';
                            var PRODUCT_ID = '${not empty product ? product.id : ""}';

                            // 数量选择器逻辑
                            var qtyInput = document.getElementById('quantity');
                            if (qtyInput) {
                                document.getElementById('decreaseQty').onclick = function () {
                                    var v = parseInt(qtyInput.value) || 1;
                                    if (v > 1) qtyInput.value = v - 1;
                                };
                                document.getElementById('increaseQty').onclick = function () {
                                    var v = parseInt(qtyInput.value) || 1;
                                    if (v < 99) qtyInput.value = v + 1;
                                };
                            }

                            // 加入购物车按钮逻辑
                            var addToCartBtn = document.getElementById('addToCartBtn');
                            if (addToCartBtn) {
                                addToCartBtn.onclick = function (event) {
                                    event.preventDefault();
                                    if (!PRODUCT_ID) {
                                        alert('商品信息不存在');
                                        return false;
                                    }
                                    var quantity = parseInt(qtyInput.value) || 1;
                                    if (!USER_IS_LOGGED_IN) {
                                        alert('请先登录！');
                                        window.location.href = APP_CONTEXT_PATH + '/login';
                                        return false;
                                    }
                                    var url = APP_CONTEXT_PATH + '/cart?action=add&productId=' + PRODUCT_ID + '&quantity=' + quantity;
                                    window.location.href = url;
                                };
                            }

                            // 立即购买按钮逻辑
                            var buyNowBtn = document.getElementById('buyNowBtn');
                            if (buyNowBtn) {
                                buyNowBtn.onclick = function (event) {
                                    event.preventDefault();
                                    if (!PRODUCT_ID) {
                                        alert('商品信息不存在');
                                        return false;
                                    }
                                    var quantity = parseInt(qtyInput.value) || 1;
                                    if (!USER_IS_LOGGED_IN) {
                                        alert('请先登录！');
                                        window.location.href = APP_CONTEXT_PATH + '/login';
                                        return false;
                                    }
                                    var url = APP_CONTEXT_PATH + '/checkout?productId=' + PRODUCT_ID + '&quantity=' + quantity;
                                    window.location.href = url;
                                };
                            }

                            // 图片缩略图切换逻辑
                            document.addEventListener('DOMContentLoaded', function () {
                                var thumbnails = document.querySelectorAll('.thumbnail');
                                var mainImage = document.getElementById('mainImage');

                                thumbnails.forEach(function (thumbnail) {
                                    thumbnail.addEventListener('click', function () {
                                        // 移除所有缩略图的active类
                                        thumbnails.forEach(function (thumb) {
                                            thumb.classList.remove('active');
                                        });

                                        // 添加active类到当前点击的缩略图
                                        this.classList.add('active');

                                        // 更新主图
                                        mainImage.src = this.getAttribute('data-src');
                                    });
                                });
                            });
                        </script>
                    </body>

                    </html>