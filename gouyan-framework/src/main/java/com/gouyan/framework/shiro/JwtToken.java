package com.gouyan.framework.shiro;

import org.apache.shiro.authc.AuthenticationToken;

/**
 * 实现shiro的AuthenticationToken接口的类JwtToken
 * @Author: 华雨欣
 * @Create: 2020-12-09 10:35
 */
public class JwtToken implements AuthenticationToken {

    private String token;

    public JwtToken(String token){
        this.token = token;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
