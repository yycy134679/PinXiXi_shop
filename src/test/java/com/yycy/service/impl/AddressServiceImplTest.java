package com.yycy.service.impl;

import com.yycy.dao.IAddressDao;
import com.yycy.entity.Address;
import com.yycy.service.IAddressService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * AddressServiceImplTest.java
 * AddressServiceImpl的单元测试类
 * 测试地址管理相关的业务逻辑
 */
@ExtendWith(MockitoExtension.class)
class AddressServiceImplTest {

    @Mock
    private IAddressDao mockAddressDao;

    @InjectMocks
    private AddressServiceImpl addressService;

    private Address testAddress;
    private int testUserId;

    @BeforeEach
    void setUp() {
        testUserId = 1;
        testAddress = new Address();
        testAddress.setId(1);
        testAddress.setUserId(testUserId);
        testAddress.setProvince("广东省");
        testAddress.setCity("深圳市");
        testAddress.setDistrict("南山区");
        testAddress.setDetailAddress("科技园路123号 创新大厦A座501室");
        testAddress.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        testAddress.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
    }

    // ==================== 获取用户地址测试 ====================
    @Test
    void getAddressByUserId_shouldReturnAddress_whenAddressExists() throws Exception {
        // Given
        when(mockAddressDao.findByUserId(testUserId)).thenReturn(testAddress);

        // When
        Address result = addressService.getAddressByUserId(testUserId);

        // Then
        assertNotNull(result);
        assertEquals(testAddress.getId(), result.getId());
        assertEquals(testAddress.getUserId(), result.getUserId());
        assertEquals(testAddress.getProvince(), result.getProvince());
        assertEquals(testAddress.getCity(), result.getCity());
        assertEquals(testAddress.getDistrict(), result.getDistrict());
        assertEquals(testAddress.getDetailAddress(), result.getDetailAddress());
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
    }

    @Test
    void getAddressByUserId_shouldReturnNull_whenAddressNotExists() throws Exception {
        // Given
        int nonExistentUserId = 999;
        when(mockAddressDao.findByUserId(nonExistentUserId)).thenReturn(null);

        // When
        Address result = addressService.getAddressByUserId(nonExistentUserId);

        // Then
        assertNull(result);
        verify(mockAddressDao, times(1)).findByUserId(nonExistentUserId);
    }

    @Test
    void getAddressByUserId_shouldReturnNull_whenDaoThrowsException() throws Exception {
        // Given
        when(mockAddressDao.findByUserId(testUserId)).thenThrow(new SQLException("Database error"));

        // When
        Address result = addressService.getAddressByUserId(testUserId);

        // Then
        assertNull(result);
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
    }

    // ==================== 保存或更新地址测试 ====================
    @Test
    void saveOrUpdateAddress_shouldSaveNewAddress_whenAddressNotExists() throws Exception {
        // Given
        Address newAddress = new Address();
        newAddress.setUserId(testUserId);
        newAddress.setProvince("上海市");
        newAddress.setCity("上海市");
        newAddress.setDistrict("浦东新区");
        newAddress.setDetailAddress("世纪大道888号 国金中心二期10楼");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(null);

        // When
        boolean result = addressService.saveOrUpdateAddress(newAddress);

        // Then
        assertTrue(result);
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
        verify(mockAddressDao, times(1)).save(newAddress);
        verify(mockAddressDao, never()).update(any(Address.class));
    }

