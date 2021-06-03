package com.panda.system.mapper;

import com.panda.system.domin.SysResource;

import java.util.List;


public interface SysResourceMapper {

    /**
     * 查询所有并包含其父菜单
     *
     * @return
     */
    List<SysResource> findAllResources();

    /**
     * 查出所有菜单并包含其直接children
     *
     * @return
     */
    List<SysResource> findWithChildren();

    /**
     * 查询所有按父子关系的权限
     *
     * @return
     */
    List<SysResource> findAllWithAllChildren();

    SysResource findResourceById(Long id);

    int addResource(SysResource sysResource);

    int updateResource(SysResource sysResource);

    int deleteResource(Long id);

}
