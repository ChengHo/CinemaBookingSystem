package com.gouyan.common.exception;

/**
 * 文件后缀无效异常，用于文件校验
 * @Author: 华雨欣
 * @Create: 2020-12-04 20:09
 */
public class InvalidExtensionException extends RuntimeException{

    private static final long serialVersionUID = 1L;

    public InvalidExtensionException(){

    }

    public InvalidExtensionException(String message){
        super(message);
    }

}
