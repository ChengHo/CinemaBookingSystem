package com.panda.system.service.impl;

import com.panda.system.domin.SysBill;
import com.panda.system.mapper.SysBillMapper;
import com.panda.system.service.SysBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class SysBillServiceImpl implements SysBillService {

    @Autowired
    private SysBillMapper sysBillMapper;

    @Override
    public List<SysBill> findAll(SysBill sysBill) {
        return sysBillMapper.findAll(sysBill);
    }

    @Override
    public SysBill findById(Long id) {
        return sysBillMapper.findById(id);
    }

    @Override
    public Object add(SysBill sysBill) {
        int rows = sysBillMapper.add(sysBill);
        return rows > 0 ? sysBill : rows;
    }

    @Override
    public int update(SysBill sysBill) {
        return sysBillMapper.update(sysBill);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for (Long id : ids) {
            rows += sysBillMapper.delete(id);
        }
        return rows;
    }

    @Override
    public List<SysBill> findTimeoutBill() {
        return sysBillMapper.findTimeoutBill();
    }

}
