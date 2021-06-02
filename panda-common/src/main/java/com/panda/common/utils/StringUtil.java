package com.panda.common.utils;

/**
 * 字符串工具类，抽取一些常用操作
 */
public class StringUtil {

    /**
     * 判断val是否不为空(null/"")
     *
     * @param val
     * @return
     */
    public static boolean isNotEmpty(String val) {
        return val != null && !"".equals(val);
    }

    /**
     * 将给定的驼峰命名值转换为下划线命名
     *
     * @param val
     * @return
     */
    public static String toUnderScoreCase(String val) {
        if (!isNotEmpty(val)) {
            return val;
        }
        StringBuilder sb = new StringBuilder(val);
        for (int i = 0; i < sb.length(); i++) {
            if (sb.charAt(i) >= 'A' && sb.charAt(i) <= 'Z') {
                //将大写字母 "A" 替换为 "_a"
                sb.replace(i, i + 1, "_" + (char) (sb.charAt(i) + 32));
            }
        }
        return sb.toString();
    }

}
