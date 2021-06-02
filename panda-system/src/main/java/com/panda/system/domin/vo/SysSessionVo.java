package com.panda.system.domin.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class SysSessionVo implements Serializable {

    private Long hallId;

    private Long movieId;

    @JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd")
    private LocalDate sessionDate;

}
