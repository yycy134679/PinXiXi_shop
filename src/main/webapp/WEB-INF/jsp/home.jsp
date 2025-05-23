<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="zh-CN">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <c:out value="${not empty pageTitle ? pageTitle : '拼夕夕 电商平台'}" />
                </title>
                <!-- 防止浏览器请求默认favicon.ico -->
                <link rel="icon" href="data:,">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                <style type="text/css">
                    /* 现代化电商平台样式 */
                    :root {
                        --primary-red: #ff4757;
                        --primary-orange: #ffa502;
                        --success-green: #2ed573;
                        --info-blue: #3742fa;
                        --dark-gray: #2f3542;
                        --light-gray: #f1f2f6;
                        --warm-white: #ffffff;
                        --shadow-color: rgba(0, 0, 0, 0.1);
                    }

                    /* 页面背景 */
                    body {
                        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                        min-height: 100vh;
                        font-family: 'Microsoft YaHei', '微软雅黑', sans-serif;
                    }

                    /* 导航栏样式升级 */
                    .navbar {
                        background: linear-gradient(135deg, #ff4757 0%, #ff3742 100%) !important;
                        box-shadow: 0 2px 20px rgba(255, 71, 87, 0.3);
                        border: none;
                        padding-top: 0.8rem;
                        padding-bottom: 0.8rem;
                    }

                    .navbar-brand-text {
                        color: white !important;
                        font-size: 2.8rem;
                        font-weight: 900;
                        letter-spacing: 0.08em;
                        font-family: 'Arial Black', 'FZYaoti', 'FZCuHeiSongS-B-GB', 'FZShuTi', 'STHeiti', 'SimHei', sans-serif;
                        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                        vertical-align: middle;
                    }

                    .navbar-brand img {
                        margin-top: -0.25rem;
                    }

                    /* 导航链接样式 */
                    .navbar-nav .nav-link {
                        font-size: 1.35rem;
                        font-weight: 600;
                        padding-left: 1.2rem;
                        padding-right: 1.2rem;
                        color: white !important;
                        letter-spacing: 0.03em;
                        transition: all 0.3s ease;
                    }

                    .navbar-nav .nav-link:hover,
                    .navbar-nav .nav-link:focus {
                        color: #ffeaa7 !important;
                        transform: translateY(-1px);
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
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

                    /* 搜索框美化 */
                    .navbar form input.form-control {
                        border-radius: 25px;
                        border: 2px solid rgba(255, 255, 255, 0.3);
                        background: rgba(255, 255, 255, 0.9);
                        padding: 10px 20px;
                        font-size: 14px;
                        transition: all 0.3s ease;
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
                        transition: all 0.3s ease;
                    }

                    .navbar form button:hover {
                        background: #ff9500;
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(255, 165, 2, 0.3);
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

                    .cart-badge.large-number {
                        width: 24px;
                        height: 20px;
                        border-radius: 10px;
                        font-size: 11px;
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

                    /* 主要内容区域 */
                    .container.mt-4 {
                        background: white;
                        border-radius: 20px;
                        padding: 30px;
                        margin-top: 30px !important;
                        box-shadow: 0 5px 25px rgba(0, 0, 0, 0.1);
                    }

                    /* 容器间距优化 */
                    .container {
                        padding-left: 20px;
                        padding-right: 20px;
                    }

                    /* 轮播图美化 */
                    #homeCarousel {
                        border-radius: 20px;
                        overflow: hidden;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                        margin-bottom: 40px;
                    }

                    .carousel-item img {
                        max-height: 450px;
                        object-fit: cover;
                        width: 100%;
                    }

                    /* 轮播指示器美化 */
                    .carousel-indicators button {
                        width: 12px;
                        height: 12px;
                        border-radius: 50%;
                        border: 2px solid white;
                        background-color: rgba(255, 255, 255, 0.5);
                        transition: all 0.3s ease;
                    }

                    .carousel-indicators button.active {
                        background-color: var(--primary-red);
                        transform: scale(1.2);
                    }

                    /* 商品网格间距 */
                    .row .col-lg-3,
                    .row .col-md-4,
                    .row .col-sm-6 {
                        padding: 15px;
                    }

                    /* 商品卡片视觉升级 */
                    .card.h-100 {
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        border: none;
                        border-radius: 15px;
                        box-shadow: 0 5px 25px rgba(0, 0, 0, 0.1);
                        transition: all 0.3s ease;
                        overflow: hidden;
                        background: white;
                    }

                    .card.h-100:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
                    }

                    .card-img-top {
                        width: 100%;
                        height: 260px;
                        object-fit: cover;
                        background: #f8f9fa;
                        transition: transform 0.3s ease;
                        border-radius: 15px 15px 0 0;
                    }

                    .card.h-100:hover .card-img-top {
                        transform: scale(1.05);
                    }

                    .card-body {
                        flex: 1 1 auto;
                        display: flex;
                        flex-direction: column;
                        padding: 20px;
                        position: relative;
                    }

                    .card-body::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, var(--primary-red), var(--primary-orange));
                        border-radius: 15px 15px 0 0;
                    }

                    .card-title {
                        min-height: 3em;
                        font-size: 1.1rem;
                        margin-bottom: 0.5rem;
                        font-weight: 600;
                        color: var(--dark-gray);
                        line-height: 1.4;
                    }

                    .card-title a {
                        color: var(--dark-gray);
                        transition: color 0.3s ease;
                        text-decoration: none;
                    }

                    .card-title a:hover {
                        color: var(--primary-red);
                    }

                    /* 价格样式美化 */
                    .card-text {
                        font-size: 1.4rem;
                        font-weight: 700;
                        color: var(--primary-red);
                        margin: 10px 0;
                    }

                    /* 销量标签美化 */
                    .card-text.text-muted {
                        background: var(--light-gray);
                        color: var(--dark-gray) !important;
                        padding: 5px 10px;
                        border-radius: 15px;
                        font-size: 0.85rem;
                        display: inline-block;
                        font-weight: 500;
                        margin: 5px 0;
                    }

                    /* 按钮样式升级 */
                    .add-to-cart-btn {
                        margin-top: auto;
                        background: linear-gradient(135deg, var(--primary-red), var(--primary-orange));
                        border: none;
                        border-radius: 25px;
                        padding: 10px 20px;
                        font-weight: 600;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);
                        color: white;
                    }

                    .add-to-cart-btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(255, 71, 87, 0.4);
                        background: linear-gradient(135deg, var(--primary-orange), var(--primary-red));
                        color: white;
                    }

                    /* 页脚样式升级 */
                    .custom-footer {
                        background: linear-gradient(135deg, #2f3542 0%, #40407a 100%);
                        color: white;
                        border-top: none;
                        margin-top: 60px;
                    }

                    .footer-icon {
                        font-size: 2.2rem;
                        color: var(--primary-orange) !important;
                        margin-bottom: 15px;
                    }

                    .footer-text {
                        font-size: 1rem;
                        color: #ddd !important;
                        font-weight: 400;
                        letter-spacing: 0.01em;
                    }

                    /* 提示信息样式优化 */
                    .alert {
                        border-radius: 15px;
                        border: none;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        font-weight: 500;
                    }

                    .alert-info {
                        background: linear-gradient(135deg, #74b9ff, #0984e3);
                        color: white;
                    }

                    .alert-warning {
                        background: linear-gradient(135deg, #fdcb6e, #e17055);
                        color: white;
                    }

                    /* 下拉菜单美化 */
                    .dropdown-menu {
                        border-radius: 15px;
                        border: none;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                        padding: 10px 0;
                    }

                    .dropdown-item {
                        padding: 10px 20px;
                        transition: all 0.3s ease;
                    }

                    .dropdown-item:hover {
                        background: linear-gradient(135deg, var(--primary-red), var(--primary-orange));
                        color: white;
                        transform: translateX(5px);
                    }

                    /* 响应式优化 */
                    @media (max-width: 768px) {
                        .navbar-brand-text {
                            font-size: 2rem;
                        }

                        .container.mt-4 {
                            padding: 20px;
                            margin-top: 20px !important;
                        }

                        .card-body {
                            padding: 15px;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- navigation.jsp 内容内联 -->
                <nav class="navbar navbar-expand-lg navbar-light sticky-top">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                            <!-- <img src="${pageContext.request.contextPath}/images/logo.png" alt="拼夕夕 Logo" width="50"
                                height="50" class="d-inline-block align-top me-2"> -->
                            <span class="navbar-brand-text">拼夕夕商城</span>
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
                                            <a class="nav-link cart-link"
                                                href="${pageContext.request.contextPath}/cart">
                                                <i class="bi bi-cart-fill"></i> 购物车
                                                <c:if
                                                    test="${not empty sessionScope.shoppingCart && sessionScope.shoppingCart.totalItemsCount > 0}">
                                                    <span
                                                        class="cart-badge ${sessionScope.shoppingCart.totalItemsCount > 99 ? 'large-number' : ''}">${sessionScope.shoppingCart.totalItemsCount
                                                        > 99 ? '99+' : sessionScope.shoppingCart.totalItemsCount}</span>
                                                </c:if>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <!-- 轮播图 - 添加Bootstrap Carousel -->
                    <div id="homeCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="0"
                                class="active"></button>
                            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="1"></button>
                            <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="2"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="${pageContext.request.contextPath}/images/banner/banner1.jpg"
                                    class="d-block w-100" alt="Banner 1">
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/images/banner/banner2.jpg"
                                    class="d-block w-100" alt="Banner 2">
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/images/banner/banner3.jpg"
                                    class="d-block w-100" alt="Banner 3">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>

                    <!-- 商品列表部分 -->
                    <div class="container">
                        <!-- 无搜索结果提示 -->
                        <c:if test="${not empty noResultsMessage}">
                            <div class="alert alert-info text-center" role="alert">
                                ${noResultsMessage}
                            </div>
                        </c:if>
                        <!-- 商品列表为空提示 -->
                        <c:if test="${empty products && empty noResultsMessage}">
                            <div class="alert alert-warning text-center" role="alert">
                                暂无商品，请稍后再来！
                            </div>
                        </c:if>
                        <!-- 商品列表展示 -->
                        <c:if test="${not empty products}">
                            <div class="row">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                        <div class="card h-100">
                                            <!-- 商品图片 -->
                                            <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                class="card-img-top" alt="${product.name}">
                                            <!-- 商品信息 -->
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/productDetail?id=${product.id}"
                                                        class="text-decoration-none">
                                                        ${product.name}
                                                    </a>
                                                </h5>
                                                <p class="card-text">¥
                                                    <fmt:formatNumber value="${product.price}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </p>
                                                <p class="card-text text-muted">销量: ${product.salesVolume}</p>
                                                <a href="${pageContext.request.contextPath}/cart?action=add&productId=${product.id}&quantity=1"
                                                    class="btn btn-primary mt-auto add-to-cart-btn">加入购物车</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- footer.jsp 内容内联 -->
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
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script type="text/javascript">
                    // 全局 JS 变量定义
                    const APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
                    const USER_IS_LOGGED_IN = <c:out value='${not empty sessionScope.loggedInUser}' />;
                    // script.js 内容内联
                    document.addEventListener('DOMContentLoaded', function () {
                        const addToCartButtons = document.querySelectorAll('.add-to-cart-btn');
                        if (typeof USER_IS_LOGGED_IN !== 'undefined') {
                            addToCartButtons.forEach(button => {
                                button.addEventListener('click', function (event) {
                                    if (!USER_IS_LOGGED_IN) {
                                        alert('请先登录后操作！');
                                        event.preventDefault();
                                        if (typeof APP_CONTEXT_PATH !== 'undefined') {
                                            window.location.href = APP_CONTEXT_PATH + '/login';
                                        } else {
                                            console.error("APP_CONTEXT_PATH is not defined.");
                                        }
                                    }
                                });
                            });
                        } else {
                            console.warn("USER_IS_LOGGED_IN variable is not defined.");
                        }
                        // 可选：初始化Bootstrap工具提示
                        // var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                        // var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                        //     return new bootstrap.Tooltip(tooltipTriggerEl)
                        // })
                    });
                </script>
            </body>

            </html>