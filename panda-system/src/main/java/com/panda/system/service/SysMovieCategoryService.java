package com.panda.system.service;

import com.panda.system.domin.SysMovieCategory;

import java.util.List;


public interface SysMovieCategoryService {
    List<SysMovieCategory> findAll();

    SysMovieCategory findById(Long id);

    int add(SysMovieCategory sysMovieCategory);

    int update(SysMovieCategory sysMovieCategory);

    int delete(Long[] ids);
}
