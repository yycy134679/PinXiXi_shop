<%-- WEB-INF/jsp/common/footer.jsp 作用：网站通用页脚。 包含版权信息, Bootstrap JS Bundle (CDN), 以及自定义 JS 文件的引入。 并闭合 body 和 html 标签。
    --%>
    <%-- </div> --%> <%-- 对应 header.jsp 中可能打开的 <div class="container"> --%>

            <footer class="bg-light text-center text-lg-start mt-auto py-3">
                <div class="container">
                    <p class="text-center mb-0" style="font-size: 1.1rem; color: #333; letter-spacing: 0.02em;">
                        &copy; 2025 拼夕夕 电商平台. All Rights Reserved. <span
                            style="color: #888; font-size: 0.95em;">(期末作业演示)</span>
                    </p>
                </div>
            </footer>

            <!-- Bootstrap 5 JS Bundle (includes Popper) (CDN) -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>

            <!-- 全局 JS 变量定义 -->
            <script>
                const APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
                const USER_IS_LOGGED_IN = <c:out value='${not empty sessionScope.loggedInUser}' />;
            </script>

            <!-- 自定义 JavaScript -->
            <script src="${pageContext.request.contextPath}/js/script.js"></script>

            <%-- 可以在这里预留位置给特定页面需要额外引入的JS --%>
                <%-- <c:if test="${not empty additionalJs}">
                    <script src="${pageContext.request.contextPath}/js/${additionalJs}"></script>
                    </c:if> --%>

                    </body>

                    </html>