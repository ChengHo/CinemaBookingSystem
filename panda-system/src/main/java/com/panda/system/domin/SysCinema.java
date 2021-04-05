package com.panda.system.domin;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * @author lxd
 * @create 2020-11-25 16:03
 */

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysCinema implements Serializable {
    private final static Long serialVersionUID = 1L;

    private Long cinemaId;

    @NotBlank(message = "影院名称不能为空")
    private String cinemaName;

    @NotNull(message = "影院品牌不能为空")
    private Long cinemaBrandId;

    private String cinemaPicture;

    private Boolean isTicketChanged;

    private Boolean isRefunded;

    @NotNull(message = "所属区域id不能为空")
    private Long cinemaAreaId;

    private String cinemaAddress;

    @NotNull(message = "负责人id不能为空")
    private Long userId;

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDate entryDate;

    private SysUser user;

    private SysCinemaBrand sysCinemaBrand;

    private SysCinemaArea sysCinemaArea;

    //影院存在的影厅类别
    private List<SysHallCategory> sysHallCategoryList;

    //当前影院上映的所有电影，规则：上映的电影指包括今天在内，未来5天有安排目标影片的场次
    private List<SysMovie> sysMovieList;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(Long cinemaId) {
        this.cinemaId = cinemaId;
    }

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

    public String getCinemaPicture() {
        return cinemaPicture;
    }

    public void setCinemaPicture(String cinemaPicture) {
        this.cinemaPicture = cinemaPicture;
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

    public Long getCinemaAreaId() {
        return cinemaAreaId;
    }

    public void setCinemaAreaId(Long cinemaAreaId) {
        this.cinemaAreaId = cinemaAreaId;
    }

    public String getCinemaAddress() {
        return cinemaAddress;
    }

    public void setCinemaAddress(String cinemaAddress) {
        this.cinemaAddress = cinemaAddress;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public LocalDate getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(LocalDate entryDate) {
        this.entryDate = entryDate;
    }

    public SysUser getUser() {
        return user;
    }

    public void setUser(SysUser user) {
        this.user = user;
    }

    public SysCinemaBrand getSysCinemaBrand() {
        return sysCinemaBrand;
    }

    public void setSysCinemaBrand(SysCinemaBrand sysCinemaBrand) {
        this.sysCinemaBrand = sysCinemaBrand;
    }

    public SysCinemaArea getSysCinemaArea() {
        return sysCinemaArea;
    }

    public void setSysCinemaArea(SysCinemaArea sysCinemaArea) {
        this.sysCinemaArea = sysCinemaArea;
    }

    public List<SysHallCategory> getSysHallCategoryList() {
        return sysHallCategoryList;
    }

    public void setSysHallCategoryList(List<SysHallCategory> sysHallCategoryList) {
        this.sysHallCategoryList = sysHallCategoryList;
    }

    public List<SysMovie> getSysMovieList() {
        return sysMovieList;
    }

    public void setSysMovieList(List<SysMovie> sysMovieList) {
        this.sysMovieList = sysMovieList;
    }
}
