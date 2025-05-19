<%-- WEB-INF/jsp/error.jsp 作用：通用错误提示页面。 显示一个通用的错误信息，或者从 requestScope 中获取具体的错误消息。 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <%-- 引入通用头部 (包含导航栏) --%>
                <%@ include file="/WEB-INF/jsp/common/header.jsp" %>

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
                                        <%-- 如果 isErrorPage="true" ，可以尝试获取更详细的异常信息 (开发时用，生产环境不建议直接显示) --%>
                                            <p class="lead mt-3">抱歉，处理您的请求时遇到了问题。</p>
                                            <%-- <p>错误详情 (仅供开发参考):</p>
                                                <pre
                                                    style="text-align: left; background-color: #f8f9fa; padding: 10px; border-radius: 5px;">
                        Request URI: ${pageContext.errorData.requestURI}
                        Status Code: ${pageContext.errorData.statusCode}
                        Exception: ${pageContext.errorData.throwable}
                        Message: ${pageContext.errorData.throwable.message}
                    </pre>
                                                --%>
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
                                <%-- 可以添加其他链接，例如联系支持等 --%>
                            </div>
                        </div>
                    </div>

                    <%-- 引入通用尾部 --%>
                        <%@ include file="/WEB-INF/jsp/common/footer.jsp" %>