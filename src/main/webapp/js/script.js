/**
 * PinXiXi 电商平台全局JavaScript文件
 * 主要功能：
 * 1. 处理"加入购物车"按钮的点击事件，检查用户是否登录
 * 2. 其他全局交互功能
 */

document.addEventListener('DOMContentLoaded', function () {
    // 处理加入购物车按钮
    const addToCartButtons = document.querySelectorAll('.add-to-cart-btn');
    
    // 检查全局变量是否已定义（在header.jsp或各页面中定义）
    if (typeof USER_IS_LOGGED_IN !== 'undefined') {
        addToCartButtons.forEach(button => {
            button.addEventListener('click', function (event) {
                if (!USER_IS_LOGGED_IN) {
                    alert('请先登录后再操作！');
                    event.preventDefault();
                    if (typeof APP_CONTEXT_PATH !== 'undefined') {
                        window.location.href = APP_CONTEXT_PATH + '/login';
                    } else {
                        console.error("APP_CONTEXT_PATH is not defined.");
                    }
                }
            });
        });
    } else {
        console.warn("USER_IS_LOGGED_IN variable is not defined.");
    }
    
    // 初始化Bootstrap工具提示（如果有使用）
    // var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    // var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    //     return new bootstrap.Tooltip(tooltipTriggerEl)
    // })
});