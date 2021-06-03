package com.panda.framework.config;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.panda.common.exception.DataNotFoundException;
import com.panda.common.utils.ApplicationContextUtils;
import com.panda.system.domin.SysBill;
import com.panda.system.domin.SysSession;
import com.panda.system.service.impl.SysBillServiceImpl;
import com.panda.system.service.impl.SysSessionServiceImpl;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Configuration
public class QuartzConfig {

    @Autowired
    private SysBillServiceImpl sysBillService;

    @Autowired
    private SysSessionServiceImpl sysSessionService;

    @Bean
    public JobDetail jobDetail() {
        QuartzJobBean quartzJob = new QuartzJobBean() {
            @Override
            protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                System.out.println("执行取消超时订单处理" + sdf.format(new Date()));
                // 取消所有超时订单并释放占座资源
                ApplicationContextUtils.getBean("cancelTimeoutBill");
            }
        };
        return JobBuilder.newJob(quartzJob.getClass()).storeDurably().build();
    }

    @Bean
    public SimpleTrigger trigger() {
        //每5分钟执行一次，一直重复执行
        SimpleScheduleBuilder scheduleBuilder =
                SimpleScheduleBuilder.simpleSchedule()
                        .withIntervalInSeconds(5 * 60)
                        .repeatForever();
        return TriggerBuilder.newTrigger()
                .forJob(jobDetail())
                .withSchedule(scheduleBuilder).build();
    }

}
