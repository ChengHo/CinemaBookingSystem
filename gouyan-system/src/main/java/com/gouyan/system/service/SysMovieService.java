package com.gouyan.system.service;

import com.gouyan.system.domin.SysMovie;
import com.gouyan.system.domin.vo.SysMovieVo;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-22 15:56
 */
public interface SysMovieService {

    List<SysMovie> findAll(SysMovieVo sysMovieVo);

    SysMovie findById(Long id);

    SysMovie findOne(Long id);

    int add(SysMovie sysMovie);

    int update(SysMovie sysMovie);

    int delete(Long[] ids);

    SysMovie findMovieById(Long id);

    //获取单个影院上映的所有电影信息
    List<SysMovie> findByCinemaId(Long id);


    //获取各种榜单
    List<SysMovie> hotMovieList();

    List<SysMovie> domesticBoxOfficeList();

    List<SysMovie> europeanAndAmericanBoxOfficeList();

    List<SysMovie> top100List();
}
