package com.panda.system.mapper;

import com.panda.system.domin.SysBill;

import java.util.List;


public interface SysBillMapper {

    List<SysBill> findAll(SysBill sysBill);

    SysBill findById(Long id);

    int add(SysBill sysBill);

    int update(SysBill sysBill);

    int delete(Long id);

    /**
     * 查询所有超时订单
     *
     * @return
     */
    List<SysBill> findTimeoutBill();

}
