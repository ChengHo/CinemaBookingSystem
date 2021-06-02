package com.panda.system.service;

import com.panda.system.domin.SysBill;

import java.util.List;


public interface SysBillService {

    List<SysBill> findAll(SysBill sysBill);

    SysBill findById(Long id);

    Object add(SysBill sysBill);

    int update(SysBill sysBill);

    int delete(Long[] ids);

    List<SysBill> findTimeoutBill();

    Double todayBoxOffice();
    
}
