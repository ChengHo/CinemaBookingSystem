package com.gouyan.web.controller.system;

import com.gouyan.common.constant.MovieRankingList;
import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysMovie;
import com.gouyan.system.domin.vo.SysMovieVo;
import com.gouyan.system.service.impl.SysMovieServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-22 16:00
 */
@RestController
public class SysMovieController extends BaseController {

    @Autowired
    private SysMovieServiceImpl sysMovieService;

    @GetMapping("/sysMovie")
    public ResponseResult findAll(SysMovieVo sysMovieVo){
        startPage();
        List<SysMovie> data = sysMovieService.findAll(sysMovieVo);
        return getResult(data);
    }

    @GetMapping("/sysMovie/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysMovieService.findById(id));
    }

    @PostMapping("/sysMovie")
    public ResponseResult add(@Validated @RequestBody SysMovie sysMovie){
        return getResult(sysMovieService.add(sysMovie));
    }

    @PutMapping("/sysMovie")
    public ResponseResult update(@Validated @RequestBody SysMovie sysMovie){
        return getResult(sysMovieService.update(sysMovie));
    }

    @DeleteMapping("/sysMovie/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysMovieService.delete(ids));
    }

    @GetMapping("/sysMovie/find/{id}")
    public ResponseResult findMovieById(@PathVariable Long id){
        return getResult(sysMovieService.findMovieById(id));
    }

    @GetMapping("/sysMovie/rankingList/{listId}")
    public ResponseResult findRankingList(@PathVariable Integer listId) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        if(listId <= 0 || listId > 4){
            //暂时只支持4种榜单
            return ResponseResult.error("抱歉，暂时只支持4种榜单，id为[1,4]");
        }
        Method getList = sysMovieService.getClass().getMethod(MovieRankingList.listNames[listId - 1]);
        startPage();
        List<SysMovie> data = (List<SysMovie>)getList.invoke(sysMovieService);
        return getResult(data);
    }

}
