package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-20 09:05
 */
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Data
public class SysCinemaArea implements Serializable {

    private static final Long serialVersionUID = 1L;

    //影院区域id
    private Long cinemaAreaId;

    //影院区域名称
    @NotBlank(message = "影院区域名称不能为空")
    private String cinemaAreaName;

    //影院所属省份
    @NotBlank(message = "影院所属省份不能为空")
    private String province;

    //影院所属城市
    @NotBlank(message = "影院所属城市不能为空")
    private String city;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getCinemaAreaId() {
        return cinemaAreaId;
    }

    public void setCinemaAreaId(Long cinemaAreaId) {
        this.cinemaAreaId = cinemaAreaId;
    }

    public String getCinemaAreaName() {
        return cinemaAreaName;
    }

    public void setCinemaAreaName(String cinemaAreaName) {
        this.cinemaAreaName = cinemaAreaName;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
