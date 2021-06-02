package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysHall implements Serializable {
    private final static Long serialVersionUID = 1L;

    private Long cinemaId;

    private Long hallId;

    @NotBlank(message = "影厅名称不能为空")
    private String hallName;

    private String hallCategory;

    //排开始标号：'1' / 'A' 等
    private String rowStart;

    //影厅排数
    @Min(value = 3, message = "排数不能小于3")
    @Max(value = 50, message = "排数不能大于50")
    private Integer rowNums;

    //每排座位数
    @Min(value = 3, message = "每排座位数不能小于3")
    @Max(value = 50, message = "每排座位数不能大于50")
    private Integer seatNumsRow;

    //总可用座位数，可以通过安排座位禁用指定座位
    @Min(value = 9, message = "座位数不能小于9")
    @Max(value = 2500, message = "座位数不能大于2500")
    private Integer seatNums;

    //座位的状态，使用json存储每个座位的状态，0表示可用，2表示禁用(1表示售出，在场次表中统计)
    private String seatState;

    private Boolean delState;

    //影厅表的多表连接
    private SysCinema sysCinema;

}
