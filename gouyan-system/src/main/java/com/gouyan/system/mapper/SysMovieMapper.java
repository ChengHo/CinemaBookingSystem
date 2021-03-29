package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysMovie;
import com.gouyan.system.domin.vo.SysMovieVo;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-22 10:00
 */
public interface SysMovieMapper {

    /**
     * 按照传入对象的参数进行条件分页查询
     * @param sysMovieVo
     * @return
     */
    List<SysMovie> findAll(SysMovieVo sysMovieVo);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    SysMovie findById(Long id);

    /**
     * 查询一个电影的信息，不查询相关的演员等信息
     * @param id
     * @return
     */
    SysMovie findOne(Long id);

    /**
     * 添加
     * @param sysMovie
     * @return 影响行数
     */
    int add(SysMovie sysMovie);

    /**
     * 修改
     * @param sysMovie
     */
    int update(SysMovie sysMovie);

    /**
     * 删除
     * @param id
     */
    int delete(Long id);


    /**
     * 前台根据movie_id查询电影信息，含电影演员与演员对应角色
     * @param id
     * @return
     */
    SysMovie findMovieById(Long id);

    /**
     * 根据影院id查询影院上映的所有电影
     * @param id
     * @return
     */
    List<SysMovie> findByCinemaId(Long id);

    /**
     * 热映口碑榜 昨日热映的电影里，按评分取前10
     * @return
     */
    List<SysMovie> hotMovieList();

    /**
     * 国内票房榜 已上映的国内电影里，按票房取前10 国内电影 areaid = 1、5、6
     * @return
     */
    List<SysMovie> domesticBoxOfficeList();

    /**
     * 欧美票房榜 已上映的欧美电影里，按票房取前10 欧美电影 areaid = 2、9、10、11、12、13、14
     * @return
     */
    List<SysMovie> europeanAndAmericanBoxOfficeList();

    /**
     * top100榜 所有已上映影片按评分、评分人数取前100
     * @return
     */
    List<SysMovie> top100List();

}
