package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysUserHobby;
import com.panda.system.service.impl.SysUserHobbyServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-20 10:54
 */
@RestController
public class SysUserHobbyController extends BaseController {

    @Autowired
    SysUserHobbyServiceImpl sysUserHobbyService;

    @GetMapping("/sysUserHobby")
    public ResponseResult findAll(){
        startPage();
        List<SysUserHobby> data = sysUserHobbyService.findAll();
        return getResult(data);
    }

    @GetMapping("/sysUserHobby/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysUserHobbyService.findById(id));
    }

    @PostMapping("/sysUserHobby")
    public ResponseResult add(@Validated @RequestBody SysUserHobby sysUserHobby){
        return getResult(sysUserHobbyService.add(sysUserHobby));
    }

    @PutMapping("/sysUserHobby")
    public ResponseResult update(@Validated @RequestBody SysUserHobby sysUserHobby){
        return getResult(sysUserHobbyService.update(sysUserHobby));
    }

    @DeleteMapping("/sysUserHobby/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysUserHobbyService.delete(ids));
    }

}
