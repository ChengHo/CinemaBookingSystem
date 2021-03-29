package com.gouyan.system.service;

import com.gouyan.system.domin.SysHallCategory;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-19 21:11
 */
public interface SysHallCategoryService {
    /**
     * 查询所有影厅分类信息
     * @return
     */
    List<SysHallCategory> findAll();

    /**
     * 根据id查询影厅分类信息
     * @param id
     * @return
     */
    SysHallCategory findById(Long id);

    /**
     * 添加影厅分类信息
     * @param sysHallCategory
     */
    int add(SysHallCategory sysHallCategory);

    /**
     * 修改影厅分类信息
     * @param sysHallCategory
     */
    int update(SysHallCategory sysHallCategory);

    /**
     * 删除指定id的影厅分类
     * @param ids
     */
    int delete(Long[] ids);
}
