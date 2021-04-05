package com.panda.system.service;

import com.panda.system.domin.SysLog;

import java.util.List;

/**
 * @author: chengho
 * @create: 2021-04-01 17:41
 */
public interface SysLogService {
    List<SysLog> findAll();

    void insert(SysLog sysLog);
}
