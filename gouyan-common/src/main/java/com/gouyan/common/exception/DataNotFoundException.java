package com.gouyan.common.exception;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-24 11:04
 */
public class DataNotFoundException extends RuntimeException{

    static final long serialVersionUID = -7034897190745456227L;

    public DataNotFoundException() {
        super();
    }

    public DataNotFoundException(String message) {
        super(message);
    }
}
