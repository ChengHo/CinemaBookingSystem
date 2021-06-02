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
public class SysResource implements Serializable {

    private static final Long serialVersionUID = 1L;

    private Long id;

    @NotBlank(message = "菜单名称不能为空")
    private String name;

    private String path;

    //菜单权限等级
    private Integer level;

    private Long parentId;

    //父菜单
    private SysResource parent;

    //子菜单
    private List<SysResource> children;

}
