<%-- WEB-INF/jsp/productNotFound.jsp 作用：当用户请求的商品不存在时显示的提示页面。 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <%-- 引入通用头部 (包含导航栏) --%>
                <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

                    <div class="container mt-5 mb-5">
                        <div class="row">
                            <div class="col-md-8 offset-md-2 text-center">
                                <h1 class="display-4 text-warning">商品未找到 <i class="bi bi-search"></i></h1>
                                <p class="lead mt-3">
                                    抱歉，您要查找的商品似乎不存在或者已经被下架了。
                                </p>
                                <c:if test="${not empty requestScope.productId}">
                                    <p>您尝试访问的商品ID是: <strong>
                                            <c:out value="${requestScope.productId}" />
                                        </strong></p>
                                </c:if>

                                <hr class="my-4">

                                <p>您可以：</p>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg mt-3">
                                    <i class="bi bi-house-door-fill"></i> 返回首页查看其他商品
                                </a>
                                <p class="mt-3">或者尝试使用顶部的搜索框查找您感兴趣的商品。</p>
                            </div>
                        </div>
                    </div>

                    <%-- 引入通用尾部 --%>
                        <%@ include file="/WEB-INF/jsp/common/footer.jsp" %>