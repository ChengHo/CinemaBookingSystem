package com.gouyan.web.controller.aspect;

import lombok.Data;
 
import java.util.Date;
 

@Data
public class OperatingRecordLogModel {
    /**
     * 主键id
     */
    private Integer id;
    /**
     * token
     */
    private String token;
    /**
     * 用户id
     */
    private Integer memberId;
    /**
     * 请求地址
     */
    private String apiUri;
    /**
     * 请求方法
     */
    private String method;
    /**
     * 请求类型
     */
    private String requestType;
    /**
     * 请求ip地址
     */
    private String ipAddress;
    /**
     * 请求耗时
     */
    private long timeConsuming;
    /**
     * 请求时间
     */
    private Date createTime;
    /**
     * 请求参数
     */
    private String requestParam;
    /**
     * 响应状态码
     */
    private int responseCode;
    /**
     * 响应状态码说明
     */
    private String responseMessage;
    /**
     * 响应参数
     */
    private String responseParam;
    /**
     * Http响应状态
     */
    private String status;
 
}

