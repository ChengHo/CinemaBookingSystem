package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysMovie;
import com.gouyan.system.domin.vo.SysMovieVo;
import com.gouyan.system.mapper.SysMovieMapper;
import com.gouyan.system.service.SysMovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-22 15:58
 */
@Service
public class SysMovieServiceImpl implements SysMovieService {

    @Autowired
    private SysMovieMapper sysMovieMapper;

    @Override
    public List<SysMovie> findAll(SysMovieVo sysMovieVo) {
        return sysMovieMapper.findAll(sysMovieVo);
    }

    @Override
    public SysMovie findById(Long id) {
        return sysMovieMapper.findById(id);
    }

    @Override
    public SysMovie findOne(Long id) {
        return sysMovieMapper.findOne(id);
    }

    @Override
    public int add(SysMovie sysMovie) {
        return sysMovieMapper.add(sysMovie);
    }

    @Override
    public int update(SysMovie sysMovie) {
        return sysMovieMapper.update(sysMovie);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for(Long id : ids){
            rows += sysMovieMapper.delete(id);
        }
        return rows;
    }

    @Override
    public SysMovie findMovieById(Long id) {
        return sysMovieMapper.findMovieById(id);
    }

    @Override
    public List<SysMovie> findByCinemaId(Long id) {
        return sysMovieMapper.findByCinemaId(id);
    }

    /**
     * 热映口碑榜 昨日热映的电影里，按评分取前10
     * @return
     */
    @Override
    public List<SysMovie> hotMovieList() {
        return sysMovieMapper.hotMovieList();
    }

    /**
     * 国内票房榜 已上映的国内电影里，按票房取前10 国内电影 areaid = 1、5、6
     * @return
     */
    @Override
    public List<SysMovie> domesticBoxOfficeList() {
        return sysMovieMapper.domesticBoxOfficeList();
    }

    /**
     * 欧美票房榜 已上映的欧美电影里，按票房取前10 欧美电影 areaid = 2、9、10、11、12、13、14
     * @return
     */
    @Override
    public List<SysMovie> europeanAndAmericanBoxOfficeList() {
        return sysMovieMapper.europeanAndAmericanBoxOfficeList();
    }

    /**
     * top100榜 所有已上映影片按评分、评分人数取前100
     * @return
     */
    @Override
    public List<SysMovie> top100List() {
        return sysMovieMapper.top100List();
    }
}
