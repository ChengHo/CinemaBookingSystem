package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysMovieToCategory;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-30 22:13
 */
public interface SysMovieToCategoryMapper {

    List<SysMovieToCategory> findAll(SysMovieToCategory sysMovieToCategory);

    int add(SysMovieToCategory sysMovieToCategory);

    int delete(SysMovieToCategory sysMovieToCategory);

}
