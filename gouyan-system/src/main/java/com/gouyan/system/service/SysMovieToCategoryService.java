package com.gouyan.system.service;

import com.gouyan.system.domin.SysMovie;
import com.gouyan.system.domin.SysMovieToCategory;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-30 22:19
 */
public interface SysMovieToCategoryService {

    List<SysMovieToCategory> findAll(SysMovieToCategory sysMovieToCategory);

    int add(SysMovieToCategory sysMovieToCategory);

    int delete(SysMovieToCategory sysMovieToCategory);

}
