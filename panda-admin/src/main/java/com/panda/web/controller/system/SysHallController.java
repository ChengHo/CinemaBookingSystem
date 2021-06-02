package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysHall;
import com.panda.system.service.impl.SysHallServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
public class SysHallController extends BaseController {

    @Autowired
    private SysHallServiceImpl sysHallService;

    @GetMapping("/sysHall")
    public ResponseResult findAll(SysHall sysHall){
        startPage();
        return getResult(sysHallService.findAll(sysHall));
    }

    @GetMapping("/sysHall/{hallId}")
    public ResponseResult findById(@PathVariable Long hallId){
        SysHall sysHall = new SysHall();
        sysHall.setHallId(hallId);
        return getResult(sysHallService.findById(sysHall));
    }

    @PostMapping("/sysHall")
    public ResponseResult add(@Validated @RequestBody SysHall sysHall){
        return getResult(sysHallService.add(sysHall));
    }

    @PutMapping("/sysHall")
    public ResponseResult update(@Validated @RequestBody SysHall sysHall){
        int rows = sysHallService.update(sysHall);
        return getResult(rows);
    }

    @PostMapping("/sysHall/delete")
    public ResponseResult delete(@RequestBody SysHall[] sysHalls){
        return getResult(sysHallService.delete(sysHalls));
    }

}
