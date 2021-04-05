package com.panda.system.service;

import com.panda.system.domin.SysMovieComment;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-22 21:48
 */
public interface SysMovieCommentService {

    List<SysMovieComment> findAll();

    SysMovieComment findOne(SysMovieComment sysMovieComment);

    List<SysMovieComment> findByMovieId(Long movieId);

    List<SysMovieComment> findByUserId(Long userId);

    int add(SysMovieComment sysMovieComment);

    int update(SysMovieComment sysMovieComment);

    int delete(SysMovieComment[] pks);

}
