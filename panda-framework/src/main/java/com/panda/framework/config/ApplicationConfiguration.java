package com.panda.framework.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-15 22:41
 */
@Configuration
//配置要扫描mapper的包
@MapperScan("com.panda.**.mapper")
public class ApplicationConfiguration {
}
