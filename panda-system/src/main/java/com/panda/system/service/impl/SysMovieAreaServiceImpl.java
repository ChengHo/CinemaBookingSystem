package com.panda.system.service.impl;

import com.panda.system.domin.SysMovieArea;
import com.panda.system.mapper.SysMovieAreaMapper;
import com.panda.system.service.SysMovieAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-18 22:29
 */
@Service
public class SysMovieAreaServiceImpl implements SysMovieAreaService {
    @Autowired
    SysMovieAreaMapper sysMovieAreaMapper;

    @Override
    public List<SysMovieArea> findAll() {
        return sysMovieAreaMapper.findAll();
    }

    @Override
    public SysMovieArea findById(Long id) {
        return sysMovieAreaMapper.findById(id);
    }

    @Override
    public int add(SysMovieArea sysMovieArea) {
        return sysMovieAreaMapper.add(sysMovieArea);
    }

    @Override
    public int update(SysMovieArea sysMovieArea) {
        return sysMovieAreaMapper.update(sysMovieArea);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for (Long id : ids) {
            rows += sysMovieAreaMapper.delete(id);
        }
        return rows;
    }
}
