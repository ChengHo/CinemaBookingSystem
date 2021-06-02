package com.panda.common.constant;

/**
 * 定义常量记录Http状态码
 */
public class HttpStatus {
    /**
     * 成功
     */
    public static final int SUCCESS = 200;

    public static final int BAD_REQUEST = 400;

    /**
     * 访问受限，授权过期
     */
    public static final int FORBIDDEN = 403;

    /**
     * 资源，服务未找到
     */
    public static final int NOT_FOUND = 404;

    /**
     * 系统内部错误
     */
    public static final int ERROR = 500;
}
