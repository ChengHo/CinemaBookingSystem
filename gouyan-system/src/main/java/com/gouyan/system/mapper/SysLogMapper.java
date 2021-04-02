package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysLog;

import java.util.List;
import java.util.Map;

/**
 * @author: chengho
 * @create: 2021-04-01 18:05
 */
public interface SysLogMapper {
    List<SysLog> findAll();
    int deleteByPrimaryKey(Integer logId);

//    int insert(SysLog record);

    void insert(SysLog sysLog);

    int insertSelective(SysLog record);

    SysLog selectByPrimaryKey(Integer logId);

    int updateByPrimaryKeySelective(SysLog record);

    int updateByPrimaryKeyWithBLOBs(SysLog record);

    int updateByPrimaryKey(SysLog record);

    /**
     * 分页查询
     */
    List<SysLog> list(Map<String,Object> map);

    /**
     * 总数
     */
    int count(Map<String,Object> map);
}
