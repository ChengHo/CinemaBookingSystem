package com.panda.system.domin.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * 封装用户登录输入的信息
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysUserVo implements Serializable {

    private String userName;

    private String password;

}
