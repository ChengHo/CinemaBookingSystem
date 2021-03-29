package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysUserHobby;
import com.gouyan.system.mapper.SysUserHobbyMapper;
import com.gouyan.system.service.SysUserHobbyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-20 10:45
 */
@Service
public class SysUserHobbyServiceImpl implements SysUserHobbyService {

    @Autowired
    private SysUserHobbyMapper sysUserHobbyMapper;

    @Override
    public List<SysUserHobby> findAll() {
        return sysUserHobbyMapper.findAll();
    }

    @Override
    public SysUserHobby findById(Long id) {
        return sysUserHobbyMapper.findById(id);
    }

    @Override
    public int add(SysUserHobby sysUserHobby) {
        return sysUserHobbyMapper.add(sysUserHobby);
    }

    @Override
    public int update(SysUserHobby sysUserHobby) {
        return sysUserHobbyMapper.update(sysUserHobby);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for(Long id : ids){
            rows += sysUserHobbyMapper.delete(id);
        }
        return rows;
    }
}
