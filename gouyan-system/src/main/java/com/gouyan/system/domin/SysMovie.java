package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-21 22:26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SysMovie implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long movieId;

    //电影中文名
    @NotBlank(message = "电影中文名不能为空")
    private String movieNameCn;

    //电影英文名
    @NotBlank(message = "电影英文名不能为空")
    private String movieNameEn;

    //电影时长
    private Integer movieLength;

    //电影海报
    private String moviePoster;

    //电影区域id
    private Long movieAreaId;

    //电影年代id
    private Long movieAgeId;

    //上映日期
    private Date releaseDate;

    //电影评分
    private Double movieScore;

    //电影总票房
    private Double movieBoxOffice;

    //评分人数
    private Integer movieRateNum;

    //电影简介
    private String movieIntroduction;

    //电影图集
    private String moviePictures;


    //电影区域
    private SysMovieArea sysMovieArea;

    //电影年代
    private SysMovieAge sysMovieAge;


    //电影的参演人员角色，每个角色分别对应若干演员
    private List<SysActorRole> actorRoleList;

    //影评列表
    private List<SysMovieComment> movieCommentList;

    //电影的类别
    private List<SysMovieCategory> movieCategoryList;

    //电影主演名称，在影院中显示
    private List<String> majorActorNameList;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieId() {
        return movieId;
    }

    public void setMovieId(Long movieId) {
        this.movieId = movieId;
    }

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

    public Integer getMovieLength() {
        return movieLength;
    }

    public void setMovieLength(Integer movieLength) {
        this.movieLength = movieLength;
    }

    public String getMoviePoster() {
        return moviePoster;
    }

    public void setMoviePoster(String moviePoster) {
        this.moviePoster = moviePoster;
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

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Double getMovieScore() {
        return movieScore;
    }

    public void setMovieScore(Double movieScore) {
        this.movieScore = movieScore;
    }

    public Double getMovieBoxOffice() {
        return movieBoxOffice;
    }

    public void setMovieBoxOffice(Double movieBoxOffice) {
        this.movieBoxOffice = movieBoxOffice;
    }

    public Integer getMovieRateNum() {
        return movieRateNum;
    }

    public void setMovieRateNum(Integer movieRateNum) {
        this.movieRateNum = movieRateNum;
    }

    public String getMovieIntroduction() {
        return movieIntroduction;
    }

    public void setMovieIntroduction(String movieIntroduction) {
        this.movieIntroduction = movieIntroduction;
    }

    public String getMoviePictures() {
        return moviePictures;
    }

    public void setMoviePictures(String moviePictures) {
        this.moviePictures = moviePictures;
    }

    public SysMovieArea getSysMovieArea() {
        return sysMovieArea;
    }

    public void setSysMovieArea(SysMovieArea sysMovieArea) {
        this.sysMovieArea = sysMovieArea;
    }

    public SysMovieAge getSysMovieAge() {
        return sysMovieAge;
    }

    public void setSysMovieAge(SysMovieAge sysMovieAge) {
        this.sysMovieAge = sysMovieAge;
    }

    public List<SysActorRole> getActorRoleList() {
        return actorRoleList;
    }

    public void setActorRoleList(List<SysActorRole> actorRoleList) {
        this.actorRoleList = actorRoleList;
    }

    public List<SysMovieComment> getMovieCommentList() {
        return movieCommentList;
    }

    public void setMovieCommentList(List<SysMovieComment> movieCommentList) {
        this.movieCommentList = movieCommentList;
    }

    public List<SysMovieCategory> getMovieCategoryList() {
        return movieCategoryList;
    }

    public void setMovieCategoryList(List<SysMovieCategory> movieCategoryList) {
        this.movieCategoryList = movieCategoryList;
    }

    public List<String> getMajorActorNameList() {
        return majorActorNameList;
    }

    public void setMajorActorNameList(List<String> majorActorNameList) {
        this.majorActorNameList = majorActorNameList;
    }
}
