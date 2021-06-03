package com.panda.system.mapper;

import com.panda.system.domin.LoginUser;
import com.panda.system.domin.SysUser;
import com.panda.system.domin.vo.SysUserVo;

import java.util.List;


public interface SysUserMapper {
    List<SysUser> findAllUsers(SysUser sysUser);

    SysUser findUserById(Long id);

    /**
     * jwt校验
     * @param userName
     * @return
     */
    SysUser findUserByName(String userName);

    int addUser(SysUser sysUser);

    int updateUser(SysUser sysUser);

    int deleteUser(Long id);

    LoginUser findLoginUser(SysUserVo sysUserVo);

    /**
     * 查出指定名字用户的所有id
     *
     * @param userName
     * @return
     */
    List<Long> checkUserNameUnique(String userName);
}
