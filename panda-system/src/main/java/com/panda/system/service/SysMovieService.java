package com.panda.system.service;

import com.panda.system.domin.SysMovie;
import com.panda.system.domin.vo.SysMovieVo;

import java.util.List;


public interface SysMovieService {

    List<SysMovie> findAllMovies(SysMovieVo sysMovieVo);

    SysMovie findMovieById(Long id);

    SysMovie findOneMovie(Long id);

    int addMovie(SysMovie sysMovie);

    int updateMovie(SysMovie sysMovie);

    int deleteMovie(Long[] ids);

    //获取单个影院上映的所有电影信息
//    List<SysMovie> findByCinemaId(Long id);


    //获取各种榜单
    List<SysMovie> totalBoxOfficeList();

    List<SysMovie> domesticBoxOfficeList();

    List<SysMovie> foreignBoxOfficeList();

}
