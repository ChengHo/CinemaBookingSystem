package com.panda.system.service;

import com.panda.system.domin.SysHall;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-25 10:21
 */
public interface SysHallService {
    List<SysHall> findAll(SysHall sysHall);

    SysHall findByCinemaIdAndHallId(SysHall sysHall);

    int add(SysHall sysHall);

    int update(SysHall sysHall);

    int delete(SysHall[] sysHall);
}
