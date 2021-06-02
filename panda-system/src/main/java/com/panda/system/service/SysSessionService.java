package com.panda.system.service;

import com.panda.system.domin.SysSession;
import com.panda.system.domin.vo.SysSessionVo;

import java.util.List;


public interface SysSessionService {

    List<SysSession> findByVo(SysSessionVo sysSessionVo);

    List<SysSession> findByMovieIdOrHallId(SysSession sysSession);

    SysSession findById(Long id);

    SysSession findOne(Long id);

    int add(SysSession sysSession);

    int update(SysSession sysSession);

    int delete(Long[] id);

    List<SysSession> findByCinemaAndMovie(Long cinemaId, Long movieId);

}
