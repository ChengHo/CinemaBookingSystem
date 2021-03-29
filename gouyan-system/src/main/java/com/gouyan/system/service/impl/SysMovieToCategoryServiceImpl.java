package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysMovieToCategory;
import com.gouyan.system.mapper.SysMovieToCategoryMapper;
import com.gouyan.system.service.SysMovieToCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-30 22:19
 */
@Service
public class SysMovieToCategoryServiceImpl implements SysMovieToCategoryService {

    @Autowired
    private SysMovieToCategoryMapper sysMovieToCategoryMapper;

    @Override
    public List<SysMovieToCategory> findAll(SysMovieToCategory sysMovieToCategory) {
        return sysMovieToCategoryMapper.findAll(sysMovieToCategory);
    }

    @Override
    public int add(SysMovieToCategory sysMovieToCategory) {
        return sysMovieToCategoryMapper.add(sysMovieToCategory);
    }

    @Override
    public int delete(SysMovieToCategory sysMovieToCategory) {
        return sysMovieToCategoryMapper.delete(sysMovieToCategory);
    }
}
