package com.gouyan.system.service;

import com.gouyan.system.domin.SysBill;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-30 14:24
 */
public interface SysBillService {

    List<SysBill> findAll(SysBill sysBill);

    SysBill findById(Long id);

    Object add(SysBill sysBill);

    int update(SysBill sysBill);

    int delete(Long[] ids);

    Double todayBoxOffice();
    
}
