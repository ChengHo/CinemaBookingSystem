package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author lxd
 * @create 2020-11-19 21:05
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysHallCategory implements Serializable{
    //序列号
    private static final long serialVersionUID = 1L;

    //影厅分类id
    private Long hallCategoryId;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getHallCategoryId() {
        return hallCategoryId;
    }

    public void setHallCategoryId(Long hallCategoryId) {
        this.hallCategoryId = hallCategoryId;
    }

    public String getHallCategoryName() {
        return hallCategoryName;
    }

    public void setHallCategoryName(String hallCategoryName) {
        this.hallCategoryName = hallCategoryName;
    }

    //影厅分类名称
    @NotBlank(message = "影厅分类名称不能为空")
    private String hallCategoryName;
}
