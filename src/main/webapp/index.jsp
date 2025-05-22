<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>JSP - Hello World</title>
        <!-- 防止浏览器请求默认favicon.ico -->
        <link rel="icon" href="data:,">
    </head>

    <body>
        <%-- index.jsp 作用：作为应用的默认入口文件，自动重定向到首页 Servlet。 --%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                <c:redirect url="/home" />
                <%-- 注意：这里的 url="/home" 是相对于应用上下文的路径。 如果首页 Servlet 映射到 "/HomeServlet" ，则 url="/HomeServlet" --%>
    </body>

    </html>