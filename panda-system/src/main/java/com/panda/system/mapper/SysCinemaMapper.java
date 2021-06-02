package com.panda.system.mapper;

import com.panda.system.domin.SysCinema;

import java.util.List;


public interface SysCinemaMapper {

    SysCinema findById(Long id);

    int update(SysCinema sysCinema);

    //前台展示单个影院信息，返回包含影院、上映中的所有电影信息
    SysCinema findCinemaById(Long id);

}
