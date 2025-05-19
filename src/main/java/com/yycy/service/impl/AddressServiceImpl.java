package com.yycy.service.impl;

import com.yycy.dao.IAddressDao;
import com.yycy.dao.impl.AddressDaoImpl;
import com.yycy.entity.Address;
import com.yycy.service.IAddressService;

/**
 * AddressServiceImpl.java
 * IAddressService 接口的实现类。
 * 处理地址管理业务逻辑。
 */
public class AddressServiceImpl implements IAddressService {

    // 依赖 IAddressDao
    private IAddressDao addressDao = new AddressDaoImpl(); // 简单实例化

    @Override
    public Address getAddressByUserId(int userId) {
        throw new UnsupportedOperationException("getAddressByUserId not implemented yet.");
    }

    @Override
    public boolean saveOrUpdateAddress(Address address) {
        throw new UnsupportedOperationException("saveOrUpdateAddress not implemented yet.");
    }
}
