package com.panda.system.service;

import com.panda.system.domin.SysHall;

import java.util.List;


public interface SysHallService {
    List<SysHall> findAll(SysHall sysHall);

    SysHall findById(SysHall sysHall);

    int add(SysHall sysHall);

    int update(SysHall sysHall);

    int delete(SysHall[] sysHall);
}
