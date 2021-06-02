package com.panda.system.service;

import com.panda.system.domin.SysMovieToCategory;

import java.util.List;


public interface SysMovieToCategoryService {

    List<SysMovieToCategory> findAll(SysMovieToCategory sysMovieToCategory);

    int add(SysMovieToCategory sysMovieToCategory);

    int delete(SysMovieToCategory sysMovieToCategory);

}
