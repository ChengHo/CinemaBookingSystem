package com.panda.web.controller.system;

import com.panda.common.constant.MovieRankingList;
import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysMovie;
import com.panda.system.domin.vo.SysMovieVo;
import com.panda.system.service.impl.SysMovieServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;


@RestController
public class SysMovieController extends BaseController {

    @Autowired
    private SysMovieServiceImpl sysMovieService;

    @GetMapping("/sysMovie/find")
    public ResponseResult findAll(SysMovieVo sysMovieVo) {
        startPage();
        List<SysMovie> data = sysMovieService.findAll(sysMovieVo);
        return getResult(data);
    }

    @GetMapping("/sysMovie/find/{id}")
    public ResponseResult findById(@PathVariable Long id) {
        return getResult(sysMovieService.findById(id));
    }

    @PostMapping("/sysMovie")
    public ResponseResult add(@Validated @RequestBody SysMovie sysMovie) {
        return getResult(sysMovieService.add(sysMovie));
    }

    @PutMapping("/sysMovie")
    public ResponseResult update(@Validated @RequestBody SysMovie sysMovie) {
        return getResult(sysMovieService.update(sysMovie));
    }

    @DeleteMapping("/sysMovie/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids) {
        return getResult(sysMovieService.delete(ids));
    }

    @GetMapping("/sysMovie/find/rankingList/{listId}")
    public ResponseResult findRankingList(@PathVariable Integer listId) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        if (listId <= 0 || listId > 4) {
            //暂时只支持4种榜单
            return ResponseResult.error("抱歉，暂时只支持3种榜单，id为[1,3]");
        }
        Method getList = sysMovieService.getClass().getMethod(MovieRankingList.listNames[listId - 1]);
        startPage();
        List<SysMovie> data = (List<SysMovie>) getList.invoke(sysMovieService);
        return getResult(data);
    }

}
