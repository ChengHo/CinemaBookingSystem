package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.common.utils.ApplicationContextUtils;
import com.panda.framework.config.QuartzConfig;
import com.panda.system.domin.SysSession;
import com.panda.system.domin.vo.SysSessionVo;
import com.panda.system.service.impl.SysSessionServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
public class SysSessionController extends BaseController {

    @Autowired
    private SysSessionServiceImpl sysSessionService;

    /**
     * 根据vo中的条件查询所有场次，如果在前台购票部分注意设置pageSize=100或者其他大一些的数
     *
     * @param sysSessionVo
     * @return
     */
    @GetMapping("/sysSession")
    public ResponseResult findByVo(SysSessionVo sysSessionVo) {
        startPage();
        List<SysSession> list = sysSessionService.findByVo(sysSessionVo);
        return getResult(list);
    }

    @GetMapping("/sysSession/find/{id}")
    public ResponseResult findById(@PathVariable Long id) {
        ApplicationContextUtils.getBean("cancelTimeoutBill");
        return getResult(sysSessionService.findById(id));
    }


    @GetMapping("/sysSession/isAbleEdit")
    public ResponseResult findByMovieIdOrHallId(SysSession sysSession) {
        return getResult(sysSessionService.findByMovieIdOrHallId(sysSession));
    }

    @PostMapping("/sysSession")
    public ResponseResult add(@RequestBody SysSession sysSession) {
        return getResult(sysSessionService.add(sysSession));
    }

    @PutMapping("/sysSession")
    public ResponseResult update(@RequestBody SysSession sysSession) {
        return getResult(sysSessionService.update(sysSession));
    }

    @DeleteMapping("/sysSession/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids) {
        return getResult(sysSessionService.delete(ids));
    }

}
