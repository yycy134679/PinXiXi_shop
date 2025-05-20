package com.yycy.service.impl;

import com.yycy.dao.IProductDao;
import com.yycy.entity.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ProductServiceImplTest {
    @Mock
    private IProductDao mockProductDao;

    @InjectMocks
    private ProductServiceImpl productService;

    private Product sampleProduct;
    private List<Product> sampleList;

    @BeforeEach
    void setUp() {
        sampleProduct = new Product();
        sampleProduct.setId(1);
        sampleProduct.setName("HUAWEI Mate 70");
        sampleList = Arrays.asList(sampleProduct);
    }

    // getAllProducts
    @Test
    void getAllProducts_success() throws SQLException {
        when(mockProductDao.findAll()).thenReturn(sampleList);
        List<Product> result = productService.getAllProducts();
        assertEquals(sampleList, result);
        verify(mockProductDao, times(1)).findAll();
    }

    @Test
    void getAllProducts_sqlException() throws SQLException {
        when(mockProductDao.findAll()).thenThrow(new SQLException("DB error"));
        List<Product> result = productService.getAllProducts();
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(mockProductDao, times(1)).findAll();
    }

    // getProductById
    @Test
    void getProductById_found() throws SQLException {
        when(mockProductDao.findById(1)).thenReturn(sampleProduct);
        Product result = productService.getProductById(1);
        assertEquals(sampleProduct, result);
        verify(mockProductDao, times(1)).findById(1);
    }

    @Test
    void getProductById_notFound() throws SQLException {
        when(mockProductDao.findById(999)).thenReturn(null);
        Product result = productService.getProductById(999);
        assertNull(result);
        verify(mockProductDao, times(1)).findById(999);
    }

    @Test
    void getProductById_sqlException() throws SQLException {
        when(mockProductDao.findById(1)).thenThrow(new SQLException("DB error"));
        Product result = productService.getProductById(1);
        assertNull(result);
        verify(mockProductDao, times(1)).findById(1);
    }

    // searchProductsByName
    @Test
    void searchProductsByName_keyword_success() throws SQLException {
        when(mockProductDao.findByNameContaining("keyword")).thenReturn(sampleList);
        List<Product> result = productService.searchProductsByName("keyword");
        assertEquals(sampleList, result);
        verify(mockProductDao, times(1)).findByNameContaining("keyword");
    }

    @Test
    void searchProductsByName_keyword_sqlException() throws SQLException {
        when(mockProductDao.findByNameContaining("keyword")).thenThrow(new SQLException("DB error"));
        List<Product> result = productService.searchProductsByName("keyword");
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(mockProductDao, times(1)).findByNameContaining("keyword");
    }

    @Test
    void searchProductsByName_nullOrEmpty_callsGetAllProducts_success() throws SQLException {
        when(mockProductDao.findAll()).thenReturn(sampleList);
        List<Product> result1 = productService.searchProductsByName(null);
        List<Product> result2 = productService.searchProductsByName("");
        assertEquals(sampleList, result1);
        assertEquals(sampleList, result2);
        verify(mockProductDao, times(2)).findAll();
        verify(mockProductDao, never()).findByNameContaining(anyString());
    }

    @Test
    void searchProductsByName_nullOrEmpty_callsGetAllProducts_sqlException() throws SQLException {
        when(mockProductDao.findAll()).thenThrow(new SQLException("DB error"));
        List<Product> result = productService.searchProductsByName(null);
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(mockProductDao, times(1)).findAll();
        verify(mockProductDao, never()).findByNameContaining(anyString());
    }
}
