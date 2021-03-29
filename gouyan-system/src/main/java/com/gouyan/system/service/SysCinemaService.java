package com.gouyan.system.service;

import com.gouyan.system.domin.SysCinema;
import com.gouyan.system.domin.vo.SysCinemaVo;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-25 22:24
 */
public interface SysCinemaService {

    List<SysCinema> findAll(SysCinemaVo sysCinemaVo);

    SysCinema findById(Long id);

    int add(SysCinema sysCinema);

    int update(SysCinema sysCinema);

    int delete(Long[] ids);

    SysCinema findCinemaById(Long id);

}
