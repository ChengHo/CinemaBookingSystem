package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysMovieAge;
import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-14 22:52
 */
public interface SysMovieAgeMapper {

    /**
     * 查询所有
     * @return
     */
    List<SysMovieAge> findAll();

    /**
     * 根据id查询
     * @param id
     * @return
     */
    SysMovieAge findById(Long id);

    /**
     * 添加电影年代
     * @param sysMovieAge
     * @return 影响行数
     */
    int add(SysMovieAge sysMovieAge);

    /**
     * 修改电影年代
     * @param sysMovieAge
     */
    int update(SysMovieAge sysMovieAge);

    /**
     * 删除指定id的电影年代
     * @param id
     */
    int delete(Long id);
}
