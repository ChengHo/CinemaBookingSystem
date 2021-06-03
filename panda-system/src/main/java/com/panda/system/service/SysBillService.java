package com.panda.system.service;

import com.panda.system.domin.SysBill;

import java.util.List;


public interface SysBillService {

    List<SysBill> findAllBills(SysBill sysBill);

    SysBill findBillById(Long id);

    Object addBill(SysBill sysBill);

    int updateBill(SysBill sysBill);

    int deleteBill(Long[] ids);

    List<SysBill> findTimeoutBill();

}
