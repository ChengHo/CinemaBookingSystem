package com.panda.system.mapper;

import com.panda.system.domin.SysRole;

import java.util.List;


public interface SysRoleMapper {

    List<SysRole> findAll();

    SysRole findById(Long id);

    int add(SysRole sysRole);

    int update(SysRole sysRole);

    int delete(Long id);

    //给当前角色分配权限
    int addRight(Long roleId, Long resourceId);

    int deleteRight(Long roleId, Long resourceId);

    //查询指定角色的所有三级权限id
    List<Long> findAllRights(Long roleId);

}
