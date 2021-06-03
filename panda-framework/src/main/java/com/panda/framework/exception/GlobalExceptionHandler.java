package com.panda.framework.exception;

import com.panda.common.constant.HttpStatus;
import com.panda.common.exception.DataNotFoundException;
import com.panda.common.response.ResponseResult;
import org.apache.shiro.authc.AuthenticationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

/**
 * 配置异常处理器，管理全局异常
 */
@RestController
@ControllerAdvice
public class GlobalExceptionHandler {

    // Logger控制台显示错误信息
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 处理验证不通过异常，将错误信息响应给前端
     *
     * @return 错误响应信息
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseResult methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        //打印日志
        log.error(e.getMessage(), e);
        //获取该异常的结果
        BindingResult bindingResult = e.getBindingResult();
        //获取错误msg
        String msg = bindingResult.getAllErrors().get(0).getDefaultMessage();
        return ResponseResult.error(msg);
    }

    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    public ResponseResult sqlIntegrityConstraintViolationExceptionHandler(SQLIntegrityConstraintViolationException e) {
        log.error(e.getMessage(), e);
        return ResponseResult.error("插入或修改操作不合法");
    }

    @ExceptionHandler(DataNotFoundException.class)
    public ResponseResult dataNotFoundExceptionHandler(DataNotFoundException e) {
        log.warn(e.getMessage());
        return ResponseResult.error(e.getMessage());
    }

    @ExceptionHandler(NoSuchMethodException.class)
    public ResponseResult noSuchMethodExceptionHandler(NoSuchMethodException e) {
        log.warn(e.getMessage());
        return ResponseResult.error("抱歉，服务器内部出现了些问题");
    }

    @ExceptionHandler(IllegalAccessException.class)
    public ResponseResult illegalAccessExceptionHandler(IllegalAccessException e) {
        log.warn(e.getMessage());
        return ResponseResult.error("抱歉，服务器内部出现了些问题");
    }

    @ExceptionHandler(IOException.class)
    public ResponseResult IOExceptionHandler(IOException e) {
        log.warn(e.getMessage());
        return ResponseResult.error("文件信息错误，原因：" + e.getMessage());
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseResult authenticationExceptionHandler(AuthenticationException e) {
        log.warn(e.getMessage());
        return ResponseResult.error(HttpStatus.BAD_REQUEST, e.getMessage());
    }

}
