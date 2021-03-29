package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysResource;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-19 22:52
 */
public interface SysResourceMapper {

    /**
     * 查询所有并包含其父菜单
     * @return
     */
    List<SysResource> findAll();

    /**
     * 查出所有菜单并包含其直接children
     * @return
     */
    List<SysResource> findWithChildren();

    /**
     * 根据父资源权限id查询权限
     * @param id
     * @return
     */
    List<SysResource> findByParentId(Long id);

    /**
     * 查询所有按父子关系的权限
     * @return
     */
    List<SysResource> findAllWithAllChildren();

    SysResource findById(Long id);

    int add(SysResource sysResource);

    int update(SysResource sysResource);

    int delete(Long id);

}
