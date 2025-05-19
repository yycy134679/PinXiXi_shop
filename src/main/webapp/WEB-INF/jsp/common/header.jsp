<%-- WEB-INF/jsp/common/header.jsp 作用：网站通用页头。 包含 HTML5 文档类型声明, html 和 head 标签,字符集,视口设置, 网站标题, Bootstrap CSS (CDN), 以及自定义
    CSS 文件的引入。 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- JSTL core library --%>
                <!DOCTYPE html>
                <html lang="zh-CN"> <%-- 设定语言为中文 --%>

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <%-- 动态标题: 优先使用 request 作用域中的 pageTitle，如果没有则使用默认标题 --%>
                            <title>
                                <c:out value="${not empty pageTitle ? pageTitle : '拼夕夕 电商平台'}" />
                            </title>

                            <!-- Bootstrap 5 CSS (CDN) -->
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                                rel="stylesheet"
                                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                                crossorigin="anonymous">

                            <!-- (可选) Bootstrap Icons (CDN) -->
                            <link rel="stylesheet"
                                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

                            <!-- 自定义 CSS -->
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

                            <%-- 可以在这里预留位置给特定页面需要额外引入的CSS --%>
                                <%-- <c:if test="${not empty additionalCss}">
                                    <link rel="stylesheet"
                                        href="${pageContext.request.contextPath}/css/${additionalCss}">
                                    </c:if> --%>
                    </head>

                    <body> <%-- body 标签在这里开始，将在 footer.jsp 中闭合 --%>

                            <%-- 引入通用导航栏 --%>
                                <%@ include file="navigation.jsp" %>

                                    <%-- 主内容区域开始 (通常在 navigation.jsp 之后，具体页面内容之前) --%>
                                        <%-- <div class="container mt-4"> --%>
                                            <%-- 具体页面的内容将在这里被包含或直接编写 --%>