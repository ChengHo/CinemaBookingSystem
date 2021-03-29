package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysResource;
import com.gouyan.system.service.impl.SysResourceServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class SysResourceController extends BaseController {

    @Autowired
    SysResourceServiceImpl sysResourceService;

    @GetMapping("/sysResource")
    public ResponseResult findAll(){
        startPage();
        List<SysResource> data = sysResourceService.findAll();
        return getResult(data);
    }

    @GetMapping("/sysResource/children")
    public ResponseResult findWithChildren(){
        return getResult((Object)sysResourceService.findWithChildren());
    }

    @GetMapping("/sysResource/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysResourceService.findById(id));
    }

    @GetMapping("/sysResource/tree")
    public ResponseResult findAllWithAllChildren(){
        return getResult(sysResourceService.findAllWithAllChildren());
    }

    @PostMapping("/sysResource")
    public ResponseResult add(@Validated @RequestBody SysResource sysResource){
        return getResult(sysResourceService.add(sysResource));
    }

    @PutMapping("/sysResource")
    public ResponseResult update(@Validated @RequestBody SysResource sysResource){
        return getResult(sysResourceService.update(sysResource));
    }

    @DeleteMapping("/sysResource/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysResourceService.delete(ids));
    }

}
