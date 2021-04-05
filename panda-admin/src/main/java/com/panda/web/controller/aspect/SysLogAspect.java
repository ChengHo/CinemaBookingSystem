package com.panda.web.controller.aspect;

import com.panda.common.utils.IpUtils;
import com.panda.common.utils.JacksonUtils;
import com.panda.common.utils.JwtUtil;
import com.panda.common.utils.ServletUtil;
import com.panda.system.domin.SysLog;
import com.panda.system.domin.vo.SysUserVo;
import com.panda.system.service.SysLogService;
import org.apache.shiro.authc.AuthenticationException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import com.panda.web.controller.annotation.SysLogAnnotaion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

/**
 * @author: chengho
 * @create: 2021-04-02 12:40
 */
@Aspect
@Component
public class SysLogAspect {

    private final static int ADMIN_PORT = 8888;
    private final static String ADMIN_IP = "127.0.0.1";
    private final static String ADMIN_IP_ADDRESS = "localhost";

    private static final Logger logger = LoggerFactory.getLogger(SysLogAspect.class);

    @Autowired
    private SysLogService sysLogService;

    @Pointcut("@annotation(com.panda.web.controller.annotation.SysLogAnnotaion)")
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

    public void saveLog(ProceedingJoinPoint joinPoint, long time) throws Exception {
        SysLog sysLog = new SysLog();

        // 从切面织入点处通过反射机制获取织入点处的方法
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        //获取切入点所在的方法
        Method method = signature.getMethod();

        //获取请求的类名
        String className = joinPoint.getTarget().getClass().getName();
        //获取请求的方法名
        String methodName = method.getName();
        sysLog.setMethod(className + "." + methodName);

        SysLogAnnotaion sysLogAnnotaion = method.getAnnotation(SysLogAnnotaion.class);
        if (sysLogAnnotaion != null) {
            // 注解上的描述
            sysLog.setDescription(sysLogAnnotaion.operModul());
        }

        // 获取HttpServletRequest对象
        HttpServletRequest request = ServletUtil.getRequest();
        HttpServletResponse response = ServletUtil.getResponse();
        // 设置IP地址
        sysLog.setIp(IpUtils.getIpAdrress(request));
        // 判断是否为管理系统，是则添加管理系统属性并添加管理项序号
        if (isAdminSystem(IpUtils.getOriginIPAndPort(request))) {
            sysLog.setSysType("管理系统");
            if (sysLog.getDescription() != null) {
                sysLog.setOperSeq(sysLogAnnotaion.operSeq());
            }
        } else {
            sysLog.setSysType("购票系统");
        }
        // 设置根路径
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
        sysLog.setBasePath(basePath);
        // 获取uri
        sysLog.setReqUri(request.getRequestURI());

        // 请求方式
        sysLog.setReqType(request.getMethod());
        // 获取用户设备信息
        sysLog.setUserAgent(request.getHeader("User-Agent"));

        //请求的参数
        Object[] args = joinPoint.getArgs();
        if (sysLog.getReqUri().equals("/sysUser/login")) {
            SysUserVo arg = (SysUserVo) args[0];
            sysLog.setUserName(arg.getUserName());
        } else if (sysLog.getReqUri().contains("/sysUser/logout")) {
            sysLog.setUserName((String) args[0]);
        } else {
            String token = request.getHeader("Token");
            // 解密获得username，用于和数据库进行对比
            String username = null;
            try {
                //这里工具类没有处理空指针等异常这里处理一下(这里处理科学一些)
                username = JwtUtil.getUsername(token);
            } catch (Exception e){
                throw new AuthenticationException("token拼写错误或者值为空");
            }

            sysLog.setUserName(username);
        }

        //将参数所在的数组转换成json
        String params = null;
        try {
            params = JacksonUtils.obj2json(args);
        } catch (Exception e) {
            logger.error("error: "+ e.getMessage(),e);
            e.printStackTrace();
        }
        sysLog.setParams(params);

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

    // 判断是否为管理系统
    public boolean isAdminSystem(Map map) throws Exception{
        boolean result = false;
        int originPortIntValue = -1;

        String originPort = (String) map.get("originPort");
        try {
            originPortIntValue = Integer.parseInt(originPort);
        } catch (Exception e){
            logger.error("端口String类型转换int失败");
            e.printStackTrace();
        }

        // 当管理系统和购票系统ip相同，端口号不同时，以端口号判断是否为管理系统
        if (originPortIntValue >= ADMIN_PORT) {
            result = true;
        }

//        // 当管理系统和购票系统端口号相同，ip不同时，以ip判断是否为管理系统
//        if (map.get("originIP").equals(ADMIN_IP_ADDRESS) || map.get("originIP").equals(ADMIN_IP)) {
//            result = true;
//        }

        // 不设置两系统端口和ip都相同的情况，当ip和端口都不同是，则有一个不同就能做出判断

        return result;
    }
}
