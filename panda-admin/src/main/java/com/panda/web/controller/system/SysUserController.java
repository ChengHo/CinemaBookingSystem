package com.panda.web.controller.system;

import com.panda.common.response.ResponseResult;
import com.panda.system.domin.SysUser;
import com.panda.system.domin.vo.SysUserVo;
import com.panda.system.service.impl.SysUserServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class SysUserController extends BaseController {
    @Autowired
    private SysUserServiceImpl sysUserService;

    @GetMapping("/sysUser")
    public ResponseResult findAllUsers(SysUser sysUser) {
        startPage();
        List<SysUser> data = sysUserService.findAllUsers(sysUser);
        return getResult(data);
    }

    @GetMapping("/sysUser/{id}")
    public ResponseResult findUserById(@PathVariable Long id) {
        return getResult(sysUserService.findUserById(id));
    }

    /**
     * 添加用户请求，注册也在这里
     * @param sysUser
     * @return
     */
    @PostMapping("/sysUser")
    public ResponseResult addUser(@Validated @RequestBody SysUser sysUser) {
        return getResult(sysUserService.addUser(sysUser));
    }

    @PutMapping("/sysUser")
    public ResponseResult updateUser(@Validated @RequestBody SysUser sysUser) {
        return getResult(sysUserService.updateUser(sysUser));
    }

    @DeleteMapping("/sysUser/{ids}")
    public ResponseResult deleteUser(@PathVariable Long[] ids) {
        return getResult(sysUserService.deleteUser(ids));
    }

    /**
     * 用户登录请求
     *
     * @param sysUserVo
     * @return
     */
    @RequestMapping("/sysUser/login")
    public ResponseResult login(@RequestBody SysUserVo sysUserVo) {
        return getResult(sysUserService.login(sysUserVo));
    }

    /**
     * 用户注册请求
     *
     * @param sysUser
     * @return
     */
    @PostMapping("/sysUser/register")
    public ResponseResult register(@Validated @RequestBody SysUser sysUser) {
        // 注册只接收部分参数值，重新建立一个实例对象只接受注册接受的参数
        SysUser registerUserInfo = new SysUser();
        registerUserInfo.setUserName(sysUser.getUserName());
        registerUserInfo.setPassword(sysUser.getPassword());
        registerUserInfo.setSex(sysUser.getSex());
        registerUserInfo.setPhoneNumber(sysUser.getPhoneNumber());
        return getResult(sysUserService.addUser(registerUserInfo));
    }

}
