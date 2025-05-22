<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="zh-CN">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>出错了 - PinXiXi 电商平台</title>
            <!-- 防止浏览器请求默认favicon.ico -->
            <link rel="icon" href="data:,">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
            <style type="text/css">
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
            </style>
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
                <div class="container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="PinXiXi Logo" width="50"
                            height="50" class="d-inline-block align-top me-2">
                        <span class="navbar-brand-text"
                            style="color: #ff7c7c; font-size: 2.8rem; font-weight: 900; letter-spacing: 0.08em; font-family: 'Arial Black', 'FZYaoti', 'FZCuHeiSongS-B-GB', 'FZShuTi', 'STHeiti', 'SimHei', sans-serif;">PinXiXi商城</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavDropdown">
                        <form class="d-flex mx-auto my-2 my-lg-0" style="width: 60%; max-width: 600px;"
                            action="${pageContext.request.contextPath}/home" method="GET">
                            <input class="form-control me-2" type="search" name="searchKeyword" placeholder="搜索商品..."
                                aria-label="Search" value="${param.searchKeyword}">
                            <button class="btn btn-outline-success" type="submit">搜索</button>
                        </form>
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <c:choose>
                                <c:when test="${empty sessionScope.loggedInUser}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/login">登录</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/register">注册</a>
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
            <div class="container mt-5 mb-5">
                <div class="row">
                    <div class="col-md-8 offset-md-2 text-center">
                        <h1 class="display-4 text-danger">发生错误 <i class="bi bi-emoji-frown"></i></h1>
                        <c:choose>
                            <c:when test="${not empty requestScope.errorMessage}">
                                <p class="lead mt-3">${requestScope.errorMessage}</p>
                            </c:when>
                            <c:when
                                test="${not empty pageContext.errorData && not empty pageContext.errorData.throwable}">
                                <p class="lead mt-3">抱歉，处理您的请求时遇到了问题。</p>
                            </c:when>
                            <c:otherwise>
                                <p class="lead mt-3">抱歉，系统出现了一个未知错误，请稍后再试。</p>
                            </c:otherwise>
                        </c:choose>
                        <hr class="my-4">
                        <p>您可以尝试以下操作：</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg mt-3">
                            <i class="bi bi-house-door-fill"></i> 返回首页
                        </a>
                    </div>
                </div>
            </div>
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
                const APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
                const USER_IS_LOGGED_IN = <c:out value='${not empty sessionScope.loggedInUser}' />;
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
                });
            </script>
        </body>

        </html>