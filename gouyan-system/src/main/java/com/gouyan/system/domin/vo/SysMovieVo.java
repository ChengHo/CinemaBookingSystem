package com.gouyan.system.domin.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * 封装电影查询的条件
 * @Author: 华雨欣
 * @Create: 2020-12-01 10:58
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysMovieVo {

    private String movieNameCn;

    private String movieNameEn;

    private Long movieAreaId;

    private Long movieAgeId;

    private Long movieCategoryId;

    private Date startDate;

    private Date endDate;

    public String getMovieNameCn() {
        return movieNameCn;
    }

    public void setMovieNameCn(String movieNameCn) {
        this.movieNameCn = movieNameCn;
    }

    public String getMovieNameEn() {
        return movieNameEn;
    }

    public void setMovieNameEn(String movieNameEn) {
        this.movieNameEn = movieNameEn;
    }

    public Long getMovieAreaId() {
        return movieAreaId;
    }

    public void setMovieAreaId(Long movieAreaId) {
        this.movieAreaId = movieAreaId;
    }

    public Long getMovieAgeId() {
        return movieAgeId;
    }

    public void setMovieAgeId(Long movieAgeId) {
        this.movieAgeId = movieAgeId;
    }

    public Long getMovieCategoryId() {
        return movieCategoryId;
    }

    public void setMovieCategoryId(Long movieCategoryId) {
        this.movieCategoryId = movieCategoryId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
