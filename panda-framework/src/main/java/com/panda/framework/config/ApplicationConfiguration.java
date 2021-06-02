package com.panda.framework.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;


@Configuration
//配置要扫描mapper的包
@MapperScan("com.panda.**.mapper")
public class ApplicationConfiguration {
}
