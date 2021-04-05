package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * @author: chengho
 * @create: 2021-04-01 17:43
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysLog implements Serializable {
    private final static Long serialVersionUID = 1L;
    //日志id
    private Long logId;
    // 系统类别
    private String sysType;
    //操作用户
    private String userName;
    // 操作序号
    private String operSeq;
    //操作描述
    private String description;
    //请求参数
    private String params;
    //操作时间
    private Date startTime;
    //消耗时间，单位ms
    private int spendTime;
    //根路径
    private String basePath;
    //请求路径
    @NotBlank(message = "请求路径不能为空")
    private String reqUri;
    //请求方法
    @NotBlank(message = "请求方法不能为空")
    private String method;
    //请求类型
    private String reqType;
    //用户标识
    private String userAgent;
    //ip地址
    private String ip;
    //结果
    private int result;

//    @NotBlank(message = "控制器名称不能为空")
//    private String controllerName;
//    //设备名称
//    private String driverName;
//    //浏览器名称
//    private String browerName;
//    //异常信息
//    private String exceptionInfo;
}
