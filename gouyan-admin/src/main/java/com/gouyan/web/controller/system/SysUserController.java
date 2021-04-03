package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysUser;
import com.gouyan.system.domin.vo.SysUserVo;
import com.gouyan.system.service.impl.SysUserServiceImpl;
import com.gouyan.web.controller.BaseController;
import com.gouyan.web.controller.annotation.SysLogAnnotaion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lxd
 * @create 2020-11-22 21:52
 */

@RestController
public class SysUserController extends BaseController {
    @Autowired
    private SysUserServiceImpl sysUserService;

    @GetMapping("/sysUser")
    public ResponseResult findAll(SysUser sysUser){
        startPage();
        List<SysUser> data = sysUserService.findAll(sysUser);
        return getResult(data);
    }

    @GetMapping("/sysUser/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysUserService.findById(id));
    }

    /**
     * 添加用户请求，注册也在这里
     * @param sysUser
     * @return
     */
    @PostMapping("/sysUser")
    public ResponseResult add(@Validated @RequestBody SysUser sysUser){
        return getResult(sysUserService.add(sysUser));
    }

    @PutMapping("/sysUser")
    public ResponseResult update(@Validated @RequestBody SysUser sysUser){
        return getResult(sysUserService.update(sysUser));
    }

    @DeleteMapping("/sysUser/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysUserService.delete(ids));
    }

    //用户登录
    @SysLogAnnotaion(value = "sysloganno用户登录")
//    @Operation(value = "用户登录")
    @RequestMapping("/sysUser/login")
    public ResponseResult login(@RequestBody SysUserVo sysUserVo){
        return getResult(sysUserService.login(sysUserVo));
    }

    @SysLogAnnotaion(value = "退出登录")
    @RequestMapping("/sysUser/logout")
    public Map<String, String> logout(){
        Map<String, String> map = new HashMap<String, String>();
        map.put("1","result");
        return map;
    }
}
