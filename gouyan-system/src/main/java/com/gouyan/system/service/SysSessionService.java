package com.gouyan.system.service;

import com.gouyan.system.domin.SysSession;
import com.gouyan.system.domin.vo.SysSessionVo;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-24 23:23
 */
public interface SysSessionService {

    List<SysSession> findByVo(SysSessionVo sysSessionVo);

    SysSession findById(Long id);

    SysSession findOne(Long id);

    int add(SysSession sysSession);

    int update(SysSession sysSession);

    int delete(Long[] id);

    List<SysSession> findByCinemaAndMovie(Long cinemaId, Long movieId);

}
