package com.panda.common.utils;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class IpUtils {

    /**
     * 根据HTTPServletRequest对象获取IP地址     *
     * @param request
     * @return
     */
    public static String getIpAdrress(HttpServletRequest request) {
        String ip = null;

        //X-Forwarded-For：Squid 服务代理
        String ipAddresses = request.getHeader("X-Forwarded-For");
        String unknown = "unknown";
        if (ipAddresses == null || ipAddresses.length() == 0 || unknown.equalsIgnoreCase(ipAddresses)) {
            //Proxy-Client-IP：apache 服务代理
            ipAddresses = request.getHeader("Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || unknown.equalsIgnoreCase(ipAddresses)) {
            //WL-Proxy-Client-IP：weblogic 服务代理
            ipAddresses = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || unknown.equalsIgnoreCase(ipAddresses)) {
            //HTTP_CLIENT_IP：有些代理服务器
            ipAddresses = request.getHeader("HTTP_CLIENT_IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || unknown.equalsIgnoreCase(ipAddresses)) {
            //X-Real-IP：nginx服务代理
            ipAddresses = request.getHeader("X-Real-IP");
        }

        //有些网络通过多层代理，那么获取到的ip就会有多个，一般都是通过逗号（,）分割开来，并且第一个ip为客户端的真实IP
        if (ipAddresses != null && ipAddresses.length() != 0) {
            ip = ipAddresses.split(",")[0];
        }

        //还是不能获取到，最后再通过request.getRemoteAddr();获取
        if (ip == null || ip.length() == 0 || unknown.equalsIgnoreCase(ipAddresses)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

	/**
	 * 根据根据HTTPServletRequest对象获取发送请求的IP地址和端口
	 * @param request
	 * @return
	 */
    public static Map getOriginIPAndPort(HttpServletRequest request) {
        Map map = new HashMap();

        // 获取客户机发送请求的IP地址
        String originIpAddress = request.getHeader("origin");

        // IP地址去除协议头
        String str = originIpAddress.substring(originIpAddress.lastIndexOf("/")+1, originIpAddress.length());
        // 存在 ":" 则未使用默认80端口，否则端口默认为80
        if (str.contains(":")) {
            map.put("originIP", str.substring(0, str.indexOf(":")));
            map.put("originPort", str.substring(str.indexOf(":") + 1, str.length()));
        } else {
            map.put("originIP", str);
            map.put("originPort", "80");
        }

        return map;
    }
}
