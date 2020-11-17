package com.adtec.daily.service.user;

import com.adtec.daily.bean.user.UserProjectExample;

/**
 * @version V1.0
 * @Description: 类名
 */
public interface UserProjectService {

    /**
     * 根据条件删除用户项目关联表
     *
     * @param example
     */
    void deleteUserProjectByExample(UserProjectExample example);
}
