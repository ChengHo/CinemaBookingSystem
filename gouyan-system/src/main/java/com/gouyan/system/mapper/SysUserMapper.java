package com.gouyan.system.mapper;

import com.gouyan.system.domin.LoginUser;
import com.gouyan.system.domin.SysUser;
import com.gouyan.system.domin.vo.SysUserVo;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-22 21:48
 */
public interface SysUserMapper {
    List<SysUser> findAll(SysUser sysUser);

    SysUser findById(Long id);

    SysUser findByName(String userName);

    int add(SysUser sysUser);

    int update(SysUser sysUser);

    int delete(Long id);

    LoginUser findLoginUser(SysUserVo sysUserVo);

    /**
     * 查出指定名字用户的所有id
     * @param userName
     * @return
     */
    List<Long> findUsersByName(String userName);
}
