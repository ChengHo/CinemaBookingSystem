package com.gouyan.system.service;

import com.gouyan.system.domin.SysRole;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-19 22:53
 */
public interface SysRoleService {
    List<SysRole> findAll();

    SysRole findById(Long id);

    int add(SysRole sysRole);

    int update(SysRole sysRole);

    int delete(Long[] ids);

    int allotRight(Long roleId, Long[] resourceIds);
}
