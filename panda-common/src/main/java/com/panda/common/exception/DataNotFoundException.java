package com.panda.common.exception;

public class DataNotFoundException extends RuntimeException {

    static final long serialVersionUID = -7034897190745456227L;

    public DataNotFoundException() {
        super();
    }

    public DataNotFoundException(String message) {
        super(message);
    }

}
