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
                            /* 全局变量定义 */
                            :root {
                                --primary-red: #ff4757;
                                --primary-orange: #ffa502;
                                --success-green: #2ed573;
                                --info-blue: #3742fa;
                                --dark-gray: #2f3542;
                                --light-gray: #f1f2f6;
                                --warm-white: #ffffff;
                                --shadow-light: 0 4px 20px rgba(0, 0, 0, 0.08);
                                --shadow-medium: 0 8px 30px rgba(0, 0, 0, 0.12);
                                --border-radius: 12px;
                                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            }

                            /* 页面整体样式 */
                            body {
                                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                                font-family: 'Microsoft YaHei', '微软雅黑', sans-serif;
                                min-height: 100vh;
                            }

                            /* 导航栏样式 - 与首页保持一致 */
                            .navbar {
                                background: linear-gradient(135deg, #ff4757 0%, #ff3742 100%) !important;
                                box-shadow: 0 2px 20px rgba(255, 71, 87, 0.3);
                                border: none;
                                padding-top: 0.8rem;
                                padding-bottom: 0.8rem;
                            }

                            .navbar-brand-text {
                                color: white !important;
                                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                                font-family: 'Arial Black', 'FZYaoti', 'FZCuHeiSongS-B-GB', 'FZShuTi', 'STHeiti', 'SimHei', sans-serif;
                                font-size: 2.8rem;
                                font-weight: 900;
                                letter-spacing: 0.08em;
                            }

                            .navbar-nav .nav-link {
                                color: white !important;
                                font-size: 1.35rem;
                                font-weight: 600;
                                padding-left: 1.2rem;
                                padding-right: 1.2rem;
                                letter-spacing: 0.03em;
                                transition: var(--transition);
                            }

                            .navbar-nav .nav-link:hover,
                            .navbar-nav .nav-link:focus {
                                color: #ffeaa7 !important;
                                transform: translateY(-1px);
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

                            /* 搜索框样式 */
                            .navbar form input.form-control {
                                border-radius: 25px;
                                border: 2px solid rgba(255, 255, 255, 0.3);
                                background: rgba(255, 255, 255, 0.9);
                                padding: 10px 20px;
                                font-size: 14px;
                            }

                            .navbar form input.form-control:focus {
                                border-color: var(--primary-orange);
                                box-shadow: 0 0 0 3px rgba(255, 165, 2, 0.2);
                                background: white;
                            }

                            .navbar form button {
                                border-radius: 25px;
                                background: var(--primary-orange);
                                border: none;
                                padding: 10px 20px;
                                font-weight: 600;
                            }

                            /* 购物车角标样式 */
                            .cart-link {
                                position: relative;
                                display: inline-block;
                            }

                            .cart-badge {
                                position: absolute;
                                top: -8px;
                                right: -8px;
                                background: linear-gradient(135deg, var(--primary-orange), #ff6348);
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
                                animation: pulse 2s infinite;
                            }

                            @keyframes pulse {
                                0% {
                                    transform: scale(1);
                                }

                                50% {
                                    transform: scale(1.1);
                                }

                                100% {
                                    transform: scale(1);
                                }
                            }

                            .cart-badge.large-number {
                                width: 24px;
                                height: 20px;
                                border-radius: 10px;
                                font-size: 11px;
                            }

                            /* 商品详情容器 */
                            .product-detail-container {
                                background: white;
                                border-radius: var(--border-radius);
                                box-shadow: var(--shadow-medium);
                                padding: 40px;
                                margin: 30px auto;
                                max-width: 1200px;
                                position: relative;
                                overflow: hidden;
                            }

                            .product-detail-container::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                height: 4px;
                                background: linear-gradient(90deg, var(--primary-red), var(--primary-orange));
                            }

                            /* 图片展示区域 */
                            .product-image-section {
                                position: relative;
                                background: #fafafa;
                                border-radius: var(--border-radius);
                                padding: 20px;
                                box-shadow: var(--shadow-light);
                            }

                            .product-main-image {
                                max-height: 500px !important;
                                width: 100%;
                                object-fit: contain;
                                border-radius: 8px;
                                transition: all 0.4s ease;
                                background: white;
                                padding: 10px;
                            }

                            .product-main-image:hover {
                                transform: scale(1.05);
                            }

                            /* 缩略图容器 */
                            .thumbnail-container {
                                display: flex;
                                justify-content: center;
                                margin-top: 20px;
                                gap: 10px;
                                flex-wrap: wrap;
                            }

                            .thumbnail {
                                width: 80px;
                                height: 80px;
                                object-fit: cover;
                                border: 3px solid #e0e0e0;
                                cursor: pointer;
                                border-radius: 8px;
                                transition: var(--transition);
                                background: white;
                                padding: 5px;
                            }

                            .thumbnail:hover {
                                border-color: var(--primary-orange);
                                transform: translateY(-2px);
                                box-shadow: 0 4px 12px rgba(255, 165, 2, 0.3);
                            }

                            .thumbnail.active {
                                border-color: var(--primary-red);
                                box-shadow: 0 4px 15px rgba(255, 71, 87, 0.4);
                                transform: scale(1.1);
                            }

                            /* 商品信息区域 */
                            .product-info-section {
                                padding-left: 30px;
                            }

                            .product-title {
                                font-size: 2rem;
                                font-weight: 700;
                                color: var(--dark-gray);
                                margin-bottom: 15px;
                                line-height: 1.3;
                            }

                            .product-description {
                                font-size: 1.1rem;
                                color: #666;
                                line-height: 1.6;
                                margin-bottom: 20px;
                                padding: 15px;
                                background: #f8f9fa;
                                border-radius: 8px;
                                border-left: 4px solid var(--primary-orange);
                            }

                            /* 特色标签 */
                            .feature-badges {
                                display: flex;
                                gap: 10px;
                                margin: 20px 0;
                                flex-wrap: wrap;
                            }

                            .feature-badge {
                                background: linear-gradient(135deg, #667eea, #764ba2);
                                color: white;
                                padding: 5px 12px;
                                border-radius: 15px;
                                font-size: 0.8rem;
                                font-weight: 600;
                            }

                            /* 价格展示 */
                            .price-section {
                                background: linear-gradient(135deg, #fff5f5 0%, #ffe8e8 100%);
                                padding: 20px;
                                border-radius: 12px;
                                margin: 20px 0;
                                border: 2px solid rgba(255, 71, 87, 0.1);
                            }

                            .current-price {
                                font-size: 2.5rem;
                                font-weight: 900;
                                color: var(--primary-red);
                                text-shadow: 1px 1px 2px rgba(255, 71, 87, 0.2);
                            }

                            .price-currency {
                                font-size: 1.5rem;
                                vertical-align: top;
                                margin-right: 5px;
                            }

                            /* 销量信息 */
                            .sales-info {
                                display: inline-block;
                                background: var(--light-gray);
                                color: var(--dark-gray);
                                padding: 8px 15px;
                                border-radius: 20px;
                                font-size: 0.9rem;
                                font-weight: 600;
                                margin-top: 10px;
                            }

                            .sales-info i {
                                color: var(--primary-orange);
                                margin-right: 5px;
                            }

                            /* 推荐区域 */
                            .recommend-section {
                                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                                border-radius: 12px;
                                padding: 25px;
                                margin: 30px 0;
                                border: none;
                                box-shadow: var(--shadow-light);
                            }

                            .recommend-title {
                                font-size: 1.3rem;
                                font-weight: 700;
                                color: var(--dark-gray);
                                margin-bottom: 20px;
                                display: flex;
                                align-items: center;
                            }

                            .recommend-title i {
                                color: var(--primary-orange);
                                margin-right: 10px;
                                font-size: 1.5rem;
                            }

                            .product-recommend-item {
                                border: none;
                                border-radius: 10px;
                                transition: var(--transition);
                                overflow: hidden;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                                background: white;
                            }

                            .product-recommend-item:hover {
                                transform: translateY(-5px);
                                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                            }

                            .product-recommend-item .card-img-top {
                                transition: transform 0.3s ease;
                            }

                            .product-recommend-item:hover .card-img-top {
                                transform: scale(1.1);
                            }

                            /* 操作区域 */
                            .action-area {
                                background: white;
                                padding: 30px;
                                border-radius: 12px;
                                box-shadow: var(--shadow-light);
                                margin-top: 30px;
                                border: 1px solid #f0f0f0;
                            }

                            /* 数量选择器 */
                            .quantity-selector {
                                margin-bottom: 20px;
                            }

                            .quantity-label {
                                font-weight: 600;
                                color: var(--dark-gray);
                                margin-bottom: 10px;
                                display: block;
                            }

                            .quantity-controls {
                                display: flex;
                                align-items: center;
                                border: 2px solid #e0e0e0;
                                border-radius: 25px;
                                overflow: hidden;
                                width: fit-content;
                                background: white;
                            }

                            .quantity-controls button {
                                border: none;
                                background: #f8f9fa;
                                width: 40px;
                                height: 40px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-weight: bold;
                                color: var(--dark-gray);
                                transition: var(--transition);
                            }

                            .quantity-controls button:hover {
                                background: var(--primary-orange);
                                color: white;
                            }

                            .quantity-controls input {
                                border: none;
                                width: 60px;
                                height: 40px;
                                text-align: center;
                                font-weight: 600;
                                background: white;
                            }

                            .quantity-controls input:focus {
                                outline: none;
                                box-shadow: none;
                            }

                            /* 按钮组 */
                            .button-group {
                                display: flex;
                                gap: 15px;
                                flex-wrap: wrap;
                            }

                            .action-btn {
                                padding: 12px 30px;
                                border-radius: 25px;
                                font-weight: 600;
                                font-size: 1.1rem;
                                border: none;
                                transition: var(--transition);
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                text-decoration: none;
                                min-width: 160px;
                                justify-content: center;
                            }

                            .btn-add-cart {
                                background: linear-gradient(135deg, var(--primary-red), var(--primary-orange));
                                color: white;
                                box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);
                            }

                            .btn-add-cart:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 6px 20px rgba(255, 71, 87, 0.4);
                                color: white;
                            }

                            .btn-buy-now {
                                background: linear-gradient(135deg, var(--success-green), #20bf6b);
                                color: white;
                                box-shadow: 0 4px 15px rgba(46, 213, 115, 0.3);
                            }

                            .btn-buy-now:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 6px 20px rgba(46, 213, 115, 0.4);
                                color: white;
                            }

                            /* 页脚样式 - 与首页保持一致 */
                            .custom-footer {
                                background: linear-gradient(135deg, #2f3542 0%, #40407a 100%);
                                color: white;
                                border-top: none;
                                margin-top: 60px;
                            }

                            .footer-icon {
                                color: var(--primary-orange) !important;
                                font-size: 2.2rem;
                                margin-bottom: 15px;
                            }

                            .footer-text {
                                color: #ddd;
                                font-size: 1.08rem;
                                font-weight: 500;
                                letter-spacing: 0.01em;
                            }

                            /* 响应式设计 */
                            @media (max-width: 768px) {
                                .product-detail-container {
                                    padding: 20px;
                                    margin: 15px;
                                }

                                .product-info-section {
                                    padding-left: 0;
                                    margin-top: 30px;
                                }

                                .current-price {
                                    font-size: 2rem;
                                }

                                .button-group {
                                    flex-direction: column;
                                }

                                .action-btn {
                                    width: 100%;
                                }

                                .navbar-brand-text {
                                    font-size: 1.5rem !important;
                                }
                            }
                        </style>
                    </head>

                    <body>
                        <!-- 导航栏 - 与首页保持完全一致 -->
                        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
                            <div class="container">
                                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                                    <span class="navbar-brand-text">拼夕夕商城</span>
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

                        <!-- 商品不存在提示 -->
                        <c:if test="${empty product}">
                            <div class="container alert alert-danger">
                                <h3>商品信息不存在或已下架</h3>
                                <p>请返回首页查看其他商品</p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">返回首页</a>
                            </div>
                        </c:if>

                        <!-- 商品详情内容 -->
                        <c:if test="${not empty product}">
                            <div class="container-fluid product-detail-container">
                                <div class="row">
                                    <!-- 左侧图片区域 -->
                                    <div class="col-md-6 mb-4 mb-md-0">
                                        <div class="product-image-section">
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
                                    </div>

                                    <!-- 右侧信息区域 -->
                                    <div class="col-md-6 product-info-section">
                                        <h1 class="product-title">${product.name}</h1>

                                        <!-- 特色标签 -->
                                        <div class="feature-badges">
                                            <span class="feature-badge">正品保证</span>
                                            <span class="feature-badge">快速发货</span>
                                            <span class="feature-badge">7天退换</span>
                                        </div>

                                        <div class="product-description">
                                            ${product.description}
                                        </div>

                                        <!-- 价格区域 -->
                                        <div class="price-section">
                                            <div class="current-price">
                                                <span class="price-currency">¥</span>
                                                <fmt:formatNumber value="${product.price}" type="number"
                                                    minFractionDigits="2" maxFractionDigits="2" />
                                            </div>
                                            <div class="sales-info">
                                                <i class="bi bi-graph-up"></i>已售 ${product.salesVolume} 件
                                            </div>
                                        </div>

                                        <!-- 商品推荐区域 -->
                                        <c:if test="${not empty allProductsForNav}">
                                            <div class="recommend-section">
                                                <h5 class="recommend-title">
                                                    <i class="bi bi-grid-3x3-gap-fill"></i>其他商品推荐
                                                </h5>
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

                                        <!-- 操作区域 -->
                                        <div class="action-area">
                                            <div class="quantity-selector">
                                                <label class="quantity-label">选择数量：</label>
                                                <div class="quantity-controls">
                                                    <button type="button" id="decreaseQty">-</button>
                                                    <input type="number" id="quantity" value="1" min="1" max="99">
                                                    <button type="button" id="increaseQty">+</button>
                                                </div>
                                            </div>

                                            <div class="button-group">
                                                <a href="#" id="addToCartBtn" class="action-btn btn-add-cart">
                                                    <i class="bi bi-cart-plus"></i> 加入购物车
                                                </a>
                                                <a href="#" id="buyNowBtn" class="action-btn btn-buy-now">
                                                    <i class="bi bi-bag-check"></i> 立即购买
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- 页脚 - 与首页保持完全一致 -->
                        <footer class="custom-footer mt-auto py-4">
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
                                        <div class="footer-icon text-danger mb-2"><i class="bi bi-patch-check"></i>
                                        </div>
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
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                            // 全局变量
                            var USER_IS_LOGGED_IN = '${sessionScope.loggedInUser != null ? "true" : "false"}' === 'true';
                            var APP_CONTEXT_PATH = '${pageContext.request.contextPath}';
                            var PRODUCT_ID = '${not empty product ? product.id : ""}';

                            // 页面加载完成后执行
                            document.addEventListener('DOMContentLoaded', function () {
                                // 数量选择器逻辑
                                var qtyInput = document.getElementById('quantity');
                                var decreaseBtn = document.getElementById('decreaseQty');
                                var increaseBtn = document.getElementById('increaseQty');

                                if (qtyInput && decreaseBtn && increaseBtn) {
                                    // 减少数量
                                    decreaseBtn.onclick = function () {
                                        var currentValue = parseInt(qtyInput.value) || 1;
                                        if (currentValue > 1) {
                                            qtyInput.value = currentValue - 1;
                                        }
                                    };

                                    // 增加数量
                                    increaseBtn.onclick = function () {
                                        var currentValue = parseInt(qtyInput.value) || 1;
                                        if (currentValue < 99) {
                                            qtyInput.value = currentValue + 1;
                                        }
                                    };

                                    // 输入框值变化验证
                                    qtyInput.addEventListener('input', function () {
                                        var value = parseInt(this.value);
                                        if (isNaN(value) || value < 1) {
                                            this.value = 1;
                                        } else if (value > 99) {
                                            this.value = 99;
                                        }
                                    });

                                    // 失去焦点时验证
                                    qtyInput.addEventListener('blur', function () {
                                        if (this.value === '' || parseInt(this.value) < 1) {
                                            this.value = 1;
                                        }
                                    });
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

                                        if (!USER_IS_LOGGED_IN) {
                                            alert('请先登录！');
                                            window.location.href = APP_CONTEXT_PATH + '/login';
                                            return false;
                                        }

                                        var quantity = parseInt(qtyInput.value) || 1;

                                        // 添加加载效果
                                        var originalText = this.innerHTML;
                                        this.innerHTML = '<i class="bi bi-hourglass-split"></i> 添加中...';
                                        this.style.pointerEvents = 'none';

                                        // 模拟加载时间，然后跳转
                                        setTimeout(function () {
                                            var url = APP_CONTEXT_PATH + '/cart?action=add&productId=' + PRODUCT_ID + '&quantity=' + quantity;
                                            window.location.href = url;
                                        }, 500);
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

                                        if (!USER_IS_LOGGED_IN) {
                                            alert('请先登录！');
                                            window.location.href = APP_CONTEXT_PATH + '/login';
                                            return false;
                                        }

                                        var quantity = parseInt(qtyInput.value) || 1;

                                        // 添加加载效果
                                        var originalText = this.innerHTML;
                                        this.innerHTML = '<i class="bi bi-hourglass-split"></i> 处理中...';
                                        this.style.pointerEvents = 'none';

                                        // 模拟加载时间，然后跳转
                                        setTimeout(function () {
                                            var url = APP_CONTEXT_PATH + '/checkout?productId=' + PRODUCT_ID + '&quantity=' + quantity;
                                            window.location.href = url;
                                        }, 500);
                                    };
                                }

                                // 图片缩略图切换逻辑
                                var thumbnails = document.querySelectorAll('.thumbnail');
                                var mainImage = document.getElementById('mainImage');

                                if (thumbnails.length > 0 && mainImage) {
                                    thumbnails.forEach(function (thumbnail) {
                                        thumbnail.addEventListener('click', function () {
                                            // 移除所有缩略图的active类
                                            thumbnails.forEach(function (thumb) {
                                                thumb.classList.remove('active');
                                            });

                                            // 添加active类到当前点击的缩略图
                                            this.classList.add('active');

                                            // 更新主图，添加淡入效果
                                            mainImage.style.opacity = '0.5';
                                            setTimeout(function () {
                                                mainImage.src = thumbnail.getAttribute('data-src');
                                                mainImage.style.opacity = '1';
                                            }, 150);
                                        });

                                        // 添加键盘支持
                                        thumbnail.addEventListener('keydown', function (e) {
                                            if (e.key === 'Enter' || e.key === ' ') {
                                                e.preventDefault();
                                                this.click();
                                            }
                                        });

                                        // 使缩略图可聚焦
                                        thumbnail.setAttribute('tabindex', '0');
                                    });
                                }

                                // 图片加载错误处理
                                if (mainImage) {
                                    mainImage.addEventListener('error', function () {
                                        this.src = APP_CONTEXT_PATH + '/images/placeholder.jpg';
                                        this.alt = '图片加载失败';
                                    });
                                }

                                // 为所有缩略图添加错误处理
                                thumbnails.forEach(function (thumbnail) {
                                    thumbnail.addEventListener('error', function () {
                                        this.style.display = 'none';
                                    });
                                });

                                // 添加页面加载动画
                                var container = document.querySelector('.product-detail-container');
                                if (container) {
                                    container.style.opacity = '0';
                                    container.style.transform = 'translateY(20px)';
                                    container.style.transition = 'all 0.6s ease';

                                    setTimeout(function () {
                                        container.style.opacity = '1';
                                        container.style.transform = 'translateY(0)';
                                    }, 100);
                                }

                                // 滚动到顶部功能（可选）
                                var scrollToTop = function () {
                                    window.scrollTo({
                                        top: 0,
                                        behavior: 'smooth'
                                    });
                                };

                                // 如果页面很长，可以添加返回顶部按钮
                                var createBackToTopButton = function () {
                                    var backToTopBtn = document.createElement('button');
                                    backToTopBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
                                    backToTopBtn.className = 'btn btn-primary position-fixed';
                                    backToTopBtn.style.cssText = `
                    bottom: 20px;
                    right: 20px;
                    z-index: 1000;
                    border-radius: 50%;
                    width: 50px;
                    height: 50px;
                    display: none;
                    box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);
                `;

                                    backToTopBtn.onclick = scrollToTop;
                                    document.body.appendChild(backToTopBtn);

                                    // 滚动显示/隐藏按钮
                                    window.addEventListener('scroll', function () {
                                        if (window.pageYOffset > 300) {
                                            backToTopBtn.style.display = 'block';
                                        } else {
                                            backToTopBtn.style.display = 'none';
                                        }
                                    });
                                };

                                // 如果页面内容足够长，创建返回顶部按钮
                                if (document.body.scrollHeight > window.innerHeight + 500) {
                                    createBackToTopButton();
                                }

                                // 添加商品推荐卡片的懒加载效果
                                var recommendItems = document.querySelectorAll('.product-recommend-item');
                                if (recommendItems.length > 0) {
                                    var observerOptions = {
                                        threshold: 0.1,
                                        rootMargin: '0px 0px -50px 0px'
                                    };

                                    var observer = new IntersectionObserver(function (entries) {
                                        entries.forEach(function (entry) {
                                            if (entry.isIntersecting) {
                                                entry.target.style.opacity = '1';
                                                entry.target.style.transform = 'translateY(0)';
                                            }
                                        });
                                    }, observerOptions);

                                    recommendItems.forEach(function (item, index) {
                                        item.style.opacity = '0';
                                        item.style.transform = 'translateY(20px)';
                                        item.style.transition = 'all 0.6s ease ' + (index * 0.1) + 's';
                                        observer.observe(item);
                                    });
                                }
                            });

                            // 全局错误处理
                            window.addEventListener('error', function (e) {
                                console.error('页面错误:', e.error);
                            });

                            // 防止表单重复提交
                            var formSubmitted = false;
                            var preventDoubleSubmit = function () {
                                if (formSubmitted) {
                                    return false;
                                }
                                formSubmitted = true;
                                return true;
                            };

                            // 页面卸载前重置标志
                            window.addEventListener('beforeunload', function () {
                                formSubmitted = false;
                            });
                        </script>
                    </body>

                    </html>