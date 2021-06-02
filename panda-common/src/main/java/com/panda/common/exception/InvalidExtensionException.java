package com.panda.common.exception;

/**
 * 文件后缀无效异常，用于文件校验
 */
public class InvalidExtensionException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public InvalidExtensionException() {
    }

    public InvalidExtensionException(String message) {
        super(message);
    }

}
