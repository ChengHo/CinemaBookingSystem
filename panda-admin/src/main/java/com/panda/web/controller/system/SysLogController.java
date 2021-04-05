package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysLog;
import com.panda.system.service.impl.SysLogServiceImpl;
import com.panda.web.controller.BaseController;
import com.panda.web.controller.annotation.SysLogAnnotaion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author: chengho
 * @create: 2021-04-01 17:36
 */
@RestController
public class SysLogController extends BaseController {
    @Autowired
    private SysLogServiceImpl sysLogService;

    @SysLogAnnotaion(operModul = "日志管理-查看日志", operSeq = "81")
    @GetMapping("/sysLog")
    public ResponseResult findAll(){
        startPage();
        List<SysLog> data = sysLogService.findAll();
        return getResult(data);
    }
}
