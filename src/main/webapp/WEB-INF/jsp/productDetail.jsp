<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% try {
    System.out.println("\n==========productDetail.jsp is executing!==========");
    System.out.println(" JSP - Request URI: " + request.getRequestURI());
    System.out.println(" JSP - Context Path: " + request.getContextPath());
    System.out.println(" JSP - Servlet Path: " + request.getServletPath());
    System.out.println(" JSP - Request Method: " + request.getMethod());

    Object productObj = request.getAttribute("product");
    System.out.println("JSP - Product object: " + (productObj != null ? "exists" : "null"));
    if (productObj != null && productObj
            instanceof com.yycy.entity.Product) {
        com.yycy.entity.Product product = (com.yycy.entity.Product)
                productObj;
        System.out.println(" JSP - Product details - Name: " + product.getName());
        System.out.println(" JSP - Product details - ID: " + product.getId());
        System.out.println(" JSP - Product details - Price: " + product.getPrice());
        System.out.println(" JSP - Product details - ImageUrl: " + product.getImageUrl());
    } else if (productObj == null) {
        System.err.println(" JSP - CRITICAL: Product object is NULL in scriptlet!");
    } else {
        System.err.println("JSP - CRITICAL: product attribute is not of type com.yycy.entity.Product!");
    }
    Object navObj = request.getAttribute("allProductsForNav");
    System.out.println(" JSP - allProductsForNav: " + (navObj != null ? " exists" : "null"));
    if (navObj != null && navObj
            instanceof java.util.List) {
        java.util.List<?> navList = (java.util.List
                <?>) navObj;
        System.out.println(" JSP - Navigation products count: " + navList.size());
    } else if (navObj == null) {
        System.err.println("JSP - CRITICAL: allProductsForNav is NULL in scriptlet!");
    } else {
        System.err.println("JSP - CRITICAL: allProductsForNav is not a List in scriptlet!");
    }
} catch (Exception e) {
    System.err.println("JSP - ERROR in top scriptlet of productDetail.jsp:");
    e.printStackTrace(System.err);
    // 不要 re-throw e，让 errorPage 机制处理后续渲染错误
}
%>

