package com.gouyan.system.service;

import com.gouyan.system.domin.SysUserHobby;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-20 10:43
 */
public interface SysUserHobbyService {

    List<SysUserHobby> findAll();

    SysUserHobby findById(Long id);

    int add(SysUserHobby sysUserHobby);

    int update(SysUserHobby sysUserHobby);

    int delete(Long[] ids);

}
