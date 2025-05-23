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
        try {
            return addressDao.findByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean saveOrUpdateAddress(Address address) {
        try {
            if (address == null || address.getUserId() <= 0) {
                return false;
            }

            // 查找是否已存在地址
            Address existingAddress = addressDao.findByUserId(address.getUserId());

            if (existingAddress == null) {
                // 新增地址
                addressDao.save(address);
            } else {
                // 更新地址
                address.setId(existingAddress.getId());
                addressDao.update(address);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
