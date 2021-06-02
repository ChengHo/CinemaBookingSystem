package com.panda.system.service.impl;

import com.panda.system.domin.SysMovie;
import com.panda.system.domin.vo.SysMovieVo;
import com.panda.system.mapper.SysMovieMapper;
import com.panda.system.service.SysMovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


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

//    @Override
//    public List<SysMovie> findByCinemaId(Long id) {
//        return sysMovieMapper.findByCinemaId(id);
//    }

    /**
     * 总票房榜
     * @return
     */
    @Override
    public List<SysMovie> totalBoxOfficeList() {
        return sysMovieMapper.totalBoxOfficeList();
    }

    /**
     * 国内票房榜 已上映的国内电影里，按票房取前10 国内电影 movieArea in (港台+大陆)
     * @return
     */
    @Override
    public List<SysMovie> domesticBoxOfficeList() {
        return sysMovieMapper.domesticBoxOfficeList();
    }

    /**
     * 国外票房榜 已上映的国外电影里，按票房取前10 国外电影 movieArea not in (港台+大陆)
     * @return
     */
    @Override
    public List<SysMovie> foreignBoxOfficeList() {
        return sysMovieMapper.foreignBoxOfficeList();
    }

}
