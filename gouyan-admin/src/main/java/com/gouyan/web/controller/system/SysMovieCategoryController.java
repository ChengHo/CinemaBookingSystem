package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysMovieArea;
import com.gouyan.system.domin.SysMovieCategory;
import com.gouyan.system.service.impl.SysMovieCategoryServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-19 18:45
 */
@RestController
public class SysMovieCategoryController extends BaseController {

    @Autowired
    private SysMovieCategoryServiceImpl sysMovieCategoryService;

    @GetMapping("/sysMovieCategory")
    public ResponseResult findAll(){
        startPage();
        List<SysMovieCategory> data = sysMovieCategoryService.findAll();
        return getResult(data);
    }

    @GetMapping("/sysMovieCategory/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysMovieCategoryService.findById(id));
    }

    @PostMapping("/sysMovieCategory")
    public ResponseResult add(@Validated @RequestBody SysMovieCategory sysMovieCategory){
        return getResult(sysMovieCategoryService.add(sysMovieCategory));
    }


    @PutMapping("/sysMovieCategory")
    public ResponseResult update(@Validated @RequestBody SysMovieCategory sysMovieCategory){
        return getResult(sysMovieCategoryService.update(sysMovieCategory));
    }

    @DeleteMapping("/sysMovieCategory/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysMovieCategoryService.delete(ids));
    }
}
