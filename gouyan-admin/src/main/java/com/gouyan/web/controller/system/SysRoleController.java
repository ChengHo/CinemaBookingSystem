package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysRole;
import com.gouyan.system.service.impl.SysRoleServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class SysRoleController extends BaseController {

    @Autowired
    SysRoleServiceImpl sysRoleService;

    @GetMapping("/sysRole")
    public ResponseResult findAll(){
        startPage();
        List<SysRole> data = sysRoleService.findAll();
        return getResult(data);
    }

    @GetMapping("/sysRole/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysRoleService.findById(id));
    }

    @PostMapping("/sysRole")
    public ResponseResult add(@Validated @RequestBody SysRole sysRole){
        return getResult(sysRoleService.add(sysRole));
    }

    @PutMapping("/sysRole")
    public ResponseResult update(@Validated @RequestBody SysRole sysRole){
        return getResult(sysRoleService.update(sysRole));
    }

    @DeleteMapping("/sysRole/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysRoleService.delete(ids));
    }

    /**
     * 给指定 id 的角色分配权限，包括增加或者删除权限
     * @param roleId
     * @param keys
     * @return
     */
    @PostMapping("/sysRole/{roleId}")
    public ResponseResult allotRight(@PathVariable Long roleId, @RequestBody Long[] keys){
        return getResult(sysRoleService.allotRight(roleId, keys));
    }

}
