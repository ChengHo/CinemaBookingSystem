package com.gouyan.common.exception;

/**
 * 文件大小超过限制异常，用于文件校验
 * @Author: 华雨欣
 * @Create: 2020-12-04 20:09
 */
public class FileSizeLimitExceededException extends RuntimeException{

    private static final long serialVersionUID = 1L;

    public FileSizeLimitExceededException(){

    }

    public FileSizeLimitExceededException(String message){
        super(message);
    }

}
