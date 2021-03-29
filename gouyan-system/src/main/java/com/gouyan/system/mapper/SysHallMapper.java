package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysHall;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-25 10:16
 */
public interface SysHallMapper {
    List<SysHall> findAll(SysHall sysHall);

    SysHall findByCinemaIdAndHallId(SysHall sysHall);

    int add(SysHall sysHall);

    int update(SysHall sysHall);

    int delete(SysHall sysHall);
}
