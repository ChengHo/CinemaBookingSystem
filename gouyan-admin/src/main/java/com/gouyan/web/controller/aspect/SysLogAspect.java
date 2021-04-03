package com.gouyan.web.controller.aspect;

import com.gouyan.common.utils.IpAdrressUtils;
import com.gouyan.common.utils.JacksonUtils;
import com.gouyan.common.utils.JwtUtil;
import com.gouyan.system.domin.SysLog;
import com.gouyan.system.domin.vo.SysUserVo;
import com.gouyan.system.service.SysLogService;
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


import com.gouyan.web.controller.annotation.SysLogAnnotaion;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * @author: chengho
 * @create: 2021-04-02 12:40
 */
@Aspect
@Component
public class SysLogAspect {
    private static final Logger logger = LoggerFactory.getLogger(SysLogAspect.class);

    @Autowired
    private SysLogService sysLogService;

    @Pointcut("@annotation(com.gouyan.web.controller.annotation.SysLogAnnotaion)")
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
        SysLog sysLog = new SysLog();

        logger.debug("into LOG AOP==============================++++++++++++++++++++++++++++++++");
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
            sysLog.setDescription(sysLogAnnotaion.value());
        }

        // 获取RequestAttributes
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        // 从获取RequestAttributes中获取HttpServletRequest的信息
        HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);
        // 设置IP地址
        sysLog.setIp(IpAdrressUtils.getIpAdrress(request));
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
        if(sysLog.getReqUri().equals("/sysUser/login")){
            SysUserVo arg = (SysUserVo) args[0];
            sysLog.setUserName(arg.getUserName());
        }else{
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
}
