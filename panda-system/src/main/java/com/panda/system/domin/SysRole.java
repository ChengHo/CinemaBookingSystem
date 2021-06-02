package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysRole implements Serializable {

    private static final Long serialVersionUID = 1L;

    private Long roleId;

    //角色名称
    @NotBlank(message = "角色名称不能为空")
    private String roleName;

    //角色描述
    @NotBlank(message = "角色描述不能为空")
    private String roleDesc;


    //角色拥有的权限，分多级权限存储，取名为children方便读取所有权限
    private List<SysResource> children;
}
