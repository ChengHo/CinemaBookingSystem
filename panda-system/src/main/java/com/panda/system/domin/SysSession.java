package com.panda.system.domin;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * 场次实体类
 * @Author: 华雨欣
 * @Create: 2020-11-23 21:59
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysSession implements Serializable {

    private static final Long serialVersionUID = 1L;

    //场次id
    private Long sessionId;

    //影院id
    @NotNull(message = "场次所属影院不能为空")
    private Long cinemaId;

    //影厅id
    @NotNull(message = "场次所在影厅不能为空")
    private Long hallId;

    //该场次语言版本
    @NotBlank(message = "场次电影语言版本不能为空")
    private String languageVersion;

    //电影id
    @NotNull(message = "场次安排电影不能为空")
    private Long movieId;

    //电影播放时段id
    @NotNull(message = "场次播放时段不能为空")
    private Long movieRuntimeId;

    //场次日期
    @NotNull(message = "场次日期不能为空")
    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDate sessionDate;

    //场次状态, true表示上映中, false表示已下架
    @NotNull(message = "场次状态不能为空")
    private Boolean sessionState;

    //场次票价
    @NotNull(message = "场次票价不能为空")
    @Size(min = 0, message = "场次票价不能为负数")
    private Double sessionPrice;

    //场次提示
    private String sessionTips;

    //场次座位信息
    @NotBlank(message = "场次座位信息不能为空")
    private String sessionSeats;

    private Integer seatNums;


    //多表连接
    private SysCinema sysCinema;

    private SysHall sysHall;

    private SysMovie sysMovie;

    private SysMovieRuntime sysMovieRuntime;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getSessionId() {
        return sessionId;
    }

    public void setSessionId(Long sessionId) {
        this.sessionId = sessionId;
    }

    public Long getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(Long cinemaId) {
        this.cinemaId = cinemaId;
    }

    public Long getHallId() {
        return hallId;
    }

    public void setHallId(Long hallId) {
        this.hallId = hallId;
    }

    public String getLanguageVersion() {
        return languageVersion;
    }

    public void setLanguageVersion(String languageVersion) {
        this.languageVersion = languageVersion;
    }

    public Long getMovieId() {
        return movieId;
    }

    public void setMovieId(Long movieId) {
        this.movieId = movieId;
    }

    public Long getMovieRuntimeId() {
        return movieRuntimeId;
    }

    public void setMovieRuntimeId(Long movieRuntimeId) {
        this.movieRuntimeId = movieRuntimeId;
    }

    public LocalDate getSessionDate() {
        return sessionDate;
    }

    public void setSessionDate(LocalDate sessionDate) {
        this.sessionDate = sessionDate;
    }

    public Boolean getSessionState() {
        return sessionState;
    }

    public void setSessionState(Boolean sessionState) {
        this.sessionState = sessionState;
    }

    public Double getSessionPrice() {
        return sessionPrice;
    }

    public void setSessionPrice(Double sessionPrice) {
        this.sessionPrice = sessionPrice;
    }

    public String getSessionTips() {
        return sessionTips;
    }

    public void setSessionTips(String sessionTips) {
        this.sessionTips = sessionTips;
    }

    public String getSessionSeats() {
        return sessionSeats;
    }

    public void setSessionSeats(String sessionSeats) {
        this.sessionSeats = sessionSeats;
    }

    public Integer getSeatNums() {
        return seatNums;
    }

    public void setSeatNums(Integer seatNums) {
        this.seatNums = seatNums;
    }

    public SysCinema getSysCinema() {
        return sysCinema;
    }

    public void setSysCinema(SysCinema sysCinema) {
        this.sysCinema = sysCinema;
    }

    public SysHall getSysHall() {
        return sysHall;
    }

    public void setSysHall(SysHall sysHall) {
        this.sysHall = sysHall;
    }

    public SysMovie getSysMovie() {
        return sysMovie;
    }

    public void setSysMovie(SysMovie sysMovie) {
        this.sysMovie = sysMovie;
    }

    public SysMovieRuntime getSysMovieRuntime() {
        return sysMovieRuntime;
    }

    public void setSysMovieRuntime(SysMovieRuntime sysMovieRuntime) {
        this.sysMovieRuntime = sysMovieRuntime;
    }
}
