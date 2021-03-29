package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @Author: 华雨欣
 * @Create: 2020-12-03 16:56
 */
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Data
public class SysCinemaBrand implements Serializable {

    private static final Long serialVersionUID = 1L;

    //影院区域id
    private Long cinemaBrandId;

    //影院区域名称
    @NotBlank(message = "影院品牌名称不能为空")
    private String cinemaBrandName;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getCinemaBrandId() {
        return cinemaBrandId;
    }

    public void setCinemaBrandId(Long cinemaBrandId) {
        this.cinemaBrandId = cinemaBrandId;
    }

    public String getCinemaBrandName() {
        return cinemaBrandName;
    }

    public void setCinemaBrandName(String cinemaBrandName) {
        this.cinemaBrandName = cinemaBrandName;
    }
}
