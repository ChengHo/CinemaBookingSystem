package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysBill;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-30 14:01
 */
public interface SysBillMapper {

    List<SysBill> findAll(SysBill sysBill);

    SysBill findById(Long id);

    int add(SysBill sysBill);

    int update(SysBill sysBill);

    int delete(Long id);

    Double todayBoxOffice();
    
}
