package com.gouyan.common.utils;

import java.util.Random;

/**
 * 生成随机盐工具类
 * @Author: 华雨欣
 * @Create: 2020-12-08 10:44
 */
public class SaltUtils {

    public static String getSalt(int n){
        //返回长度为n的随机盐
        StringBuilder sb = new StringBuilder();
        char[] chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()".toCharArray();
        for (int i = 0; i < n; i++) {
            char c = chars[new Random().nextInt(chars.length)];
            sb.append(c);
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        System.out.println(getSalt(8));
    }

}
