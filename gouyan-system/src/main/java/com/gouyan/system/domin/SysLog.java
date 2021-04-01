package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

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
//    //标题
//    private String title;
//    //请求路径
//    @NotBlank(message = "请求路径不能为空")
//    private String reqUrl;
//    //请求方法
//    @NotBlank(message = "请求方法不能为空")
//    private String reqMethod;
//    @NotBlank(message = "控制器名称不能为空")
//    private String controllerName;
//    //处理请求的方法名称
//    private String methodName;
    //操作用户
    private String userName;
//    //ip地址
//    private String addressIp;
//    //设备名称
//    private String driverName;
//    //浏览器名称
//    private String browerName;
//    //异常信息
//    private String exceptionInfo;
//    //处理时间
//    private Long executeUseMillisecond;


}
