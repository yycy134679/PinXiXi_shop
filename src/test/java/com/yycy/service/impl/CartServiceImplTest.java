package com.yycy.service.impl;

import com.yycy.entity.Cart;
import com.yycy.entity.Product;
import com.yycy.service.IProductService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
// Mockito.reset is not generally recommended, but for re-initializing sampleCart for each test,
// it's better to create a new Cart instance in setUp.
// import org.mockito.Mockito; // Not needed for reset if we re-create Cart
import org.mockito.junit.jupiter.MockitoExtension;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CartServiceImplTest {

    @Mock
    private IProductService mockProductService;

    @Mock
    private HttpSession mockSession;

    @InjectMocks
    private CartServiceImpl cartService;

    private Product sampleProduct;
    private Cart sampleCart; // This will be the cart instance used in session for relevant tests

    private static final String CART_SESSION_KEY = "shoppingCart"; // Assuming this is your session key

    @BeforeEach
    void setUp() {
        // 创建样例商品
        sampleProduct = new Product();
        sampleProduct.setId(1);
        sampleProduct.setName("测试商品");
        sampleProduct.setPrice(new BigDecimal("99.99"));
        sampleProduct.setImageUrl("images/products/test.jpg");

        // 为每个测试创建一个新的、干净的 sampleCart 实例
        // 这个 sampleCart 将被用作期望的购物车对象，或者被放入模拟的 session 中
        sampleCart = new Cart();
    }

    @Test
    void getCart_whenCartExists_returnsExistingCart() {
        // 准备 - 在这里设置 stubbing
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);

        // 执行
        Cart result = cartService.getCart(mockSession);

        // 验证
        assertSame(sampleCart, result, "Should return the existing cart from session.");
        verify(mockSession, times(1)).getAttribute(CART_SESSION_KEY);
        verify(mockSession, never()).setAttribute(eq(CART_SESSION_KEY), any(Cart.class));
    }

    @Test
    void getCart_whenCartDoesNotExist_createsNewCart() {
        // 准备 - 覆盖默认行为
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(null);

        // 执行
        Cart result = cartService.getCart(mockSession);

        // 验证
        assertNotNull(result, "A new cart should be created.");
        assertTrue(result.getItems().isEmpty(), "The new cart should be empty.");
        verify(mockSession, times(1)).getAttribute(CART_SESSION_KEY);
        verify(mockSession, times(1)).setAttribute(eq(CART_SESSION_KEY), any(Cart.class));
    }

    @Test
    void addProductToCart_withValidProductAndQuantity_addsToCart() {
        // 准备
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);

        // 执行
        cartService.addProductToCart(mockSession, 1, 2);

        // 验证
        assertEquals(1, sampleCart.getItems().size(), "Cart should have one item type.");
        assertTrue(sampleCart.getItems().containsKey(1), "Cart should contain the added product.");
        assertEquals(2, sampleCart.getItems().get(1).getQuantity(), "Quantity of the product should be 2.");
        assertEquals(sampleProduct, sampleCart.getItems().get(1).getProduct(), "Product in cart item should be the sample product.");
        verify(mockProductService, times(1)).getProductById(1);
        // Verify session setAttribute is NOT called if getCart returns an existing cart that is then modified
        // This depends on CartServiceImpl's getCart implementation detail.
        // If getCart always sets the (potentially modified) cart back to session, then this verify needs adjustment.
        // Assuming getCart only setsAttribute if a new cart is created.
    }

    @Test
    void addProductToCart_withInvalidQuantity_doesNotAddToCartIfQuantityIsZeroOrLess() {
        // 准备
        // No need to stub mockSession.getAttribute if the logic bails out before getting the cart
        // However, if getCart is always called, then we need:
        // when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);

        // 执行
        cartService.addProductToCart(mockSession, 1, 0); // Assuming 0 is invalid

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Cart should remain empty for invalid quantity.");
        verify(mockProductService, never()).getProductById(anyInt()); // Product service should not be called
        // verify(mockSession, never()).setAttribute(anyString(), any()); // Session should not be updated
    }

    @Test
    void addProductToCart_withNonExistentProduct_doesNotAddToCart() {
        // 准备
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(999)).thenReturn(null);

        // 执行
        cartService.addProductToCart(mockSession, 999, 1);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Cart should remain empty if product does not exist.");
        verify(mockProductService, times(1)).getProductById(999);
    }

    @Test
    void addProductToCart_withExistingProduct_updatesQuantity() {
        // 准备
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);

        // 先添加一次
        cartService.addProductToCart(mockSession, 1, 2);

        // 再添加一次
        cartService.addProductToCart(mockSession, 1, 3);

        // 验证
        assertEquals(1, sampleCart.getItems().size(), "Cart should still have one item type.");
        assertEquals(5, sampleCart.getItems().get(1).getQuantity(), "Quantity should be updated to 5 (2 + 3).");
        verify(mockProductService, times(2)).getProductById(1); // Called twice
    }

    @Test
    void removeProductFromCart_withExistingProduct_removesFromCart() {
        // 准备 - 先添加商品
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);
        cartService.addProductToCart(mockSession, 1, 2); // sampleCart now has product 1

        // 执行
        cartService.removeProductFromCart(mockSession, 1);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Product should be removed from cart.");
    }

    @Test
    void removeProductFromCart_withNonExistentProductInCart_doesNothingToCart() {
        // 准备
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        // sampleCart is empty initially

        // 执行
        cartService.removeProductFromCart(mockSession, 999);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Cart should remain empty.");
    }

    @Test
    void updateProductQuantityInCart_withPositiveQuantity_updatesQuantity() {
        // 准备 - 先添加商品
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);
        cartService.addProductToCart(mockSession, 1, 2);

        // 执行
        cartService.updateProductQuantityInCart(mockSession, 1, 5);

        // 验证
        assertEquals(1, sampleCart.getItems().size());
        assertEquals(5, sampleCart.getItems().get(1).getQuantity(), "Quantity should be updated to 5.");
    }

    @Test
    void updateProductQuantityInCart_withZeroQuantity_removesProduct() {
        // 准备 - 先添加商品
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);
        cartService.addProductToCart(mockSession, 1, 2);

        // 执行
        cartService.updateProductQuantityInCart(mockSession, 1, 0);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Product should be removed if quantity is updated to 0.");
    }

    @Test
    void updateProductQuantityInCart_withNegativeQuantity_removesProduct() {
        // 准备 - 先添加商品
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);
        cartService.addProductToCart(mockSession, 1, 2);

        // 执行
        cartService.updateProductQuantityInCart(mockSession, 1, -1);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Product should be removed if quantity is updated to negative.");
    }

    @Test
    void updateProductQuantityInCart_withNonExistentProductInCart_doesNothing() {
        // 准备
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        // sampleCart is empty

        // 执行
        cartService.updateProductQuantityInCart(mockSession, 999, 5);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Cart should remain empty if product to update is not in cart.");
    }

    @Test
    void clearCart_emptiesCart() {
        // 准备 - 先添加商品
        when(mockSession.getAttribute(CART_SESSION_KEY)).thenReturn(sampleCart);
        when(mockProductService.getProductById(1)).thenReturn(sampleProduct);
        cartService.addProductToCart(mockSession, 1, 2);
        assertFalse(sampleCart.getItems().isEmpty(), "Cart should not be empty before clearing.");


        // 执行
        cartService.clearCart(mockSession);

        // 验证
        assertTrue(sampleCart.getItems().isEmpty(), "Cart should be empty after clearing.");
    }
}
