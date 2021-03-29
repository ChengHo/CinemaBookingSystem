package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysSession;
import com.gouyan.system.domin.vo.SysSessionVo;
import com.gouyan.system.mapper.SysSessionMapper;
import com.gouyan.system.service.SysSessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-24 23:24
 */
@Service
public class SysSessionServiceImpl implements SysSessionService {

    @Autowired
    private SysSessionMapper sysSessionMapper;

    @Override
    public List<SysSession> findByVo(SysSessionVo sysSessionVo) {
        return sysSessionMapper.findByVo(sysSessionVo);
    }

    @Override
    public SysSession findById(Long id) {
        return sysSessionMapper.findById(id);
    }

    @Override
    public SysSession findOne(Long id){
        return sysSessionMapper.findOne(id);
    }

    @Override
    public int add(SysSession sysSession) {
        return sysSessionMapper.add(sysSession);
    }

    @Override
    public int update(SysSession sysSession) {
        return sysSessionMapper.update(sysSession);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for(Long id : ids){
            rows += sysSessionMapper.delete(id);
        }
        return rows;
    }

    @Override
    public List<SysSession> findByCinemaAndMovie(Long cinemaId, Long movieId) {
        return sysSessionMapper.findByCinemaAndMovie(cinemaId, movieId);
    }
}
