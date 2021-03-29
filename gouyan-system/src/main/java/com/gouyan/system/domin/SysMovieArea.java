package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author lxd
 * @create 2020-11-18 22:01
 */

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysMovieArea implements Serializable {

    //序列号
    private static final long serialVersionUID = 1L;

    //电影区域id
    private Long movieAreaId;

    //电影区域名称
    @NotBlank(message = "电影区域名称不能为空")
    private String movieAreaName;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieAreaId() {
        return movieAreaId;
    }

    public void setMovieAreaId(Long movieAreaId) {
        this.movieAreaId = movieAreaId;
    }

    public String getMovieAreaName() {
        return movieAreaName;
    }

    public void setMovieAreaName(String movieAreaName) {
        this.movieAreaName = movieAreaName;
    }
}
