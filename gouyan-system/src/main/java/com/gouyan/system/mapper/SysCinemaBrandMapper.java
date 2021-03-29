package com.gouyan.system.mapper;

import com.gouyan.system.domin.SysCinemaBrand;

import java.util.List;

public interface SysCinemaBrandMapper {
    
    List<SysCinemaBrand> findAll();
    
    SysCinemaBrand findById(Long id);
    
    int add(SysCinemaBrand sysCinemaBrand);
    
    int update(SysCinemaBrand sysCinemaBrand);

    int delete(Long id);
}
