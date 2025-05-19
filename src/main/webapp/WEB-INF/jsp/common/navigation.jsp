<%-- WEB-INF/jsp/common/navigation.jsp 作用：网站通用顶部导航栏。 包含 Logo, 商品搜索框, 以及根据用户登录状态动态显示的导航链接。 使用了 Bootstrap Navbar 组件和 JSTL。
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top"> <%-- sticky-top 使导航栏吸顶 --%>
                    <div class="container-fluid">
                        <%-- 网站 Logo --%>
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                                <img src="${pageContext.request.contextPath}/images/logo.png" alt="PinXiXi Logo"
                                    width="30" height="30" class="d-inline-block align-top">
                                PinXiXi
                            </a>

                            <%-- Navbar Toggler (用于小屏幕) --%>
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>

                                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                                    <%-- 商品搜索框 (居中) --%>
                                        <form class="d-flex mx-auto my-2 my-lg-0" style="max-width: 500px;"
                                            action="${pageContext.request.contextPath}/home" method="GET">
                                            <input class="form-control me-2" type="search" name="searchKeyword"
                                                placeholder="搜索商品..." aria-label="Search"
                                                value="${param.searchKeyword}">
                                            <button class="btn btn-outline-success" type="submit">搜索</button>
                                        </form>

                                        <%-- 右侧导航链接 --%>
                                            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                                                <c:choose>
                                                    <%-- 未登录状态 --%>
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
                                                                <%-- 未登录时，购物车链接到登录页 --%>
                                                                    <a class="nav-link"
                                                                        href="${pageContext.request.contextPath}/login"
                                                                        onclick="alert('请先登录后查看购物车'); return true;">
                                                                        <i class="bi bi-cart"></i> 购物车
                                                                    </a>
                                                            </li>
                                                        </c:when>
                                                        <%-- 已登录状态 --%>
                                                            <c:otherwise>
                                                                <li class="nav-item dropdown">
                                                                    <a class="nav-link dropdown-toggle" href="#"
                                                                        id="navbarUserDropdown" role="button"
                                                                        data-bs-toggle="dropdown" aria-expanded="false">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty sessionScope.loggedInUser.avatarPath}">
                                                                                <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.avatarPath}"
                                                                                    alt="User Avatar" width="24"
                                                                                    height="24"
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
                                                                    <a class="nav-link"
                                                                        href="${pageContext.request.contextPath}/cart">
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