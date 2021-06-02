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
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysSession implements Serializable {

    private static final Long serialVersionUID = 1L;

    //场次编号
    private Long sessionId;

    //影厅编号
    @NotNull(message = "场次所在影厅不能为空")
    private Long hallId;

    //该场次语言版本
    @NotBlank(message = "场次电影语言版本不能为空")
    private String languageVersion;

    // 电影编号
    @NotNull(message = "场次安排电影不能为空")
    private Long movieId;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "HH:mm")
    private String playTime;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "HH:mm")
    private String endTime;

    // 截止时间，此时间之前不可删不可改电影、影厅信息
    private String deadline;

    // 场次日期
    @NotNull(message = "场次日期不能为空")
    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDate sessionDate;

    // 场次票价
    @NotNull(message = "场次票价不能为空")
    @Size(min = 0, message = "场次票价不能为负数")
    private Double sessionPrice;

    // 场次提示
    private String sessionTips;

    // 场次座位信息
    @NotBlank(message = "场次座位信息不能为空")
    private String sessionSeats;

    private Integer seatNums;

    // 已售座位数
    private Integer sallNums;

    private SysHall sysHall;

    private SysMovie sysMovie;
}
