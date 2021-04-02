package com.gouyan.web.controller.aspect;

import com.alibaba.druid.support.json.JSONUtils;
import com.gouyan.system.domin.SysLog;
import com.gouyan.system.domin.SysUser;
import com.gouyan.system.service.impl.SysLogServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import com.gouyan.web.controller.annotation.Log;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

/**
 * @author: chengho
 * @create: 2021-04-02 12:40
 */
@Aspect
@Component
public class LogAspect {
    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);

    @Autowired
    private SysLogServiceImpl sysLogService;

    @Pointcut("@annotation(com.gouyan.web.controller.annotation.Log)")
    public void logPointCut() {
    }

    @Around("logPointCut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        long beginTime = System.currentTimeMillis();

        //执行方法
        Object result = point.proceed();
        //执行时长（ms）
        long time = System.currentTimeMillis() - beginTime;
        saveLog(point, time);
        return result;
    }

    public void saveLog(ProceedingJoinPoint joinPoint, long time) throws InterruptedException {

        logger.debug("into LOG AOP==============================++++++++++++++++++++++++++++++++");
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        SysLog sysLog = new SysLog();
logger.debug(method.getName());
        Log syslog = method.getAnnotation(Log.class);
        if (syslog != null) {
            // 注解上的描述
            sysLog.setDescription(syslog.value());
        }

        // 获取request
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        // 设置IP地址
        sysLog.setIp(IPUtils.getIpAddr(request));
        // 设置根路径
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
        sysLog.setBasePath(basePath);
        // 获取uri
        sysLog.setReqUrl(request.getRequestURI());
        // 请求方式
        sysLog.setMethod(request.getMethod());
        // 获取用户设备信息
        sysLog.setUserAgent(request.getHeader("User-Agent"));
        // 用户名
//        SysUser currUser = ShiroUtils.getUser();
        SysUser currUser = (SysUser) SecurityUtils.getSubject().getPrincipal();

        // 请求的参数
        Map<String, String[]> paramMap = request.getParameterMap();
        try {
            if (paramMap != null) {
                String params = JSONUtils.toJSONString(paramMap);
                params = params.substring(0, params.length() < 1000 ? params.length(): 999);
                sysLog.setParameter(params);
            }
        } catch (Exception e) {
            logger.error("error: "+ e.getMessage(),e);
        }
        if (null == currUser) {
            if (null != sysLog.getParameter()) {
                sysLog.setUserName(sysLog.getParameter());
            } else {
                sysLog.setUserName("获取用户信息为空");
            }
        } else {
//            sysLog.setUserName(ShiroUtils.getUser().getUsername());
            sysLog.setUserName(((SysUser) SecurityUtils.getSubject().getPrincipal()).getUserName());
        }
        sysLog.setSpendTime((int) time);
        // 系统当前时间
        Date date = new Date();
        sysLog.setStartTime(date);
        // 相应状态 0：成功， 1：失败
        sysLog.setResult(0);
        logger.debug(sysLog.getMethod());
        // 保存系统日志
        sysLogService.insert(sysLog);
    }
}