    @Test
    void saveOrUpdateAddress_shouldUpdateExistingAddress_whenAddressExists() throws Exception {
        // Given
        Address updatedAddress = new Address();
        updatedAddress.setUserId(testUserId);
        updatedAddress.setProvince("北京市");
        updatedAddress.setCity("北京市");
        updatedAddress.setDistrict("朝阳区");
        updatedAddress.setDetailAddress("建国门外大街1号 国贸大厦A座2001室");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(testAddress);

        // When
        boolean result = addressService.saveOrUpdateAddress(updatedAddress);

        // Then
        assertTrue(result);
        assertEquals(testAddress.getId(), updatedAddress.getId()); // 应该设置了现有地址的ID
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
        verify(mockAddressDao, times(1)).update(updatedAddress);
        verify(mockAddressDao, never()).save(any(Address.class));
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenAddressIsNull() throws Exception {
        // When
        boolean result = addressService.saveOrUpdateAddress(null);

        // Then
        assertFalse(result);
        verify(mockAddressDao, never()).findByUserId(anyInt());
        verify(mockAddressDao, never()).save(any(Address.class));
        verify(mockAddressDao, never()).update(any(Address.class));
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenUserIdIsZero() throws Exception {
        // Given
        Address invalidAddress = new Address();
        invalidAddress.setUserId(0); // 无效的用户ID
        invalidAddress.setProvince("广东省");
        invalidAddress.setCity("深圳市");
        invalidAddress.setDistrict("南山区");
        invalidAddress.setDetailAddress("测试地址");

        // When
        boolean result = addressService.saveOrUpdateAddress(invalidAddress);

        // Then
        assertFalse(result);
        verify(mockAddressDao, never()).findByUserId(anyInt());
        verify(mockAddressDao, never()).save(any(Address.class));
        verify(mockAddressDao, never()).update(any(Address.class));
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenUserIdIsNegative() throws Exception {
        // Given
        Address invalidAddress = new Address();
        invalidAddress.setUserId(-1); // 负数用户ID
        invalidAddress.setProvince("广东省");
        invalidAddress.setCity("深圳市");
        invalidAddress.setDistrict("南山区");
        invalidAddress.setDetailAddress("测试地址");

        // When
        boolean result = addressService.saveOrUpdateAddress(invalidAddress);

        // Then
        assertFalse(result);
        verify(mockAddressDao, never()).findByUserId(anyInt());
        verify(mockAddressDao, never()).save(any(Address.class));
        verify(mockAddressDao, never()).update(any(Address.class));
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenSaveThrowsException() throws Exception {
        // Given
        Address newAddress = new Address();
        newAddress.setUserId(testUserId);
        newAddress.setProvince("上海市");
        newAddress.setCity("上海市");
        newAddress.setDistrict("浦东新区");
        newAddress.setDetailAddress("世纪大道888号");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(null);
        doThrow(new SQLException("Save failed")).when(mockAddressDao).save(newAddress);

        // When
        boolean result = addressService.saveOrUpdateAddress(newAddress);

        // Then
        assertFalse(result);
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
        verify(mockAddressDao, times(1)).save(newAddress);
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenUpdateThrowsException() throws Exception {
        // Given
        Address updatedAddress = new Address();
        updatedAddress.setUserId(testUserId);
        updatedAddress.setProvince("北京市");
        updatedAddress.setCity("北京市");
        updatedAddress.setDistrict("朝阳区");
        updatedAddress.setDetailAddress("建国门外大街1号");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(testAddress);
        doThrow(new SQLException("Update failed")).when(mockAddressDao).update(updatedAddress);

        // When
        boolean result = addressService.saveOrUpdateAddress(updatedAddress);

        // Then
        assertFalse(result);
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
        verify(mockAddressDao, times(1)).update(updatedAddress);
    }

    @Test
    void saveOrUpdateAddress_shouldReturnFalse_whenFindByUserIdThrowsException() throws Exception {
        // Given
        Address newAddress = new Address();
        newAddress.setUserId(testUserId);
        newAddress.setProvince("上海市");
        newAddress.setCity("上海市");
        newAddress.setDistrict("浦东新区");
        newAddress.setDetailAddress("世纪大道888号");

        when(mockAddressDao.findByUserId(testUserId)).thenThrow(new SQLException("Find failed"));

        // When
        boolean result = addressService.saveOrUpdateAddress(newAddress);

        // Then
        assertFalse(result);
        verify(mockAddressDao, times(1)).findByUserId(testUserId);
        verify(mockAddressDao, never()).save(any(Address.class));
        verify(mockAddressDao, never()).update(any(Address.class));
    }

    // ==================== 边界条件测试 ====================
    @Test
    void saveOrUpdateAddress_shouldHandleCompleteAddressInfo_whenSaving() throws Exception {
        // Given
        Address completeAddress = new Address();
        completeAddress.setUserId(testUserId);
        completeAddress.setProvince("江苏省");
        completeAddress.setCity("南京市");
        completeAddress.setDistrict("鼓楼区");
        completeAddress.setDetailAddress("中山路1号 紫峰大厦88层");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(null);

        // When
        boolean result = addressService.saveOrUpdateAddress(completeAddress);

        // Then
        assertTrue(result);
        verify(mockAddressDao, times(1)).save(completeAddress);

        // 验证地址信息完整性
        assertEquals("江苏省", completeAddress.getProvince());
        assertEquals("南京市", completeAddress.getCity());
        assertEquals("鼓楼区", completeAddress.getDistrict());
        assertEquals("中山路1号 紫峰大厦88层", completeAddress.getDetailAddress());
    }

    @Test
    void saveOrUpdateAddress_shouldHandleCompleteAddressInfo_whenUpdating() throws Exception {
        // Given
        Address updatedAddress = new Address();
        updatedAddress.setUserId(testUserId);
        updatedAddress.setProvince("浙江省");
        updatedAddress.setCity("杭州市");
        updatedAddress.setDistrict("西湖区");
        updatedAddress.setDetailAddress("文三路269号 华星时代广场B座15楼");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(testAddress);

        // When
        boolean result = addressService.saveOrUpdateAddress(updatedAddress);

        // Then
        assertTrue(result);
        assertEquals(testAddress.getId(), updatedAddress.getId());
        verify(mockAddressDao, times(1)).update(updatedAddress);

        // 验证更新后的地址信息
        assertEquals("浙江省", updatedAddress.getProvince());
        assertEquals("杭州市", updatedAddress.getCity());
        assertEquals("西湖区", updatedAddress.getDistrict());
        assertEquals("浙江省", updatedAddress.getProvince());
    }

    // ==================== 集成场景测试 ====================
    @Test
    void saveOrUpdateAddress_shouldWorkCorrectly_inTypicalUserFlow() throws Exception {
        // 场景：用户首次添加地址，然后修改地址

        // 第一步：用户首次添加地址
        Address firstAddress = new Address();
        firstAddress.setUserId(testUserId);
        firstAddress.setProvince("广东省");
        firstAddress.setCity("广州市");
        firstAddress.setDistrict("天河区");
        firstAddress.setDetailAddress("天河路123号");

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(null);

        boolean firstResult = addressService.saveOrUpdateAddress(firstAddress);
        assertTrue(firstResult);
        verify(mockAddressDao, times(1)).save(firstAddress);

        // 第二步：用户修改地址
        reset(mockAddressDao); // 重置mock对象

        Address updatedAddress = new Address();
        updatedAddress.setUserId(testUserId);
        updatedAddress.setProvince("广东省");
        updatedAddress.setCity("广州市");
        updatedAddress.setDistrict("越秀区");
        updatedAddress.setDetailAddress("中山五路456号");

        Address existingAddress = new Address();
        existingAddress.setId(1);
        existingAddress.setUserId(testUserId);

        when(mockAddressDao.findByUserId(testUserId)).thenReturn(existingAddress);

        boolean updateResult = addressService.saveOrUpdateAddress(updatedAddress);
        assertTrue(updateResult);
        assertEquals(1, updatedAddress.getId()); // 应该设置了现有地址的ID
        verify(mockAddressDao, times(1)).update(updatedAddress);
        verify(mockAddressDao, never()).save(any(Address.class));
    }

    @Test
    void getAddressByUserId_shouldHandleDifferentUserIds() throws Exception {
        // 测试不同用户ID的地址获取
        int user1Id = 1;
        int user2Id = 2;

        Address user1Address = new Address();
        user1Address.setId(1);
        user1Address.setUserId(user1Id);
        user1Address.setProvince("广东省");

        Address user2Address = new Address();
        user2Address.setId(2);
        user2Address.setUserId(user2Id);
        user2Address.setProvince("上海市");

        when(mockAddressDao.findByUserId(user1Id)).thenReturn(user1Address);
        when(mockAddressDao.findByUserId(user2Id)).thenReturn(user2Address);

        // 获取用户1的地址
        Address result1 = addressService.getAddressByUserId(user1Id);
        assertNotNull(result1);
        assertEquals(user1Id, result1.getUserId());
        assertEquals("广东省", result1.getProvince());

        // 获取用户2的地址
        Address result2 = addressService.getAddressByUserId(user2Id);
        assertNotNull(result2);
        assertEquals(user2Id, result2.getUserId());
        assertEquals("上海市", result2.getProvince());

        verify(mockAddressDao, times(1)).findByUserId(user1Id);
        verify(mockAddressDao, times(1)).findByUserId(user2Id);
    }
}