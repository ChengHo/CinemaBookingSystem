package com.gouyan.web.controller.system;

import com.gouyan.common.response.ResponseResult;
import com.gouyan.system.domin.SysCinemaBrand;
import com.gouyan.system.service.impl.SysCinemaBrandServiceImpl;
import com.gouyan.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
public class SysCinemaBrandController extends BaseController {
    @Autowired
    private SysCinemaBrandServiceImpl sysCinemaBrandService;

    @GetMapping("/sysCinemaBrand")
    public ResponseResult findAll(){
        startPage();
        List<SysCinemaBrand> data = sysCinemaBrandService.findAll();
        return getResult(data);
    }

    @GetMapping("/sysCinemaBrand/{id}")
    public ResponseResult findById(@PathVariable Long id){
        return getResult(sysCinemaBrandService.findById(id));
    }

    @PostMapping("/sysCinemaBrand")
    public ResponseResult add(@Validated @RequestBody SysCinemaBrand sysCinemaBrand){
        return getResult(sysCinemaBrandService.add(sysCinemaBrand));
    }


    @PutMapping("/sysCinemaBrand")
    public ResponseResult update(@Validated @RequestBody SysCinemaBrand sysCinemaBrand){
        return getResult(sysCinemaBrandService.update(sysCinemaBrand));
    }

    @DeleteMapping("/sysCinemaBrand/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids){
        return getResult(sysCinemaBrandService.delete(ids));
    }
}
