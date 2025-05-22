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
                    /* style.css 内容内联 */
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

                    .carousel-item img {
                        max-height: 400px;
                        object-fit: contain;
                        width: 100%;
                    }

                    .card.h-100 {
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                    }

                    .card-img-top {
                        width: 100%;
                        height: 260px;
                        object-fit: cover;
                        background: #f8f9fa;
                    }

                    .card-body {
                        flex: 1 1 auto;
                        display: flex;
                        flex-direction: column;
                    }

                    .card-title {
                        min-height: 3em;
                        font-size: 1.1rem;
                        margin-bottom: 0.5rem;
                    }

                    .add-to-cart-btn {
                        margin-top: auto;
                    }

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
                </style>
            </head>

            <body>
                <!-- navigation.jsp 内容内联 -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                            <!-- <img src="${pageContext.request.contextPath}/images/logo.png" alt="拼夕夕 Logo" width="50"
                                height="50" class="d-inline-block align-top me-2"> -->
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