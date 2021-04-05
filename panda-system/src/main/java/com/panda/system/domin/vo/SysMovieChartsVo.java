package com.panda.system.domin.vo;

import java.io.Serializable;

/**
 * @Author: 华雨欣
 * @Create: 2020-12-03 11:22
 */
public class SysMovieChartsVo implements Serializable {

    //是否为热映榜
    private Boolean isOnshow;

    private Long movieAreaId;

    public Boolean getOnshow() {
        return isOnshow;
    }

    public void setOnshow(Boolean onshow) {
        isOnshow = onshow;
    }

    public Long getMovieAreaId() {
        return movieAreaId;
    }

    public void setMovieAreaId(Long movieAreaId) {
        this.movieAreaId = movieAreaId;
    }
}
