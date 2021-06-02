package com.panda.common.exception;

/**
 * 文件名字长度超过限制异常，用于文件校验
 */
public class FileNameLengthLimitExceededException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public FileNameLengthLimitExceededException() {
    }

    public FileNameLengthLimitExceededException(String message) {
        super(message);
    }

}
