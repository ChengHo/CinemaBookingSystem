package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysSession;
import com.gouyan.system.domin.vo.SysSessionVo;
import com.gouyan.system.service.impl.SysSessionServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-25 09:32
 */
@RestController
public class SysSessionController extends BaseController {

    @Autowired
    private SysSessionServiceImpl sysSessionService;

    /**
     * 根据vo中的条件查询所有场次，如果在前台购票部分注意设置pageSize=100或者其他大一些的数
     * @param sysSessionVo
     * @return
     */
    @GetMapping("/sysSession")
    public ResponseResult findByVo(SysSessionVo sysSessionVo){
        startPage();
        List<SysSession> list = sysSessionService.findByVo(sysSessionVo);
        return getResult(list);
    }

    @GetMapping("/sysSession/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysSessionService.findById(id));
    }

    @PostMapping("/sysSession")
    public ResponseResult add(@RequestBody SysSession sysSession){
        return getResult(sysSessionService.add(sysSession));
    }

    @PutMapping("/sysSession")
    public ResponseResult update(@RequestBody SysSession sysSession){
        return getResult(sysSessionService.update(sysSession));
    }

    @DeleteMapping("/sysSession/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysSessionService.delete(ids));
    }

}
