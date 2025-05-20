<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 用于格式化价格 --%>

                <%-- 设置此页面的特定标题，会被 header.jsp 中的 <title> 使用 --%>
                    <c:set var="pageTitle" value="欢迎来到 PinXiXi 商城 - 首页" scope="request" />

                    <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

                        <div class="container mt-4">
                            <!-- 轮播图 Banner -->
                            <div class="mb-5">
                                <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="${pageContext.request.contextPath}/images/banner/banner1.jpg"
                                                class="d-block w-100" alt="Banner1">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/images/banner/banner2.jpg"
                                                class="d-block w-100" alt="Banner2">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/images/banner/banner3.jpg"
                                                class="d-block w-100" alt="Banner3">
                                        </div>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel"
                                        data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel"
                                        data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
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

                        <%@ include file="/WEB-INF/jsp/common/footer.jsp" %>