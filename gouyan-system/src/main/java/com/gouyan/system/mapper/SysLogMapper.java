package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysLog;

import java.util.List;

/**
 * @author: chengho
 * @create: 2021-04-01 18:05
 */
public interface SysLogMapper {
    List<SysLog> findAll();
}
