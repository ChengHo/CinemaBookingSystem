package com.panda.system.service;

import com.panda.system.domin.SysMovieArea;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-18 22:28
 */
public interface SysMovieAreaService {
    List<SysMovieArea> findAll();

    SysMovieArea findById(Long id);

    int add(SysMovieArea sysMovieArea);

    int update(SysMovieArea sysMovieArea);

    int delete(Long[] ids);
}
