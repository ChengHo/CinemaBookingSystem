package com.panda.system.service;

import com.panda.system.domin.SysResource;

import java.util.List;


public interface SysResourceService {
    List<SysResource> findAllResources();

    List<SysResource> findWithChildren();

    List<SysResource> findAllWithAllChildren();

    SysResource findResourceById(Long id);

    int addResource(SysResource sysResource);

    int updateResource(SysResource sysResource);

    int deleteResource(Long[] ids);
}
