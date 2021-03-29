package com.gouyan.system.service;

import com.gouyan.system.domin.SysActor;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-23 15:36
 */
public interface SysActorService {
    List<SysActor> findAll(SysActor sysActor);

    SysActor findById(Long id);

    int add(SysActor sysActor);

    int update(SysActor sysActor);

    int delete(Long[] ids);

    SysActor findActorById(Long id);
}
