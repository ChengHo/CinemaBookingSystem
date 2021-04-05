package com.panda.system.domin.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * @Author: 华雨欣
 * @Create: 2020-12-01 16:32
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SysCinemaVo implements Serializable {

    private String cinemaName;

    private Long cinemaBrandId;

    private String cinemaAddress;

    private Long cinemaAreaId;

    private Boolean isTicketChanged;

    private Boolean isRefunded;

    private Long hallCategoryId;

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public Long getCinemaBrandId() {
        return cinemaBrandId;
    }

    public void setCinemaBrandId(Long cinemaBrandId) {
        this.cinemaBrandId = cinemaBrandId;
    }

    public String getCinemaAddress() {
        return cinemaAddress;
    }

    public void setCinemaAddress(String cinemaAddress) {
        this.cinemaAddress = cinemaAddress;
    }

    public Long getCinemaAreaId() {
        return cinemaAreaId;
    }

    public void setCinemaAreaId(Long cinemaAreaId) {
        this.cinemaAreaId = cinemaAreaId;
    }

    public Boolean getTicketChanged() {
        return isTicketChanged;
    }

    public void setTicketChanged(Boolean ticketChanged) {
        isTicketChanged = ticketChanged;
    }

    public Boolean getRefunded() {
        return isRefunded;
    }

    public void setRefunded(Boolean refunded) {
        isRefunded = refunded;
    }

    public Long getHallCategoryId() {
        return hallCategoryId;
    }

    public void setHallCategoryId(Long hallCategoryId) {
        this.hallCategoryId = hallCategoryId;
    }
}
