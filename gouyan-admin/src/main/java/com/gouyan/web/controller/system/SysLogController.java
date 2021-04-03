package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysLog;
import com.gouyan.system.service.impl.SysLogServiceImpl;
import com.gouyan.web.controller.BaseController;
import com.gouyan.web.controller.annotation.SysLogAnnotaion;
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

    @SysLogAnnotaion(value = "查看日志")
    @GetMapping("/sysLog")
    public ResponseResult findAll(){
        startPage();
        List<SysLog> data = sysLogService.findAll();
        return getResult(data);
    }
}
