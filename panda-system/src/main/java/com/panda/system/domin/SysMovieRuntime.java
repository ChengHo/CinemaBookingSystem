package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * 电影播放时段
 * @Author: 华雨欣
 * @Create: 2020-11-20 11:10
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysMovieRuntime implements Serializable {

    private static final Long serialVersionUID = 1L;

    private Long movieRuntimeId;

    //播放时段名称
    @NotBlank(message = "播放时段名称不能为空")
    private String movieRuntimeName;

    //时段开始时间
    @NotBlank(message = "时段开始时间不能为空")
    @Pattern(regexp = "^(20|21|22|23|[0-1]\\d):[0-5]\\d$", message = "时间输入格式不匹配，请按照：hh:mm 输入")
    private String beginTime;

    //时段结束时间
    @NotBlank(message = "时段结束时间不能为空")
    @Pattern(regexp = "^(20|21|22|23|[0-1]\\d):[0-5]\\d$", message = "时间输入格式不匹配，请按照：hh:mm 输入")
    private String endTime;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieRuntimeId() {
        return movieRuntimeId;
    }

    public void setMovieRuntimeId(Long movieRuntimeId) {
        this.movieRuntimeId = movieRuntimeId;
    }

    public String getMovieRuntimeName() {
        return movieRuntimeName;
    }

    public void setMovieRuntimeName(String movieRuntimeName) {
        this.movieRuntimeName = movieRuntimeName;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
