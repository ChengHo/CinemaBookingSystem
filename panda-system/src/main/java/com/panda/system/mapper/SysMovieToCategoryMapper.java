package com.panda.system.mapper;

import com.panda.system.domin.SysMovieToCategory;

import java.util.List;


public interface SysMovieToCategoryMapper {

    List<SysMovieToCategory> findAll(SysMovieToCategory sysMovieToCategory);

    int add(SysMovieToCategory sysMovieToCategory);

    int delete(SysMovieToCategory sysMovieToCategory);

}
