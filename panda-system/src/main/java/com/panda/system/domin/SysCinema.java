package com.panda.system.domin;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysCinema implements Serializable {
    private final static Long serialVersionUID = 1L;

    private Long cinemaId;

    @NotBlank(message = "影院名称不能为空")
    private String cinemaName;

    private String hallCategoryList;

    private String cinemaPicture;

    private String cinemaAddress;

    private String cinemaPhone;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "HH:mm")
    private String workStartTime;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "HH:mm")
    private String workEndTime;

    //当前影院上映的所有电影，规则：上映的电影指包括今天在内，未来5天有安排目标影片的场次
    private List<SysMovie> sysMovieList;

}
