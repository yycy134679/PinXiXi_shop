package com.yycy.filter;

import javax.servlet.*;
import java.io.IOException;

/**
 * CharacterEncodingFilter.java
 * 作用：统一设置请求和响应的字符编码为 UTF-8，解决中文乱码问题。
 */
public class CharacterEncodingFilter implements Filter {

    private String encoding = "UTF-8"; // 默认编码

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("--- CharacterEncodingFilter init START ---");
        // 可以从 filterConfig 中获取初始化参数来设置编码，如果需要的话
        // String configEncoding = filterConfig.getInitParameter("encoding");
        // if (configEncoding != null) {
        // this.encoding = configEncoding;
        // }
        System.out.println("--- CharacterEncodingFilter init END ---");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 设置请求编码
        request.setCharacterEncoding(this.encoding);

        // 设置响应编码 (setContentType 会同时设置字符集，或者单独设置)
        response.setContentType("text/html;charset=" + this.encoding);
        // response.setCharacterEncoding(this.encoding); // 也可以单独设置

        // 将请求传递给过滤器链中的下一个资源
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 清理资源（如果需要）
    }
}
