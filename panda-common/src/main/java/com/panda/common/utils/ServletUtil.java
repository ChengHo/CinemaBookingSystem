package com.panda.common.utils;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 从当前绑定的线程上获取请求属性
 */
public class ServletUtil {

    /**
     * 获取所有请求属性
     *
     * @return 请求属性
     */
    public static ServletRequestAttributes getAttributes() {
        return (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
    }

    /**
     * 获取request请求对象
     *
     * @return
     */
    public static HttpServletRequest getRequest() {
        return getAttributes().getRequest();
    }

    /**
     * 获取response响应对象
     *
     * @return
     */
    public static HttpServletResponse getResponse() {
        return getAttributes().getResponse();
    }

    /**
     * 获取session域对象
     *
     * @return
     */
    public static HttpSession getSession() {
        return getRequest().getSession();
    }

}
