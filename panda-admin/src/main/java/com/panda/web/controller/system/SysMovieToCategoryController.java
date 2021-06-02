package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysMovieToCategory;
import com.panda.system.service.impl.SysMovieToCategoryServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
public class SysMovieToCategoryController extends BaseController {

    @Autowired
    private SysMovieToCategoryServiceImpl sysMovieToCategoryService;

    @GetMapping("/sysMovieToCategory")
    public ResponseResult findAll(SysMovieToCategory sysMovieToCategory) {
        startPage();
        return getResult(sysMovieToCategoryService.findAll(sysMovieToCategory));
    }

    @PostMapping("/sysMovieToCategory/{movieId}/{movieCategoryId}")
    public ResponseResult add(@PathVariable Long movieId, @PathVariable Long movieCategoryId) {
        return getResult(sysMovieToCategoryService.add(new SysMovieToCategory(movieId, movieCategoryId)));
    }

    @DeleteMapping("/sysMovieToCategory/{movieId}/{movieCategoryId}")
    public ResponseResult delete(@PathVariable Long movieId, @PathVariable Long movieCategoryId) {
        return getResult(sysMovieToCategoryService.delete(new SysMovieToCategory(movieId, movieCategoryId)));
    }

}