<!-- 设置页面标题 -->
<c:set var="pageTitle" value="${not empty product ? product.name : '商品详情'} - PinXiXi 商城" scope="request"/>
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

        .thumbnail-img {
            transition: border 0.2s;
        }

        .thumbnail-img.active,
        .thumbnail-img:hover {
            border: 2px solid #0d6efd;
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

<div class="container product-detail-container">
    <div class="row">
        <!-- 左侧图片区域 -->
        <div class="col-md-5 mb-4 mb-md-0">
            <div class="mb-3 text-center">
                <img id="mainProductImage"
                     src="${pageContext.request.contextPath}/${product.imageUrl}"
                     class="img-fluid rounded shadow-sm" alt="${product.name}"
                     style="max-height: 350px; object-fit: contain; background: #f6f6f6;">
            </div>
            <div class="d-flex flex-wrap justify-content-center">
                <%-- 主图本身作为第一个缩略图 --%>
                <img class="thumbnail-img img-thumbnail me-2 mb-2 active"
                     src="${pageContext.request.contextPath}/${product.imageUrl}"
                     data-large-src="${pageContext.request.contextPath}/${product.imageUrl}"
                     style="width: 80px; height: 80px; object-fit: cover; cursor: pointer;"
                     alt="缩略图">
                <%-- 解析主图名和扩展名 --%>
                <c:set var="mainImageUrl" value="${product.imageUrl}"/>
                <c:set var="dotIndex" value="${fn:lastIndexOf(mainImageUrl, '.')}"/>
                <c:choose>
                    <c:when test="${dotIndex != -1}">
                        <c:set var="baseName"
                               value="${fn:substring(mainImageUrl, 0, dotIndex)}"/>
                        <c:set var="extension"
                               value="${fn:substring(mainImageUrl, dotIndex, fn:length(mainImageUrl))}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="baseName" value="${mainImageUrl}"/>
                        <c:set var="extension" value=""/>
                    </c:otherwise>
                </c:choose>
                <c:forEach var="i" begin="1" end="3">
                    <c:set var="detailImageUrl" value="${baseName}_d${i}${extension}"/>
                    <img class="thumbnail-img img-thumbnail me-2 mb-2"
                         src="${pageContext.request.contextPath}/${detailImageUrl}"
                         data-large-src="${pageContext.request.contextPath}/${detailImageUrl}"
                         style="width: 80px; height: 80px; object-fit: cover; cursor: pointer;"
                         alt="详细图 ${i}" onerror="this.style.display='none'">
                </c:forEach>
            </div>
        </div>
        <!-- 右侧信息区域 -->
        <div class="col-md-7">
            <h1 class="mb-3">${product.name}</h1>
            <p class="h3 text-danger mb-2">¥
                <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2"
                                  maxFractionDigits="2"/>
            </p>
            <p class="text-muted">销量: ${product.salesVolume}</p>
            <div class="mt-3 mb-4" style="min-height: 80px;">${product.description}</div>
            <!-- 用户操作区域 -->
            <div class="d-flex align-items-center mb-3">
                <label for="quantity" class="me-2">数量：</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button"
                            id="decreaseQty">-
                    </button>
                    <input type="number" class="form-control text-center" id="quantity"
                           name="quantity" value="1" min="1" max="99" style="max-width: 70px;">
                    <button class="btn btn-outline-secondary" type="button"
                            id="increaseQty">+
                    </button>
                </div>
            </div>
            <div>
                <a href="#" id="addToCartDetailBtn"
                   class="btn btn-primary btn-lg mt-3 me-2 add-to-cart-btn"><i
                        class="bi bi-cart-plus"></i> 加入购物车</a>
                <a href="#" id="buyNowBtn" class="btn btn-success btn-lg mt-3"><i
                        class="bi bi-bag-check"></i> 立即购买</a>
            </div>
        </div>
    </div>
    <!-- 迷你商品导航列表 -->
    <div class="mini-nav-title">
        <h3><i class="bi bi-grid-3x3-gap-fill"></i> 其他商品推荐</h3>
        <div class="row mt-3">
            <c:forEach var="navProd" items="${allProductsForNav}">
                <div class="col-lg-2 col-md-3 col-sm-4 col-6 mb-3">
                    <div class="card h-100 text-center">
                        <a
                                href="${pageContext.request.contextPath}/productDetail?id=${navProd.id}">
                            <img src="${pageContext.request.contextPath}/${navProd.imageUrl}"
                                 class="card-img-top p-2"
                                 style="max-height: 100px; object-fit: contain;"
                                 alt="${navProd.name}">
                        </a>
                        <div class="card-body py-2 px-1">
                            <h6 class="card-title small mb-0">
                                <a href="${pageContext.request.contextPath}/productDetail?id=${navProd.id}"
                                   class="text-decoration-none text-dark stretched-link">${navProd.name}</a>
                            </h6>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

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
    // 全局变量（需后端输出）
    var USER_IS_LOGGED_IN = '${sessionScope.user != null ? "true" : "false"}' === 'true';
    var APP_CONTEXT_PATH = '${pageContext.request.contextPath}';

    // 缩略图切换主图
    document.querySelectorAll('.thumbnail-img').forEach(function (thumb) {
        thumb.addEventListener('click', function () {
            document.getElementById('mainProductImage').src = this.getAttribute('data-large-src');
            document.querySelectorAll('.thumbnail-img').forEach(function (t) {
                t.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
    // 默认激活第一个缩略图
    var firstThumb = document.querySelector('.thumbnail-img');
    if (firstThumb) firstThumb.classList.add('active');

    // 数量选择器逻辑
    var qtyInput = document.getElementById('quantity');
    document.getElementById('decreaseQty').onclick = function () {
        var v = parseInt(qtyInput.value) || 1;
        if (v > 1) qtyInput.value = v - 1;
    };
    document.getElementById('increaseQty').onclick = function () {
        var v = parseInt(qtyInput.value) || 1;
        if (v < 99) qtyInput.value = v + 1;
    };

    // 加入购物车按钮逻辑
    document.getElementById('addToCartDetailBtn').onclick = function (event) {
        event.preventDefault();
        var quantity = parseInt(qtyInput.value) || 1;
        if (!USER_IS_LOGGED_IN) {
            alert('请先登录！');
            window.location.href = APP_CONTEXT_PATH + '/login';
            return false;
        }
        var url = APP_CONTEXT_PATH + '/cart?action=add&productId=${product.id}&quantity=' + quantity;
        window.location.href = url;
    };
    // 立即购买按钮逻辑
    document.getElementById('buyNowBtn').onclick = function (event) {
        event.preventDefault();
        var quantity = parseInt(qtyInput.value) || 1;
        if (!USER_IS_LOGGED_IN) {
            alert('请先登录！');
            window.location.href = APP_CONTEXT_PATH + '/login';
            return false;
        }
        var url = APP_CONTEXT_PATH + '/checkout?productId=${product.id}&quantity=' + quantity;
        window.location.href = url;
    };
</script>
</body>

</html>