package com.adtec.daily.service.user;

import com.adtec.daily.bean.user.Privilege;

import java.util.List;

/**
 * @version V1.0
 * @Description: 菜单权限接口类
 */
public interface PrivilegeService {

    /**
     * 查询所有权限信息
     *
     * @return
     */
    List<Privilege> getAll();


}
