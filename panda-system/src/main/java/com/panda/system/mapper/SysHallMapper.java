package com.panda.system.mapper;

import com.panda.system.domin.SysHall;

import java.util.List;


public interface SysHallMapper {
    List<SysHall> findAll(SysHall sysHall);

    SysHall findById(SysHall sysHall);

    int add(SysHall sysHall);

    int update(SysHall sysHall);

    int delete(SysHall sysHall);
}
