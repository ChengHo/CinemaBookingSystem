package com.gouyan.system.service.impl;

import com.gouyan.system.domin.SysActorMovie;
import com.gouyan.system.mapper.SysActorMovieMapper;
import com.gouyan.system.service.SysActorMovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-27 10:28
 */
@Service
public class SysActorMovieServiceImpl implements SysActorMovieService {

    @Autowired
    private SysActorMovieMapper sysActorMovieMapper;

    @Override
    public List<SysActorMovie> findAll(SysActorMovie sysActorMovie) {
        return sysActorMovieMapper.findAll(sysActorMovie);
    }

    @Override
    public int add(SysActorMovie sysActorMovie) {
        return sysActorMovieMapper.add(sysActorMovie);
    }

    @Override
    public int delete(SysActorMovie sysActorMovie) {
        return sysActorMovieMapper.delete(sysActorMovie);
    }
}
