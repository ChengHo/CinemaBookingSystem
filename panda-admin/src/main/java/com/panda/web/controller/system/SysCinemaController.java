package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysCinema;
import com.panda.system.domin.SysSession;
import com.panda.system.domin.vo.SysCinemaVo;
import com.panda.system.service.impl.SysCinemaServiceImpl;
import com.panda.system.service.impl.SysSessionServiceImpl;
import com.panda.web.controller.BaseController;
import com.panda.web.controller.annotation.SysLogAnnotaion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

/**
 * @author lxd
 * @create 2020-11-25 22:41
 */
@RestController
public class SysCinemaController extends BaseController {

    @Autowired
    private SysCinemaServiceImpl sysCinemaService;

    @Autowired
    private SysSessionServiceImpl sysSessionService;

    @SysLogAnnotaion(operModul = "影院信息管理-获取所有影院信息")
    @GetMapping("/sysCinema")
    public ResponseResult findAll(SysCinemaVo sysCinemaVo){
        startPage();
        return getResult(sysCinemaService.findAll(sysCinemaVo));
    }

    @GetMapping("/sysCinema/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysCinemaService.findById(id));
    }

    @SysLogAnnotaion(operModul = "影院信息管理-添加影院")
    @PostMapping("/sysCinema")
    public ResponseResult add(@Validated @RequestBody SysCinema sysCinema){
        return getResult(sysCinemaService.add(sysCinema));
    }

    @PutMapping("/sysCinema")
    public ResponseResult update(@Validated @RequestBody SysCinema sysCinema){
        return getResult(sysCinemaService.update(sysCinema));
    }

    @DeleteMapping("/sysCinema/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysCinemaService.delete(ids));
    }

    @GetMapping(value = {"/sysCinema/find/{cinemaId}/{movieId}", "/sysCinema/find/{cinemaId}"})
    public ResponseResult findCinemaById(@PathVariable Long cinemaId, @PathVariable(required = false) Long movieId){
        SysCinema cinema = sysCinemaService.findCinemaById(cinemaId);
        if(movieId == null || movieId == 0){
            movieId = cinema.getSysMovieList().size() > 0 ? cinema.getSysMovieList().get(0).getMovieId() : 0;
        }
        List<SysSession> sessions = null;
        if(movieId != null && movieId != 0){
            sessions = sysSessionService.findByCinemaAndMovie(cinemaId, movieId);
        }

        HashMap<String, Object> response = new HashMap<>();
        response.put("cinema", cinema);
        response.put("sessions", sessions);
        return getResult(response);

    }

}
