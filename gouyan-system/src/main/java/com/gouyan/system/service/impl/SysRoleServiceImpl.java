package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysRole;
import com.gouyan.system.mapper.SysRoleMapper;
import com.gouyan.system.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-12-11 23:31
 */
@Service
public class SysRoleServiceImpl implements SysRoleService {

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Override
    public List<SysRole> findAll() {
        return sysRoleMapper.findAll();
    }

    @Override
    public SysRole findById(Long id) {
        return sysRoleMapper.findById(id);
    }

    @Override
    public int add(SysRole sysRole) {
        return sysRoleMapper.add(sysRole);
    }

    @Override
    public int update(SysRole sysRole) {
        return sysRoleMapper.update(sysRole);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for(Long id : ids){
            rows += sysRoleMapper.delete(id);
        }
        return rows;
    }

    @Override
    public int allotRight(Long roleId, Long[] keys) {
        int rows = 0;
        HashSet<Long> originResources = new HashSet<>(sysRoleMapper.findAllRights(roleId));

        for(Long id : keys){
            if(originResources.contains(id)){
                originResources.remove(id);
            }else{
                rows += sysRoleMapper.addRight(roleId, id);
            }
        }
        for(Long id : originResources){
            rows += sysRoleMapper.deleteRight(roleId, id);
        }
        return rows;
    }
}
