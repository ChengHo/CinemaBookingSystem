package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysUser implements Serializable {
    private final static Long serialVersionUID = 1L;
    //用户id
    private Long userId;
    //用户名
    @NotBlank(message = "用户名不能为空")
    private String userName;
    //密码
    @NotBlank(message = "密码不能为空")
    private String password;
    //盐
    private String salt;
    //邮箱
    @Email(message = "邮箱格式有误")
    private String email;
    //电话号码
    @Pattern(regexp = "^1[3|4|5|7|8]\\d{9}$", message = "电话号码格式有错")
    private String phoneNumber;
    //性别
    private Boolean sex;
    //用户头像
    private String userPicture;
    //用户对应的角色id，为简化操作，采用1对1
    private Long roleId;

    private String birthday;

    private String autograph;

    //用户的角色
    private SysRole sysRole;
}
