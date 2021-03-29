package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 电影年代
 * @Author: 华雨欣
 * @Create: 2020-11-14 22:46
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysMovieAge implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long movieAgeId;//年代id

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieAgeId() {
        return movieAgeId;
    }

    public void setMovieAgeId(Long movieAgeId) {
        this.movieAgeId = movieAgeId;
    }

    public String getMovieAgeName() {
        return movieAgeName;
    }

    public void setMovieAgeName(String movieAgeName) {
        this.movieAgeName = movieAgeName;
    }

    @NotBlank(message = "年代名称不能为空")
    private String movieAgeName;//年代名称
}
