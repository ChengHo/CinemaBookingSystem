package com.panda.system.mapper;

import com.panda.system.domin.SysMovie;
import com.panda.system.domin.vo.SysMovieVo;

import java.util.List;


public interface SysMovieMapper {

    /**
     * 按照传入对象的参数进行条件分页查询
     * @param sysMovieVo
     * @return
     */
    List<SysMovie> findAllMovies(SysMovieVo sysMovieVo);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    SysMovie findMovieById(Long id);

    /**
     * 查询一个电影的信息，不查询相关的其他等信息
     * @param id
     * @return
     */
    SysMovie findOneMovie(Long id);

    int addMovie(SysMovie sysMovie);

    int updateMovie(SysMovie sysMovie);

    int deleteMovie(Long id);

    /**
     * 查询影院上映的所有电影
     *
     * @param id
     * @return
     */
    List<SysMovie> findMovieByCinemaId(Long id);

    /**
     * 总票房榜
     * @return
     */
    List<SysMovie> totalBoxOfficeList();

    /**
     * 国内票房榜 已上映的国内电影里，按票房取前10 国内电影 movieArea in (港台+大陆)
     * @return
     */
    List<SysMovie> domesticBoxOfficeList();

    /**
     * 国外票房榜 已上映的国外电影里，按票房取前10 国外电影 movieArea not in (港台+大陆)
     * @return
     */
    List<SysMovie> foreignBoxOfficeList();

}
