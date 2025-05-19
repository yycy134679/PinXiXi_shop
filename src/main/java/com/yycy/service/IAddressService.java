package com.yycy.service;

import com.yycy.entity.Address;

/**
 * IAddressService.java
 * 作用：定义用户收货地址相关业务逻辑的服务接口。
 * 包含根据用户ID获取地址、保存或更新地址等操作。
 */
public interface IAddressService {

    /**
     * 根据用户ID获取其收货地址。
     *
     * @param userId 用户ID
     * @return Address 对象，若无则返回 null
     */
    Address getAddressByUserId(int userId);

    /**
     * 保存或更新用户收货地址。
     *
     * @param address Address 实体对象
     * @return 操作是否成功
     */
    boolean saveOrUpdateAddress(Address address);
}
