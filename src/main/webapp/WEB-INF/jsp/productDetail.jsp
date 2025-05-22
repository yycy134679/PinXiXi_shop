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
                        <!-- Bootstrap CSS -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <!-- Bootstrap Icons -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                            rel="stylesheet">
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
                                margin-top: 2.5rem;
                            }

                            .thumbnail-container {
                                display: flex;
                                margin-top: 10px;
                                justify-content: center;
                            }

                            .thumbnail {
                                width: 60px;
                                height: 60px;
                                object-fit: cover;
                                margin: 0 5px;
                                border: 1px solid #ddd;
                                cursor: pointer;
                                border-radius: 4px;
                            }

                            .thumbnail.active {
                                border: 2px solid #007bff;
                            }
                        </style>
                    </head>

                    <body>
                        <!-- 简化导航栏 -->
                        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
                            <div class="container">
                                <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">PinXiXi
                                    商城</a>
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarNav">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarNav">
                                    <ul class="navbar-nav ms-auto">
                                        <li class="nav-item"><a class="nav-link"
                                                href="${pageContext.request.contextPath}/">首页</a></li>
                                        <li class="nav-item"><a class="nav-link"
                                                href="${pageContext.request.contextPath}/cart">购物车</a></li>
                                        <li class="nav-item"><a class="nav-link"
                                                href="${pageContext.request.contextPath}/order">我的订单</a></li>
                                        <li class="nav-item"><a class="nav-link"
                                                href="${pageContext.request.contextPath}/login">登录</a></li>
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
                            <div class="container product-detail-container">
                                <div class="row">
                                    <!-- 左侧图片区域 - 主图和缩略图 -->
                                    <div class="col-md-5 mb-4 mb-md-0">
                                        <div class="mb-2 text-center">
                                            <img id="mainImage"
                                                src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                class="img-fluid rounded shadow-sm" alt="${product.name}"
                                                style="max-height: 350px; object-fit: contain; background: #f6f6f6;">
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
                                    <div class="col-md-7">
                                        <h1 class="mb-3">${product.name}</h1>
                                        <div class="mt-2 mb-3" style="font-size: 1.1rem;">
                                            ${product.description}
                                        </div>
                                        <p class="h3 text-danger mb-2">¥
                                            <fmt:formatNumber value="${product.price}" type="number"
                                                minFractionDigits="2" maxFractionDigits="2" />
                                        </p>

                                        <p class="text-muted">销量: ${product.salesVolume}</p>
                                        <!-- 用户操作区域 -->
                                        <div class="d-flex align-items-center mb-3">
                                            <label for="quantity" class="me-2">数量：</label>
                                            <div class="input-group" style="width: 130px;">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    id="decreaseQty">-</button>
                                                <input type="number" class="form-control text-center" id="quantity"
                                                    name="quantity" value="1" min="1" max="99" style="max-width: 70px;">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    id="increaseQty">+</button>
                                            </div>
                                        </div>
                                        <div>
                                            <a href="#" id="addToCartBtn" class="btn btn-primary btn-lg mt-3 me-2">
                                                <i class="bi bi-cart-plus"></i> 加入购物车
                                            </a>
                                            <a href="#" id="buyNowBtn" class="btn btn-success btn-lg mt-3">
                                                <i class="bi bi-bag-check"></i> 立即购买
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- 迷你商品导航列表 -->
                                <c:if test="${not empty allProductsForNav}">
                                    <div class="mini-nav-title">
                                        <h3><i class="bi bi-grid-3x3-gap-fill"></i> 其他商品推荐</h3>
                                        <div class="row mt-3">
                                            <c:forEach var="navProd" items="${allProductsForNav}">
                                                <c:if test="${not empty navProd}">
                                                    <div class="col-lg-2 col-md-3 col-sm-4 col-6 mb-3">
                                                        <div class="card h-100 text-center">
                                                            <a
                                                                href="${pageContext.request.contextPath}/productDetail?id=${navProd.id}">
                                                                <c:if test="${not empty navProd.imageUrl}">
                                                                    <img src="${pageContext.request.contextPath}/${navProd.imageUrl}"
                                                                        class="card-img-top p-2"
                                                                        style="max-height: 100px; object-fit: contain;"
                                                                        alt="${navProd.name}">
                                                                </c:if>
                                                            </a>
                                                            <div class="card-body py-2 px-1">
                                                                <h6 class="card-title small mb-0">
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
                            </div>
                        </c:if>

                        <!-- 页脚 -->
                        <footer class="bg-white text-center py-3 mt-5 border-top">
                            <div class="container">
                                <span class="text-muted">&copy; 2025 PinXiXi 商城</span>
                            </div>
                        </footer>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                            // 全局变量
                            var USER_IS_LOGGED_IN = '${sessionScope.user != null ? "true" : "false"}' === 'true';
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