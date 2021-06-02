package com.panda.system.service;

import com.panda.system.domin.SysCinema;

import java.util.List;


public interface SysCinemaService {

    SysCinema findById(Long id);

    int update(SysCinema sysCinema);

    SysCinema findCinemaById(Long id);

}
