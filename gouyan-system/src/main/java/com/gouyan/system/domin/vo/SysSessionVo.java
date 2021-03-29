package com.gouyan.system.domin.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * @Author: 华雨欣
 * @Create: 2020-11-24 15:08
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class SysSessionVo implements Serializable {

    private Long cinemaId;

    private Long hallId;

    private Long movieId;

    private Long movieRuntimeId;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDate sessionDate;

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
}
