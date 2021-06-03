package com.panda.system.mapper;

import com.panda.system.domin.SysSession;
import com.panda.system.domin.vo.SysSessionVo;

import java.util.List;


public interface SysSessionMapper {

    /**
     * 根据条件查询
     *
     * @param sysSessionVo
     * @return
     */
    List<SysSession> findByVo(SysSessionVo sysSessionVo);

    /**
     * 查询一个
     *
     * @param sysSession
     * @return
     */
    List<SysSession> findSessionByMovieIdOrHallId(SysSession sysSession);

    /**
     * 查询一个
     *
     * @param id
     * @return
     */
    SysSession findSessionById(Long id);

    /**
     * 查询一个，不查询相关的信息
     *
     * @param id
     * @return
     */
    SysSession findOneSession(Long id);

    /**
     * 添加
     *
     * @param sysSession
     * @return
     */
    int addSession(SysSession sysSession);

    /**
     * 修改
     *
     * @param sysSession
     * @return
     */
    int updateSession(SysSession sysSession);

    /**
     * 删除
     *
     * @param id
     * @return
     */
    int deleteSession(Long id);

    /**
     * 根据影院id和电影id查询近5天上映的场次信息
     *
     * @param movieId
     * @return
     */
    List<SysSession> findSessionByMovieId(Long movieId);

}
