package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysLog;
import com.gouyan.system.mapper.SysLogMapper;
import com.gouyan.system.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: chengho
 * @create: 2021-04-01 18:03
 */
@Service("sysLogService")
public class SysLogServiceImpl implements SysLogService {

    @Autowired
    private SysLogMapper sysLogMapper;

    @Override
    public List<SysLog> findAll() {
        return sysLogMapper.findAll();
    }

    @Override
    public void insert(SysLog sysLog) {
        sysLogMapper.insert(sysLog);
    }
}
